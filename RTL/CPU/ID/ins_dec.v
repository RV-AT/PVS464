//适用于PRV464的指令解码单元
//支持RV64IA指令解码
//特别注意 RISCV的J和B的立即数编码是混乱的（大草）

module ins_dec(

input wire clk,
input wire rst,

//csr
input wire [3:0]priv,		//当前机器权限
input wire tvm,
input wire tsr,
input wire tw,
input wire [63:0]csr_data,
//GPR输入
input wire [63:0]rs1_data,
input wire [63:0]rs2_data,

//上一级（IF）信号
//指令输出
input wire [31:0]ins_in,
//指令对应的PC值输出
input wire [63:0]ins_pc,
//机器控制段
input wire ins_acc_fault_if,	//指令访问失败
input wire ins_addr_mis_if, 	//指令地址错误
input wire ins_page_fault_if,	//指令页面错误
input wire int_acc_if,			//中断接收信号
input wire valid_if,			//指令有效信号

//下一级（EX）信号
//异常码
//当非法指时候，该码被更新为ins，当指令页面错误，被更新为addr
output reg [63:0]exc_code,
//当前指令pc
output reg [63:0]ins_pc_id,

//操作码 ALU,运算码
//rd数据选择
output reg rd_data_ds1,		//ds1直通
output reg rd_data_add,		//加
output reg rd_data_sub,		//减
output reg rd_data_and,		//逻辑&
output reg rd_data_or,		//逻辑|
output reg rd_data_xor,		//逻辑^
output reg rd_data_slt,		//比较大小
output reg compare,			//比较大小，配合bge0_blt1\beq0_bne1控制线并产生分支信号
output reg amo_lr_sc,		//lr/sc读写成功标志

//mem_csr_data数据选择
output reg mem_csr_data_ds1,
output reg mem_csr_data_ds2,
output reg mem_csr_data_add,
output reg mem_csr_data_and,
output reg mem_csr_data_or,
output reg mem_csr_data_xor,
output reg mem_csr_data_max,
output reg mem_csr_data_min,
//运算,跳转辅助控制信号
output reg blt,				//条件跳转，blt bltu指令时为1
output reg bge,
output reg beq,				//条件跳转，bne指令时为一
output reg bne,				//
output reg jmp,				//无条件跳转，适用于JAL JALR指令
output reg unsign,			//无符号操作，同时控制mem单元信号的符号
output reg and_clr,			//将csr操作的and转换为clr操作
output reg ds1_sel,			//ALU ds1选择，为0选择ds1，为1选择MEM读取信号

//位宽控制
output reg [3:0]size, 		//0001:1Byte 0010:2Byte 0100=4Byte 1000=8Byte
//多周期控制
//多周期控制信号线控制EX单元进行多周期操作
output reg load,
output reg store,
output reg amo,
output reg l1i_reset,		//缓存刷新信号，此信号可以与内存进行同步
output reg l1d_reset,		//缓存复位信号，下次访问内存时重新刷新页表
output reg TLB_reset,		//TLB复位
output reg shift_r,			//左移位
output reg shift_l,			//右移位

//写回控制，当valid=0时候，所有写回不有效
output reg csr_write,
output reg gpr_write,
output reg [11:0]csr_index,
output reg [4:0]rs1_index,
output reg [4:0]rs2_index,
output reg [4:0]rd_index,

//数据输出							   
output reg [63:0]ds1,		//数据源1，imm/rs1/rs1/csr/pc /pc
output reg [63:0]ds2,		//数据源2，00 /rs2/imm/imm/imm/04
output reg [63:0]as1,		//地址源1,  pc/rs1/rs1
output reg [63:0]as2,		//地址源2, imm/imm/00
output reg [7:0]op_count,	//操作次数码，用于AMO指令或移位指令
//机器控制段
//机器控制段负责WB阶段时csr的自动更新
output reg id_system,		//system指令，op code=system的时候被置1
output reg id_jmp,			//会产生跳转的指令 opcode=branch时候置1
output reg ins_acc_fault,	//指令访问失败
output reg ins_addr_mis, 	//指令地址错误
output reg ins_page_fault,	//指令页面错误
output reg int_acc,			//中断接收信号
output reg valid, 			//指令有效信号
output reg ill_ins,			//异常指令信号
output reg m_ret,				//返回信号
output reg s_ret,
output reg ecall,			//环境调用
output reg ebreak,			//断点
//到EX信号完


//pip_ctrl信号
//pip_ctrl负责检查这些信号并控制整个流水线的操作
output wire [4:0]dec_rs1_index,			//立即解码得到的rs1index
output wire [4:0]dec_rs2_index,
output wire [4:0]dec_rd_index,
output wire [11:0]dec_csr_index,
//ID独有pip_ctrl信号
output wire dec_gpr_write,
output wire dec_ill_ins,				//译码之后得到错误指令信号
output wire dec_branch,					//分支指令，要求进行多周期操作
output wire dec_system_mem,				//系统操作,即所有的system和fence指令，要求进行多周期操作

input wire id_hold,						//ID等待
input wire id_nop						//ID插空

);
//opcode译码参数,RV低7位是操作码
parameter lui_encode 	= 7'b0110111;
parameter auipc_encode	= 7'b0010111;
parameter jal_encode	= 7'b1101111;
parameter jalr_encode	= 7'b1100111;
parameter branch_encode	= 7'b1100011;
parameter load_encode 	= 7'b0000011;
parameter store_encode	= 7'b0100011;
parameter imm_encode	= 7'b0010011;
parameter imm_32_encode = 7'b0011011;
parameter reg_encode	= 7'b0110011;	//R type指令opcode
parameter reg_32_encode = 7'b0111011;	
parameter mem_encode	= 7'b0001111;	//MISC-MEM指令OPCODE，
parameter system_encode = 7'b0001111;	
parameter amo_encode	= 7'b0101111;
parameter m_32_encode	= 7'b0111011;

