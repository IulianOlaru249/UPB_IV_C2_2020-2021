//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Tue Nov  9 16:39:47 2021
//Host        : ghostmachine running 64-bit Linux Mint 19.3 Tricia
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=4,numReposBlks=4,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=4,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (AS_1,
    CLK_0,
    C_0,
    DTACKi_0,
    FC0_1,
    FC1_1,
    FC2_1,
    H1_0,
    Hdoi_0,
    IPL0_1,
    IPL1_1,
    IPL2_1,
    IRESET_1,
    LDS_0,
    PA7_0,
    PAI0_0,
    PAI1_0,
    PAI2_0,
    PAI3_0,
    PAI4_0,
    PAI5_0,
    PAI6_0,
    PC0_0,
    PC1_0,
    PC6_0,
    PC_0,
    PIC5_0,
    ceva_0);
  output AS_1;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, CLK_DOMAIN design_1_CLK_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input CLK_0;
  output [23:22]C_0;
  output DTACKi_0;
  output FC0_1;
  output FC1_1;
  output FC2_1;
  input H1_0;
  output Hdoi_0;
  input IPL0_1;
  input IPL1_1;
  input IPL2_1;
  input IRESET_1;
  output LDS_0;
  input PA7_0;
  output PAI0_0;
  output PAI1_0;
  output PAI2_0;
  output PAI3_0;
  output PAI4_0;
  output PAI5_0;
  output PAI6_0;
  input PC0_0;
  input PC1_0;
  input PC6_0;
  output [2:0]PC_0;
  output PIC5_0;
  output ceva_0;

  wire CLK_0_1;
  wire Decadd_0_CSo;
  wire H1_0_1;
  wire IPL0_1_1;
  wire IPL1_1_1;
  wire IPL2_1_1;
  wire IRESET_1_1;
  wire [23:1]MC68000_0_A;
  wire MC68000_0_AS;
  wire [15:0]MC68000_0_D;
  wire MC68000_0_FC0;
  wire MC68000_0_FC1;
  wire MC68000_0_FC2;
  wire [2:0]MC68000_0_PC;
  wire MC68000_0_RESET;
  wire MC68000_0_RW;
  wire MC68000_0_UDS;
  wire MC68000p_0_LDS;
  wire MC68230_0_DTACKi;
  wire MC68230_0_Hdoi;
  wire MC68230_0_PAI0;
  wire MC68230_0_PAI1;
  wire MC68230_0_PAI2;
  wire MC68230_0_PAI3;
  wire MC68230_0_PAI4;
  wire MC68230_0_PAI5;
  wire MC68230_0_PAI6;
  wire MC68230_0_PIC5;
  wire MC68230_0_ceva;
  wire PA7_0_1;
  wire PC0_0_1;
  wire PC1_0_1;
  wire PC6_0_1;
  wire [5:1]REG_0_Ao;
  wire [21:6]REG_0_Ao1;
  wire [23:22]REG_0_C;

  assign AS_1 = MC68000_0_AS;
  assign CLK_0_1 = CLK_0;
  assign C_0[23:22] = REG_0_C;
  assign DTACKi_0 = MC68230_0_DTACKi;
  assign FC0_1 = MC68000_0_FC0;
  assign FC1_1 = MC68000_0_FC1;
  assign FC2_1 = MC68000_0_FC2;
  assign H1_0_1 = H1_0;
  assign Hdoi_0 = MC68230_0_Hdoi;
  assign IPL0_1_1 = IPL0_1;
  assign IPL1_1_1 = IPL1_1;
  assign IPL2_1_1 = IPL2_1;
  assign IRESET_1_1 = IRESET_1;
  assign LDS_0 = MC68000p_0_LDS;
  assign PA7_0_1 = PA7_0;
  assign PAI0_0 = MC68230_0_PAI0;
  assign PAI1_0 = MC68230_0_PAI1;
  assign PAI2_0 = MC68230_0_PAI2;
  assign PAI3_0 = MC68230_0_PAI3;
  assign PAI4_0 = MC68230_0_PAI4;
  assign PAI5_0 = MC68230_0_PAI5;
  assign PAI6_0 = MC68230_0_PAI6;
  assign PC0_0_1 = PC0_0;
  assign PC1_0_1 = PC1_0;
  assign PC6_0_1 = PC6_0;
  assign PC_0[2:0] = MC68000_0_PC;
  assign PIC5_0 = MC68230_0_PIC5;
  assign ceva_0 = MC68230_0_ceva;
  design_1_Decadd_0_0 Decadd_0
       (.Ai(REG_0_Ao1),
        .CLK(CLK_0_1),
        .CSo(Decadd_0_CSo),
        .LDSi(MC68000p_0_LDS),
        .UDSi(MC68000_0_UDS));
  design_1_MC68000_0_0 MC68000_0
       (.A(MC68000_0_A),
        .AS(MC68000_0_AS),
        .CLK(CLK_0_1),
        .D(MC68000_0_D),
        .DTACK(MC68230_0_DTACKi),
        .FC0(MC68000_0_FC0),
        .FC1(MC68000_0_FC1),
        .FC2(MC68000_0_FC2),
        .IPL0(IPL0_1_1),
        .IPL1(IPL1_1_1),
        .IPL2(IPL2_1_1),
        .IRESET(IRESET_1_1),
        .LDS(MC68000p_0_LDS),
        .PC(MC68000_0_PC),
        .RESET(MC68000_0_RESET),
        .RW(MC68000_0_RW),
        .UDS(MC68000_0_UDS));
  design_1_MC68230_0_0 MC68230_0
       (.CLK(CLK_0_1),
        .CS(Decadd_0_CSo),
        .D({MC68000_0_D[7],MC68000_0_D[6],MC68000_0_D[5],MC68000_0_D[4],MC68000_0_D[3],MC68000_0_D[2],MC68000_0_D[1],MC68000_0_D[0]}),
        .DTACKi(MC68230_0_DTACKi),
        .H1(H1_0_1),
        .Hdoi(MC68230_0_Hdoi),
        .PA7(PA7_0_1),
        .PAI0(MC68230_0_PAI0),
        .PAI1(MC68230_0_PAI1),
        .PAI2(MC68230_0_PAI2),
        .PAI3(MC68230_0_PAI3),
        .PAI4(MC68230_0_PAI4),
        .PAI5(MC68230_0_PAI5),
        .PAI6(MC68230_0_PAI6),
        .PC0(PC0_0_1),
        .PC1(PC1_0_1),
        .PC6(PC6_0_1),
        .PIC5(MC68230_0_PIC5),
        .RESET(MC68000_0_RESET),
        .RSi(REG_0_Ao),
        .RW(MC68000_0_RW),
        .ceva(MC68230_0_ceva));
  design_1_REG_0_0 REG_0
       (.A(MC68000_0_A),
        .Ao(REG_0_Ao),
        .Ao1(REG_0_Ao1),
        .C(REG_0_C));
endmodule
