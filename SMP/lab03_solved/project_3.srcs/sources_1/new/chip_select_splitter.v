`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2020 10:53:23 AM
// Design Name: 
// Module Name: chip_select_splitter
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
module chip_select_splitter(
    a, b
    );
    input [0:7] a;
    output b;
    assign b = a[7];
    
endmodule