//size参数
parameter sbyte_size	= 4'b0001;		//Singal Byte
parameter dbyte_size	= 4'b0010;		//Double Byte
parameter qbyte_size	= 4'b0100;		//Quad Byte
parameter obyte_size	= 4'b1000;		//Octal Byte
//权限参数
parameter user = 4'b0001;
parameter supe = 4'b0010;
parameter mach = 4'b1000;

//opcode译码
wire op_system;		//CSR操作指令
wire op_imm;		//立即数操作指令（I type）
wire op_32_imm;
wire op_lui;		//lui指令
wire op_auipc;		//auipc指令
wire op_jal;
wire op_jalr;
wire op_branch;		//分支指令 (B type)
wire op_store;
wire op_load;
wire op_reg;		//寄存器操作指令（R type）
wire op_32_reg;
wire op_amo;
wire op_m;			// 内存屏障指令

//funct3译码
wire funct3_0; 
wire funct3_1;
wire funct3_2;
wire funct3_3;
wire funct3_4;
wire funct3_5;
wire funct3_6;
wire funct3_7;
//funct5译码
wire funct5_0;
wire funct5_1;
wire funct5_2;
wire funct5_3;
wire funct5_4;
/*
wire funct5_5;
wire funct5_6;
wire funct5_7;
*/
wire funct5_8;
/*
wire funct5_9;
wire funct5_10;
wire funct5_11;
*/
wire funct5_12;
/*
wire funct5_13;
wire funct5_14;
wire funct5_15;
*/
wire funct5_16;
/*
wire funct5_17;
wire funct5_18;
wire funct5_19;
*/
wire funct5_20;
/*
wire funct5_21;
wire funct5_22;
wire funct5_23;
*/
wire funct5_24;
/*
wire funct5_25;
wire funct5_26;
wire funct5_27;
*/
wire funct5_28;
/*
wire funct5_29;
wire funct5_30;
wire funct5_31;
*/
//funct6译码	funct6是移位指令用的
wire funct6_0;
wire funct6_16;
//funct7译码
wire funct7_32;
wire funct7_24;
wire funct7_8;
wire funct7_9;
wire funct7_0;

//funct12译码
wire funct12_0;
wire funct12_1;
//立即数译码
wire [63:0]imm20;		//LUI，AUIPC指令使用的20位立即数（进行符号位拓展）
wire [63:0]imm20_jal;	//jal指令使用的20位立即数，左移一位，高位进行符号拓展
wire [63:0]imm12_i;		//I-type，L-type指令使用的12位立即数（进行符号位拓展）
wire [63:0]imm12_b;		//b-type指令使用的12位立即数（进行符号位拓展）
wire [63:0]imm12_s;		//S-type指令使用的12位立即数（进行符号位拓展）

wire [63:0]imm5_csr;	//csr指令使用的5位立即数，高位补0
//操作大小译码
wire sbyte;				//单字节
wire dbyte;				//双字节
wire qbyte;				//四字节
wire obyte;				//8字节
//操作次数译码
wire [7:0]op_count_decode;	//操作次数译码，用于移位指令
//指令译码
//RV32I
wire ins_lui;	
wire ins_auipc;
wire ins_jal;
wire ins_jalr;
wire ins_beq;
wire ins_bne;
wire ins_blt;
wire ins_bge;
wire ins_bltu;
wire ins_bgeu;
wire ins_lb;
wire ins_lbu;
wire ins_lh;
wire ins_lhu;
wire ins_lw;

wire ins_sb;
wire ins_sh;
wire ins_sw;

wire ins_addi;

