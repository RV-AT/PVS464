//适用于PRV464的LSU，在这里LSU的作用只有对数据进行移位和符号位补充的作用

module lsu(

input wire unsign,
input wire [2:0]addr,//地址低3位 用于指示移位大小
input wire [3:0]size,//0001:1Byte 0010:2Byte 0100=4Byte 1000=8Byte

input wire [63:0] data_in,			//要送往BIU的数据
output wire [63:0]data_lsu_uncache,	//从BIU读出的数据
output wire [63:0]data_lsu_cache,	

//对BIU信号
output wire [63:0]data_write,
input wire [63:0]data_read,
input wire [63:0]uncache_data	//没有被缓存的数据

);
parameter offest0	=	3'b000;
parameter offest1	=	3'b001;
parameter offest2	=	3'b010;
parameter offest3	=	3'b011;
parameter offest4	=	3'b100;
parameter offest5	=	3'b101;
parameter offest6	=	3'b110;
parameter offest7	=	3'b111;

wire [63:0]data_lsu_cache_shift;	//BIU送来的数据先进行移位
wire [63:0]data_lsu_uncache_shift;	

//向左移位
wire [63:0]left_shift_8bit;
wire [63:0]left_shift_level0;
wire [63:0]left_shift_16bit;
wire [63:0]left_shift_level1;
wire [63:0]left_shift_32bit;

//向右对齐
//可缓存的
wire [63:0]cache_right_shift_8bit;
wire [63:0]cache_right_shift_level0;
wire [63:0]cache_right_shift_16bit;
wire [63:0]cache_right_shift_level1;
wire [63:0]cache_right_shift_32bit;
//不可缓存的
wire [63:0]uncache_right_shift_8bit;
wire [63:0]uncache_right_shift_level0;
wire [63:0]uncache_right_shift_16bit;
wire [63:0]uncache_right_shift_level1;
wire [63:0]uncache_right_shift_32bit;

//送往BIU的数据先进行移位
/*
assign data_write 	=	((addr==offest0)?data_in:64'b0)|
						((addr==offest1)?{data_in[55:0],8'b0}:64'b0)|
						((addr==offest2)?{data_in[47:0],16'b0}:64'b0)|
						((addr==offest3)?{data_in[39:0],24'b0}:64'b0)|
						((addr==offest4)?{data_in[31:0],32'b0}:64'b0)|
						((addr==offest5)?{data_in[23:0],40'b0}:64'b0)|
						((addr==offest6)?{data_in[15:0],48'b0}:64'b0)|
						((addr==offest7)?{data_in[7:0],56'b0}:64'b0);
						*/
//第零级移位
assign left_shift_8bit	=	{data_in[55:0],8'b0};
assign left_shift_level0=	addr[0] ? left_shift_8bit : data_in;
//第一级移位
assign left_shift_16bit	=	{left_shift_level0[47:0],16'b0};
assign left_shift_level1=	addr[1] ? left_shift_16bit : left_shift_level0;

assign left_shift_32bit = 	{left_shift_level1[31:0],32'b0};
assign data_write		=	addr[2] ? left_shift_32bit : left_shift_level1 ;


//送往内部的数据先移位（向右对齐）

//可缓存的数据
//第零级移位
assign cache_right_shift_8bit	=	{8'b0,data_read[63:8]};
assign cache_right_shift_level0	=	addr[0] ? cache_right_shift_8bit : data_read;
//第一级移位
assign cache_right_shift_16bit	=	{16'b0,cache_right_shift_level0[63:16]};
assign cache_right_shift_level1	=	addr[1] ? cache_right_shift_16bit : cache_right_shift_level0;
//第三级
assign cache_right_shift_32bit	=	{32'b0,cache_right_shift_level1[63:32]};
assign data_lsu_cache_shift		=	addr[2]	? cache_right_shift_32bit : cache_right_shift_level1;

//不可缓存的数据
//第零级移位
assign uncache_right_shift_8bit		=	{8'b0,uncache_data[63:8]};
assign uncache_right_shift_level0	=	addr[0] ? uncache_right_shift_8bit : uncache_data;
//第一级移位
assign uncache_right_shift_16bit	=	{16'b0,uncache_right_shift_level0[63:16]};
assign uncache_right_shift_level1	=	addr[1] ? uncache_right_shift_16bit : uncache_right_shift_level0;
//第三级
assign uncache_right_shift_32bit	=	{32'b0,uncache_right_shift_level1[63:32]};
assign data_lsu_uncache_shift		=	addr[2]	? uncache_right_shift_32bit : uncache_right_shift_level1;

assign data_lsu_uncache	=	((size[0]&!unsign)?{{56{data_lsu_uncache_shift[7]}},data_lsu_uncache_shift[7:0]}:64'b0)|
							((size[1]&!unsign)?{{48{data_lsu_uncache_shift[15]}},data_lsu_uncache_shift[15:0]}:64'b0)|
							((size[2]&!unsign)?{{32{data_lsu_uncache_shift[31]}},data_lsu_uncache_shift[31:0]}:64'b0)|
							(unsign? data_lsu_uncache_shift : 64'b0);
							
							
assign data_lsu_cache	=	((size[0]&!unsign)?{{56{data_lsu_cache_shift[7]}},data_lsu_cache_shift[7:0]}:64'b0)|
							((size[1]&!unsign)?{{48{data_lsu_cache_shift[15]}},data_lsu_cache_shift[15:0]}:64'b0)|
							((size[2]&!unsign)?{{32{data_lsu_cache_shift[31]}},data_lsu_cache_shift[31:0]}:64'b0)|
							(unsign? data_lsu_cache_shift : 64'b0);



endmodule






