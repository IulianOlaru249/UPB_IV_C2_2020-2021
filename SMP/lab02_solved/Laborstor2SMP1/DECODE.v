module decode (Ai, LDSi, UDSi, RWi, CSo, CLK) ;

input [21:6] Ai ;
input LDSi ;
input UDSi ;
input RWi ;
input CLK ;
output CSo ;

reg CSo;

// add your declarations here
always @(posedge CLK)
begin
if (Ai == 16'h0378)
  begin
  if (LDSi == 1'b0 && UDSi == 1'b1)
    begin
      if (RWi == 1'b0)
        begin
        CSo = 1'b1;
        end
      else
        begin
        CSo = 1'b0;
        end
    end
  else 
    begin
    CSo = 1'b0;
    end
  end
else
  begin
  CSo = 1'b0;
  end
end
// add your code here

endmodule 

