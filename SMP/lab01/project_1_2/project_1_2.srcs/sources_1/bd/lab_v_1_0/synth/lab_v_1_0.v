//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Sun Oct 24 20:15:50 2021
//Host        : ghostmachine running 64-bit Linux Mint 19.3 Tricia
//Command     : generate_target lab_v_1_0.bd
//Design      : lab_v_1_0
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "lab_v_1_0,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=lab_v_1_0,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,da_clkrst_cnt=1,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "lab_v_1_0.hwdef" *) 
module lab_v_1_0
   (clk_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, CLK_DOMAIN lab_v_1_0_clk_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input clk_0;

  wire clk_0_1;
  wire core_logic_0_gnt;
  wire [2:0]core_logic_0_st;
  wire graphic_controller_0_inta;
  wire graphic_controller_0_intb;
  wire graphic_controller_0_pipe;
  wire graphic_controller_0_rbf;
  wire graphic_controller_0_req;
  wire graphic_controller_0_sb_stb;
  wire [7:0]graphic_controller_0_sba;
  wire graphic_controller_0_serr;

  assign clk_0_1 = clk_0;
  lab_v_1_0_core_logic_0_0 core_logic_0
       (.clk(clk_0_1),
        .gnt(core_logic_0_gnt),
        .inta(graphic_controller_0_inta),
        .intb(graphic_controller_0_intb),
        .pipe(graphic_controller_0_pipe),
        .rbf(graphic_controller_0_rbf),
        .req(graphic_controller_0_req),
        .sb_stb(graphic_controller_0_sb_stb),
        .sba(graphic_controller_0_sba),
        .serr(graphic_controller_0_serr),
        .st(core_logic_0_st));
  lab_v_1_0_graphic_controller_0_0 graphic_controller_0
       (.clk(clk_0_1),
        .gnt(core_logic_0_gnt),
        .inta(graphic_controller_0_inta),
        .intb(graphic_controller_0_intb),
        .pipe(graphic_controller_0_pipe),
        .rbf(graphic_controller_0_rbf),
        .req(graphic_controller_0_req),
        .sb_stb(graphic_controller_0_sb_stb),
        .sba(graphic_controller_0_sba),
        .serr(graphic_controller_0_serr),
        .st(core_logic_0_st));
endmodule
