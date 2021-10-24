`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 07:53:12 PM
// Design Name: 
// Module Name: test_1
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


module test_1(

    );
    
    reg clk_0;
    lab_v_1_0_wrapper top(clk_0);
    
    initial begin
        clk_0 = 0;
    end
    
    always #10 clk_0 = ~clk_0;
     
    
endmodule
