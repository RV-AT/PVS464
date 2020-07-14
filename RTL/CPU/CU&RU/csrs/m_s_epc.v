module m_s_epc(
input wire clk,
input wire rst,

//trap信号
input wire trap_target_m,
input wire trap_target_s,
input wire next_pc,

//写回和读出信号
input wire [63:0]ins_pc,
input wire [63:0]new_pc,
input wire pc_jmp,
input wire mrw_mepc_sel,
input wire srw_sepc_sel,
input wire csr_write,
output reg [63:0]mepc,
output reg [63:0]sepc,
input wire [63:0]data_csr

);
//在这里，xepc在退出异常时不复位
always@(posedge clk)begin
	if(rst)begin
		mepc	<=	64'b0;
		sepc	<=	64'b0;
	end
	//如果此时已经生成了新的跳转pc，那么mepc直接更新到跳转pc上
	else if(trap_target_m)begin
		mepc	<=	next_pc ? (pc_jmp ? new_pc : ins_pc + 64'd4) : ins_pc;
	end
	else if(trap_target_s)begin
		sepc	<=	next_pc ? (pc_jmp ? new_pc : ins_pc + 64'd4) : ins_pc;
	end
	else if(mrw_mepc_sel & csr_write)begin
		mepc	<=	data_csr;
	end
	else if(srw_sepc_sel & csr_write)begin
		sepc	<=	data_csr;
	end
end

endmodule