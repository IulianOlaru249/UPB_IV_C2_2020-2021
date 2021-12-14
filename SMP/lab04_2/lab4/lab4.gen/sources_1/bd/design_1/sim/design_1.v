//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
//Date        : Tue Nov 23 17:46:49 2021
//Host        : DESKTOP-04HOUK7 running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=3,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (clk_0,
    clk_1);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, CLK_DOMAIN design_1_arbiter_0_0_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output clk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_1 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_1, CLK_DOMAIN design_1_bus_0_0_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output clk_1;

  wire arbiter_0_bb;
  wire arbiter_0_bg;
  wire arbiter_0_clk;
  wire arbiter_0_lock;
  wire arbiter_0_req;
  wire bus_0_clk;
  wire bus_0_gnt;
  wire dsp_0_ba;
  wire dsp_0_bl;
  wire dsp_0_br;

  assign clk_0 = arbiter_0_clk;
  assign clk_1 = bus_0_clk;
  design_1_arbiter_0_0 arbiter_0
       (.ba(dsp_0_ba),
        .bb(arbiter_0_bb),
        .bg(arbiter_0_bg),
        .bl(dsp_0_bl),
        .br(dsp_0_br),
        .clk(arbiter_0_clk),
        .clkpci(bus_0_clk),
        .gnt(bus_0_gnt),
        .lock(arbiter_0_lock),
        .req(arbiter_0_req));
  design_1_bus_0_0 bus_0
       (.clk(bus_0_clk),
        .gnt(bus_0_gnt),
        .lock(arbiter_0_lock),
        .req(arbiter_0_req));
  design_1_dsp_0_0 dsp_0
       (.ba(dsp_0_ba),
        .bb(arbiter_0_bb),
        .bg(arbiter_0_bg),
        .bl(dsp_0_bl),
        .br(dsp_0_br),
        .clk(arbiter_0_clk));
endmodule
