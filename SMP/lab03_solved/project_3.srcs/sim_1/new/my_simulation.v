`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2020 11:04:17 AM
// Design Name: 
// Module Name: my_simulation
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
module my_simulation();

    reg clk;
    design_1_wrapper top(clk);
    initial begin
        clk = 0;
    end
    always begin
        #50 clk = ~clk;
    end
endmodule
