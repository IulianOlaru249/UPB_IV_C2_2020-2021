/*
 *  LINKS:
 *      1) https://www.felixcloutier.com/x86/inc
 *      2) https://www.felixcloutier.com/x86/rep:repe:repz:repne:repnz
 *      3) https://www.felixcloutier.com/x86/cmovcc
 *      4) https://software.intel.com/sites/landingpage/pintool/docs/97503/Pin/h
 *         tml/group__INST__ARGS.html#gga089c27ca15e9ff139dd3a3f8a6f8451da985747
 *         a3c70e3a4283fc8a2f16399e63
 */

#include <cstdio>       /* fprintf                  */
#include <cstdint>      /* [u]int{8,16,32,64}_t     */
#include <string>       /* string                   */
#include <cstring>      /* strdup                   */
#include <stack>        /* stack                    */
#include "pin.H"        /* Intel Pin API            */
#include "util.h"       /* DIE, ANSI codes          */

using namespace std;

/******************************************************************************
 ********************* GLOBAL DEFINITIONS & DECLARATIONS **********************
 ******************************************************************************/

/* command line arguments */
static KNOB<string> knob_img(KNOB_MODE_APPEND,    "pintool",
        "i", "", "names of objects to be instrumented for branch logging");

/* pre-write -> post-write analysis routine communication medium */
stack<char *> pre_write_states;

/******************************************************************************
 ***************************** UTILITY FUNCTIONS ******************************
 ******************************************************************************/

/*
 *  hexdump - returns string containing hexdump of memory area
 *      @addr   : starting address
 *      @len    : number of bytes
 * 
 *      @return : pointer to internally allocated C-string
 *                caller must free!
 * 
 * NOTE: generally, expect small sizes for len:
 *          SIMD reads / writes = up to 32 bytes
 *          x(r)stor            = 896 bytes
 *          string instructions = unknown
 */
char *hexdump(void *addr, size_t len)
{
    /* allocate buffer (2 chars + 1 space) per byte + '\0' */
    char *hd = (char *) malloc(3 * len + 1);

    /* write hexdump byte by byte */
    for (size_t i=0; i<len; ++i)
        snprintf(hd + 3*i, 4, "%02hhx ", ((uint8_t *) addr)[i]);
    
    /* make sure string is null terminated */
    hd[3 * len] = '\0';

    return hd;
}

/*
 * ends_with - checks if a string ends with another string
 *      @s      : string
 *      @sfx    : suffix
 * 
 *      @return : { true, false }
 * 
 * The Image names as provided by the PIN API are absolute paths to the objects
 * on disk. This is useful to improve portability of any experiment scripts
 * that provide only the base name (e.g.: "libc.so.6").
 */
inline bool ends_with(string &s, string &sfx)
{
    if (sfx.size() > s.size())
        return false;

    return equal(sfx.rbegin(), sfx.rend(), s.rbegin());
}

/******************************************************************************
 ***************************** ANALYSIS ROUTINES ******************************
 ******************************************************************************/

/*
 *  read_analysis - code inserted before each load instruction, once for every
 *                  read operand(reflected in accessed_addr)
 *      @ins_addr       : absolute instruction address
 *      @ins_disass     : disassembly of instruction
 *      @accessed_addr  : memory source address
 *      @accessed_bytes : number of read bytes
 * 
 *      @return         : N/A
 */
void read_analysis(uint64_t ins_addr,
                   char     *ins_disass,
                   uint64_t accessed_addr,
                   uint32_t accessed_bytes)
{
    /* get hexdump of read memory */
    char *hd = hexdump((void *) accessed_addr, accessed_bytes);

    fprintf(stderr,
        CYAN  TOOL_TAG  CLEAR " "
              "READ "         " | "
        BLUE  "%#018lx" CLEAR ": "
              "%-40s"         " -- [ "
        GREEN "%s"      CLEAR "]\n",
        ins_addr, ins_disass, hd);

    /* free hexdump buffer */
    free(hd);
}

/*
 *  pre_write_analysis - code inserted before each store instruction, once for
 *                       every written operand (reflected in accessed_addr)
 *      @accessed_addr  : memory destination address
 *      @accessed_bytes : number of written bytes
 * 
 *      @return         : N/A
 * 
 * This function is used only to pass the initial buffer state to the post-write
 * analysis routine.
 */
void pre_write_analysis(uint64_t accessed_addr,
                        uint32_t accessed_bytes)
{
    /* push pre-written hexdump of memory to common stack */
    pre_write_states.push(hexdump((void *) accessed_addr, accessed_bytes));
}

/*
 * post_write_analysis - code inserted after each store instruction, once for
 *                       every written operand (reflected in accessed_addr)
 *      @ins_addr       : original instruction address
 *      @ins_disass     : disassembly of instruction
 *      @accessed_addr  : memory destination address
 *      @accessed_bytes : number of written bytes
 * 
 *      @return         : N/A
 * 
 * This function uses a hexdump string passed by the pre-write analysis routine
 * via the pre_write_states stack.
 */
