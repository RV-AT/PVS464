
module BaudGen(clkdivL,en,clk,rst,BaudOut,BaudOutL);
input [15:0]clkdivL;
input clk,rst,en;
output reg BaudOut;
output reg BaudOutL;
wire [12:0]clkdiv;

reg [12:0]count;
reg [15:0]countL;
assign clkdiv=clkdivL[15:4];

always @(posedge clk or posedge rst)
begin
	if(rst)
		begin
		count<=9'b0;
		BaudOut<=1'b0;
		countL<=9'b0;
		BaudOutL<=1'b0;
		end
	else
	if(en)
	begin
		if(count==clkdiv)
		begin 
			count<=12'h0;
			BaudOut<=~BaudOut;
		end
		else count<=count+1'b1;
		if(countL==clkdivL)
		begin 
			countL<=15'h0;
			BaudOutL<=~BaudOutL;
		end
		else countL<=countL+1'b1;
	end
end
endmodule
