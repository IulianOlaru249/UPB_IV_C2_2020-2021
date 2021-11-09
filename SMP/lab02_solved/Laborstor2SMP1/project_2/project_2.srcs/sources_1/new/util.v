`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2021 18:48:46
// Design Name: 
// Module Name: util
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


module util(
    input [15:0] d,
    output [7:0] d1,
    output [7:0] d2
    );
    
    assign d1 = d[15:8];
    assign d2 = d[7:0];
endmodule
