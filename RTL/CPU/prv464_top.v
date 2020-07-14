
/*
 *    author : Pan
 *    e-mail : 2320025806@qq.com
 *    date   : 20200710
 *    desc   : PRV464SX-R Top level file
 *    version: 2.1
 
Family 	: PRV4
Module 	: 464SX-R
ISA		: RISC-V 64bit Extension U,S,I,A
L1I		: Full speed Sync 8KiByte 4-Lines 
L1D		: Full speed Sync 8KiByte 4-Lines
TLB-I	: Automatic 4-entry TLB-I
TLB-D	: Automatic 4-entry TLB-I

Reference to Version 1.2:
Add "bus_master_ack"&"bus_master_req" singal and "barrel_shifter" in EXU
*In come cases, when machine is in a trap, gprs are writen with unknowen value, and this version soleved it
Reference to Versions before 1.6:
Some errors like jal and bxx bugs
Reference to PRV464SX
PRV464SX-R added TLB-D and TLB-I

*/
module prv464_top(
//用户配置信号
input wire [31:0]cacheability_block,	//可缓存的区，即物理地址[63:31],这个区间里的内存是可以缓存的

input wire clk,			//时钟信号，和AHB总线同步
input wire rst,			//复位信号，高有效，AHB总线的复位信号是空脚
//AHB总线
output wire [63:0]haddr,
output wire hwrite,
output wire [2:0]hsize,
output wire [2:0]hburst,	//固定值
output wire [3:0]hprot,		//固定值
output wire [1:0]htrans,
output wire hmastlock,
output wire [63:0]hwdata,

input wire hready,
input wire hresp,
input wire hreset_n,
input wire [63:0]hrdata,

input wire bus_master_req,	//总线主机请求，当其他主机需要占用总线时候发出此请求
output wire bus_master_ack,	//总线主机允许，当464SX处理器结束总线访问且有主机请求之后，此位为1，表示总线可以被占用

//外部中断信号
input wire m_time_int,
input wire m_soft_int,
input wire m_ext_int,	//对M模式的中断信号
input wire s_ext_int,	//对S模式的中断信号
//外部时钟信号
input wire [63:0]mtime	//mtime寄存器实时值

);
//CSR信号
wire [63:0]satp;
wire [3:0]priv;		//当前机器权限
wire [3:0]mod_priv;
wire tvm;
wire tsr;
wire sum;
wire mxr;
wire mprv;
wire tw;
wire [63:0]csr_data;
wire [11:0]id_csr_index;
wire [63:0]rs1_data;
wire [4:0]id_rs1_index;
wire [63:0]rs2_data;
wire [4:0]id_rs2_index;

wire [63:0]flush_pc;
//CR对IF信号
wire int_req;
wire pip_flush;


//BIU对IF信号
wire [3:0]if_priv;
wire [63:0]addr_if;
wire rd_ins;
wire [63:0]ins_read;	//读取到的指令
wire ins_acc_fault;
wire ins_page_fault;
wire cache_ready_if;
//BIU对EX信号
wire unpage;
wire [3:0]ex_priv;
wire [63:0]addr_ex;
wire [63:0]data_read;
wire [63:0]data_write;
wire [63:0]uncache_data;
wire [3:0]size;
wire cache_l1i_reset;
wire cache_l1d_reset;
wire cache_TLB_reset;
wire read;
wire write;
wire load_acc_fault;
wire load_page_fault;
wire store_acc_fault;
wire store_page_fault;
wire cache_ready_ex;
wire uncache_data_rdy;
//IF对ID信号
wire [31:0]id_ins;
wire [63:0]id_ins_pc;
wire id_ins_acc_fault;
wire id_ins_addr_mis;
wire id_ins_page_fault;
wire id_int_acc;
wire id_valid;

//ID对EX信号
wire [63:0]ex_exc_code;		//错误码
wire [63:0]ex_ins_pc;		//指令PC
//操作码 ALU,运算码
//rd数据选择
wire rd_data_ds1;		//ds1直通
wire rd_data_add;		//加
wire rd_data_sub;		//减
wire rd_data_and;		//逻辑&
wire rd_data_or;		//逻辑|
wire rd_data_xor;		//逻辑^
wire rd_data_slt;		//比较大小
wire compare;			//比较大小，配合bge0_blt1\beq0_bne1控制线并产生分支信号
wire amo_lr_sc;		//lr/sc读写成功标志

