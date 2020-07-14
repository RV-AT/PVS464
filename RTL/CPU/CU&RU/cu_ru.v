/*
适用于PRV464的控制单元CU和寄存器单元ru
寄存器单元含32个通用寄存器
控制单元含csr寄存器
对外的接口只有和IF，ID和WB
*/
module cu_ru(
input wire clk,
input wire rst,

//外部中断信号
input wire m_time_int,
input wire m_soft_int,
input wire m_ext_int,	//对M模式的中断信号
input wire s_ext_int,	//对S模式的中断信号
//外部时钟信号
input wire [63:0]mtime,	//mtime寄存器实时值

//对IF信号
output wire int_req,		//中断请求信号
output wire [63:0]flush_pc,	//新的PC值
output wire pip_flush,		//流水线冲刷信号

//对ID信号
output wire [63:0]satp,
output wire [3:0]priv,		//当前机器权限
output wire tvm,
output wire tsr,
output wire tw,
input wire [11:0]id_csr_index,
output wire [63:0]csr_data,	//读取的CSR值
input wire [4:0]rs1_index,
output wire [63:0]rs1_data,
input wire [4:0]rs2_index,
output wire [63:0]rs2_data,
//对EX信号
output wire mprv,
output wire [3:0]mod_priv,

//对WB信号
input wire [63:0]data_rd,
input wire [63:0]data_csr,
input wire [63:0]new_pc,

//对BIU信号
output wire sum,
output wire mxr,

//写回控制
input wire csr_write,
input wire gpr_write,
input wire pc_jmp,				//新的PC需要被更改，新的PC由pc_new给出，该信号表明WB阶段需要修改PC
input wire [11:0]csr_index,
input wire [4:0]rd_index,
//异常码
input wire [63:0]ins_pc,
input wire [63:0]exc_code,		//如果是非法指令异常，则为非法指令，如果是硬件断点和储存器访问失败，则是虚拟地址
//机器控制段
//机器控制段负责WB阶段时csr的自动更新
input wire id_system,		//system指令，op code=system的时候被置1
input wire id_jmp,			//会产生跳转的指令 opcode=branch时候置1
input wire ins_acc_fault,	//指令访问失败
input wire ins_addr_mis, 	//指令地址错误
input wire ins_page_fault,	//指令页面错误
input wire ld_addr_mis,		//load地址不对齐
input wire st_addr_mis,		//store地址不对齐
input wire ld_acc_fault,	//load访问失败
input wire st_acc_fault,	//store访问失败
input wire ld_page_fault,	//load页面错误
input wire st_page_fault,	//store页面错误
input wire int_acc,			//中断接收信号
input wire valid, 			//指令有效信号
input wire ill_ins,			//异常指令信号
input wire m_ret,			//返回信号
input wire s_ret,			//
input wire ecall,			//环境调用
input wire ebreak			//断点


);
//csr地址
parameter uro_cycle_index 			= 12'hc00	;
parameter uro_time_index  			= 12'hc01	;
parameter uro_instret_index 		= 12'hc02;
parameter uro_hpmcounter3_index		= 12'hc03;
parameter uro_hpmcounter4_index 	= 12'hc04;
parameter srw_sstatus_index			= 12'h100;
parameter srw_sie_index 			= 12'h104;
parameter srw_stvec_index 			= 12'h105;
parameter srw_scounteren_index 		= 12'h106;
parameter srw_sscratch_index 		= 12'h140;
parameter srw_sepc_index 			= 12'h141;
parameter srw_scause_index 			= 12'h142;
parameter srw_stval_index 			= 12'h143;
parameter srw_sip_index 			= 12'h144;
parameter srw_satp_index 			= 12'h180;
parameter mro_mvendorid_index 		= 12'hf11;
parameter mro_marchid_index 		= 12'hf12;
parameter mro_mimp_index 			= 12'hf13;
parameter mro_mhardid_index 		= 12'hf14;
parameter mrw_mstatus_index 		= 12'h300;
parameter mro_misa_index 			= 12'h301;
parameter mrw_medeleg_index 		= 12'h302;
parameter mrw_mideleg_index 		= 12'h303;	
parameter mrw_mie_index 			= 12'h304;
parameter mrw_mtvec_index 			= 12'h305;
parameter mrw_mcounteren_index 		= 12'h306;
parameter mrw_mscratch_index 		= 12'h340;
parameter mrw_mepc_index 			= 12'h341;
parameter mrw_mcause_index 			= 12'h342;
parameter mrw_mtval_index 			= 12'h343;
parameter mrw_mip_index 			= 12'h344;
parameter mrw_pmpcfg0_index 		= 12'h3a0;
parameter mrw_pmpaddr0_index 		= 12'h3b0;
parameter mrw_pmpaddr1_index 		= 12'h3b1;
parameter mrw_mcycle_index 			= 12'hb00;
parameter mrw_minstret_index 		= 12'hb02;
parameter mrw_mhpcounter3_index 	= 12'hb03;
parameter mrw_mhpcounter4_index	 	= 12'hb04;
parameter mrw_mcounterinhibit_index = 12'h320;
parameter mrw_mhpmevent3_index 		= 12'h323;
//机器权限

