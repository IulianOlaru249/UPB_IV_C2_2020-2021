`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2021 05:41:19 PM
// Design Name: 
// Module Name: test
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


module test();

    reg ARB_clk;
    reg PCI_clk;
    
    design_1_wrapper d(ARB_clk,PCI_clk);
    
    initial begin
    ARB_clk = 0;
    PCI_clk = 0;
    end
    
    always begin
    #5 ARB_clk = ~ARB_clk; PCI_clk = ~PCI_clk;
    end
endmodule