wire ins_slti;
wire ins_sltiu;
wire ins_xori;
wire ins_ori;
wire ins_andi;
wire ins_slli;
wire ins_srli;
wire ins_srai;
wire ins_add;
wire ins_sub;
wire ins_sll;
wire ins_slt;
wire ins_sltu;
wire ins_xor;
wire ins_srl;
wire ins_sra;
wire ins_or;
wire ins_and;
wire ins_fence;		
wire ins_fence_i;	
wire ins_ecall;
wire ins_ebreak;
wire ins_csrrw;
wire ins_csrrs;
wire ins_csrrc;
wire ins_csrrwi;
wire ins_csrrsi;
wire ins_csrrci;
//RV64I ext
wire ins_lwu;
wire ins_ld;
wire ins_sd;
wire ins_addiw;
wire ins_slliw;
wire ins_srliw;
wire ins_sraiw;
wire ins_addw;
wire ins_subw;
wire ins_sllw;
wire ins_srlw;
wire ins_sraw;
//RV32A
wire ins_lrw;
wire ins_scw;
wire ins_amoswapw;
wire ins_amoaddw;
wire ins_amoxorw;
wire ins_amoandw;
wire ins_amoorw;
wire ins_amominw;
wire ins_amomaxw;
wire ins_amominuw;
wire ins_amomaxuw;
//rv64A
wire ins_lrd;
wire ins_scd;
wire ins_amoswapd;
wire ins_amoaddd;
wire ins_amoxord;
wire ins_amoandd;
wire ins_amoord;
wire ins_amomind;
wire ins_amomaxd;
wire ins_amominud;
wire ins_amomaxud;
//模式特权指令
wire ins_mret;
wire ins_sret;
wire ins_sfencevma;
wire ins_wfi;

//异常指令解码信号
wire dec_csr_acc_fault;		//访问不该访问的csr
wire dec_ins_unpermit;		//指令不被允许执行
wire dec_ins_dec_fault;		//指令解码失败

//判断是否需要将ALU输入源ds1转换为MEM单元的数据
wire ds1_mem_iden;
assign ds1_mem_iden = ins_amoswapd|ins_amoswapw|ins_amoaddw|ins_amoaddd|ins_amoxorw|ins_amoxord
		|ins_amoandw|ins_amoandd|ins_amoorw|ins_amoord|ins_amominw|ins_amomind|
		ins_amomaxw|ins_amomaxd||ins_amomaxd|ins_amomaxud|ins_amomind|ins_amominud|
		ins_lb|ins_lbu|ins_lh|ins_lhu|ins_lw|ins_lwu|ins_ld|ins_lrw|ins_lrd;

//首先对opcode进行译码
assign op_system	= (ins_in[6:0]==system_encode);
assign op_imm		= (ins_in[6:0]==imm_encode);
assign op_32_imm	= (ins_in[6:0]==imm_32_encode);
assign op_lui		= (ins_in[6:0]==lui_encode);
assign op_auipc	= (ins_in[6:0]==auipc_encode);
assign op_jal		= (ins_in[6:0]==jal_encode);
assign op_jalr		= (ins_in[6:0]==jalr_encode);
assign op_branch	= (ins_in[6:0]==branch_encode);
assign op_load		= (ins_in[6:0]==load_encode);
assign op_store		= (ins_in[6:0]==store_encode);
assign op_reg		= (ins_in[6:0]==reg_encode);
assign op_32_reg	= (ins_in[6:0]==reg_32_encode);
assign op_amo		= (ins_in[6:0]==amo_encode);

assign op_m			= (ins_in[6:0]==mem_encode);

