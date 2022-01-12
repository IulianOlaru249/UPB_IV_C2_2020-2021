//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Tue Jan 11 15:30:35 2022
//Host        : ghostmachine running 64-bit Linux Mint 19.3 Tricia
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=9,numReposBlks=9,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=9,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (oe_0);
  input oe_0;

  wire [5:0]PIC16F873_0_porta;
  wire [7:0]PIC16F873_0_portb;
  wire [7:0]PIC16F873_0_portc;
  wire T74LS04_0_outt;
  wire [7:0]T74LS373_0_outh;
  wire [7:0]chip_select_0_d_out;
  wire [7:0]m62256_0_dat;
  wire [7:0]m62256_1_dat;
  wire oe_0_1;
  wire splitter3_0_d_out;
  wire splitter_1_0_d_out;
  wire [14:0]splitter_1_0_d_out2;
  wire splitter_2_0_d_out;

  assign oe_0_1 = oe_0;
  design_1_PIC16F873_0_0 PIC16F873_0
       (.porta(PIC16F873_0_porta),
        .portb(PIC16F873_0_portb),
        .portbw(chip_select_0_d_out),
        .portc(PIC16F873_0_portc));
  design_1_T74LS04_0_0 T74LS04_0
       (.inn(splitter_1_0_d_out),
        .outt(T74LS04_0_outt));
  design_1_T74LS373_0_0 T74LS373_0
       (.dat(PIC16F873_0_portb),
        .le(splitter_2_0_d_out),
        .oe(oe_0_1),
        .outh(T74LS373_0_outh));
  design_1_chip_select_0_0 chip_select_0
       (.d_in1(m62256_1_dat),
        .d_in2(m62256_0_dat),
        .d_out(chip_select_0_d_out),
        .not_in(T74LS04_0_outt),
        .oe(splitter3_0_d_out));
  design_1_m62256_0_0 m62256_0
       (.adr(splitter_1_0_d_out2),
        .ce(splitter_1_0_d_out),
        .dat(m62256_0_dat),
        .datw(PIC16F873_0_portb),
        .oe(splitter_1_0_d_out),
        .we(splitter3_0_d_out));
  design_1_m62256_1_0 m62256_1
       (.adr(splitter_1_0_d_out2),
        .ce(T74LS04_0_outt),
        .dat(m62256_1_dat),
        .datw(PIC16F873_0_portb),
        .oe(T74LS04_0_outt),
        .we(splitter3_0_d_out));
  design_1_splitter3_0_0 splitter3_0
       (.d_in(PIC16F873_0_porta),
        .d_out(splitter3_0_d_out));
  design_1_splitter_1_0_0 splitter_1_0
       (.d_in(PIC16F873_0_portc),
        .d_out(splitter_1_0_d_out),
        .d_out2(splitter_1_0_d_out2),
        .out_in(T74LS373_0_outh));
  design_1_splitter_2_0_0 splitter_2_0
       (.d_in(PIC16F873_0_porta),
        .d_out(splitter_2_0_d_out));
endmodule
