module m62256(dat,datw,adr,ce,oe,we);
output [7:0]dat;
reg [7:0]dat;
input [7:0]datw;
input [14:0]adr;
input ce,oe,we;
reg [7:0] mem [32767:0];

	always@(negedge oe) assign dat=dat;
	always@(posedge oe) assign dat=8'hz;
	always@(adr) if(!ce) assign dat=mem[adr];
	always@(negedge we) if(!ce) mem[adr]=datw;

endmodule

module T74LS373(outh,dat,oe,le);
output [7:0]outh;
reg [7:0]outh;
input [7:0]dat;
input oe,le;
reg [7:0]la;
	
	always@(posedge le) assign la=dat; //latch transparent
	always@(negedge le) assign la=la;
	always@(posedge oe) assign outh=8'hz;
	always@(negedge oe) assign outh=la;

endmodule

module T74LS04(outt,inn);
input inn;
output outt;

	assign outt=!inn;

endmodule

module PIC16F873(porta,portb,portbw,portc);
output [5:0]porta;
reg [5:0]porta;
output [7:0]portb;
reg [7:0]portb;
output [7:0]portc;
reg [7:0]portc;
input [7:0]portbw;
reg [7:0]mem [367:0];
integer co;

	initial
	begin
	porta[1:0]=2'b10;
	portc=0;
		for(co=0;co<8;co=co+1)
		begin
			porta[1]=1;
			portb=co; 
			porta[0]=1; //latch enable
			#5;
			porta[0]=0;
			portb=7-co; //punem datele
			porta[1]=0;  //write
			#5;
		end
	$display("---\n");
	portc=8'hFF;
		for(co=0;co<8;co=co+1)
		begin
			porta[1]=1;
			portb=co; 
			porta[0]=1; //latch enable
			#5;
			porta[0]=0;
			portb=7-co; //punem datele
			porta[1]=0;  //write
			#5;
		end	
	$display("***\n");
	portc=0;
	porta[1]=1;
		for(co=0;co<8;co=co+1)
		begin				
			portb=co; 
			porta[0]=1; //latch enable
			#5;
			porta[0]=0;
			mem[co]=portbw; //punem datele
			#5;
		end
	//for(co=0;co<8;co=co+1) $display("%d ",mem[co]);
	$display("---\n");
	portc=8'hFF;
		for(co=0;co<8;co=co+1)
		begin
			porta[1]=1;
			portb=co; 
			porta[0]=1; //latch enable
			#5;
			porta[0]=0;
			mem[co]=portbw; //punem datele
			#5;
		end
	//for(co=0;co<8;co=co+1) $display("%d ",mem[co]);
	end
	
endmodule