void post_write_analysis(uint64_t ins_addr,
                         char     *ins_disass,
                         uint64_t accessed_addr,
                         uint32_t accessed_bytes)
{
    /* get hexdump of written memory */
    char *pre_hd  = pre_write_states.top();
    char *post_hd = hexdump((void *) accessed_addr, accessed_bytes);

    fprintf(stderr,
        CYAN   TOOL_TAG  CLEAR " "
               "WRITE"         " | "
        BLUE   "%#018lx" CLEAR ": "
               "%-40s"         " -- [ "
        YELLOW "%s"      CLEAR "] ==> [ "
        RED    "%s"      CLEAR "]\n",
        ins_addr, ins_disass, pre_hd, post_hd);

    /* free hexdump buffers; pop element from stack */
    free(pre_hd);
    free(post_hd);
    pre_write_states.pop();
}

/******************************************************************************
 ************************* INSTRUMENTATION CALLBACKS **************************
 ******************************************************************************/

/*
 *  ins_instrum - instruction level instrumentation callback routine
 *      @ins    : Intel Pin instruction object (non-persistent)
 * 
 *      @return : N/A
 * 
 * This routine is invoked ONCE for every newly encountered instruction.
 * Persistent instrumented code is registered via INS_InsertCall().
 */
void ins_instrum(INS ins, void *)
{
    /* extract image name */
    RTN rtn = INS_Rtn(ins);
    SEC sec = RTN_Valid(rtn) ? RTN_Sec(rtn) : SEC_Invalid();
    IMG img = SEC_Valid(sec) ? SEC_Img(sec) : IMG_Invalid();
    if (!IMG_Valid(img))
        return;

    string img_name = IMG_Name(img);

    /* ignore irrelevant images (as specified by user) */
    for (size_t i=0; i<knob_img.NumberOfValues(); ++i) {
        string sfx = knob_img.Value(i);
        if (ends_with(img_name, sfx))
            goto proceed;
    }

    return;

proceed:
    /* extract address & ins disassembly */
    uint64_t ins_addr   = INS_Address(ins);
    string   ins_disass = INS_Disassemble(ins);

    /* for each memory operand of this instruction */
    uint32_t mem_ops = INS_MemoryOperandCount(ins);
    for (uint32_t op_idx = 0; op_idx < mem_ops; ++op_idx) {
        /* perform read analysis                                            *
         *                                                                  *
         * NOTE: one instruction can both read and write memory (see [1])   *
         * NOTE: predicated call insertions are needed here for REP [2] and *
         *       conditional moves [3]                                      */
        if (INS_MemoryOperandIsRead(ins, op_idx))
            INS_InsertPredicatedCall(
                ins, IPOINT_BEFORE, (AFUNPTR) read_analysis,
                IARG_ADDRINT,       ins_addr,
                IARG_PTR,           strdup(ins_disass.c_str()),
                IARG_MEMORYOP_EA,   op_idx,
                IARG_MEMORYREAD_SIZE,
                IARG_END);

        /* memory writes must be instrumented both before and after   *
         *                                                            *       
         * NOTE: all pre_write_analysis() are evaluated before any    *
         *       post_write_analysis()                                *
         * NOTE: the k^th written operand (out of n) will be the k^th *
         *       analyzed with pre_write_analysis() and the (n-k)^th  *
         *       analyzed with post_write_analysis(); as a result, a  *
         *       stack can be used to pass information from           *
         *       pre_write_analysis() to post_write_analysis()        */
        if (INS_MemoryOperandIsWritten(ins, op_idx) &&
            INS_IsValidForIpointAfter(ins))
        {
            /* get initial buffer state */
            INS_InsertPredicatedCall(
                ins, IPOINT_BEFORE, (AFUNPTR) pre_write_analysis,
                IARG_CALL_ORDER,    CALL_ORDER_FIRST + op_idx + 1,
                IARG_MEMORYOP_EA,   op_idx,
                IARG_MEMORYWRITE_SIZE,
                IARG_END);

            /* display all information (including initial buffer state)      *
             *                                                               *
             * NOTE: the Pin documentation [4] says that IARG_MEMORYOP_EA is *
             *       valid only at IPOINT_BEFORE; somehow, this works        */
            INS_InsertPredicatedCall(
                ins, IPOINT_AFTER, (AFUNPTR) post_write_analysis,
                IARG_CALL_ORDER,    CALL_ORDER_LAST - op_idx - 1,
                IARG_ADDRINT,       ins_addr,
                IARG_PTR,           strdup(ins_disass.c_str()),
                IARG_MEMORYOP_EA,   op_idx,
                IARG_MEMORYWRITE_SIZE,
                IARG_END);
        }
    }
}

/******************************************************************************
 ************************************ MAIN ************************************
 ******************************************************************************/

int32_t main(int32_t argc, char *argv[])
{
    /* initialize PIN */
    int32_t ans = PIN_Init(argc, argv);
    DIE(ans, "Error initializing PIN");

    /* load symbols in order to access function names */
    PIN_InitSymbols();

    /* rgister instruction-level instrumentation function */
    INS_AddInstrumentFunction(ins_instrum, NULL);

    /* begin program execution */
    PIN_StartProgram();

    /* this point will never be reached */
    return 0;
}