//mem_csr_data数据选择
wire mem_csr_data_ds1;
wire mem_csr_data_ds2;
wire mem_csr_data_add;
wire mem_csr_data_and;
wire mem_csr_data_or;
wire mem_csr_data_xor;
wire mem_csr_data_max;
wire mem_csr_data_min;
//运算,跳转辅助控制信号
wire blt;				//条件跳转，blt bltu指令时为1
wire bge;
wire beq;				//条件跳转，bne指令时为一
wire bne;				//
wire jmp;				//无条件跳转，适用于JAL JALR指令
wire unsign;			//无符号操作，同时控制mem单元信号的符号
wire and_clr;			//将csr操作的and转换为clr操作
wire ds1_sel;			//ALU ds1选择，为0选择ds1，为1选择MEM读取信号

//位宽控制
wire [3:0]ex_size; 		//0001:1Byte 0010:2Byte 0100=4Byte 1000=8Byte
//多周期控制
//多周期控制信号线控制EX单元进行多周期操作
wire load;
wire store;
wire amo;
wire l1i_reset;		//
wire l1d_reset;		//
wire TLB_reset;
wire shift_r;			//左移位
wire shift_l;			//右移位

//写回控制，当valid=0时候，所有写回不有效
wire ex_csr_write;
wire ex_gpr_write;
wire [11:0]ex_csr_index;
wire [4:0]ex_rs1_index;
wire [4:0]ex_rs2_index;
wire [4:0]ex_rd_index;

//数据输出							   
wire [63:0]ds1;		//数据源1，imm/rs1/rs1/csr/pc /pc
wire [63:0]ds2;		//数据源2，00 /rs2/imm/imm/imm/04
wire [63:0]as1;		//地址源1,  pc/rs1/rs1
wire [63:0]as2;		//地址源2, imm/imm/00
wire [7:0]op_count;	//操作次数码，用于AMO指令或移位指令
//机器控制段
//机器控制段负责WB阶段时csr的自动更新
wire ex_system;		//system指令，op code=system的时候被置1
wire ex_jmp;			//会产生跳转的指令 opcode=branch时候置1
wire ex_ins_acc_fault;	//指令访问失败
wire ex_ins_addr_mis; 	//指令地址错误
wire ex_ins_page_fault;	//指令页面错误
wire ex_int_acc;			//中断接收信号
wire ex_valid; 			//指令有效信号
wire ex_ill_ins;			//异常指令信号
wire ex_m_ret;				//返回信号
wire ex_s_ret;
wire ex_ecall;			//环境调用
wire ex_ebreak;			//断点
//到EX信号完
//ID独有的pip ctrl信号
wire id_branch;
wire id_system;
wire id_ill_ins;
wire id_hold;
wire id_nop;
//EX到WB信号
wire wb_csr_write;
wire wb_gpr_write;
wire wb_system;
wire wb_jmp;
wire wb_ins_acc_fault;
wire wb_ins_addr_mis;
wire wb_ins_page_fault;
wire wb_ld_addr_mis;
wire wb_st_addr_mis;
wire wb_ld_page_fault;
wire wb_st_page_fault;
wire wb_int_acc;
wire wb_valid;
wire wb_ill_ins;
wire wb_m_ret;
wire wb_s_ret;
wire wb_ecall;
wire wb_ebreak;

wire pc_jmp;
wire [11:0]csr_index;
wire [4:0]wb_rd_index;
wire [63:0]data_csr;
wire [63:0]data_rd;
wire [63:0]new_pc;
wire [63:0]wb_exc_code;
wire [63:0]wb_ins_pc;
//EX信号
wire ex_more_exception;
wire ex_ready;
wire ex_hold;
wire ex_nop;


//pip_ctrl信号
wire if_nop;
wire if_hold;
wire wb_ld_acc_fault;
wire wb_st_acc_fault;

