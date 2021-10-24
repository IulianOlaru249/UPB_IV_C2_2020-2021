//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Sun Oct 24 20:26:11 2021
//Host        : ghostmachine running 64-bit Linux Mint 19.3 Tricia
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (clk_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, CLK_DOMAIN design_1_clk_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input clk_0;

  wire clk_0_1;
  wire core_logic_0_ad_stb0;
  wire core_logic_0_ad_stb1;
  wire core_logic_0_gnt;
  wire [2:0]core_logic_0_st;
  wire core_logic_0_trdy;
  wire [31:0]graphic_controller_0_ad;
  wire [3:0]graphic_controller_0_c_be;
  wire graphic_controller_0_inta;
  wire graphic_controller_0_intb;
  wire graphic_controller_0_irdy;
  wire graphic_controller_0_pipe;
  wire graphic_controller_0_rbf;
  wire graphic_controller_0_req;
  wire graphic_controller_0_sb_stb;
  wire [7:0]graphic_controller_0_sba;
  wire graphic_controller_0_serr;

  assign clk_0_1 = clk_0;
  design_1_core_logic_0_0 core_logic_0
       (.ad(graphic_controller_0_ad),
        .ad_stb0(core_logic_0_ad_stb0),
        .ad_stb1(core_logic_0_ad_stb1),
        .c_be(graphic_controller_0_c_be),
        .clk(clk_0_1),
        .gnt(core_logic_0_gnt),
        .inta(graphic_controller_0_inta),
        .intb(graphic_controller_0_intb),
        .irdy(graphic_controller_0_irdy),
        .pipe(graphic_controller_0_pipe),
        .rbf(graphic_controller_0_rbf),
        .req(graphic_controller_0_req),
        .sb_stb(graphic_controller_0_sb_stb),
        .sba(graphic_controller_0_sba),
        .serr(graphic_controller_0_serr),
        .st(core_logic_0_st),
        .trdy(core_logic_0_trdy));
  design_1_graphic_controller_0_0 graphic_controller_0
       (.ad(graphic_controller_0_ad),
        .ad_stb0(core_logic_0_ad_stb0),
        .ad_stb1(core_logic_0_ad_stb1),
        .c_be(graphic_controller_0_c_be),
        .clk(clk_0_1),
        .gnt(core_logic_0_gnt),
        .inta(graphic_controller_0_inta),
        .intb(graphic_controller_0_intb),
        .irdy(graphic_controller_0_irdy),
        .pipe(graphic_controller_0_pipe),
        .rbf(graphic_controller_0_rbf),
        .req(graphic_controller_0_req),
        .sb_stb(graphic_controller_0_sb_stb),
        .sba(graphic_controller_0_sba),
        .serr(graphic_controller_0_serr),
        .st(core_logic_0_st),
        .trdy(core_logic_0_trdy));
endmodule
