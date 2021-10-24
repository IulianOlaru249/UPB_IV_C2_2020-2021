`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2021 08:12:46 PM
// Design Name: 
// Module Name: test1
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


module test1(

    );
    
    reg clk_0;
    
    design_1_wrapper lab1(clk_0);
    
    initial begin
        clk_0 = 0;
    end
    
    always #10 clk_0 = ~clk_0;
    
endmodule
