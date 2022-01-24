`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2022 09:51:36 PM
// Design Name: 
// Module Name: usb
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


module usb(
    inout [7:0]P,
    inout [7:0]N,
    input [4:0]OC,
    input  GPIO29,
    input  GPIO30,
    input  GPIO31,
    input USBRBIAS_I,
    output USBRBIAS_O
    );
endmodule
