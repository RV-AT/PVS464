module BRAM2K
	(
	input [11:0]addra,
	input clka,
	input [7:0]dina,
	input ena,
	input wea,
	input clkb,
	input enb,
	input [11:0]addrb,
	output reg[7:0]doutb
	);
reg [7:0]BRAM8[2047:0];

initial #5 doutb<=0;

always@(posedge clka )
begin
	if(ena&wea)BRAM8[addra]<=dina;
end

always@(posedge clkb)
begin
	doutb<=(enb)?BRAM8[addrb]:8'b0;
end



endmodule