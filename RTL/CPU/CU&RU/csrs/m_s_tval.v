module m_s_tval(
input wire clk,
input wire rst,

//trap信号
input wire trap_target_m,
input wire trap_target_s,

//写回和读出信号
input wire [63:0]ins_pc,
input wire [63:0]exc_code,
input wire ins_acc_fault,	//指令访问失败
input wire ins_addr_mis, 	//指令地址错误
input wire ins_page_fault,	//指令页面错误
input wire ld_addr_mis,		//load地址不对齐
input wire st_addr_mis,		//store地址不对齐
input wire ld_acc_fault,	//load访问失败
input wire st_acc_fault,	//store访问失败
input wire ld_page_fault,	//load页面错误
input wire st_page_fault,	//store页面错误

input wire valid, 			//指令有效信号
input wire ill_ins,			//异常指令信号
input wire m_ret,			//返回信号
input wire s_ret,			//
input wire ecall,			//环境调用
input wire ebreak,			//断点

input wire mrw_mtval_sel,
input wire srw_stval_sel,
input wire csr_write,
output reg [63:0]mtval,
output reg [63:0]stval,
input wire [63:0]data_csr

);
//当出现指令错误，断点异常时，更新为指令自己的地址
//其他情况更新为exc code
always@(posedge clk)begin
	if(rst)begin
		mtval	<=	64'b0;
		stval	<=	64'b0;
	end
	else if(trap_target_m)begin
		mtval 	<=	(ins_acc_fault | ins_addr_mis | ins_page_fault | ebreak) ? ins_pc : exc_code;
	end
	else if(trap_target_s)begin
		stval 	<=	(ins_acc_fault | ins_addr_mis | ins_page_fault | ebreak) ? ins_pc : exc_code;
	end
	else if(mrw_mtval_sel & csr_write)begin
		mtval	<=	data_csr;
	end
	else if(srw_stval_sel & csr_write)begin
		stval	<=	data_csr;
	end
end

endmodule




