`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2022 09:51:36 PM
// Design Name: 
// Module Name: gmch
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


module gmch(
    input [0:1]TXP_A,
    input [0:1]TXN_A,
    input [2:3]TXP,
    input [2:3]TXN,
    
    output [0:1]RXP_A,
    output [0:1]RXN_A,
    output [2:3]RXP,
    output [2:3]RXN,
    
    output DMI_ZCOMP,
    input DMI_IRCOMP,
    
    inout [35:3]HA,
    inout [63:0]HD,
    inout HADS,
    inout HBNR,
    input HBPRI,
    inout HDBSY,
    input HDEFER,
    inout HHIT,
    inout HHITM,
    inout HLOCK,
    inout [4:0]HREQ,
    output HPCREQ,
    input HTRDY,
    input [2:0]HRS,
    inout HBREQ0,
    inout [3:0]HDINV,
    inout [1:0]HADSTB,
    inout [3:0]HDSTBP,
    output [2:0]BSEL,
    inout HRCOMP,
    inout HSCOMP,
    inout HSCOMP_C,
    output HSWING,
    output HDVREF,
    output HACCVREF,
    
    input [1:0]SCS_A,
    input [14:0]SMA_A,
    input  [2:0]SBS_A,
    input SRAS_A,
    input SCAS_A,
    input SWE_A,
    inout [63:0]SDQ_A,
    input [7:0]SDM_A,
    inout [7:0]SDQS_A,
    input [3:0]SCKE_A,
    input [2:0]SCLK_A,
    input [1:0]SODT_A
    );
endmodule