wire mie;			//M模式中断使能
wire sie;			//S模式中断使能
//中断原因
wire [63:0]trap_cause;
//生成的新的向量PC值
wire [63:0]tvec;	//mtvec,stvec寄存器生成的tvec
//最终生成的跳转地址
wire [63:0]vec_pc;
//int cause
wire [63:0]int_cause;	//中断原因
wire [63:0]exc_cause;	//异常原因
//发生了异常
wire exception;

//异常/中断受理目标
wire int_target_s;		//中断的目标权限是S，此信号由中断控制单元int_ctrl发出
wire int_target_m;		//中断的目标权限是M，此信号由中断控制单元int_ctrl发出
wire exc_target_s;		//异常的目标权限是S，此信号由异常控制单元exc_ctrl发出
wire exc_target_m;		//异常的目标权限是M，此信号由异常控制单元exc_ctrl发出

wire trap_target_m;		//m模式立即受理trap，当此位为1时候，m模式下受理trap的寄存器将会被影响，s模式的不动
wire trap_target_s;		//s模式立即受理trap，当此位为1时，s模式下受理trap的寄存器将会被影响，M模式的不动
wire next_pc;			//控制epc寄存器保存下一个pc,所有int指令 ecall和ebreak指令会用到这个信号

//csr寄存器值信号
wire [63:0]mstatus;
wire [63:0]sstatus;
wire [63:0]mideleg;
wire [63:0]medeleg;
wire [63:0]m_sie;
wire [63:0]m_sip;
wire [63:0]s_ip;
wire [63:0]s_ie;
wire [63:0]mcause;
wire [63:0]scause;
wire [63:0]mepc;
wire [63:0]sepc;
wire [63:0]mtval;
wire [63:0]stval;
wire [63:0]mtvec;
wire [63:0]stvec;

wire [63:0]mcountinhibit;
wire [63:0]mcycle;
wire [63:0]minstret;
wire [63:0]mscratch;
wire [63:0]sscratch;

wire [63:0]marchid;
wire [63:0]mimpid;
wire [63:0]mhartid;
wire [63:0]mvendorid;
wire [63:0]misa;


//写csr寄存器选择信号

wire srw_sstatus_sel;
wire srw_sie_sel;
wire srw_stvec_sel;
wire srw_scounteren_sel;
wire srw_sscratch_sel;
wire srw_sepc_sel;
wire srw_scause_sel;
wire srw_stval_sel;
wire srw_sip_sel;
wire srw_satp_sel;

wire mrw_mstatus_sel;

