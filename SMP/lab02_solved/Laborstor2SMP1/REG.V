module REG (A, Ao, Ao1, C) ;

input [23:1] A ;
output [5:1] Ao ;
output [21:6] Ao1 ;
output [23:22] C ;

// add your declarations here
assign Ao = A[5:1];
assign Ao1 = A[21:6];
assign C = A[23:22];
// add your code here

endmodule 
