module PERI_DECODE
	(
	input HSEL,
	input [16:7]HADDR, //Divide peripheral Address base into 128 Bytes minimum (32 words)
	output [31:0]SSEL //Subrange SELect
	);
	wire [31:0] SELI;
	assign SSEL={32{HSEL}}&SELI;
	assign SELI=
	(
	({32{HADDR==10'h000}}&32'h00000002)|//SPI,128Byte
	({32{HADDR==10'h001}}&32'h00000004)|//AUART,128Byte
	({32{HADDR==10'h002}}&32'h00000008)|//S68000 Bus
	({32{HADDR==10'h003}}&32'h00000010)|//AFGPIO
	({32{HADDR==10'h004}}&32'h00000020)|//TIM
	
	32'b0000
	);
	
	
	
	
	
	
endmodule