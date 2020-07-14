`timescale 1 ns / 100 ps
module VIS62
	(
		inout [31:0]data,
		input [21:0]address,
		input [3:0]BSEL,
		input cs_n,
		input wr_n,
		input oe_n 
	);
	reg [7:0]RAML8[2097151:0];
	reg [7:0]RAML16[2097151:0];
	reg [7:0]RAMH24[2097151:0];
	reg [7:0]RAMH32[2097151:0];
	reg [31:0]idata;
	assign data=(oe_n|cs_n)?31'hzzzzzzzz:idata;
	always @(*)
	begin
		#65 idata<={RAMH32[address[20:0]],RAMH24[address[20:0]],RAML16[address[20:0]],RAML8[address[20:0]]}; 
	end
	always @(*)
	begin
		if(!cs_n)
		begin
			if(!(BSEL[0]|wr_n))
			#55	RAML8[address[20:0]]<=data[7:0];
			if(!(BSEL[1]|wr_n))
			#55	RAML16[address[20:0]]<=data[15:8];
			if(!(BSEL[2]|wr_n))
			#55	RAMH24[address[20:0]]<=data[23:16];
			if(!(BSEL[3]|wr_n))
			#55	RAMH32[address[20:0]]<=data[31:24];
		end
	end
	
endmodule