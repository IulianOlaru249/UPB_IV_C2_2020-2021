//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Tue Nov  9 16:39:47 2021
//Host        : ghostmachine running 64-bit Linux Mint 19.3 Tricia
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
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
  input CLK_0;
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

  wire AS_1;
  wire CLK_0;
  wire [23:22]C_0;
  wire DTACKi_0;
  wire FC0_1;
  wire FC1_1;
  wire FC2_1;
  wire H1_0;
  wire Hdoi_0;
  wire IPL0_1;
  wire IPL1_1;
  wire IPL2_1;
  wire IRESET_1;
  wire LDS_0;
  wire PA7_0;
  wire PAI0_0;
  wire PAI1_0;
  wire PAI2_0;
  wire PAI3_0;
  wire PAI4_0;
  wire PAI5_0;
  wire PAI6_0;
  wire PC0_0;
  wire PC1_0;
  wire PC6_0;
  wire [2:0]PC_0;
  wire PIC5_0;
  wire ceva_0;

  design_1 design_1_i
       (.AS_1(AS_1),
        .CLK_0(CLK_0),
        .C_0(C_0),
        .DTACKi_0(DTACKi_0),
        .FC0_1(FC0_1),
        .FC1_1(FC1_1),
        .FC2_1(FC2_1),
        .H1_0(H1_0),
        .Hdoi_0(Hdoi_0),
        .IPL0_1(IPL0_1),
        .IPL1_1(IPL1_1),
        .IPL2_1(IPL2_1),
        .IRESET_1(IRESET_1),
        .LDS_0(LDS_0),
        .PA7_0(PA7_0),
        .PAI0_0(PAI0_0),
        .PAI1_0(PAI1_0),
        .PAI2_0(PAI2_0),
        .PAI3_0(PAI3_0),
        .PAI4_0(PAI4_0),
        .PAI5_0(PAI5_0),
        .PAI6_0(PAI6_0),
        .PC0_0(PC0_0),
        .PC1_0(PC1_0),
        .PC6_0(PC6_0),
        .PC_0(PC_0),
        .PIC5_0(PIC5_0),
        .ceva_0(ceva_0));
endmodule
