/*
PRV464的执行单元，含算术运算（ALU）和内存访问（LSU）两个部分
LSU单元只进行数据移位
*/
module exu(
input wire clk,
input wire rst,

input wire [3:0]priv,		//当前机器权限
//csr输入
input wire mprv,			//更改权限
input wire [3:0]mod_priv,	//要被更改的权限
//上一级 ID输入
//异常码
//当非法指时候，该码被更新为ins，当指令页面错误，被更新为addr
input wire [63:0]exc_code_id,
//当前指令pc
input wire [63:0]ins_pc_id,

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
input wire amo_lr_sc,		//lr/sc读写成功标志，LR/SC指令总是读写成功

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
input wire blt,				
input wire bge,
input wire beq,				
input wire bne,
input wire jmp,				//无条件跳转，适用于JAL JALR指令
input wire unsign,			//无符号操作，同时控制mem单元信号的符号拓展
input wire and_clr,			//将csr操作的and转换为clr操作
input wire ds1_sel,			//ALU ds1选择，为0选择ds1，为1选择LSU读取的数据

//位宽控制
input wire [3:0]size, 		//0001:1Byte 0010:2Byte 0100=4Byte 1000=8Byte
//多周期控制
//多周期控制信号线控制EX单元进行多周期操作
input wire load,
input wire store,
input wire amo,
input wire l1i_reset,		//命令 缓存刷新信号，此信号可以与内存进行同步
input wire l1d_reset,		//命令 缓存复位信号，下次访问内存时重新刷新页表
input wire TLB_reset,
input wire shift_r,			//左移位
input wire shift_l,			//右移位

//写回控制，当valid=0时候，所有写回不有效
input wire csr_write_id,		//注*后缀ID表示是ID传输进来的信号
input wire gpr_write_id,
input wire [11:0]csr_index_id,
input wire [4:0]rs1_index_id,
input wire [4:0]rs2_index_id,
input wire [4:0]rd_index_id,

//数据输出							   
input wire [63:0]ds1,		//数据源1，imm/rs1/rs1/csr/pc /pc
input wire [63:0]ds2,		//数据源2，00 /rs2/imm/imm/imm/04
input wire [63:0]as1,		//地址源1,  pc/rs1/rs1
input wire [63:0]as2,		//地址源2, imm/imm/00
input wire [7:0]op_count,	//操作次数码，用于AMO指令或移位指令
//机器控制段
//机器控制段负责WB阶段时csr的自动更新
input wire id_system_id,		//system指令，op code=system的时候被置1
input wire id_jmp_id,			//会产生跳转的指令 opcode=branch时候置1
input wire ins_acc_fault_id,	//指令访问失败
input wire ins_addr_mis_id, 	//指令地址错误
input wire ins_page_fault_id,	//指令页面错误
input wire int_acc_id,			//中断接收信号
input wire valid_id, 			//指令有效信号
input wire ill_ins_id,			//异常指令信号
input wire m_ret_id,				//返回信号
input wire s_ret_id,
input wire ecall_id,			//环境调用
input wire ebreak_id,			//断点
//到EX信号完

//到下一级 WB信号
//数据输出
output reg [63:0]data_rd,
output reg [63:0]data_csr,
output reg [63:0]new_pc,
//写回控制
output reg csr_write,
output reg gpr_write,
output reg pc_jmp,				//新的PC需要被更改，新的PC由pc_new给出，该信号表明WB阶段需要修改PC
output reg [11:0]csr_index,
output reg [4:0]rd_index,
//异常码
output reg [63:0]ins_pc,
output reg [63:0]exc_code,		//如果是非法指令异常，则为非法指令，如果是硬件断点和储存器访问失败，则是虚拟地址
//机器控制段
//机器控制段负责WB阶段时csr的自动更新
output reg id_system,		//system指令，op code=system的时候被置1
output reg id_jmp,			//会产生跳转的指令 opcode=branch时候置1
output reg ins_acc_fault,	//指令访问失败
output reg ins_addr_mis, 	//指令地址错误
output reg ins_page_fault,	//指令页面错误
output reg ld_addr_mis,		//load地址不对齐
output reg st_addr_mis,		//store地址不对齐
output reg ld_acc_fault,	//load访问失败
output reg st_acc_fault,	//store访问失败
output reg ld_page_fault,	//load页面错误
output reg st_page_fault,	//store页面错误
output reg int_acc,			//中断接收信号
output reg valid, 			//指令有效信号
output reg ill_ins,			//异常指令信号
output reg m_ret,			//返回信号
output reg s_ret,			//
output reg ecall,			//环境调用
output reg ebreak,			//断点


//对BIU信号
output wire unpage,				//只使用物理地址 data_from_biu
output wire [3:0]ex_priv,		//ex权限，0001=U 0010=S 0100=H 1000=M 
output reg [63:0]addr_ex,
output wire [63:0]data_write,
input wire [63:0]data_read,
input wire [63:0]uncache_data,	//没有被缓存的数据
output wire [3:0]size_biu,			//0001=1Byte 0010=2Byte 0100=4Byte 1000=8Byte other=fault			
output wire cache_l1i_reset,			//缓存刷新信号，用于执行fence指令的时候使用
output wire cache_l1d_reset,			//缓存载入信号，用于执行fence.vma时候和cache_flush配合使用
output wire cache_TLB_reset,
output wire read,				//读数据信号
output wire write,				//写数据信号

input wire load_acc_fault,
input wire load_page_fault,
input wire store_acc_fault,
input wire store_page_fault,
input wire cache_ready_ex,		//cache数据准备好信号，此信号比read_data提前一个周期出现
input wire uncache_data_ready,	//不可缓存的数据准备好，此信号与uncache_data一个周期出现

//pip_ctrl信号
//pip_ctrl负责检查这些信号并控制整个流水线的操作

//ex独有pipctrl信号
output wire ex_exception,				//ex发生错误，此信号比WB阶段的信号提早1T出现，
output wire ex_ready,					//ex准备好信号,和同步sram信号一样，这个信号在T1出现，T2才会更新出有效数据

input wire ex_hold,						//ID等待
input wire ex_nop						//ID插空

);
parameter p_stb 		= 4'b0000;	//等待状态
parameter p_shift		= 4'b0001;	//移位指令，需要多周期
parameter p_load		= 4'b0010;	//load指令，需要多周期
parameter p_load1		= 4'b0011;	//load指令，第二周期
parameter p_store 		= 4'b0100;	//store指令
parameter p_amo_mem0	= 4'b1000;	//amo指令第一次访问内存
parameter p_amo_mem01	= 4'b1001;	//amo指令第一次访问内存延迟一拍，为了同步sram
parameter p_amo_ex1		= 4'b1010;	//amo指令第二次执行，第一次执行在stb状态时已经完成
parameter p_amo_mem1	= 4'b1011;	//amo指令第二次访问内存
parameter p_fence		= 4'b1100;	//fence指令

