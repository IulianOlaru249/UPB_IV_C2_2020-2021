module MC68000 (CLK, D, A, LDS, FC2, FC1, FC0, AS, UDS, RW, RESET, DTACK, IPL2, IPL1, IPL0, IRESET, PC) ;

input CLK ;
input DTACK ;
input IPL0 ;
input IPL1 ;
input IPL2 ;
input IRESET ;

output [2:0] PC ;
output [15:0] D ;
output [23:1] A ;
output LDS ;
output FC2 ;
output FC1 ;
output FC0 ;
output AS ;
output UDS ;
output RW ;
output RESET ;

reg [7:0] Mem [7:0];
reg [2:0] PC;
reg LDS, UDS, RW, RESET, FC2, FC1, FC0, AS;
reg [15:0] D;
reg [23:1] A;

// add your declarations here

always @(negedge CLK)
  begin
  #1 Mem[0] = 8'b00000010;
  #1 Mem[1] = 8'b00000110;
  #1 Mem[2] = 8'b00001110;
  #1 Mem[3] = 8'b00011110;
  #1 Mem[4] = 8'b00111110;
  #1 Mem[5] = 8'b01111110;
  #1 Mem[6] = 8'b11111110;
  #1 Mem[7] = 8'b11111100;
//  #1 PC = 3'b000;
  
  LDS = 1'b0;		// iese negat
  UDS = 1'b1;		// iesenegat
  RW = 1'b0;
  if (IRESET == 1'b1)
    begin
    RESET = 0;		//se inverseza
    PC = 3'b000;
    D[15:0] = 16'b0;
    A[23:1] = 23'b0;
    end
  else
    begin
    if ((IPL2 == 1'b1) && (IPL1 == 1'b1))	// daca printer e BUSY
      begin
      if (IPL0 == 1'b1)
        begin
        PC = 3'b000;	// program counter
        FC2 = 1'b1;		// raspuns PIACK
        FC1 = 1'b1;		// la cerere de intrerupere 
        FC0 = 1'b1;		// de la MC68320
        AS = 1'b1;
        A[23:22] = 2'b11;			//la interupt ack    
        end
      if (IPL0 == 1'b0)
        begin
        FC2 = 1'b1;		// raspuns PIACK
        FC1 = 1'b1;		// la cerere de intrerupere 
        FC0 = 1'b1;		// de la MC68320
        AS = 1'b1;
        A[23:22] = 2'b11;			//la interupt ack
        end
      end
    else
      begin
      if (DTACK == 1'b1)			// pot sa transmit date
        begin
        D[7:0] = Mem[PC];
        D[15:8] = Mem[PC];
        A[5:1] = 5'b00001;		//lpt1
        A[21:6] = 16'h0378;		//adr lpt1
        A[23:22] = 2'b00;			//la interupt ack
        PC = PC +1;      
        end
      else 
        begin
        D[15:0] = 16'b0;
        A[23:1] = 23'b0;
        end
      end
    end
  end
// add your code here

endmodule 
