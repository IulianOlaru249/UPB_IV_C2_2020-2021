module Printer (Data1, Data2, Data3, Data4, Data5, Data6, Data7, DataStrobe, PE, SLCT, BUSY, ACK, CLK, DA) ;

input CLK;
input Data1 ;
input Data2 ;
input Data3 ;
input Data4 ;
input Data5 ;
input Data6 ;
input Data7 ;
input DataStrobe ;

output PE ;
output SLCT ;
output BUSY ;
output ACK ;
output [7:1] DA ;

reg SLCT, BUSY, PE, ACK ;
reg [7:1] DA;

// add your declarations here
always @(posedge CLK)
begin
  if (DataStrobe == 1'b1)
    begin
    PE = 1'b0;
    SLCT = 1'b1;
    ACK = 1'b1;
    BUSY = 1'b0;
    DA[1] = Data1;
    DA[2] = Data2;
    DA[3] = Data3;
    DA[4] = Data4;
    DA[5] = Data5;
    DA[6] = Data6;
    DA[7] = Data7;
    end
  else
    begin
    PE = 1'b1;
    BUSY = 1'b1;
    ACK = 1'b0;
    SLCT = 1'b0;
    DA = 7'b0;
    end
end
// add your code here

endmodule 
