`timescale 1ns / 1ps

module chip_select(
    d_in1, d_in2, not_in, oe, d_out
    );
    input [7:0] d_in1;
    input [7:0] d_in2;
    input not_in;
    input oe;
    output [7:0] d_out;
    reg [7:0] d_out;
    
	always@(*)
	 
	if (!oe) 
        begin
            if (!not_in) assign d_out = d_in1;
            if (not_in) assign d_out = d_in2;
        end	
    else 
        d_out = 8'bZZZZZZZZ;
    
endmodule