//EXU状态机控制线
wire c_stb;		//对系统主状态机译码
//wire c_shift;
wire c_load;
wire c_load_1;
wire c_store;
wire c_amo_mem0;
wire c_amo_mem01;
wire c_amo_ex1;
wire c_amo_mem1;
wire c_fence;

reg [3:0]main_state;			//系统主状态机
//reg [7:0]shift_count;

wire non_shift;					//不移位判断，当shift指令但是opcount=0时不为1，表示不需要移位
wire shift_ready;				//移位完成信号，由rd输出寄存器给出
wire ls_amo_ready;				//amo，load/store指令完成信号
//ALU信号
wire [63:0]ds1_mem_data;		//ALU数据源1选择，当ds1_sel=1时，切换到MEM出来的数据，此举是为了AMO指令
wire [63:0]alu_data_rd;			//ALU数据数据输出，写回rd寄存器的数据
wire [63:0]alu_data_mem_csr;	//ALU数据输出，csr数据或者写回内存的数据

wire jmp_ok;					//跳转信号，允许跳转，此信号指示WB阶段进行跳转
//AU信号
wire [63:0]au_addr_pc;			//AU数据输出，访问内存所需的地址或者是跳转地址
//LSU信号

wire [63:0]data_lsu_cache;		//LSU输出数据(被缓存的)，AMO指令或Load指令时使用
//wire [63:0]data_lsu_uncache;	//lsu输出数据（不被缓存的）
wire exception_id;


