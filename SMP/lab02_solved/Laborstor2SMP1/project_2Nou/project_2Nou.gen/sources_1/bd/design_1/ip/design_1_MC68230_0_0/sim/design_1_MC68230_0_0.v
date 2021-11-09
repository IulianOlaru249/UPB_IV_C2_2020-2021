// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:MC68230:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_MC68230_0_0 (
  PAI0,
  PAI1,
  PAI2,
  PAI3,
  PAI4,
  PAI5,
  PAI6,
  PA7,
  Hdoi,
  H1,
  PC0,
  PC1,
  D,
  RSi,
  CS,
  PC6,
  PIC5,
  DTACKi,
  RW,
  RESET,
  CLK,
  ceva
);

output wire PAI0;
output wire PAI1;
output wire PAI2;
output wire PAI3;
output wire PAI4;
output wire PAI5;
output wire PAI6;
input wire PA7;
output wire Hdoi;
input wire H1;
input wire PC0;
input wire PC1;
input wire [0 : 7] D;
input wire [5 : 1] RSi;
input wire CS;
input wire PC6;
output wire PIC5;
output wire DTACKi;
input wire RW;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RESET, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RESET RST" *)
input wire RESET;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK, ASSOCIATED_RESET RESET, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_CLK_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK CLK" *)
input wire CLK;
output wire ceva;

  MC68230 inst (
    .PAI0(PAI0),
    .PAI1(PAI1),
    .PAI2(PAI2),
    .PAI3(PAI3),
    .PAI4(PAI4),
    .PAI5(PAI5),
    .PAI6(PAI6),
    .PA7(PA7),
    .Hdoi(Hdoi),
    .H1(H1),
    .PC0(PC0),
    .PC1(PC1),
    .D(D),
    .RSi(RSi),
    .CS(CS),
    .PC6(PC6),
    .PIC5(PIC5),
    .DTACKi(DTACKi),
    .RW(RW),
    .RESET(RESET),
    .CLK(CLK),
    .ceva(ceva)
  );
endmodule
