/*
此寄存器存放本机的MRO信息，如VID和PID
*/
module mro_csr(
output wire [63:0]marchid,
output wire [63:0]mimpid,
output wire [63:0]mhartid,
output wire [63:0]mvendorid,
output wire [63:0]misa
);

assign misa		=	64'b00000000_00000000_00000000_00000000_00000000_00001010_00000001_00000001;
//						_________________________________________________U_S_________I________A
assign mvendorid=	64'h0000_0000_5256_4154;	//RVAT
assign marchid	=	64'h50525634;	//
assign mhartid	=	64'h0;
assign mimpid	=	64'd7;	//update 20200503 

endmodule	