wire mrw_medeleg_sel;
wire mrw_mideleg_sel;	
wire mrw_mie_sel;
wire mrw_mtvec_sel;
wire mrw_mcounteren_sel;
wire mrw_mscratch_sel;
wire mrw_mepc_sel;
wire mrw_mcause_sel;
wire mrw_mtval_sel;
wire mrw_mip_sel;
wire mrw_pmpcfg0_sel;
//wire mrw_pmpaddr0_sel;
//wire mrw_pmpaddr1_sel;
wire mrw_mcycle_sel;
wire mrw_minstret_sel;
//wire mrw_mhpcounter3_sel;
//wire mrw_mhpcounter4_sel;
wire mrw_mcounterinhibit_sel;
wire mrw_mhpmevent3_sel;
//读csr寄存器选择信号
wire read_cycle_sel;
wire read_time_sel;
wire read_instret_sel;
wire read_hpmcounter3_sel;
wire read_hpmcounter4_sel;
wire read_sstatus_sel;
wire read_sie_sel;
wire read_stvec_sel;
wire read_scounteren_sel;
wire read_sscratch_sel;
wire read_sepc_sel;
wire read_scause_sel;
wire read_stval_sel;
wire read_sip_sel;
wire read_satp_sel;
wire read_mvendorid_sel;
wire read_marchid_sel;
wire read_mimp_sel;
wire read_mhardid_sel;
wire read_mstatus_sel;
wire read_misa_sel;
wire read_medeleg_sel;
wire read_mideleg_sel;	
wire read_mie_sel;
wire read_mtvec_sel;
wire read_mcounteren_sel;
wire read_mscratch_sel;
wire read_mepc_sel;
wire read_mcause_sel;
wire read_mtval_sel;
wire read_mip_sel;
//wire read_pmpcfg0_sel;
//wire read_pmpaddr0_sel;
//wire read_pmpaddr1_sel;
wire read_mcycle_sel;
wire read_minstret_sel;
//wire read_mhpcounter3_sel;
//wire read_mhpcounter4_sel;
wire read_mcounterinhibit_sel;
//wire read_mhpmevent3_sel;
//写csr寄存器选择线
//只有当前指令有效时，才会允许被写回寄存器


assign srw_sstatus_sel		=	valid&(csr_index==srw_sstatus_index);
assign srw_sie_sel			=	valid&(csr_index==srw_sie_index);
assign srw_stvec_sel		=	valid&(csr_index==srw_stvec_index);
//assign srw_scounteren_sel	=	valid&(csr_index==srw_scounteren_index);
assign srw_sscratch_sel		=	valid&(csr_index==srw_sscratch_index);
assign srw_sepc_sel			=	valid&(csr_index==srw_sepc_index);
assign srw_scause_sel		=	valid&(csr_index==srw_scause_index);
assign srw_stval_sel		=	valid&(csr_index==srw_stval_index);
assign srw_sip_sel			=	valid&(csr_index==srw_sip_index);
assign srw_satp_sel			=	valid&(csr_index==srw_satp_index);	

assign mrw_mstatus_sel		=	valid&(csr_index==mrw_mstatus_index);