wire [4:0]id_rd_index;
wire id_gpr_write;



//BIU 总线接口单元，此单元包含了L1和总线的所有存取逻辑
biu biu(
.clk					(clk),
.rst					(rst),

.cacheability_block		(cacheability_block),

.satp					(satp),			//页表基地址
.sum					(sum),					//supervis-user访问允许
.mxr					(mxr),					//禁用执行位

//pmp检查信号
//没有PMP 告辞

//if信号
.if_priv				(if_priv),		//if权限，和机器当前权限相同
.addr_if				(addr_if),
.rd_ins					(rd_ins),				//取指令信号
.ins_read				(ins_read),

.ins_acc_fault			(ins_acc_fault), 		//指令访问失败
.ins_page_fault			(ins_page_fault),		//指令页面错误
.cache_ready_if			(cache_ready_if),		//cache准备好信号


//ex信号
.unpage					(unpage),				//只使用物理地址
.ex_priv				(ex_priv),				//ex权限，0001=U 0010=S 0100=H 1000=M 
.addr_ex				(addr_ex),
.data_write				(data_write),
.data_read				(data_read),
.data_uncache			(uncache_data),
.size					(size),					//0001=1Byte 0010=2Byte 0100=4Byte 1000=8Byte other=fault			
.l1i_reset				(cache_l1i_reset),		//缓存刷新信号，用于执行fence.i或者sfence.vma指令的时候使用
.l1d_reset				(cache_l1d_reset),		//缓存刷新信号，用于执行fence或者sfence.vma指令的时候使用
.TLB_reset				(cache_TLB_reset),
.read					(read),					//读数据信号
.write					(write),				//写数据信号

.load_acc_fault			(load_acc_fault),
.load_page_fault		(load_page_fault),
.store_acc_fault		(store_acc_fault),
.store_page_fault		(store_page_fault),
.cache_ready_ex			(cache_ready_ex),
.uncache_data_rdy		(uncache_data_rdy),

//AHB信号
.haddr					(haddr),
.hwrite					(hwrite),
.hsize						(hsize),
.hburst					(hburst),
.hprot					(hprot),
.htrans					(htrans),
.hmastlock				(hmastlock),
.hwdata					(hwdata),

.hready					(hready),
.hresp					(hresp),
.hreset_n(),
.hrdata					(hrdata),

.bus_master_req			(bus_master_req),
.bus_master_ack			(bus_master_ack)

);

//IF单元
ins_fetch ins_fetch(

.clk					(clk),
.rst					(rst),
.priv					(priv),		//当前机器权限状态

//中断控制器信号
.int_req				(int_req),			//中断请求信号，当准备处理中断时为1请求,中断请求信号在IF阶段被插入，只有当机器确保流水线排空之后才会处理中断
//pip控制器信号
//插空信号
.nop_if					(if_nop),
.if_hold				(if_hold),			//if保持信号
//流水线刷新信号
.pip_flush				(pip_flush),
.new_pc					(flush_pc),	//新PC输入
//对cache控制器信号
.addr					(addr_if),

.rd						(rd_ins),				//取指令信号
.if_priv				(if_priv),
.ins_in					(ins_read),
.ins_acc_fault_biu		(ins_acc_fault), 		//指令访问失败
.ins_page_fault_biu		(ins_page_fault),		//指令页面错误
.cache_ready			(cache_ready_if),				//cache准备好信号

/*

*/

//对下一级（ID）信号
//指令输出
.ins_out				(id_ins),
//指令对应的PC值输出
.ins_pc					(id_ins_pc),
//机器控制段

.ins_acc_fault			(id_ins_acc_fault),	//指令访问失败
.ins_addr_mis			(id_ins_addr_mis), 	//指令地址错误
.ins_page_fault			(id_ins_page_fault),	//指令页面错误
.int_acc				(id_int_acc),			//中断接收信号
.valid					(id_valid)			//指令有效信号


);



