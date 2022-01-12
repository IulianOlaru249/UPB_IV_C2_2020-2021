//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Tue Jan 11 15:30:35 2022
//Host        : ghostmachine running 64-bit Linux Mint 19.3 Tricia
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (oe_0);
  input oe_0;

  wire oe_0;

  design_1 design_1_i
       (.oe_0(oe_0));
endmodule
