//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Wed Jan 12 08:17:24 2022
//Host        : DESKTOP-VDS8009 running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=9,numReposBlks=9,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=9,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (oe_0);
  input oe_0;

  wire Net1;
  wire [5:0]PIC16F873_0_porta;
  wire [7:0]PIC16F873_0_portb;
  wire [7:0]PIC16F873_0_portc;
  wire T74LS04_0_out_snd1;
  wire [7:0]T74LS373_0_out_fst;
  wire [7:0]m62256_0_dat;
  wire [7:0]m62256_1_dat;
  wire oe_0_1;
  wire [7:0]select_0_d_out;
  wire splitter1_0_d_out;
  wire [14:0]splitter1_0_d_out2;
  wire splitter2_0_d_out;

  assign oe_0_1 = oe_0;
  design_1_PIC16F873_0_0 PIC16F873_0
       (.porta(PIC16F873_0_porta),
        .portb(PIC16F873_0_portb),
        .portbw(select_0_d_out),
        .portc(PIC16F873_0_portc));
  design_1_T74LS04_0_0 T74LS04_0
       (.in_snd(splitter1_0_d_out),
        .out_snd(T74LS04_0_out_snd1));
  design_1_T74LS373_0_0 T74LS373_0
       (.dat(PIC16F873_0_portb),
        .le(splitter2_0_d_out),
        .oe(oe_0_1),
        .out_fst(T74LS373_0_out_fst));
  design_1_m62256_0_0 m62256_0
       (.adr(splitter1_0_d_out2),
        .ce(T74LS04_0_out_snd1),
        .dat(m62256_0_dat),
        .datw(PIC16F873_0_portb),
        .oe(T74LS04_0_out_snd1),
        .we(Net1));
  design_1_m62256_1_0 m62256_1
       (.adr(splitter1_0_d_out2),
        .ce(splitter1_0_d_out),
        .dat(m62256_1_dat),
        .datw(PIC16F873_0_portb),
        .oe(splitter1_0_d_out),
        .we(Net1));
  design_1_select_0_0 select_0
       (.d_in1(m62256_0_dat),
        .d_in2(m62256_1_dat),
        .d_out(select_0_d_out),
        .not_in(T74LS04_0_out_snd1),
        .oe(Net1));
  design_1_splitter1_0_0 splitter1_0
       (.d_in(PIC16F873_0_portc),
        .d_out(splitter1_0_d_out),
        .d_out2(splitter1_0_d_out2),
        .out_in(T74LS373_0_out_fst));
  design_1_splitter2_0_0 splitter2_0
       (.d_in(PIC16F873_0_porta),
        .d_out(splitter2_0_d_out));
  design_1_splitter3_0_0 splitter3_0
       (.d_in(PIC16F873_0_porta),
        .d_out(Net1));
endmodule