//指令解码单元
ins_dec ins_dec(

.clk					(clk),
.rst					(rst),

//csr
.priv					(priv),		//当前机器权限
.tvm					(tvm),
.tsr					(tsr),
.tw						(tw),
.csr_data				(csr_data),
//GPR输入
.rs1_data				(rs1_data),
.rs2_data				(rs2_data),

//上一级（IF）信号
//指令输出
.ins_in					(id_ins),
//指令对应的PC值输出
.ins_pc					(id_ins_pc),
//机器控制段
.ins_acc_fault_if		(id_ins_acc_fault),	//指令访问失败
.ins_addr_mis_if		(id_ins_addr_mis), 	//指令地址错误
.ins_page_fault_if		(id_ins_page_fault),	//指令页面错误
.int_acc_if				(id_int_acc),			//中断接收信号
.valid_if				(id_valid),			//指令有效信号

//下一级（EX）信号
//异常码
//当非法指时候，该码被更新为ins，当指令页面错误，被更新为addr
.exc_code				(ex_exc_code),
//当前指令pc
.ins_pc_id				(ex_ins_pc),

//操作码 ALU,运算码
//rd数据选择
.rd_data_ds1			(rd_data_ds1),		//ds1直通
.rd_data_add			(rd_data_add),		//加
.rd_data_sub			(rd_data_sub),		//减
.rd_data_and			(rd_data_and),		//逻辑&
.rd_data_or				(rd_data_or),		//逻辑|
.rd_data_xor			(rd_data_xor),		//逻辑^
.rd_data_slt			(rd_data_slt),		//比较大小
.compare				(compare),			//比较大小，配合bge0_blt1\beq0_bne1控制线并产生分支信号
.amo_lr_sc				(amo_lr_sc),		//lr/sc读写成功标志

//mem_csr_data数据选择
.mem_csr_data_ds1		(mem_csr_data_ds1),
.mem_csr_data_ds2		(mem_csr_data_ds2),
.mem_csr_data_add		(mem_csr_data_add),
.mem_csr_data_and		(mem_csr_data_and),
.mem_csr_data_or		(mem_csr_data_or),
.mem_csr_data_xor		(mem_csr_data_xor),
.mem_csr_data_max		(mem_csr_data_max),
.mem_csr_data_min		(mem_csr_data_min),
//运算,跳转辅助控制信号
.blt					(blt),				//条件跳转，blt bltu指令时为1
.bge					(bge),
.beq					(beq),				//条件跳转，bne指令时为一
.bne					(bne),				//
.jmp					(jmp),				//无条件跳转，适用于JAL JALR指令
.unsign					(unsign),			//无符号操作，同时控制mem单元信号的符号
.and_clr				(and_clr),			//将csr操作的and转换为clr操作
.ds1_sel				(ds1_sel),			//ALU ds1选择，为0选择ds1，为1选择MEM读取信号

//位宽控制
.size					(ex_size), 		//0001:1Byte 0010:2Byte 0100=4Byte 1000=8Byte
//多周期控制
//多周期控制信号线控制EX单元进行多周期操作
.load					(load),
.store					(store),
.amo					(amo),
.l1i_reset				(l1i_reset),		//缓存刷新信号，此信号可以与内存进行同步
.l1d_reset				(l1d_reset),		//缓存复位信号，下次访问内存时重新刷新页表
.TLB_reset				(TLB_reset),
.shift_r				(shift_r),			//左移位
.shift_l				(shift_l),			//右移位

//写回控制，当valid=0时候，所有写回不有效
.csr_write				(ex_csr_write),
.gpr_write				(ex_gpr_write),
.csr_index				(ex_csr_index),
.rs1_index(),
.rs2_index(),
.rd_index				(ex_rd_index),

//数据输出							   
.ds1					(ds1),		//数据源1，imm/rs1/rs1/csr/pc /pc
.ds2					(ds2),		//数据源2，00 /rs2/imm/imm/imm/04
.as1					(as1),		//地址源1,  pc/rs1/rs1
.as2					(as2),		//地址源2, imm/imm/00
.op_count				(op_count),	//操作次数码，用于AMO指令或移位指令
//机器控制段
//机器控制段负责WB阶段时csr的自动更新
.id_system				(ex_system),		//system指令，op code=system的时候被置1
.id_jmp					(ex_jmp),			//会产生跳转的指令 opcode=branch时候置1
.ins_acc_fault			(ex_ins_acc_fault),	//指令访问失败
.ins_addr_mis			(ex_ins_addr_mis), 	//指令地址错误
.ins_page_fault			(ex_ins_page_fault),	//指令页面错误
.int_acc				(ex_int_acc),			//中断接收信号
.valid					(ex_valid), 			//指令有效信号
.ill_ins				(ex_ill_ins),			//异常指令信号
.m_ret					(ex_m_ret),				//返回信号
.s_ret					(ex_s_ret),
.ecall					(ex_ecall),			//环境调用
.ebreak					(ex_ebreak),			//断点
//到EX信号完


//pip_ctrl信号
//pip_ctrl负责检查这些信号并控制整个流水线的操作
.dec_rs1_index			(id_rs1_index),			//立即解码得到的rs1index
.dec_rs2_index			(id_rs2_index),
.dec_rd_index			(id_rd_index),
.dec_csr_index			(id_csr_index),
//ID独有pip_ctrl信号
.dec_gpr_write			(id_gpr_write),
.dec_ill_ins			(id_ill_ins),				//译码之后得到错误指令信号
.dec_branch				(id_branch),					//分支指令，要求进行多周期操作
.dec_system_mem			(id_system),				//系统操作,即所有的system和fence指令，要求进行多周期操作

.id_hold				(id_hold),						//ID等待
.id_nop					(id_nop)						//ID插空

);