wire load_addr_mis;				//load地址不对齐
wire store_addr_mis;			//store地址不对齐

wire load_ready;				//load指令执行完成
wire store_ready;				//store指令执行完成
wire fence_ready;				//fence指令执行完成
wire amo_ready;					//amo指令执行完成

assign ds1_mem_data		=	ds1_sel ? data_rd : ds1;	//当ds1_sel为1时，切换到MEM数据，此时MEM的数据已经被存到rd寄存器中

assign load_addr_mis	=  	(amo|load) & (size[1]&(au_addr_pc[2:0]==3'b111) | size[2]&(au_addr_pc[1:0]!=2'b00) | size[3]&(au_addr_pc[2:0]!=3'b000));
assign store_addr_mis	=	store& (size[1]&(au_addr_pc[2:0]==3'b111) | size[2]&(au_addr_pc[1:0]!=2'b00) | size[3]&(au_addr_pc[2:0]!=3'b000));


assign load_ready	=	(c_load&uncache_data_ready) | c_load_1;
assign store_ready	=	c_store & cache_ready_ex;
assign fence_ready	=	c_fence & cache_ready_ex;
assign amo_ready	=	c_amo_mem1 & cache_ready_ex;
//assign shift_multi_ready	=	c_shift	&  shift_ready;

assign exception_id = 	ins_acc_fault_id | ins_addr_mis_id | ins_page_fault_id | ill_ins_id;
assign ex_exception	=	load_acc_fault	|load_page_fault|store_acc_fault|store_page_fault|load_addr_mis|store_addr_mis;

//主状态机
always@(posedge clk)begin
	if(rst)begin
		main_state <= p_stb;
	end
	else if(ex_nop)begin
		main_state	<=	main_state;
	end
	//只有有效指令并且没有id发生异常才会引起动作,注意！如果发生了中断，是可以继续运行的
	else if(valid_id&!exception_id&(main_state==p_stb))begin
		main_state <= 	load								?p_load		:
						store								?p_store	:
						amo									?p_amo_mem0	:
						(l1i_reset|l1d_reset|TLB_reset)		?p_fence	:main_state;
	end
	
	else if(main_state==p_load)begin
		main_state <= (uncache_data_ready)?p_stb : cache_ready_ex?p_load1: main_state;//数据准备好了回到stb状态
	end
	else if(main_state==p_load1)begin
		main_state <= p_stb;
	end
	else if(main_state==p_store)begin
		main_state <= ex_exception?p_stb:(cache_ready_ex|uncache_data_ready)?p_stb : main_state;
	end
	
	else if(main_state==p_amo_mem0)begin		//AMO指令第一次操作，访问内存，如果是缓存中的信号 跳转到mem01状态读取数据
		main_state <= ex_exception?p_stb:(uncache_data_ready)?p_amo_ex1:(cache_ready_ex)?p_amo_mem01:main_state;
	end
	else if(main_state==p_fence)begin
		main_state <= ex_exception?p_stb:(cache_ready_ex|uncache_data_ready)?p_stb:main_state;	//fence指令执行好了回到stb状态
	end											//AMO指令第二次操作，进行数据运算
	else if(main_state==p_amo_ex1)begin
		main_state <= p_amo_mem1;
	end
	else if(main_state==p_amo_mem01)begin		//AMO指令第三次操作，将数据写回内存
		main_state <= p_amo_ex1;
	end
	else if(main_state==p_amo_mem1)begin
		main_state <= ex_exception?p_stb:(cache_ready_ex|uncache_data_ready)?p_stb:main_state;
	end
						
end
assign c_stb 		= (main_state==p_stb);		//对系统主状态机译码
assign c_load		= (main_state==p_load);
assign c_load_1		= (main_state==p_load1);
assign c_store 		= (main_state==p_store);
assign c_amo_mem0	= (main_state==p_amo_mem0);
assign c_amo_mem01	= (main_state==p_amo_mem01);
//assign c_amo_ex1 	= (main_state==p_amo_ex1);
assign c_amo_mem1 	= (main_state==p_amo_mem1);
assign c_fence 		= (main_state==p_fence);


//对WB的数据输出
//rd值输出寄存器，移位指令也在其中处理
always@(posedge clk)begin
	if(rst)begin
		data_rd <= 64'b0;
	end
	else if(ex_hold)begin
		data_rd <= data_rd;
	end

	else if(c_stb)begin
		data_rd 	<=	alu_data_rd;
	end
	/*
	因为AHB总线的HREADY和数据是同周期出现，而cache是SSRAM，数据和准备好信号之间延迟一个周期，故在这里
	寄存两次来保证数据正确
	*/
	//AMO指令访问内存之后进行数据寄存，以便进行下一步操作
	else if(c_load|c_amo_mem0|c_load_1|c_amo_mem01)begin
		data_rd		<=  data_lsu_cache;		//存储数据
	end
	
end
//data_csr和newpc寄存器
always@(posedge clk)begin
	if(rst)begin
		data_csr	<=	64'b0;
		new_pc		<= 	64'b0;
	end
	else if(ex_hold)begin
		data_csr	<= 	data_csr;
		new_pc		<=	new_pc;
	end
	else begin
		data_csr	<= 	alu_data_mem_csr;
		new_pc		<=	au_addr_pc;
	end
end

//传递到下一级的异常码
always@(posedge clk)begin
	if(rst)begin
		ins_pc	<=	64'b0;
		exc_code<= 	64'b0;
	end
	else if(ex_hold)begin
		ins_pc 	<=	ins_pc;
		exc_code<=	exc_code;
	end
	else begin
		ins_pc	<= 	ins_pc_id;
		exc_code<= 	ex_exception ? au_addr_pc : exc_code_id;//只有当发生了异常，才会被更新到异常上
	end
end
//写回控制信号
always@(posedge clk)begin
	if(rst | ex_nop)begin
		csr_write	<=	1'b0;
		gpr_write	<= 	1'b0;
		pc_jmp		<=	1'b0;				//新的PC需要被更改，新的PC由pc_new给出，该信号表明WB阶段需要修改PC
		csr_index	<=	12'b0;
		rd_index	<=	5'b0;
	end
	else if(ex_hold)begin
		csr_write	<=	csr_write;
		gpr_write	<= 	gpr_write;
		pc_jmp		<=	pc_jmp;				//新的PC需要被更改，新的PC由pc_new给出，该信号表明WB阶段需要修改PC
		csr_index	<=	csr_index;
		rd_index	<=	rd_index;
	end
	//EX阶段继续传递ID阶段传进来的写回信息
	else begin
		csr_write	<=	csr_write_id;
		gpr_write	<= 	gpr_write_id;
		pc_jmp		<=	jmp_ok;				//新的PC需要被更改，新的PC由pc_new给出，该信号表明WB阶段需要修改PC
		csr_index	<=	csr_index_id;
		rd_index	<=	rd_index_id;
	end
end

//机器控制段
//机器控制段负责WB阶段时csr的自动更新
always@(posedge clk)begin
	if(rst | ex_nop)begin
		id_system		<=	1'b0;		//system指令，op code=system的时候被置1
		id_jmp			<=	1'b0;		//会产生跳转的指令 opcode=branch时候置1
		ins_acc_fault	<=	1'b0;	//指令访问失败
		ins_addr_mis	<=	1'b0;	//指令地址错误
		ins_page_fault	<=	1'b0;	//指令页面错误
		ld_addr_mis		<=	1'b0;	//load地址不对齐
		st_addr_mis		<=  1'b0;	//store地址不对齐
		ld_acc_fault	<=	1'b0;	//load访问失败
		st_acc_fault	<=	1'b0;	//store访问失败
		ld_page_fault	<=	1'b0;	//load页面错误
		st_page_fault	<=	1'b0;	//store页面错误
		int_acc			<=	1'b0;	//中断接收信号
		valid			<=	1'b0;	//指令有效信号
		ill_ins			<=	1'b0;	//异常指令信号
		m_ret			<=	1'b0;	//返回信号
		s_ret			<=	1'b0;
		ecall			<=	1'b0;	//环境调用
		ebreak			<=	1'b0;	//断点
	end
	else if(ex_hold)begin
		id_system		<=	id_system;		//system指令，op code=system的时候被置1
		id_jmp			<=	id_jmp;		//会产生跳转的指令 opcode=branch时候置1
		ins_acc_fault	<=	ins_acc_fault;	//指令访问失败
		ins_addr_mis	<=	ins_addr_mis;	//指令地址错误
		ins_page_fault	<=	ins_page_fault;	//指令页面错误
		ld_addr_mis		<=	ins_addr_mis;	//load地址不对齐
		st_addr_mis		<=  st_addr_mis;	//store地址不对齐
		ld_acc_fault	<=	ld_acc_fault;	//load访问失败
		st_acc_fault	<=	st_acc_fault;	//store访问失败
		ld_page_fault	<=	ld_page_fault;	//load页面错误
		st_page_fault	<=	st_page_fault;	//store页面错误
		int_acc			<=	int_acc;	//中断接收信号
		valid			<=	valid;	//指令有效信号
		ill_ins			<=	ill_ins;	//异常指令信号
		m_ret			<=	m_ret;	//返回信号
		s_ret			<=	s_ret;
		ecall			<=	ecall;	//环境调用
		ebreak			<=	ebreak;	//断点
	end
	else begin
		id_system		<=	id_system_id;									//system指令，op code=system的时候被置1
		id_jmp			<=	id_jmp_id;										//会产生跳转的指令 opcode=branch或者JAL JALR时候置1
		ins_acc_fault	<=	ins_acc_fault_id;								//指令访问失败
		ins_addr_mis	<=	ins_addr_mis_id;								//指令地址错误
		ins_page_fault	<=	ins_page_fault_id;								//指令页面错误
		ld_addr_mis		<=	load_addr_mis;									//load地址不对齐
		st_addr_mis		<=  (c_amo_mem0&load_addr_mis) | store_addr_mis;	//store地址不对齐
		ld_acc_fault	<=	load_acc_fault;										//load访问失败
		st_acc_fault	<=	(c_amo_mem0&load_acc_fault) | store_acc_fault;	//store访问失败
		ld_page_fault	<=	load_page_fault;									//load页面错误
		st_page_fault	<=	(c_amo_mem0&load_page_fault) | store_page_fault;	//store/AMO页面错误
		int_acc			<=	int_acc_id;											//中断接收信号
		valid			<=	valid_id & (ex_ready | ex_exception | exception_id);				//指令有效信号,如果发生异常，valid=1，交给WB
		ill_ins			<=	ill_ins_id;										//异常指令信号
		m_ret			<=	m_ret_id;										//返回信号
		s_ret			<=	s_ret_id;
		ecall			<=	ecall_id;											//环境调用
		ebreak			<=	ebreak_id;											//断点
	end
end


assign ex_ready			=	valid_id ? (!(load|store|amo|l1i_reset|l1d_reset) | //没有多周期操作时 1T即执行完成
							load & load_ready | 
							store & store_ready | 
							amo&amo_ready | 
							(l1i_reset|l1d_reset|TLB_reset) & fence_ready)  : 1'b1 ; //valid_id=0时，为空操作，此时EX准备好
										//ID如果发生异常，EX不会执行操作，直接准备好

alu_au		alu_au(
//操作码 ALU,运算码
//rd数据选择
	.rd_data_ds1		(rd_data_ds1),		//ds1直通
	.rd_data_add		(rd_data_add),		//加
	.rd_data_sub		(rd_data_sub),		//减
	.rd_data_and		(rd_data_and),		//逻辑&
	.rd_data_or			(rd_data_or),		//逻辑|
	.rd_data_xor		(rd_data_xor),		//逻辑^
	.rd_data_slt		(rd_data_slt),		//比较大小
	.compare			(compare),			//比较大小
	.amo_lr_sc			(amo_lr_sc),		//lr/sc读写成功标志

	.shift_r 			(shift_r),
	.shift_l 			(shift_l),

//mem_csr_data数据选择
	.mem_csr_data_ds1	(mem_csr_data_ds1),
	.mem_csr_data_ds2	(mem_csr_data_ds2),
	.mem_csr_data_add	(mem_csr_data_add),
	.mem_csr_data_and	(mem_csr_data_and),
	.mem_csr_data_or	(mem_csr_data_or),
	.mem_csr_data_xor	(mem_csr_data_xor),
	.mem_csr_data_max	(mem_csr_data_max),
	.mem_csr_data_min	(mem_csr_data_min),
//运算,跳转辅助控制信号
	.blt				(blt),				//条件跳转，blt bltu指令时为1
	.bge				(bge),
	.beq				(beq),				//条件跳转，bne指令时为一
	.bne				(bne),
	.jmp				(jmp),				//无条件跳转，适用于JAL JALR指令
	.unsign				(unsign),			//无符号操作，同时控制mem单元信号的符号
	.and_clr			(and_clr),			//将csr操作的and转换为clr操作

//位宽控制
	.size				(size), 		//0001:1Byte 0010:2Byte 0100=4Byte 1000=8Byte


//数据输入							   
	.ds1				(ds1_mem_data),		//数据源1，imm/rs1/rs1/csr/pc /pc
	.ds2				(ds2),		//数据源2，00 /rs2/imm/imm/imm/04
	.as1				(as1),		//地址源1,  pc/rs1/rs1
	.as2				(as2),		//地址源2, imm/imm/00

	.op_count			(op_count),	//移位次数

//数据输出
	.alu_data_rd		(alu_data_rd),
	.alu_data_mem_csr	(alu_data_mem_csr),//送到csr单元或者要写回内存的数据
	.au_addr_pc			(au_addr_pc),
//跳转信号输出
	.jmp_ok				(jmp_ok)

);

//对BIU信号
assign unpage	=	mprv&(mod_priv==2'b11);				//当启用的MPRV位且MPP位为M时候，绕开分页直接使用物理地址
assign ex_priv	=	unpage ? mod_priv : priv;		//ex权限，0001=U 0010=S 0100=H 1000=M 
always@(posedge clk)begin
	if(rst)begin
		addr_ex	<=	64'b0;
	end
	else begin
		addr_ex	<=	au_addr_pc;
	end
end


assign size_biu			=	size;			//0001=1Byte 0010=2Byte 0100=4Byte 1000=8Byte other=fault			
assign cache_l1i_reset 	= 	l1i_reset & c_fence;			//缓存刷新信号，用于执行fence指令的时候使用
assign cache_l1d_reset 	= 	l1d_reset & c_fence;			//缓存载入信号，用于执行fence.vma时候和cache_flush配合使用
assign cache_TLB_reset 	= 	TLB_reset & c_fence;
assign read				=	load & c_load | amo & c_amo_mem0;				//读数据信号
assign write			=	store & c_store | amo & c_amo_mem1;				//写数据信号

/*
LSU单元的主要作用只有进行数据移位和进行符号位拓展，时序控制完全被交给了EXU中的状态机
所有从EXU中向外送出的数据都要经过LSU进行数据移位。
所有从BIU中读到的数据都要经过LSU进行数据移位和符号拓展。
*/
lsu lsu(
.unsign				(unsign),
.addr				(au_addr_pc[2:0]),//地址低3位 用于指示移位大小
.size				(size),//0001:1Byte 0010:2Byte 0100=4Byte 1000=8Byte

.data_in			(alu_data_mem_csr),			//要送往BIU的数据
.data_lsu_uncache	(),							//从BIU读出的数据
.data_lsu_cache		(data_lsu_cache),	

//对BIU信号
.data_write			(data_write),
.data_read			(data_read),
.uncache_data		(uncache_data)	//没有被缓存的数据

);






endmodule
