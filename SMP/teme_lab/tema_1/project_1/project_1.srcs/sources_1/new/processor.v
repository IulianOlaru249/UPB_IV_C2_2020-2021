`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2022 09:51:36 PM
// Design Name: 
// Module Name: processor
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


module processor(
    inout [35:3]HA,
    inout [63:0]HD,
    inout HADS,
    inout HBNR,
    output HBPRI,
    inout HDBSY,
    output HDEFER,
    inout HHIT,
    inout HHITM,
    inout HLOCK,
    inout [4:0]HREQ,
    input HPCREQ,
    output HTRDY,
    output [2:0]HRS,
    inout HBREQ0,
    inout [3:0]HDINV,
    inout [1:0]HADSTB,
    inout [3:0]HDSTBP,
    input [2:0]BSEL,
    inout HRCOMP,
    inout HSCOMP,
    inout HSCOMP_C,
    input HSWING,
    input HDVREF,
    input HACCVREF
    );
endmodule