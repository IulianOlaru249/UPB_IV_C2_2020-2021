`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2022 09:51:36 PM
// Design Name: 
// Module Name: ich8
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

module ich8(
    output [0:1]TXP_A,
    output [0:1]TXN_A,
    output [2:3]TXP,
    output [2:3]TXN,
    
    input [0:1]RXP_A,
    input [0:1]RXN_A,
    input [2:3]RXP,
    input [2:3]RXN,
    
    input DMI_ZCOMP,
    output DMI_IRCOMP,
    
    inout [7:0]P,
    inout [7:0]N,
    output [4:0]OC,
    output  GPIO29,
    output  GPIO30,
    output  GPIO31,
    output USBRBIAS_I,
    input USBRBIAS_O
    
    );
 
endmodule