//对funct3译码
assign funct3_0		= (ins_in[14:12]==3'h0);
assign funct3_1		= (ins_in[14:12]==3'h1);
assign funct3_2		= (ins_in[14:12]==3'h2);
assign funct3_3		= (ins_in[14:12]==3'h3);
assign funct3_4		= (ins_in[14:12]==3'h4);
assign funct3_5		= (ins_in[14:12]==3'h5);
assign funct3_6		= (ins_in[14:12]==3'h6);
assign funct3_7		= (ins_in[14:12]==3'h7);
//funct5
assign funct5_0		= (ins_in[31:27]==5'h00);
assign funct5_1		= (ins_in[31:27]==5'h01);
assign funct5_2		= (ins_in[31:27]==5'h02);
assign funct5_3		= (ins_in[31:27]==5'h03);
assign funct5_4		= (ins_in[31:27]==5'h04);
/*
assign funct5_5		= (ins_in[31:27]==5'h05);
assign funct5_6		= (ins_in[31:27]==5'h06);
assign funct5_7		= (ins_in[31:27]==5'h07);
*/
assign funct5_8		= (ins_in[31:27]==5'h08);
/*
assign funct5_9		= (ins_in[31:27]==5'h09);
assign funct5_10	= (ins_in[31:27]==5'h0a);
assign funct5_11	= (ins_in[31:27]==5'h0b);
*/
assign funct5_12	= (ins_in[31:27]==5'h0c);
/*
assign funct5_13	= (ins_in[31:27]==5'h0d);
assign funct5_14	= (ins_in[31:27]==5'h0e);
assign funct5_15	= (ins_in[31:27]==5'h0f);
*/
assign funct5_16	= (ins_in[31:27]==5'h10);
/*
assign funct5_17	= (ins_in[31:27]==5'h11);
assign funct5_18	= (ins_in[31:27]==5'h12);
assign funct5_19	= (ins_in[31:27]==5'h13);
*/
assign funct5_20	= (ins_in[31:27]==5'h14);
/*
assign funct5_21	= (ins_in[31:27]==5'h15);
assign funct5_22	= (ins_in[31:27]==5'h16);
assign funct5_23	= (ins_in[31:27]==5'h17);
*/
assign funct5_24	= (ins_in[31:27]==5'h18);
/*
assign funct5_25	= (ins_in[31:27]==5'h19);
assign funct5_26	= (ins_in[31:27]==5'h1a);
assign funct5_27	= (ins_in[31:27]==5'h1b);
*/
assign funct5_28	= (ins_in[31:27]==5'h1c);
/*
assign funct5_29	= (ins_in[31:27]==5'h1d);
assign funct5_30	= (ins_in[31:27]==5'h1e);
assign funct5_31	= (ins_in[31:27]==5'h1f);
*/
//funct6
assign funct6_0		= (ins_in[31:26]==6'b000000);
assign funct6_16	= (ins_in[31:26]==6'b010000);
//funct7译码
assign funct7_0		= (ins_in[31:25]==7'h00);
assign funct7_8		= (ins_in[31:25]==7'h08);
assign funct7_9		= (ins_in[31:25]==7'h09);
assign funct7_24	= (ins_in[31:25]==7'h18);
assign funct7_32	= (ins_in[31:25]==7'h20);

//funct12译码
assign funct12_0	= (ins_in[31:20]==12'h0);
assign funct12_1	= (ins_in[31:20]==12'h1);
//指令解码
assign ins_lui 		= op_lui;
assign ins_auipc 	= op_auipc;
assign ins_jal		= op_jal;
assign ins_jalr		= op_jalr;
assign ins_beq		= op_branch&funct3_0;
assign ins_bne		= op_branch&funct3_1;
assign ins_blt		= op_branch&funct3_4;
assign ins_bge		= op_branch&funct3_5;
assign ins_bltu		= op_branch&funct3_6;
assign ins_bgeu		= op_branch&funct3_7;
assign ins_lb		= op_load&funct3_0;
assign ins_lh		= op_load&funct3_1;
assign ins_lw		= op_load&funct3_2;
assign ins_lbu		= op_load&funct3_4;
assign ins_lhu		= op_load&funct3_5;
assign ins_sb		= op_store&funct3_0;
assign ins_sh		= op_store&funct3_1;
assign ins_sw		= op_store&funct3_2;
assign ins_addi		= op_imm&funct3_0;
assign ins_slti		= op_imm&funct3_2;
assign ins_sltiu	= op_imm&funct3_3;
assign ins_xori		= op_imm&funct3_4;
assign ins_ori		= op_imm&funct3_6;
assign ins_andi		= op_imm&funct3_7;
assign ins_slli		= op_imm&funct3_1&funct6_0;
assign ins_srli		= op_imm&funct3_5&funct6_0;
assign ins_srai		= op_imm&funct3_5&funct6_16;
assign ins_add		= op_reg&funct3_0&funct7_0;
assign ins_sub		= op_reg&funct3_0&funct7_32;
assign ins_sll		= op_reg&funct3_1&funct7_0;
assign ins_slt		= op_reg&funct3_2&funct7_0;
assign ins_sltu		= op_reg&funct3_3&funct7_0;
assign ins_xor		= op_reg&funct3_4&funct7_0;
assign ins_srl		= op_reg&funct3_5&funct7_0;
assign ins_sra		= op_reg&funct3_5&funct7_32;
assign ins_or		= op_reg&funct3_6&funct7_0;
assign ins_and		= op_reg&funct3_7&funct7_0;
assign ins_fence	= op_m&funct3_0;
assign ins_fence_i	= op_m&funct3_1;	
assign ins_ecall	= op_system&funct3_0&funct12_0;
assign ins_ebreak	= op_system&funct3_0&funct12_1;
assign ins_csrrw	= op_system&funct3_1;
assign ins_csrrs	= op_system&funct3_2;
assign ins_csrrc	= op_system&funct3_3;
assign ins_csrrwi	= op_system&funct3_5;
assign ins_csrrsi	= op_system&funct3_6;
assign ins_csrrci	= op_system&funct3_7;
//rv64i译码
assign ins_lwu		= op_load&funct3_6;
assign ins_ld		= op_load&funct3_3;
assign ins_sd		= op_store&funct3_3;
assign ins_addiw	= op_32_imm&funct3_0;
assign ins_slliw	= op_32_imm&funct3_1&funct7_0;
assign ins_srliw	= op_32_imm&funct3_5&funct7_0;
assign ins_sraiw	= op_32_imm&funct3_5&funct7_32;
assign ins_addw		= op_32_reg&funct3_0&funct7_0;
assign ins_subw		= op_32_reg&funct3_0&funct7_32;
assign ins_sllw		= op_32_reg&funct3_1&funct7_0;
assign ins_srlw		= op_32_reg&funct3_5&funct7_0;
assign ins_sraw		= op_32_reg&funct3_5&funct7_32;
//amo32译码
assign ins_lrw		= op_amo&funct3_2&funct5_2;
assign ins_scw		= op_amo&funct3_2&funct5_3;
assign ins_amoswapw	= op_amo&funct3_2&funct5_1;
assign ins_amoaddw	= op_amo&funct3_2&funct5_0;
assign ins_amoxorw	= op_amo&funct3_2&funct5_4;
assign ins_amoandw	= op_amo&funct3_2&funct5_12;
assign ins_amoorw	= op_amo&funct3_2&funct5_8;
assign ins_amominw	= op_amo&funct3_2&funct5_16;
assign ins_amomaxw	= op_amo&funct3_2&funct5_20;
assign ins_amominuw	= op_amo&funct3_2&funct5_24;
assign ins_amomaxuw	= op_amo&funct3_2&funct5_28;
//amo64译码
assign ins_lrd		= op_amo&funct3_3&funct5_2;
assign ins_scd		= op_amo&funct3_3&funct5_3;
assign ins_amoswapd	= op_amo&funct3_3&funct5_1;
assign ins_amoaddd	= op_amo&funct3_3&funct5_0;
assign ins_amoxord	= op_amo&funct3_3&funct5_4;
assign ins_amoandd	= op_amo&funct3_3&funct5_12;
assign ins_amoord	= op_amo&funct3_3&funct5_8;
assign ins_amomind	= op_amo&funct3_3&funct5_16;
assign ins_amomaxd	= op_amo&funct3_3&funct5_20;
assign ins_amominud	= op_amo&funct3_3&funct5_24;
assign ins_amomaxud	= op_amo&funct3_3&funct5_28;
//特权指令译码
assign ins_mret		= op_system&(dec_rs2_index==5'b00010)&funct7_24;
assign ins_sret		= op_system&(dec_rs2_index==5'b00010)&funct7_8;
assign ins_sfencevma= op_system&funct7_9;
assign ins_wfi		= op_system&funct7_8;								//wfi指令
//译出立即数
assign imm20 	= {{32{ins_in[31]}},ins_in[31:12],12'b0};				//LUI，AUIPC指令使用的20位立即数（进行符号位拓展）
assign imm20_jal= {{44{ins_in[31]}},ins_in[19:12],ins_in[20],ins_in[30:21],1'b0};				//jal指令使用的20位立即数，左移一位，高位进行符号拓展
assign imm12_i	= {{52{ins_in[31]}},ins_in[31:20]};						//I-type，L-type指令使用的12位立即数（进行符号位拓展）
assign imm12_b	= {{52{ins_in[31]}},ins_in[7],ins_in[30:25],ins_in[11:8],1'b0};	//b-type指令使用的12位立即数（进行符号位拓展）
assign imm12_s	= {{52{ins_in[31]}},ins_in[31:25],ins_in[11:7]};		//S-type指令使用的12位立即数（进行符号位拓展）

assign imm5_csr = {59'b0,ins_in[11:7]};									//csr指令使用的5位立即数，高位补0


//操作大小译码
assign sbyte 	= ins_lb|ins_lbu|ins_sb;													//单字节
assign dbyte	= ins_lh|ins_lhu|ins_sh;													//双字节
assign qbyte	= ins_lw|ins_lwu|ins_sw|op_32_imm|op_32_reg|(op_amo&funct3_2);				//四字节
assign obyte	= !(sbyte|dbyte|qbyte);														//124字节不是，那当然是8字节操作

assign op_count_decode	= 		(ins_slliw|ins_srliw|ins_sraiw)?{3'b0,dec_rs2_index}:
								(ins_slli|ins_srli|ins_srai)?{3'b0,ins_in[24:20]}:
								{2'b0,rs2_data[5:0]};//注意！RV64的移位立即数编码


//译出信号给pip_ctrl单元
//译出当前指令索引
assign dec_rs1_index= (op_jal|op_jalr|op_lui|op_auipc) ? 5'b0 :(ins_in[19:15]);
assign dec_rs2_index= (op_reg|op_32_reg|op_branch|op_store|op_amo)?(ins_in[24:20]) : 5'b0;//只有reg branch amo store指令需要使用rs2，其余都不使用rs2，使用常0寄存器
assign dec_rd_index	= (ins_in[11:7]);
assign dec_csr_index= (ins_in[31:20]);


//译出当前指令是否需要多周期
//需要多周期的opcode： 内存组织&system
assign dec_system_mem		= op_system | op_m;
assign dec_branch			= op_branch | ins_jalr|ins_jal;
//译出当前指令是否需要写回寄存器
//branch,store,fence指令没有写回，其他均要写回
/*
注意，在这里译码其实忽略了一些指令也不需要写回寄存器，
但是因为那些指令的RD都是X0寄存器，
X0是常数0寄存器，写回之后毫无影响，故忽略 */
assign dec_gpr_write		= !(op_branch|op_store|ins_fence|ins_mret|ins_sret) & !dec_ill_ins;


//译出当前是否为异常指令
//译出当前指令是否访问了不该访问的csr
assign dec_csr_acc_fault= (ins_csrrc|ins_csrrci|ins_csrrs|ins_csrrsi|ins_csrrw|ins_csrrwi)?((priv==mach)|(priv==supe)|((priv==user)&(dec_csr_index[9:8]==2'b00))):1'b0;
//当tsr tvm tw位为1时候，执行这些指令会被禁止,并且SRET指令不允许在M模式下被执行
assign dec_ins_unpermit	= (tsr&ins_sret)|(tvm&(ins_sfencevma|(ins_csrrc|ins_csrrci|ins_csrrs|ins_csrrsi|ins_csrrw|ins_csrrwi)&(priv==supe)&(dec_csr_index==12'h180)))|
						  (tw&ins_wfi)|
						  (priv==supe)&ins_mret;
//opcode无法解码，直接判定为异常指令						  
assign dec_ins_dec_fault= !(op_system|op_imm|op_32_imm|op_lui|op_auipc|op_jal|op_jalr|op_branch|op_store|op_load|op_reg|op_32_reg|op_amo);
assign dec_ill_ins		= dec_ins_unpermit|dec_csr_acc_fault|dec_ins_dec_fault;//异常指令

//输出寄存器，往EX
always@(posedge clk)begin
	if(rst)begin
	//操作码 ALU,运算码
	//rd数据选择
		rd_data_ds1 <= 1'b0;		//ds1直通	
		rd_data_add <= 1'b0;		//加
		rd_data_sub <= 1'b0;
		rd_data_and <= 1'b0;		//逻辑&
		rd_data_or	<= 1'b0;		//逻辑|
		rd_data_xor <= 1'b0;		//逻辑^
		rd_data_slt <= 1'b0;		//比较大小
		compare		<= 1'b0;
		amo_lr_sc	<= 1'b0;		//lr/sc读写成功标志

//mem_csr_data数据选择
		mem_csr_data_ds1	<= 1'b0;
		mem_csr_data_ds2	<= 1'b0;
		mem_csr_data_add	<= 1'b0;
		mem_csr_data_and	<= 1'b0;
		mem_csr_data_or		<= 1'b0;
		mem_csr_data_xor	<= 1'b0;
		mem_csr_data_max	<= 1'b0;
		mem_csr_data_min	<= 1'b0;
	end
	//当进行hold的时候，输出寄存器均被保持
	else if(id_hold)begin
	//操作码 ALU,运算码
	//rd数据选择
		rd_data_ds1 <= rd_data_ds1;		//ds1直通
		
		rd_data_add <= rd_data_add;		//加
		rd_data_sub <= rd_data_sub;
		rd_data_and <= rd_data_and;		//逻辑&
		rd_data_or	<= rd_data_or;		//逻辑|
		rd_data_xor <= rd_data_xor;		//逻辑^
		rd_data_slt <= rd_data_slt;		//比较大小
		compare		<= compare;
		amo_lr_sc	<= amo_lr_sc;		//lr/sc读写成功标志

	//mem_csr_data数据选择
		mem_csr_data_ds1	<= mem_csr_data_ds1;
		mem_csr_data_ds2	<= mem_csr_data_ds2;
		mem_csr_data_add	<= mem_csr_data_add;
		mem_csr_data_and	<= mem_csr_data_and;
		mem_csr_data_or		<= mem_csr_data_or;
		mem_csr_data_xor	<= mem_csr_data_xor;
		mem_csr_data_max	<= mem_csr_data_max;
		mem_csr_data_min	<= mem_csr_data_min;
	end
	//在没有保持的时候，进行指令解码
	else begin
	//操作码 ALU,运算码
	//rd数据选择
		rd_data_ds1 <= ins_lui|ins_csrrc|ins_csrrci|ins_csrrs|ins_csrrsi|ins_csrrw|ins_csrrwi|ds1_mem_iden;		
		//ds1直通，注意：所有移位指令都在RD寄存器被处理，故移位指令时直接让数据通往RD寄存器
		//所有原子指令，内存访问读取的数据，都通过ds1被送往RD寄存器
		rd_data_add <= ins_auipc|ins_jal|ins_jalr|ins_addi|ins_addiw|ins_add|ins_addw;		//加
		rd_data_sub <= ins_sub|ins_subw;
		rd_data_and <= ins_andi|ins_and;		//逻辑&
		rd_data_or	<= ins_ori|ins_or;			//逻辑|
		rd_data_xor <= ins_xori|ins_xor;		//逻辑^
		rd_data_slt <= ins_slti|ins_sltiu|ins_slt|ins_sltu;		//比较大小
		compare		<= op_branch;
		amo_lr_sc	<= ins_scw|ins_scd;		//lr/sc读写成功标志

	//mem_csr_data数据选择
		
		mem_csr_data_ds2	<= ins_csrrw|ins_csrrwi|ins_scw|ins_scd|ins_amoswapd|ins_amoswapw|ins_sb|ins_sh|ins_sw|ins_sd;
		mem_csr_data_add	<= ins_amoaddd|ins_amoaddw;
		mem_csr_data_and	<= ins_csrrc|ins_csrrci|ins_amoandd|ins_amoandw;
		mem_csr_data_or		<= ins_csrrs|ins_csrrsi|ins_amoord|ins_amoorw;
		mem_csr_data_xor	<= ins_amoxord|ins_amoxorw;
		mem_csr_data_max	<= ins_amomaxw|ins_amomaxuw|ins_amomaxd|ins_amomaxud;
		mem_csr_data_min	<= ins_amominw|ins_amominuw|ins_amomind|ins_amominud;
	end		
end

//运算辅助控制信号
always@(posedge clk)begin
	if(rst)begin
		blt		<= 1'b0;
		bge		<= 1'b0;
		beq		<= 1'b0;
		bne		<= 1'b0;
		jmp		<= 1'b0;
		unsign 	<= 1'b0;			//无符号操作，同时控制mem单元信号的符号
		and_clr	<= 1'b0;			//将csr操作的and转换为clr操作
		ds1_sel	<= 1'b0;			//ALU ds1选择，为0选择ds1，为1选择MEM读取信号
		
	end
	else if(id_hold)begin
		blt		<= blt;
		bge		<= bge;
		beq		<= beq;
		bne		<= bne;
		jmp		<= jmp;
		unsign 	<= unsign;
		and_clr	<= and_clr;
		ds1_sel	<= ds1_sel;
		
	end
	else begin
		blt		<= ins_blt|ins_bltu;
		bge		<= ins_bge|ins_bgeu;
		beq		<= ins_beq;
		bne		<= ins_bne;
		jmp		<= ins_jal|ins_jalr;
		unsign 	<= ins_bltu|ins_bgeu|ins_lbu|ins_lhu|ins_lwu|ins_srai|ins_sraiw|
		ins_sraw|ins_sra|ins_amomaxuw|ins_amomaxud|ins_amominud|ins_amominuw;	//所有要求无符号操作的地方 unsign都为1
		and_clr	<= ins_csrrc|ins_csrrci;
		ds1_sel	<= ds1_mem_iden;		//所有ds1要求被置换为mem的地方，ds1_sel=1
		
	end
end
//size
always@(posedge clk)begin
	if(rst | !valid_if)begin
		size <= qbyte_size;
	end
	else if(id_hold)begin
		size <= size;
	end
	else begin
		size[0] <= sbyte;
		size[1] <= dbyte;
		size[2] <= qbyte;
		size[3] <= obyte;
	end
end

//多周期控制&写回控制
//多周期信号只在valid=1时候才会有效，否则无效。
always@(posedge clk)begin
	if(rst)begin
		load		<= 1'b0;
		store		<= 1'b0;
		amo			<= 1'b0;
		l1i_reset	<= 1'b0;		//缓存刷新信号，此信号可以与内存进行同步
		l1d_reset	<= 1'b0;		//缓存复位信号，sfence.vma指令使用，下次访问内存时重新刷新页表
		TLB_reset	<= 1'b0;
		shift_r		<= 1'b0;						//右移位
		shift_l		<= 1'b0;						//左移位//写回控制，当valid=0时候，所有写回不有效
		csr_write	<= 1'b0;
		gpr_write	<= 1'b0;
		csr_index	<= 12'b0;
		rs1_index	<= 5'b0;
		rs2_index	<= 5'b0;
		
	end
	else if(id_hold)begin
		load		<= load;
		store		<= store;
		amo			<= amo;
		l1i_reset	<= l1i_reset;	//缓存刷新信号，此信号可以与内存进行同步
		l1d_reset	<= l1d_reset;	//缓存复位信号，sfence.vma指令使用，下次访问内存时重新刷新页表
		TLB_reset	<=	TLB_reset;
		shift_r		<= shift_r;		//右移位
		shift_l		<= shift_l;		//左移位
		csr_write	<= csr_write;
		gpr_write	<= gpr_write;
		csr_index	<= csr_index;
		rs1_index	<= rs1_index;
		rs2_index	<= rs2_index;

	end
	else begin	
		load		<= op_load;
		store		<= op_store;
		amo			<= op_amo;
		l1i_reset 	<= ins_fence_i	;		//指令缓存刷新信号，sfence.vma或者fence.i指令使用 
		l1d_reset	<= ins_fence | ins_fence_i 	;	    //数据缓存刷新信号，sfence.vma或者fence指令使用
		TLB_reset	<= ins_sfencevma;
		shift_r		<= ins_srli|ins_srliw|ins_srai|ins_sraiw|ins_srl|ins_srlw|ins_sra|ins_sraw;						//右移位
		shift_l		<= ins_slli|ins_slliw|ins_sll|ins_sllw;						//左移位
		csr_write	<= (ins_csrrwi|ins_csrrw|ins_csrrci|ins_csrrc|ins_csrrs|ins_csrrsi)&!dec_ill_ins;	//只有CSRRxx指令且没有发生异常指令才会要求写回CSR
		gpr_write	<= dec_gpr_write;	//寄存器要被写回
		csr_index	<= dec_csr_index;
		rs1_index	<= dec_rs1_index;
		rs2_index	<= dec_rs2_index;
		rd_index	<= dec_rd_index;
	end
end
//数据源译码
always@(posedge clk)begin
	if(rst)begin
		//数据输出							   
		ds1		<= 64'b0;		//数据源1，imm/rs1/rs1/csr/pc /pc
		ds2		<= 64'b0;		//数据源2，00 /rs2/imm/imm/imm/04
		as1		<= 64'b0;		//地址源1,  pc/rs1/rs1
		as2		<= 64'b0;		//地址源2, imm/imm/00
		op_count<= 8'b0;		//操作次数码，用于AMO指令或移位指令
	end
	else if(id_hold)begin
		ds1		<= ds1;			//数据源1，imm/rs1/rs1/csr/pc /pc
		ds2		<= ds2;			//数据源2，00 /rs2/imm/imm/imm/04
		as1		<= as1;			//地址源1,  pc/rs1/rs1
		as2		<= as2;			//地址源2, imm/imm/00
		op_count<= op_count;	//操作次数码，用于AMO指令或移位指令
	end
	//此部分内容参考 Table_ID_DAS
	else begin
		ds1 	<= 	(ins_lui										?	imm20	:	64'b0)|
					((op_branch|op_reg|op_32_reg|op_imm|op_32_imm)	?	rs1_data:	64'b0)|
					(op_system										?	csr_data:	64'b0)|
					((ins_auipc|ins_jal|ins_jalr)					?	ins_pc	:	64'b0);
					
		ds2		<= 	((op_branch|op_reg|op_32_reg|op_store|op_amo)	?	rs2_data:	64'b0)|
					((op_32_imm|op_imm)								?	imm12_i	:	64'b0)|
					((ins_csrrwi|ins_csrrci|ins_csrrsi)				?	imm5_csr:	64'b0)|
					((ins_csrrw|ins_csrrc|ins_csrrs)				?	rs1_data:	64'b0)|
					(ins_auipc										?	imm20	:	64'b0)|
					((ins_jal|ins_jalr)								?	64'd4	:	64'b0);
		
		as1		<= 	(op_branch|ins_jal)	?	ins_pc		:	rs1_data;	
		
		as2		<= 	((op_branch)		?	imm12_b		:	64'b0)|
					((ins_jalr)			?	imm12_i		:	64'b0)|
					((ins_jal)			?	imm20_jal	:	64'b0)|
					((op_store)			?	imm12_s		:	64'b0)|
					((op_load)			?	imm12_i		:	64'b0);
		op_count<=	op_count_decode;
	end
end

//机器控制段
//机器控制段负责WB阶段时csr的自动更新
always@(posedge clk)begin
	if(rst)begin
		id_system		<=	1'b0;		//system指令，op code=system的时候被置1
		id_jmp			<=	1'b0;
		ins_acc_fault	<= 	1'b0;	//指令访问失败
		ins_addr_mis	<=	1'b0;	//指令地址错误
		ins_page_fault	<= 	1'b0;	//指令页面错误
		int_acc			<= 	1'b0;			//中断接收信号
		valid			<= 	1'b0;			//指令有效信号
		ill_ins			<= 	1'b0;			//异常指令信号
		m_ret			<= 	1'b0;			//返回信号
		s_ret			<=	1'b0;
		ecall			<=	1'b0;		//环境调用
		ebreak			<=	1'b0;		//断点
	end
	//ID插空时，valid位置0，表示当前指令无效，不被执行也不会响应其中的异常
	else if(id_nop)begin
		valid			<=	1'b0;
	end
	else if(id_hold)begin
		id_system		<=	id_system;		//system指令，op code=system的时候被置1
		id_jmp			<= 	id_jmp;		
		ins_acc_fault	<= 	ins_acc_fault;	//指令访问失败
		ins_addr_mis	<=	ins_addr_mis;	//指令地址错误
		ins_page_fault	<= 	ins_page_fault;	//指令页面错误
		int_acc			<= 	int_acc;		//中断接收信号
		valid			<= 	valid;			//指令有效信号
		ill_ins			<= 	ill_ins;		//异常指令信号
		m_ret			<= 	m_ret;			//返回信号
		s_ret			<=	s_ret;
		ecall			<=	ecall;			//环境调用
		ebreak			<=	ebreak;			//断点
	end
	//不需要hold和nop时候，ID直接传递由IF递过来的信号
	else begin
		id_system		<=	dec_system_mem;		//system指令，op code=system的时候被置1
		id_jmp			<=  op_branch|ins_jal|ins_jalr;
		ins_acc_fault	<= 	ins_acc_fault_if;	//指令访问失败
		ins_addr_mis	<=	ins_addr_mis_if;	//指令地址错误
		ins_page_fault	<= 	ins_page_fault_if;	//指令页面错误
		int_acc			<= 	int_acc_if;			//中断接收信号
		valid			<= 	valid_if;			//指令有效信号
		ill_ins			<= 	dec_ill_ins;		//异常指令信号
		m_ret			<= 	!dec_ill_ins&ins_mret;			//返回信号,不被trap时才能正常使用返回信号
		s_ret			<=	!dec_ill_ins&ins_sret;
		ecall			<=	ins_ecall;			//环境调用
		ebreak			<=	ins_ebreak;			//断点
	end
	
end
//异常码
always@(posedge clk)begin
	if(rst | !valid_if)begin
		
		exc_code	<=	64'b0;
		//当前指令pc
		ins_pc_id	<= 	64'b0;
	end
	else if(id_hold)begin
		exc_code	<=  exc_code;
		ins_pc_id	<=	ins_pc_id;
	end
	else begin
	//当非法指时候，该码被更新为ins
		exc_code	<= dec_ill_ins?{32'b0,ins_in}:64'b0;
		ins_pc_id	<=	ins_pc;
	end
end








endmodule