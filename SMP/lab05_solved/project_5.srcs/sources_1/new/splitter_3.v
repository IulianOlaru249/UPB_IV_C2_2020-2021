`timescale 1ns / 1ps

module splitter3(
    d_in, d_out
    );
    input [5:0] d_in;
    output d_out;
    
    assign d_out = d_in[1];
endmodule