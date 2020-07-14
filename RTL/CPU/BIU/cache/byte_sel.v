/*
字节选择模块
*/
module byte_sel(
input wire [2:0]addr,	//address
input wire [3:0]size,	//0001=1Byte;0010=2Byte;0100=4Byte;1000=8Byte
input wire mask,
output wire [7:0]bsel
);
wire [7:0]bsel_source;

wire [7:0]shift1;
wire [7:0]shift2;

assign bsel_source	=	{7'b0,size[0]} | {6'b0,{2{size[1]}}} | {4'b0,{4{size[2]}}} | {8{size[3]}};
assign shift1		=	addr[0] ? {bsel_source[7:1],1'b0} : bsel_source;	//左移1位
assign shift2		=	addr[1] ? {shift1[7:2],2'b0} : shift1;
assign bsel			=	mask ? 8'b11111111 : addr[2] ? {shift2[7:4],4'b0} : shift2;

endmodule