assign mrw_medeleg_sel		=	valid&(csr_index==mrw_medeleg_index);
assign mrw_mideleg_sel		=	valid&(csr_index==mrw_mideleg_index);		
assign mrw_mie_sel			=	valid&(csr_index==mrw_mie_index);
assign mrw_mtvec_sel		=	valid&(csr_index==mrw_mtvec_index);
//assign mrw_mcounteren_sel	=	valid&(csr_index==mrw_mcounteren_index);
assign mrw_mscratch_sel		=	valid&(csr_index==mrw_mscratch_index);
assign mrw_mepc_sel			=	valid&(csr_index==mrw_mepc_index);
assign mrw_mcause_sel		=	valid&(csr_index==mrw_mcause_index);
assign mrw_mtval_sel		=	valid&(csr_index==mrw_mtval_index);
assign mrw_mip_sel			=	valid&(csr_index==mrw_mip_index);
//assign mrw_pmpcfg0_sel		=	valid&(csr_index==mrw_pmpcfg0_index);
//assign mrw_pmpaddr0_sel		=	valid&(csr_index==mrw_pmpaddr0_index);
//assign mrw_pmpaddr1_sel		=	valid&(csr_index==mrw_pmpaddr1_index);
assign mrw_mcycle_sel		=	valid&(csr_index==mrw_mcycle_index);
assign mrw_minstret_sel		=	valid&(csr_index==mrw_minstret_index);
//assign mrw_mhpcounter3_sel	=	valid&(csr_index==mrw_mhpcounter3_index);
//assign mrw_mhpcounter4_sel	=	valid&(csr_index==mrw_mhpcounter4_index);
assign mrw_mcounterinhibit_sel= valid&(csr_index==mrw_mcounterinhibit_index);
//assign mrw_mhpmevent3_sel	=	valid&(csr_index==mrw_mhpmevent3_index);
//读csr信号选择
assign read_cycle_sel		=	(id_csr_index==uro_cycle_index);
assign read_time_sel		=	(id_csr_index==uro_time_index);
assign read_instret_sel		=	(id_csr_index==uro_instret_index);	
//assign read_hpmcounter3_sel	= 	(id_csr_index==uro_hpmcounter3_index);
//assign read_hpmcounter4_sel	=	(id_csr_index==uro_hpmcounter4_index);
assign read_sstatus_sel		=	(id_csr_index==srw_sstatus_index);
assign read_sie_sel			=	(id_csr_index==srw_sie_index);
assign read_stvec_sel		=	(id_csr_index==srw_stvec_index);
//assign read_scounteren_sel	=	(id_csr_index==srw_scounteren_index);
assign read_sscratch_sel	=	(id_csr_index==srw_sscratch_index);
assign read_sepc_sel		=	(id_csr_index==srw_sepc_index);
assign read_scause_sel		=	(id_csr_index==srw_scause_index);
assign read_stval_sel		=	(id_csr_index==srw_stval_index);
assign read_sip_sel			=	(id_csr_index==srw_sip_index);
assign read_satp_sel		=	(id_csr_index==srw_satp_index);	
assign read_mvendorid_sel	=	(id_csr_index==mro_mvendorid_index);
assign read_marchid_sel		=	(id_csr_index==mro_marchid_index);
assign read_mimp_sel		=	(id_csr_index==mro_mimp_index);
assign read_mhardid_sel		=	(id_csr_index==mro_mhardid_index);
assign read_mstatus_sel		=	(id_csr_index==mrw_mstatus_index);
assign read_misa_sel		=	(id_csr_index==mro_misa_index);
assign read_medeleg_sel		=	(id_csr_index==mrw_medeleg_index);
assign read_mideleg_sel		=	(id_csr_index==mrw_mideleg_index);		
assign read_mie_sel			=	(id_csr_index==mrw_mie_index);
assign read_mtvec_sel		=	(id_csr_index==mrw_mtvec_index);
//assign read_mcounteren_sel	=	(id_csr_index==mrw_mcounteren_index);
assign read_mscratch_sel	=	(id_csr_index==mrw_mscratch_index);
assign read_mepc_sel		=	(id_csr_index==mrw_mepc_index);
assign read_mcause_sel		=	(id_csr_index==mrw_mcause_index);
assign read_mtval_sel		=	(id_csr_index==mrw_mtval_index);
assign read_mip_sel			=	(id_csr_index==mrw_mip_index);
//assign read_pmpcfg0_sel		=	(id_csr_index==mrw_pmpcfg0_index);
//assign read_pmpaddr0_sel	=	(id_csr_index==mrw_pmpaddr0_index);
//assign read_pmpaddr1_sel	=	(id_csr_index==mrw_pmpaddr1_index);
assign read_mcycle_sel		=	(id_csr_index==mrw_mcycle_index);
assign read_minstret_sel	=	(id_csr_index==mrw_minstret_index);
//assign read_mhpcounter3_sel	=	(id_csr_index==mrw_mhpcounter3_index);
//assign read_mhpcounter4_sel	=	(id_csr_index==mrw_mhpcounter4_index);
assign read_mcounterinhibit_sel=(id_csr_index==mrw_mcounterinhibit_index);
//assign read_mhpmevent3_sel	=	(id_csr_index==mrw_mhpmevent3_index);

assign exception	=	valid&(ins_acc_fault | ins_addr_mis | ins_page_fault | ill_ins | ld_acc_fault|ld_page_fault|st_acc_fault|st_page_fault|ld_addr_mis|st_addr_mis|ecall|ebreak);

//如果指令遭遇了异常，异常被优先处理，而不管中断
assign trap_target_m=	!exception & valid & int_target_m & int_req & int_acc | valid & exc_target_m;	
assign trap_target_s=	!exception & valid & int_target_s & int_req & int_acc | valid & exc_target_s;

//要求使用下一个指令的PC
//EBREAK异常发生时候，要求使用下一个指令地址，其余情况mepc都保存当前指令地址
assign next_pc		=	ebreak	|	int_target_m	|	int_target_s;
assign trap_cause	=	exception ? exc_cause : int_cause;


