#include <stdio.h>
#include <stdlib.h>
#include <Windows.h>
#include <Psapi.h>
 
/*****************************************************************/
/*                          IMPORTANT                            */
/* You can change any part of the skeleton (even the signatures) */
/*****************************************************************/
 
// The maximum number of processes
#define MAX_NUM_PROCESSES 1024
 
// Use this to crash to check if malloc failed
static inline void exitWithErrorNoMemory(PVOID assertVal)
{
    if (!assertVal) {
        printf("Not enough memory, exiting...\n");
        ExitProcess(ENOMEM);
    }
}
 
static DWORD retrieveProcesses(PDWORD *processesIdArray, DWORD arraySize)
{
    // TODO Fill processesIdArray with available processes
    // TODO Return the number of entries returned by the function
    LPDWORD total_size;
 
    total_size = 0;
    EnumProcesses(*processesIdArray, arraySize, total_size);
 
    return *total_size;
}
 
static HANDLE openProcess(DWORD processId)
{
    // TODO Return a HANDLE from a processId
    HANDLE hProcess;
 
    hProcess = OpenProcess(PROCESS_QUERY_INFORMATION |
        PROCESS_VM_READ,
        FALSE, processId);
 
    return hProcess;
}
 
static void closeProcessList(PHANDLE processHandles, DWORD handleArraySize)
{
    // TODO Close all handles in the list
    DWORD i;
    UINT code = 0;
 
    for (i = 0; i < handleArraySize; i++) {
        TerminateProcess(processHandles, code);
    }
}
 
static DWORD processesToHandles(PHANDLE handleArray)
{
    // TODO Retrieve all processes using the retrieveProcesses function
    // TODO Open all process ids (that are positive) with the openProcess function
    // Hint: If the returned handle is > 0, the opening succeeded
    // TODO the number of open handles
    DWORD i;
    DWORD processes_no;
    DWORD process_id;
    DWORD opened_processes = 0;
    HANDLE proc;
 
    processes_no = retrieveProcesses((PDWORD*)(handleArray), 10);
 
    for(i = 0; i < processes_no; i++) {
        process_id = GetProcessId(handleArray[i]);
        if (process_id > 0) {
            proc = openProcess(process_id);
            if (proc > 0) {
                opened_processes++;
            }
        }
    }
 
    return 0;
}
 
static void getMemoryInfoForHandles(PHANDLE processArray, PPROCESS_MEMORY_COUNTERS counters, DWORD processArraySize)
{
    // TODO Retrieve the memory information for each process in the processArray and fill the data into counters
 
}
 
static PCHAR *getProcessNameForHandles(PHANDLE processArray, DWORD processArraySize)
{
    // TODO Query for the full process name for each process inside processArray and return an array with all names
    // HINT: Use PROCESS_NAME_NATIVE for the flags if needed
    // HINT: paths can have a maximum length of MAX_PATH
    return NULL;
}
 
static PERFORMANCE_INFORMATION getSystemInfo()
{
    PERFORMACE_INFORMATION perf = { 0, };
    // TODO retrieve performance information from the system
    return perf;
}
 
// Helper: Parses the full path to extract only the executable
static int extractExecutable(PCHAR pathName)
{
    for (int i = strlen(pathName) - 1; i >= 0; --i) {
        if (pathName[i] == '\\') {
            return i + 1;
        }
    }
    return 0;
}
 
// Prints all data regarding performance
static void printSystemInfo(PERFORMANCE_INFORMATION perfInfo)
{
    printf("CommitTotal, CommitLimit, CommitPeak, PhysicalTotal, PhysicalAvailable, SystemCache, "
        "KernelTotal, KernelPaged, KernelNonpaged, PageSize, HandleCount, ProcessCount, ThreadCount\n");
    printf("%lld, %lld, %lld, %lld, %lld, %lld, %lld, %lld, %lld, %lld, %lu, %lu, %lu\n\n",
        perfInfo.CommitTotal,
        perfInfo.CommitLimit,
        perfInfo.CommitPeak,
        perfInfo.PhysicalTotal,
        perfInfo.PhysicalAvailable,
        perfInfo.SystemCache,
        perfInfo.KernelTotal,
        perfInfo.KernelPaged,
        perfInfo.KernelNonpaged,
        perfInfo.PageSize,
        perfInfo.HandleCount,
        perfInfo.ProcessCount,
        perfInfo.ThreadCount
        );
}
 
// Prints all data regarding memory for each process and its name
static void printTableInfo(PPROCESS_MEMORY_COUNTERS memoryCounterData, PCHAR *processNames, DWORD counterSize)
{
    printf("ProcessName, PageFaultCount, PeakWorkingSetSize, WorkingSetSize, QuotaPeakPagedPoolUsage, QuotaPagedPoolUsage, "
            "QuotaPeakNonPagedPoolUsage, QuotaNonPagedPoolUsage, PagefileUsage, PeakPagefileUsage\n");
 
    for (DWORD i = 0; i < counterSize; ++i) {
        printf("%s, %lu, %lld, %lld, %lld, %lld, %lld, %lld, %lld, %lld\n",
            processNames[i] + extractExecutable(processNames[i]),
            memoryCounterData[i].PageFaultCount,
            memoryCounterData[i].PeakWorkingSetSize / 1024,
            memoryCounterData[i].WorkingSetSize / 1024,
            memoryCounterData[i].QuotaPeakPagedPoolUsage / 1024,
            memoryCounterData[i].QuotaPagedPoolUsage / 1024,
            memoryCounterData[i].QuotaPeakNonPagedPoolUsage / 1024,
            memoryCounterData[i].QuotaNonPagedPoolUsage / 1024,
            memoryCounterData[i].PagefileUsage / 1024,
            memoryCounterData[i].PeakPagefileUsage / 1024
            );
    }
}
 
static void initEnvironment(PHANDLE *handleArray)
{
    // TODO do initializations here
    // Hint: Initialize the Handle array
    handleArray = (PHANDLE *)malloc(1024);
    exitWithErrorNoMemory(handleArray);
}
 
static void cleanupEnvironment(PHANDLE handleArray, PPROCESS_MEMORY_COUNTERS memoryCounterData, PCHAR *processNames, DWORD openProcesses)
{
    free(memoryCounterData);
    // TODO do cleanup like frees and handle closes here
    // Hint: Free the Handle array
    closeProcessList(handleArray, openProcesses);
    free(handleArray);
 
}
 
int main()
{
    PHANDLE handleArray;
    DWORD openProcesses;
    PPROCESS_MEMORY_COUNTERS memoryCounterData;
    PERFORMANCE_INFORMATION perfInfo;
    PCHAR *processNames;
 
    initEnvironment(&handleArray);
    openProcesses = processesToHandles(handleArray);
    memoryCounterData = (PPROCESS_MEMORY_COUNTERS) calloc(openProcesses, sizeof(PROCESS_MEMORY_COUNTERS));
    exitWithErrorNoMemory(memoryCounterData);
 
    getMemoryInfoForHandles(handleArray, memoryCounterData, openProcesses);
    processNames = getProcessNameForHandles(handleArray, openProcesses);
    perfInfo = getSystemInfo();
    printSystemInfo(perfInfo);
    printTableInfo(memoryCounterData, processNames, openProcesses);
    cleanupEnvironment(handleArray, memoryCounterData, processNames, openProcesses);
    return 0;
}
 
