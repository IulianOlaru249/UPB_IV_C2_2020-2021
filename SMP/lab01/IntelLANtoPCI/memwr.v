`timescale 1ns/1ps
module i21143(clk,frame_l,ad,c_be_l,trdy_l,irdy_l,devsel_l);

parameter clk_per=10;

input trdy_l,devsel_l,clk;
output frame_l,irdy_l;
output [31:0]ad;
output [3:0] c_be_l;


reg frame_l,irdy_l;
reg [3:0]c_be_l;
reg [31:0]ad;

initial begin

	//pasul 1

	frame_l=1;irdy_l=1;

	#clk_per;

	// pasul 2	
	
	c_be_l=4'b0011;//comanda de scriere
	
	ad=32'hFFFFFFFF; // adresa
	
	frame_l=0; // initiere ciclu de scriere
	
	#clk_per;
	
	// pasul 3

	irdy_l=0;// initiator ready
	
	c_be_l=4'b0000; // date pe 4 octeti
	
	#clk_per;
	
	while (devsel_l) #clk_per; //astept confirmare ca s-a primit adresa
	
	// pasul4
	
	ad=32'h11111111; //primul set de date;
	
	#clk_per;
	
	while (trdy_l) #clk_per; // astept trdy_l;
	
	ad=32'h22222222; //al doilea set de date;
	
	#clk_per;
	
	while (trdy_l) #clk_per;
	
	ad=32'h33333333; //al treilea set de date;

    #clk_per;	
    
	while (trdy_l) #clk_per;
	
	ad=32'h44444444; //ultimul set de date;

    frame_l=1; // ultimele date
    
	#clk_per;
    
    while (trdy_l) #clk_per;
	
	// am terminat transferul
	irdy_l=1;
	
	c_be_l=4'bz;
	frame_l=1'bz;
	ad=32'hz;
	
	#clk_per;

end	
endmodule


module bus(clk,frame_l,ad,c_be_l,trdy_l,irdy_l,devsel_l);

input frame_l,irdy_l;
input [31:0]ad;
input [3:0] c_be_l;

parameter clk_per=10;


output trdy_l,devsel_l,clk;

reg trdy_l,devsel_l,clk;
reg [31:0] adr;

initial begin
	clk=1'b1;
	forever #(clk_per/2) clk=1-clk;
end

always @(negedge frame_l)
begin 

// magistrala a primit cerere

adr=ad; // adresa scrisa de controller

#clk_per;// citesc adresa de pe <ad> si selectez device-ul

adr=32'hz;

#clk_per; // simulez ca inca nu sunt gata (trdy_l=1, devsel_l=1)

devsel_l=0;
trdy_l=0;

#clk_per;// scriu DATE de pe <ad>

// acum sunt gata

adr=ad;#clk_per; // DATE
adr=ad;#clk_per; // nu sunt gata
trdy_l=1;#clk_per;
trdy_l=0;
adr=ad;#clk_per;// DATE
adr=ad;#clk_per;// DATE
end

always @(posedge frame_l) // ultimile date
begin 
#clk_per;
trdy_l=1;
devsel_l=1;
adr=32'bz; 
end

initial begin
	devsel_l=1;
	trdy_l=1;
end

endmodule


module test;

wire [31:0]ad;
wire [3:0]c_be_l;

i21143 mod_intel(clk,frame_l,ad,c_be_l,trdy_l,irdy_l,devsel_l);
bus    mod_bus(clk,frame_l,ad,c_be_l,trdy_l,irdy_l,devsel_l);

initial begin 
	#110;$finish;
end

always @(posedge clk) $display("time:%d a/d:%h c/be:%h tr:%b ir:%b devsel:%b fr:%b",$time,ad,c_be_l,trdy_l,irdy_l,devsel_l,frame_l);

endmodule
