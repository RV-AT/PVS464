module alu_au(

//操作码 ALU,运算码
//rd数据选择
input wire rd_data_ds1,		//ds1直通
input wire rd_data_add,		//加
input wire rd_data_sub,		//减
input wire rd_data_and,		//逻辑&
input wire rd_data_or,		//逻辑|
input wire rd_data_xor,		//逻辑^
input wire rd_data_slt,		//比较大小
input wire compare,			//比较大小，配合bge0_blt1\beq0_bne1控制线并产生分支信号
input wire amo_lr_sc,		//lr/sc读写成功标志

input wire shift_r,
input wire shift_l,

//mem_csr_data数据选择
input wire mem_csr_data_ds1,
input wire mem_csr_data_ds2,
input wire mem_csr_data_add,
input wire mem_csr_data_and,
input wire mem_csr_data_or,
input wire mem_csr_data_xor,
input wire mem_csr_data_max,
input wire mem_csr_data_min,
//运算,跳转辅助控制信号
input wire blt,				//条件跳转，blt bltu指令时为1
input wire bge,
input wire beq,				//条件跳转，bne指令时为一
input wire bne,
input wire jmp,				//无条件跳转，适用于JAL JALR指令
input wire unsign,			//无符号操作，同时控制mem单元信号的符号
input wire and_clr,			//将csr操作的and转换为clr操作

//位宽控制
input wire [3:0]size, 		//0001:1Byte 0010:2Byte 0100=4Byte 1000=8Byte


//数据输入							   
input wire [63:0]ds1,		//数据源1，imm/rs1/rs1/csr/pc /pc
input wire [63:0]ds2,		//数据源2，00 /rs2/imm/imm/imm/04
input wire [63:0]as1,		//地址源1,  pc/rs1/rs1
input wire [63:0]as2,		//地址源2, imm/imm/00

input wire [7:0]op_count,	//操作计数，用于移位指令

//数据输出
output wire [63:0]alu_data_rd,
output wire [63:0]alu_data_mem_csr,//送到csr单元或者要写回内存的数据
output wire [63:0]au_addr_pc,
//跳转信号输出
output wire jmp_ok



);

wire [63:0]alu_add;		//加法运算
wire [63:0]add_64;		//纯64位加法运算
wire [63:0]sub_64;		//纯64位减法运算
wire [63:0]alu_sub;
wire [63:0]alu_and;
wire [63:0]alu_or;
wire [63:0]alu_xor;
wire [63:0]alu_slt;
wire [63:0]alu_shift;	//移位指令

wire [63:0]alu_lr_sc;
wire [63:0]alu_max;
wire [63:0]alu_min;
//ds1与ds2的数据大小比较
wire ds1_light_than_ds2;
wire ds1_great_than_ds2;
wire ds1_equal_ds2;

assign ds1_light_than_ds2	=	!unsign&((ds1[63]&!ds2[63])|				//ds1是负数，ds2是正数（有符号）
								(ds1[63]==ds2[63]) & (ds1 < ds2))|			//ds1，ds2同符号（有符号）
								unsign&(ds1 < ds2);							//无符号比较
assign ds1_great_than_ds2	=	!unsign&((!ds1[63]&ds2[63])|				//ds1正，ds2负
								(ds1[63]==ds2[63]) & (ds1 > ds2))|			//有符号时候同号比较
								unsign&(ds1 < ds2);							//无符号时直接比较大小
assign ds1_equal_ds2		=	(ds1 == ds2);

assign add_64			=	ds1 + (rd_data_sub?(~ds2):ds2);			//当加法指令时，ds1和ds2正常相加，当减法指令时，对DS2取反
assign sub_64			=	add_64	+	64'b1;						//减法指令时，已经对ds2取反和ds1相加，再加1就相当于ds1-ds2（补码运算）
assign alu_add[63:32]	=	size[2]?{32{add_64[31]}}:add_64[63:32];	//再进行4Byte运算时，高位是符号拓展位
assign alu_add[31:0]	=	add_64[31:0];					

assign alu_sub[63:32]	=	size[2]?{32{sub_64[31]}}:add_64[63:32];
assign alu_sub[31:0]	=	sub_64[31:0];

assign alu_and			=	ds1	& (and_clr ? ~ds2 : ds2);			//当需要进行清零操作时候，ds2的数据被按位取反，此时是CSRRCx指令，DS1是CSR，DS2是RS1
assign alu_or			=	ds1 | ds2;
assign alu_xor			=	ds1 ^ ds2;
assign alu_slt			=	ds1_light_than_ds2?64'b1:64'b0;
//跳转信号
assign jmp_ok			=	compare&(beq&ds1_equal_ds2 | bne&!ds1_equal_ds2 | bge&ds1_great_than_ds2 | blt&ds1_light_than_ds2)|jmp;

assign alu_lr_sc		=	64'b0;
assign alu_max			=	ds1_great_than_ds2?ds1 : ds2;			//在AMO指令中，DS1被切换到MEM的数据
assign alu_min			=	ds1_light_than_ds2?ds1 : ds2;


assign alu_data_rd		=	(rd_data_ds1 		? ds1		: 64'b0)|			//ds1直通
							(rd_data_add 		? alu_add 	: 64'b0)|		//加
							(rd_data_sub 		? alu_sub 	: 64'b0)|		//减
							(rd_data_and		? alu_and 	: 64'b0)|		//逻辑&
							(rd_data_or 		? alu_or 	: 64'b0)|		//逻辑|
							(rd_data_xor 		? alu_xor 	: 64'b0)|		//逻辑^
							(rd_data_slt 		? alu_slt 	: 64'b0)|		//比较大小
							((shift_l|shift_r)	? alu_shift	: 64'b0)|	//移位
							(amo_lr_sc 			? alu_lr_sc : 64'b0);		//lr/sc读写成功标志


assign alu_data_mem_csr	=	(mem_csr_data_ds1 	? ds1 		: 64'b0)|
							(mem_csr_data_ds2 	? ds2 		: 64'b0)|
							(mem_csr_data_add 	? alu_add 	: 64'b0)|
							(mem_csr_data_and 	? alu_and 	: 64'b0)|
							(mem_csr_data_or 	? alu_or 	: 64'b0)|
							(mem_csr_data_xor 	? alu_xor 	: 64'b0)|
							(mem_csr_data_max 	? alu_max 	: 64'b0)|
							(mem_csr_data_min 	? alu_min 	: 64'b0);

assign au_addr_pc		=	as1 + as2;

//筒形移位器
/*
Type: 00/01=Left Shift
10=Right Shift, 0 Filled
11=Right Shift,with symbol extent
*/
barrel_shifter barrel_shifter
(
    .datain		(ds1),
    .type		({shift_r,!unsign}),
    .shiftnum	(op_count[5:0]),
    .dataout	(alu_shift)
);



endmodule
