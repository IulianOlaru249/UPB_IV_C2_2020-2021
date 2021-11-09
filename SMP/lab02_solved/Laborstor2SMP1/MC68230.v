module MC68230 (PAI0, PAI1, PAI2, PAI3, PAI4, PAI5, PAI6, PA7, Hdoi, H1, PC0, PC1, D, RSi, CS, PC6, PIC5, DTACKi, RW, RESET, CLK, ceva) ;

input PA7 ;
input CS ;
input PC6 ;
input RW ;
input RESET ;
input CLK ;
input [0:7] D;
input [5:1] RSi ;
input H1 ;
input PC0 ;
input PC1 ;

output PAI0 ;
output PAI1 ;
output PAI2 ;
output PAI3 ;
output PAI4 ;
output PAI5 ;
output PAI6 ;
output Hdoi ;
output PIC5 ;
output DTACKi ;
output ceva ;

reg PAI0 ; 
reg PAI1 ; 
reg PAI2 ;
reg PAI3 ;
reg PAI4 ;
reg PAI5 ;
reg PAI6 ;
reg PIC5 ;
reg DTACKi ;
reg Hdoi ;
reg ceva ;

// add your declarations here

always @(posedge CLK)
begin

if (RSi == 5'b00001)
  begin
  ceva = 1'b1 ;
  end
else
  begin
  ceva = 1'b0 ;
  end

if (CS == 1'b1)					// chip select din address decode
  begin
  if (RW == 1'b0 && RESET == 1'b0)		// rw la de proc, si reset la fel
    begin
    if (PC1 == 1'b1 && PA7 == 1'b0)		// PC = printer select de la printer PA7 = busy
      begin
      if (H1 == 1'b1)				//daca are ack de la printer
        begin
          if (PC0 == 1'b1)			// printer error
            begin
            DTACKi = 1'b0;
            end
          else if (PC0 == 1'b0)
            begin
            if (RSi == 5'b00001)			// daca e adresa
              begin
              DTACKi = 1'b1;  
              PIC5 = 1'b0;				//IRQ e pe 0
              PAI0 = D[0];				//trimit date
              PAI1 = D[1];
              PAI2 = D[2];
              PAI3 = D[3];
              PAI4 = D[4];
              PAI5 = D[5];
              PAI6 = D[6];
              Hdoi = 1'b1;				//data srtrobe
              end
            else
              begin
              PIC5 = 1'b0;				//trimit IRQ
              Hdoi = 1'b0;
              DTACKi = 1'b1;
	      end
            end
        end
      else if (H1 == 1'b0)
        begin
        PIC5 = 1'b0;				//trimit IRQ
        Hdoi = 1'b0;
        DTACKi = 1'b0;
        end
      end //pc1
    else if (PC1 == 1'b0 && PA7 == 1'b1)
      begin
      PIC5 = 1'b0;				//trimit IRQ
      Hdoi = 1'b0;
      DTACKi = 1'b0;      
      end
    end //rw
  else if (RW == 1'b1 && RESET == 1'b1)		// daca nu e pe write
    begin
    PIC5 = 1'b0;				//trimit IRQ
    Hdoi = 1'b0;
    DTACKi = 1'b0;
    end
  end  // cs
else if (CS == 1'b0)				// nu e selectat controlerul
  begin
  Hdoi = 1'b0;				// zero pe date send -> print
  DTACKi = 1'b0;				// nu mai cere date de la proc
  end
end

// add your code here

endmodule 
