//PRV464流水线控制器
//检查流水线中出现的数据冲突， 如ID中出现的RS1 RS2与后续的RD产生冲突
//检查流水线中的fence指令和单周期指令，并在合适的地方插入nop信号和hold信号

module pip_ctrl(
//pip_ctrl不需要时钟，是一个纯粹的组合逻辑

//ID输入信号
input wire [4:0]id_rs1_index,
input wire [4:0]id_rs2_index,
//ID遭遇异常
input wire id_ill_ins,		//译码是异常指令
input wire id_system_mem,	//是一个系统指令
input wire id_branch,		//是一个分支指令
input wire id_ins_acc_fault,	//指令访问失败
input wire id_ins_addr_mis, 	//指令地址错误
input wire id_ins_page_fault,	//指令页面错误
input wire id_int_acc,			//中断接收信号
input wire id_valid	,		//指令有效信号



//EX输入信号
input wire [4:0]ex_rd_index,
input wire ex_gpr_write,	//处于EX阶段的指令需要对RD寄存器写回
//EX遭遇异常
input wire ex_system,		//system指令，op code=system的时候被置1
input wire ex_jmp,			//会产生跳转的指令 opcode=branch时候置1
input wire ex_ins_acc_fault,	//指令访问失败
input wire ex_ins_addr_mis, 	//指令地址错误
input wire ex_ins_page_fault,	//指令页面错误
input wire ex_int_acc,			//中断接收信号
input wire ex_valid, 			//指令有效信号
input wire ex_ill_ins,			//异常指令信号
input wire ex_m_ret,			//返回信号
input wire ex_s_ret,
input wire ex_ecall,			//环境调用
input wire ex_ebreak,			//断点

input wire ex_ready,			//ex多周期执行正常
input wire ex_more_exception,		//ex遭遇了更多的异常


//WB输入信号
input wire [4:0]wb_rd_index,
input wire wb_gpr_write,

input wire wb_id_system,		//system指令，op code=system的时候被置1
input wire wb_id_jmp,			//会产生跳转的指令 opcode=branch时候置1
input wire wb_ins_acc_fault,	//指令访问失败
input wire wb_ins_addr_mis, 	//指令地址错误
input wire wb_ins_page_fault,	//指令页面错误
input wire wb_ld_addr_mis,		//load地址不对齐
input wire wb_st_addr_mis,		//store地址不对齐
input wire wb_ld_acc_fault,	//load访问失败
input wire wb_st_acc_fault,	//store访问失败
input wire wb_ld_page_fault,	//load页面错误
input wire wb_st_page_fault,	//store页面错误
input wire wb_int_acc,			//中断接收信号
input wire wb_valid, 			//指令有效信号
input wire wb_ill_ins,			//异常指令信号
input wire wb_m_ret,			//返回信号
input wire wb_s_ret,			//
input wire wb_ecall,			//环境调用
input wire wb_ebreak,			//断点

//控制信号
output wire if_nop,
output wire if_hold,
output wire id_nop,
output wire id_hold,
output wire ex_nop


);
/*注，只要流水线中存在一条异常，就会停下之后的操作
因为本机的缓存性能着急，如果不及时停止前面的IF，可能会因为缓存控制器刷新缓存而让延迟更大
*/
wire id_exception;	//ID存在异常
wire ex_exception;	//EX存在异常
wire wb_exception;	//WB存在异常

wire id_fence; //id有屏障指令,jmp指令或者system指令 都会构成一个屏障指令
wire ex_fence; //ex有屏障指令
wire wb_fence; //wb有屏障指令

wire id_ex_war;		//ID和EX构成了WAR数据相关
wire id_wb_war;		//ID和WB构成了WAR数据相关

assign id_exception	=	id_valid & (id_ill_ins | id_ins_acc_fault | id_ins_addr_mis | id_ins_page_fault | id_int_acc);

assign ex_exception	= 	ex_valid & (ex_more_exception | ex_ins_acc_fault | ex_ins_addr_mis | ex_ins_page_fault |
						ex_int_acc | ex_ill_ins | ex_m_ret | ex_s_ret | ex_ecall | ex_ebreak);			
assign wb_exception	=	wb_valid & (wb_ins_acc_fault | wb_ins_addr_mis | wb_ins_page_fault | wb_ld_addr_mis|	
						wb_st_addr_mis | wb_ld_acc_fault | wb_st_acc_fault | wb_ld_page_fault | wb_st_page_fault | wb_int_acc | wb_ill_ins |		
						wb_m_ret | wb_s_ret | wb_ecall | wb_ebreak);
//system指令，或者jmp/Branch指令要求进行多周期执行						
assign id_fence		=  id_valid & (id_branch | id_system_mem);
assign ex_fence		=  ex_valid & (ex_jmp 	  | ex_system);
assign wb_fence		=  wb_valid & (wb_id_jmp | wb_id_system);
						
//当ID和EX的指令都有效时，ID阶段读取的寄存器和EX要写回的寄存器值重合，产生了一个WAR相关性
//注意 当寄存器索引是0时，表示寄存器目标是常0寄存器，不会产生数据相关性
assign id_ex_war	=	id_valid & (id_rs1_index!=5'b0) & ex_valid & (id_rs1_index==ex_rd_index) & ex_gpr_write |
						id_valid & (id_rs2_index!=5'b0) & ex_valid & (id_rs2_index==ex_rd_index) & ex_gpr_write;


assign id_wb_war	=	id_valid & (id_rs1_index!=5'b0) & wb_valid & (id_rs1_index==wb_rd_index) & wb_gpr_write |
						id_valid & (id_rs2_index!=5'b0) & wb_valid & (id_rs2_index==wb_rd_index) & wb_gpr_write;


//如果后级发生了异常，则要求IF清空
assign if_nop	=	id_exception | ex_exception | wb_exception |ex_fence | wb_fence;

//只有在没有强制要求进行插入NOP，且后续指令有等待要求时进行多周期
//注意，jmp指令不能使用hold，因为下一个指令可能跳转到其他地方
assign if_hold	=	!if_nop & (id_ex_war | id_wb_war | !ex_ready | id_fence);

//当后面的指令发生异常，或者后面的指令要求多周期，或者出现了数据相关错误，ID输出插入NOP
assign id_nop	=	ex_exception | wb_exception | id_ex_war | id_wb_war | ex_fence | wb_fence;
//当EX没有准备好时，id输出数据进行等待
assign id_hold	=	!id_nop & (!ex_ready);
//当WB阶段有多周期指令 或者发生异常时，EX插入NOP
assign ex_nop	=	wb_exception | wb_fence;

endmodule

