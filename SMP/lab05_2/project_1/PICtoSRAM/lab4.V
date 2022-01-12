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

module T74LS373(out_fst,dat,oe,le);
output [7:0]out_fst;
reg [7:0]out_fst;
input [7:0]dat;
input oe,le;
reg [7:0]la;
	
	always@(posedge le) assign la=dat; //latch transparent
	always@(negedge le) assign la=la;
	always@(posedge oe) assign out_fst=8'hz;
	always@(negedge oe) assign out_fst=la;

endmodule

module T74LS04(out_snd,in_snd);
input in_snd;
output out_snd;

	assign out_snd=!in_snd;

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
	$display("*\n");
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

//module test;
//wire [7:0]ad1;
//wire [7:0]ad2;
//wire [7:0]datw;
//wire [7:0]la;
//reg oe;
//wire [3:0]dum;

//initial oe=0;

//PIC16F873 picul({dum,we,le},ad1,datw,ad2);
//m62256 mem1(datw,ad1,{ad2[6:0],la},sel,sel,we);
//m62256 mem2(datw,ad1,{ad2[6:0],la},ad2[7],ad2[7],we);
//T74LS373 lat(la,ad1,oe,le);
//T74LS04 inv(sel,ad2[7]);
		
//	initial $monitor("T:%d datw:%X ad1:%b ad2:%b la:%b le:%b we:%b",$time,datw,ad1,ad2,la,le,we);

//endmodule