//执行单元
exu exu(
.clk					(clk),
.rst					(rst),

.priv					(priv),		//当前机器权限
//csr输入
.mprv					(mprv),			//更改权限
.mod_priv				(mod_priv),	//要被更改的权限
//上一级 ID输入
//异常码
//当非法指时候，该码被更新为ins，当指令页面错误，被更新为addr
.exc_code_id			(ex_exc_code),
//当前指令pc
.ins_pc_id				(ex_ins_pc),

//操作码 ALU,运算码
//rd数据选择
.rd_data_ds1			(rd_data_ds1),		//ds1直通
.rd_data_add			(rd_data_add),		//加
.rd_data_sub			(rd_data_sub),		//减
.rd_data_and			(rd_data_and),		//逻辑&
.rd_data_or				(rd_data_or),		//逻辑|
.rd_data_xor			(rd_data_xor),		//逻辑^
.rd_data_slt			(rd_data_slt),		//比较大小
.compare				(compare),			//比较大小，配合bge0_blt1\beq0_bne1控制线并产生分支信号
.amo_lr_sc				(amo_lr_sc),		//lr/sc读写成功标志

//mem_csr_data数据选择
.mem_csr_data_ds1		(mem_csr_data_ds1),
.mem_csr_data_ds2		(mem_csr_data_ds2),
.mem_csr_data_add		(mem_csr_data_add),
.mem_csr_data_and		(mem_csr_data_and),
.mem_csr_data_or		(mem_csr_data_or),
.mem_csr_data_xor		(mem_csr_data_xor),
.mem_csr_data_max		(mem_csr_data_max),
.mem_csr_data_min		(mem_csr_data_min),
//运算,跳转辅助控制信号
.blt					(blt),				//条件跳转，blt bltu指令时为1
.bge					(bge),
.beq					(beq),				//条件跳转，bne指令时为一
.bne					(bne),				//
.jmp					(jmp),				//无条件跳转，适用于JAL JALR指令
.unsign					(unsign),			//无符号操作，同时控制mem单元信号的符号
.and_clr				(and_clr),			//将csr操作的and转换为clr操作
.ds1_sel				(ds1_sel),			//ALU ds1选择，为0选择ds1，为1选择MEM读取信号

//位宽控制
.size					(ex_size), 		//0001:1Byte 0010:2Byte 0100=4Byte 1000=8Byte
//多周期控制
//多周期控制信号线控制EX单元进行多周期操作
.load					(load),
.store					(store),
.amo					(amo),
.l1i_reset				(l1i_reset),		
.l1d_reset				(l1d_reset),	
.TLB_reset				(TLB_reset),	
.shift_r				(shift_r),			//左移位
.shift_l				(shift_l),			//右移位

//写回控制，当valid=0时候，所有写回不有效
.csr_write_id			(ex_csr_write),
.gpr_write_id			(ex_gpr_write),
.csr_index_id			(ex_csr_index),
.rs1_index_id			(),
.rs2_index_id			(),
.rd_index_id			(ex_rd_index),

//数据输出							   
.ds1					(ds1),		//数据源1，imm/rs1/rs1/csr/pc /pc
.ds2					(ds2),		//数据源2，00 /rs2/imm/imm/imm/04
.as1					(as1),		//地址源1,  pc/rs1/rs1
.as2					(as2),		//地址源2, imm/imm/00
.op_count				(op_count),	//操作次数码，用于AMO指令或移位指令
//机器控制段
//机器控制段负责WB阶段时csr的自动更新
.id_system_id			(ex_system),		//system指令，op code=system的时候被置1
.id_jmp_id				(ex_jmp),			//会产生跳转的指令 opcode=branch时候置1
.ins_acc_fault_id		(ex_ins_acc_fault),	//指令访问失败
.ins_addr_mis_id		(ex_ins_addr_mis), 	//指令地址错误
.ins_page_fault_id	(ex_ins_page_fault),	//指令页面错误
.int_acc_id				(ex_int_acc),			//中断接收信号
.valid_id				(ex_valid), 			//指令有效信号
.ill_ins_id				(ex_ill_ins),			//异常指令信号
.m_ret_id				(ex_m_ret),				//返回信号
.s_ret_id				(ex_s_ret),
.ecall_id				(ex_ecall),			//环境调用
.ebreak_id				(ex_ebreak),			//断点
//到EX信号完

//到下一级 WB信号
//数据输出
.data_rd				(data_rd),
.data_csr				(data_csr),
.new_pc					(new_pc),
//写回控制
.csr_write				(wb_csr_write),
.gpr_write				(wb_gpr_write),
.pc_jmp					(pc_jmp),				//新的PC需要被更改，新的PC由pc_new给出，该信号表明WB阶段需要修改PC
.csr_index				(csr_index),
.rd_index				(wb_rd_index),
//异常码
.ins_pc					(wb_ins_pc),
.exc_code				(wb_exc_code),		//如果是非法指令异常，则为非法指令，如果是硬件断点和储存器访问失败，则是虚拟地址
//机器控制段
//机器控制段负责WB阶段时csr的自动更新
.id_system				(wb_system),		//system指令，op code=system的时候被置1
.id_jmp					(wb_jmp),			//会产生跳转的指令 opcode=branch时候置1
.ins_acc_fault			(wb_ins_acc_fault),	//指令访问失败
.ins_addr_mis			(wb_ins_addr_mis), 	//指令地址错误
.ins_page_fault			(wb_ins_page_fault),	//指令页面错误
.ld_addr_mis			(wb_ld_addr_mis),		//load地址不对齐
.st_addr_mis			(wb_st_addr_mis),		//store地址不对齐
.ld_acc_fault			(wb_ld_acc_fault),	//load访问失败
.st_acc_fault			(wb_st_acc_fault),	//store访问失败
.ld_page_fault			(wb_ld_page_fault),	//load页面错误
.st_page_fault			(wb_st_page_fault),	//store页面错误
.int_acc				(wb_int_acc),			//中断接收信号
.valid					(wb_valid), 			//指令有效信号
.ill_ins				(wb_ill_ins),			//异常指令信号
.m_ret					(wb_m_ret),			//返回信号
.s_ret					(wb_s_ret),			//
.ecall					(wb_ecall),			//环境调用
.ebreak					(wb_ebreak),			//断点


//对BIU信号
.unpage					(unpage),				//只使用物理地址
.ex_priv				(ex_priv),		//ex权限，0001=U 0010=S 0100=H 1000=M 
.addr_ex				(addr_ex),
.data_write				(data_write),
.data_read				(data_read),
.uncache_data			(uncache_data),	//没有被缓存的数据
.size_biu				(size),			//0001=1Byte 0010=2Byte 0100=4Byte 1000=8Byte other=fault			
.cache_l1i_reset		(cache_l1i_reset),			//缓存刷新信号，用于执行fence指令的时候使用
.cache_l1d_reset		(cache_l1d_reset),			//缓存载入信号，用于执行fence.vma时候和cache_flush配合使用
.cache_TLB_reset		(cache_TLB_reset),
.read					(read),				//读数据信号
.write					(write),				//写数据信号

.load_acc_fault			(load_acc_fault),
.load_page_fault		(load_page_fault),
.store_acc_fault		(store_acc_fault),
.store_page_fault		(store_page_fault),
.cache_ready_ex			(cache_ready_ex),		//cache数据准备好信号，此信号比read_data提前一个周期出现
.uncache_data_ready		(uncache_data_rdy),	//不可缓存的数据准备好，此信号与uncache_data一个周期出现

//pip_ctrl信号
//pip_ctrl负责检查这些信号并控制整个流水线的操作
//ex独有pipctrl信号
.ex_exception			(ex_more_exception),				//ex发生错误，此信号比WB阶段的信号提早1T出现，
.ex_ready				(ex_ready),					//ex准备好信号,和同步sram信号一样，这个信号在T1出现，T2才会更新出有效数据

.ex_hold				(ex_hold),						//ID等待
.ex_nop					(ex_nop)						//ID插空

);
//CU RW\U  控制 寄存器单元
cu_ru cu_ru(
.clk					(clk),
.rst					(rst),

//外部中断信号
.m_time_int				(m_time_int),
.m_soft_int				(m_soft_int),
.m_ext_int				(m_ext_int),	//对M模式的中断信号
.s_ext_int				(s_ext_int),	//对S模式的中断信号
//外部时钟信号
.mtime					(mtime),	//mtime寄存器实时值

//对IF信号
.int_req				(int_req),		//中断请求信号
.flush_pc				(flush_pc),	//新的PC值
.pip_flush				(pip_flush),		//流水线冲刷信号

//对ID信号
.satp					(satp),
.priv					(priv),		//当前机器权限
.tvm					(tvm),
.tsr					(tsr),
.tw						(tw),
.id_csr_index			(id_csr_index),
.csr_data				(csr_data),	//被ID读取的CSR值
.rs1_index				(id_rs1_index),
.rs1_data				(rs1_data),
.rs2_index				(id_rs2_index),
.rs2_data				(rs2_data),
//对EX信号
.mprv					(mprv),
.mod_priv				(mod_priv),

//WB输入信号
.data_rd				(data_rd),
.data_csr				(data_csr),
.new_pc					(new_pc),

//对BIU信号
.sum					(sum),
.mxr					(mxr),

//写回控制
.csr_write				(wb_csr_write),
.gpr_write				(wb_gpr_write),
.pc_jmp					(pc_jmp),				//新的PC需要被更改，新的PC由pc_new给出，该信号表明WB阶段需要修改PC
.csr_index				(csr_index),
.rd_index				(wb_rd_index),
//异常码
.ins_pc					(wb_ins_pc),
.exc_code				(wb_exc_code),		//如果是非法指令异常，则为非法指令，如果是硬件断点和储存器访问失败，则是虚拟地址

//机器控制段
//机器控制段负责WB阶段时csr的自动更新
.id_system				(wb_system),		//system指令，op code=system的时候被置1
.id_jmp					(wb_jmp),			//会产生跳转的指令 opcode=branch时候置1
.ins_acc_fault			(wb_ins_acc_fault),	//指令访问失败
.ins_addr_mis			(wb_ins_addr_mis), 	//指令地址错误
.ins_page_fault			(wb_ins_page_fault),	//指令页面错误
.ld_addr_mis			(wb_ld_addr_mis),		//load地址不对齐
.st_addr_mis			(wb_st_addr_mis),		//store地址不对齐
.ld_acc_fault			(wb_ld_acc_fault),	//load访问失败
.st_acc_fault			(wb_st_acc_fault),	//store访问失败
.ld_page_fault			(wb_ld_page_fault),	//load页面错误
.st_page_fault			(wb_st_page_fault),	//store页面错误
.int_acc				(wb_int_acc),			//中断接收信号
.valid					(wb_valid), 			//指令有效信号
.ill_ins				(wb_ill_ins),			//异常指令信号
.m_ret					(wb_m_ret),			//返回信号
.s_ret					(wb_s_ret),			//
.ecall					(wb_ecall),			//环境调用
.ebreak					(wb_ebreak)			//断点
//pip_ctrl信号
//pip_ctrl负责检查这些信号并控制整个流水线的操作



);



