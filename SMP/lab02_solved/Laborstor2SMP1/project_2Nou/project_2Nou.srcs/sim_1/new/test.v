`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2021 11:38:51
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


module test(

    );
    wire AS_0;
  reg CLK_0;
  wire [23:22]C_0;
  wire FC0_0;
  wire FC1_0;
  wire FC2_0;
  reg H1_0;
  wire Hdoi_0;
  reg IPL0_1;
  reg IPL1_1;
  reg IPL2_1;
  reg IRESET_1;
  wire LDS_0;
  reg PA7_0;
  wire PAI0_0;
  wire PAI1_0;
  wire PAI2_0;
  wire PAI3_0;
  wire PAI4_0;
  wire PAI5_0;
  wire PAI6_0;
  reg PC0_0;
  reg PC1_0;
  reg PC6_0;
  wire PIC5_0;
  wire UDS_0;
  wire ceva_0;
    
    design_1_wrapper lab2(AS_1,
    CLK_0,
    C_0,
    DTACKi_0,
    FC0_1,
    FC1_1,
    FC2_1,
    H1_0,
    Hdoi_0,
    IPL0_1,
    IPL1_1,
    IPL2_1,
    IRESET_1,
    LDS_0,
    PA7_0,
    PAI0_0,
    PAI1_0,
    PAI2_0,
    PAI3_0,
    PAI4_0,
    PAI5_0,
    PAI6_0,
    PC0_0,
    PC1_0,
    PC6_0,
    PC_0,
    PIC5_0,
    ceva_0);
    
    initial begin
        CLK_0 = 0;
        H1_0 = 1;
        IPL0_1 = 0;
        IPL1_1 = 0;
        IPL2_1 = 0;
        IRESET_1 = 1;
        PA7_0 = 0;
        PC0_0 = 0;
        PC1_0 = 1;
        PC6_0 = 0;
        #10 IRESET_1 = 0;
    end
    
    always #5 CLK_0 = ~CLK_0;
endmodule
