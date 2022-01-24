`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2022 10:05:16 PM
// Design Name: 
// Module Name: ddr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ddr(
    output [1:0]SCS_A,
    output [14:0]SMA_A,
    output  [2:0]SBS_A,
    output SRAS_A,
    output SCAS_A,
    output SWE_A,
    inout [63:0]SDQ_A,
    output [7:0]SDM_A,
    inout [7:0]SDQS_A,
    output [3:0]SCKE_A,
    output [2:0]SCLK_A,
    output [1:0]SODT_A
    );
endmodule