pip_ctrl pip_ctrl(
//pip_ctrl不需要时钟，是一个纯粹的组合逻辑

//ID输入信号
.id_rs1_index			(id_rs1_index),
.id_rs2_index			(id_rs2_index),
//ID遭遇异常
.id_ill_ins				(id_ill_ins),		//译码是异常指令
.id_system_mem			(id_system),	//是一个系统指令
.id_branch				(id_branch),		//是一个分支指令
.id_ins_acc_fault		(id_ins_acc_fault),	//指令访问失败
.id_ins_addr_mis		(id_ins_addr_mis), 	//指令地址错误
.id_ins_page_fault		(id_ins_page_fault),	//指令页面错误
.id_int_acc				(id_int_acc),			//中断接收信号
.id_valid				(id_valid)	,		//指令有效信号



//EX输入信号
.ex_rd_index			(ex_rd_index),
.ex_gpr_write			(ex_gpr_write),	//处于EX阶段的指令需要对RD寄存器写回
//EX遭遇异常
.ex_system				(ex_system),		//system指令，op code=system的时候被置1
.ex_jmp					(ex_jmp),			//会产生跳转的指令 opcode=branch时候置1
.ex_ins_acc_fault		(ex_ins_acc_fault),	//指令访问失败
.ex_ins_addr_mis		(ex_ins_addr_mis), 	//指令地址错误
.ex_ins_page_fault		(ex_ins_page_fault),	//指令页面错误
.ex_int_acc				(ex_int_acc),			//中断接收信号
.ex_valid				(ex_valid), 			//指令有效信号
.ex_ill_ins				(ex_ill_ins),			//异常指令信号
.ex_m_ret				(ex_m_ret),			//返回信号
.ex_s_ret				(ex_s_ret),
.ex_ecall				(ex_ecall),			//环境调用
.ex_ebreak				(ex_ebreak),			//断点

.ex_ready				(ex_ready),			//ex多周期执行正常
.ex_more_exception		(ex_more_exception),		//ex遭遇了更多的异常


//WB输入信号
.wb_rd_index			(wb_rd_index),
.wb_gpr_write			(wb_gpr_write),

.wb_id_system			(wb_system),		//system指令，op code=system的时候被置1
.wb_id_jmp				(wb_jmp),			//会产生跳转的指令 opcode=branch时候置1
.wb_ins_acc_fault		(wb_ins_acc_fault),	//指令访问失败
.wb_ins_addr_mis		(wb_ins_addr_mis), 	//指令地址错误
.wb_ins_page_fault		(wb_ins_page_fault),	//指令页面错误
.wb_ld_addr_mis			(wb_ld_addr_mis),		//load地址不对齐
.wb_st_addr_mis			(wb_st_addr_mis),		//store地址不对齐
.wb_ld_acc_fault		(wb_ld_acc_fault),	//load访问失败
.wb_st_acc_fault		(wb_st_acc_fault),	//store访问失败
.wb_ld_page_fault		(wb_ld_page_fault),	//load页面错误
.wb_st_page_fault		(wb_st_page_fault),	//store页面错误
.wb_int_acc				(wb_int_acc),			//中断接收信号
.wb_valid				(wb_valid), 			//指令有效信号
.wb_ill_ins				(wb_ill_ins),			//异常指令信号
.wb_m_ret				(wb_m_ret),			//返回信号
.wb_s_ret				(wb_s_ret),			//
.wb_ecall				(wb_ecall),			//环境调用
.wb_ebreak				(wb_ebreak),			//断点

//控制信号
.if_nop					(if_nop),
.if_hold				(if_hold),
.id_nop					(id_nop),
.id_hold				(id_hold),
.ex_nop					(ex_nop)


);


endmodule