module RST_CON
(
input INCLK,
input RST_N,
input PLLRDY,
output reg PLLRST,
output reg SYSRST,
output SYSRST_N
 );
assign SYSRST_N=!SYSRST;
always @(posedge INCLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		PLLRST<=1'b1;
		SYSRST<=1'b1;
	end
	else
	begin
		PLLRST<=1'b0;
		if(PLLRDY)
			SYSRST<=1'b0;
		else
			SYSRST<=SYSRST;
	end
end

endmodule