//中断向量地址
assign vec_pc	= exception ? {2'b0,tvec[63:2]} : tvec[0] ? ({2'b0,tvec[63:2]} + {trap_cause[61:0],2'b00}) : {2'b0,tvec[63:2]};


//只有在有效写回gpr且写回值不是x0寄存器，才被允许写回
/*
always@(posedge clk)begin
	if(gpr_write & valid)begin
		if(rd_index!=5'b0)begin
			gpr[rd_index - 5'b1]	<=	data_rd;
		end
	end
end
*/
//调用GPR模块
//此模块可以生成可以被综合进LUT RAM的GPR模块
Anlogic_GPR_Sample	 	GPR(
.clk		(clk),
.clk_en		(gpr_write & valid),

.rd0_data	(data_rd) ,
.rd0_addr	(rd_index) ,
.rs1_addr	(rs1_index) ,
.rs2_addr	(rs2_index) ,
.rs1_data	(rs1_data) ,
.rs2_data 	(rs2_data) 
);

//调用CSR寄存器模块

m_s_status m_s_status(

.clk				(clk),
.rst				(rst),
//控制位输出
.sie				(sie),
.mie				(mie),
.mprv				(mprv),
.sum				(sum),
.mxr				(mxr),
.tvm				(tvm),
.tw					(tw),
.tsr				(tsr),

//权限输出
.priv				(priv),
.mod_priv			(mod_priv),

.csr_write			(csr_write),
.data_csr			(data_csr),
.mrw_mstatus_sel	(mrw_mstatus_sel),
.srw_sstatus_sel	(srw_sstatus_sel),

//Trap信号
.trap_target_m		(trap_target_m),		//m模式受理trap，当此位为1时候，m模式下受理trap的寄存器将会被影响，s模式的不动
.trap_target_s		(trap_target_s),		//s模式受理trap，当此位为1时，s模式下受理trap的寄存器将会被影响，M模式的不动
//wb信号
//机器控制段
//机器控制段负责WB阶段时csr的自动更新

.valid				(valid), 			//指令有效信号

.m_ret				(m_ret),			//返回信号
.s_ret				(s_ret),			//

.sstatus			(sstatus),
.mstatus			(mstatus)

);

mideleg_int_ctrl mideleg_int_ctrl(
.clk				(clk),
.rst				(rst),
.s_ext_int			(s_ext_int),	//对S模式的外部中断和SIP寄存器中的可读可写位是分开的

.priv				(priv),	//机器权限

.int_cause			(int_cause),	//中断原因

.int_target_s		(int_target_s),
.int_target_m		(int_target_m),

.int_req			(int_req),

//内部csr寄存器信号
.mie				(mie),		//mstatus寄存器中的mie位
.sie				(sie),		//status寄存器中的sie位
.m_s_ip				(m_sip),
.m_s_ie				(m_sie),

//写回和读出信号
.mrw_mideleg_sel	(mrw_mideleg_sel),
.csr_write			(csr_write),
.mideleg			(mideleg),
.data_csr			(data_csr)

);
medeleg_exc_ctrl medeleg_exc_ctrl(
.clk				(clk),
.rst				(rst),

.priv				(priv),	//当前机器权限
//异常产生信号
.exc_cause			(exc_cause),	//异常原因

.exc_target_s		(exc_target_s),
.exc_target_m		(exc_target_m),

//WB送来的信号
.ins_acc_fault		(ins_acc_fault),	//指令访问失败
.ins_addr_mis		(ins_addr_mis), 	//指令地址错误
.ins_page_fault		(ins_page_fault),	//指令页面错误
.ld_addr_mis		(ld_addr_mis),		//load地址不对齐
.st_addr_mis		(st_addr_mis),		//store地址不对齐
.ld_acc_fault		(ld_acc_fault),	//load访问失败
.st_acc_fault		(st_acc_fault),	//store访问失败
.ld_page_fault		(ld_page_fault),	//load页面错误
.st_page_fault		(st_page_fault),	//store页面错误

.valid				(valid), 			//指令有效信号
.ill_ins			(ill_ins),			//异常指令信号

.ecall				(ecall),			//环境调用
.ebreak				(ebreak),			//断点

//写回和读出信号
.mrw_medeleg_sel	(mrw_medeleg_sel),
.csr_write			(csr_write),
.medeleg			(medeleg),
.data_csr			(data_csr)

);

