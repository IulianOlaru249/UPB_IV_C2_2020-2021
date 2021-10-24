//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Sun Oct 24 20:15:51 2021
//Host        : ghostmachine running 64-bit Linux Mint 19.3 Tricia
//Command     : generate_target lab_v_1_0_wrapper.bd
//Design      : lab_v_1_0_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module lab_v_1_0_wrapper
   (clk_0);
  input clk_0;

  wire clk_0;

  lab_v_1_0 lab_v_1_0_i
       (.clk_0(clk_0));
endmodule
