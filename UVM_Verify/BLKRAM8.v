`timescale 1 ns/ 100 ps
module BLKRAM8
	(
	input [14:0]addra,
	input clka,
	input [7:0]dina,
	input ena,
	input wea,
	input clkb,
	input enb,
	input [14:0]addrb,
	output reg[7:0]doutb
	);
reg [7:0]BRAM8[32767:0];
wire [7:0]dob;
assign dob=(enb)?BRAM8[addrb]:8'b0;
initial #5 doutb<=0;

always@(posedge clka )
begin
	if(ena&wea)BRAM8[addra]<=dina;
end

always@(posedge clkb)
begin
	doutb<=dob;
end



endmodule