m_s_ip m_s_ip(
.clk				(clk),
.rst				(rst),

//外部中断信号
.m_time_int			(m_time_int),
.m_soft_int			(m_soft_int),
.m_ext_int			(m_ext_int),	//对M模式的中断信号
.s_ext_int			(s_ext_int),	//对S模式的中断信号

//写回和读出信号
.mrw_mip_sel		(mrw_mip_sel),
.srw_sip_sel		(srw_sip_sel),
.csr_write			(csr_write),
.m_s_ip				(m_sip),
.s_ip				(s_ip),
.data_csr			(data_csr)

);

m_s_ie m_s_ie(
.clk				(clk),
.rst				(rst),

//外部中断信号
.m_ext_int			(m_ext_int),	//对M模式的中断信号
.s_ext_int			(s_ext_int),	//对S模式的中断信号

//写回和读出信号
.mrw_mie_sel		(mrw_mie_sel),
.srw_sie_sel		(srw_sie_sel),
.csr_write			(csr_write),
.m_s_ie				(m_sie),
.s_ie				(s_ie),
.data_csr			(data_csr)

);

m_s_cause m_s_cause(
.clk				(clk),
.rst				(rst),

//内部csr寄存器信号
.trap_cause			(trap_cause),
.trap_target_m		(trap_target_m),
.trap_target_s		(trap_target_s),

//写回和读出信号
.mrw_mcause_sel		(mrw_mcause_sel),
.srw_scause_sel		(srw_scause_sel),
.csr_write			(csr_write),
.mcause				(mcause),
.scause				(scause),
.data_csr			(data_csr)

);

m_s_epc m_s_epc(
.clk				(clk),
.rst				(rst),

//trap信号
.trap_target_m		(trap_target_m),
.trap_target_s		(trap_target_s),
.next_pc			(next_pc),

//写回和读出信号
.ins_pc				(ins_pc),
.new_pc				(new_pc),
.pc_jmp				(pc_jmp),
.mrw_mepc_sel		(mrw_mepc_sel),
.srw_sepc_sel		(srw_sepc_sel),
.csr_write			(csr_write),
.mepc				(mepc),
.sepc				(sepc),
.data_csr			(data_csr)

);

m_s_tval m_s_tval(
.clk				(clk),
.rst				(rst),

//trap信号
.trap_target_m		(trap_target_m),
.trap_target_s		(trap_target_s),

//写回和读出信号
.ins_pc				(ins_pc),
.exc_code			(exc_code),
.ins_acc_fault		(ins_acc_fault),	//指令访问失败
.ins_addr_mis		(ins_addr_mis), 	//指令地址错误
.ins_page_fault		(ins_page_fault),	//指令页面错误
.ld_addr_mis		(ld_addr_mis),		//load地址不对齐
.st_addr_mis		(st_addr_mis),		//store地址不对齐
.ld_acc_fault		(ld_acc_fault),	//load访问失败
.st_acc_fault		(st_acc_fault),	//store访问失败
.ld_page_fault		(ld_page_fault),	//load页面错误
.st_page_fault		(st_page_fault),	//store页面错误

.valid				(valid), 			//指令有效信号
.ill_ins			(ill_ins),			//异常指令信号
.m_ret				(m_ret),			//返回信号
.s_ret				(s_ret),			//
.ecall				(ecall),			//环境调用
.ebreak				(ebreak),			//断点

.mrw_mtval_sel		(mrw_mtval_sel),
.srw_stval_sel		(srw_stval_sel),
.csr_write			(csr_write),
.mtval				(mtval),
.stval				(stval),
.data_csr			(data_csr)

);

