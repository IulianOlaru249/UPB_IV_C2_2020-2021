//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
//Date        : Tue Nov 23 17:46:49 2021
//Host        : DESKTOP-04HOUK7 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk_0,
    clk_1);
  output clk_0;
  output clk_1;

  wire clk_0;
  wire clk_1;

  design_1 design_1_i
       (.clk_0(clk_0),
        .clk_1(clk_1));
endmodule
