//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Tue Dec 14 16:27:35 2021
//Host        : ghostmachine running 64-bit Linux Mint 19.3 Tricia
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (ARB_clk,
    PCI_clk);
  output ARB_clk;
  output PCI_clk;

  wire ARB_clk;
  wire PCI_clk;

  design_1 design_1_i
       (.ARB_clk(ARB_clk),
        .PCI_clk(PCI_clk));
endmodule