/*
ms tvec寄存器
*/
m_s_tvec m_s_tvec(
.clk				(clk),
.rst				(rst),

.trap_target_m		(trap_target_m),
.trap_target_s		(trap_target_s),
.tvec				(tvec),				//如果是M模式的中断，输出MTVEC 如果是S模式 输出STVEC
//写回和读出信号
.mrw_mtvec_sel		(mrw_mtvec_sel),
.srw_stvec_sel		(srw_stvec_sel),
.csr_write			(csr_write),
.mtvec				(mtvec),
.stvec				(stvec),
.data_csr			(csr_data)

);
csr_satp csr_satp(
.clk				(clk),
.rst				(rst),

.srw_satp_sel		(srw_satp_sel),
.data_csr			(data_csr),
.csr_write			(csr_write),

.satp				(satp)
);

m_cycle_event m_cycle_event(
.clk				(clk),
.rst				(rst),

.valid				(valid),
//写回和读出信号
.mrw_mcycle_sel		(mrw_mcycle_sel),
.mrw_instret_sel	(mrw_minstret_sel),
.mrw_mcountinhibit_sel(mrw_mcounterinhibit_sel),
.csr_write			(csr_write),

.data_csr			(data_csr),

.mcycle				(mcycle),
.minstret			(minstret),
.mcountinhibit		(mcountinhibit)

);

m_s_scratch m_s_scratch(
.clk				(clk),
.rst				(rst),

.mrw_mscratch_sel	(mrw_mscratch_sel),
.srw_sscratch_sel	(srw_sscratch_sel),

.mscratch			(mscratch),
.sscratch			(sscratch),
.csr_write			(csr_write),
.data_csr			(data_csr)

);

mro_csr mro_csr(
.marchid			(marchid),
.mimpid				(mimpid),
.mhartid			(mhartid),
.mvendorid			(mvendorid),
.misa				(misa)
);

//对IF 控制指令流信号
//返回的时候，使用xepc地址；发生中断时使用向量PC：VEC_PC；跳转指令使用WB传回的new_pc
assign flush_pc	=	(valid&m_ret) ? mepc : (valid&s_ret) ? sepc : (trap_target_m | trap_target_s) ? vec_pc : new_pc;	//新的PC值
assign pip_flush=	valid & ((trap_target_m | trap_target_s) | pc_jmp)	;		//当写回指令有效时候，发出流水线冲刷信号


//ID 读取的CSR值
assign csr_data	=	(read_cycle_sel 	? 	mcycle 		:	64'b0)|
					(read_time_sel		?	mtime  		:	64'b0)|
					(read_instret_sel	?	minstret	:	64'b0)|

					(read_sstatus_sel	?	sstatus		:	64'b0)|
					(read_sie_sel		?	sie	   		:	64'b0)|
					(read_stvec_sel		?	stvec  		:	64'b0)|
				
					(read_sscratch_sel	?	sscratch	:	64'b0)|
					(read_sepc_sel		?	sepc		:	64'b0)|
					(read_scause_sel	?	scause		:	64'b0)|
					(read_stval_sel		?	stval		:	64'b0)|
					(read_sip_sel		?	s_ip		:	64'b0)|
					(read_satp_sel		?	satp		:	64'b0)|
					(read_mvendorid_sel	?	mvendorid	:	64'b0)|
					(read_marchid_sel	?	marchid		:	64'b0)|
					(read_mimp_sel		?	mimpid		:	64'b0)|
					(read_mhardid_sel	?	mhartid		:	64'b0)|
					(read_mstatus_sel	?	mstatus		:	64'b0)|
					(read_misa_sel		?	misa		:	64'b0)|
					(read_medeleg_sel	?	medeleg		:	64'b0)|
					(read_mideleg_sel	?	mideleg		:	64'b0)|	
					(read_mie_sel		?	mie			:	64'b0)|
					(read_mtvec_sel		?	mtvec		:	64'b0)|
					
					(read_mscratch_sel	?	mscratch	:	64'b0)|
					(read_mepc_sel		?	mepc		:	64'b0)|
					(read_mcause_sel	?	mcause		:	64'b0)|
					(read_mtval_sel		?	mtval		:	64'b0)|
					(read_mip_sel		?	m_sip		:	64'b0)|
					
					(read_mcycle_sel	?	mcycle		:	64'b0)|
					(read_minstret_sel	?	minstret	:	64'b0)|
					
					(read_mcounterinhibit_sel? mcountinhibit:64'b0);
					


endmodule






















