`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2021 08:47:22 PM
// Design Name: 
// Module Name: select
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


module select( d_in1, d_in2, not_in, oe, d_out
   );
   input [7:0] d_in1;
   input [7:0] d_in2;
   input not_in;
   input oe;
   output [7:0] d_out;
   reg [7:0] d_out;
   
   always@(*) 
   if(oe) 
   begin
       if (!not_in) assign d_out = d_in1;
       if (not_in) assign d_out=d_in2;
   end    
   else d_out = 8'bZZZZZZZZ;
   
endmodule
