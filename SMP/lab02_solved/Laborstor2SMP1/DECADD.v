module Decadd (Ai, LDSi, UDSi, CSo, CLK) ;

input [21:6] Ai ;
input LDSi ;
input UDSi ;
input CLK ;
output CSo ;

reg CSo;

// add your declarations here
always @(posedge CLK)
begin
  if (LDSi == 1'b0 && UDSi == 1'b1)
    begin
        CSo = 1'b1;
     end
  else 
    begin
    CSo = 1'b0;
    end
if (Ai ==16'h0370)
  begin
  CSo = 1'b1;
  end
end
// add your code here

endmodule 

