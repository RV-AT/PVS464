module m_s_cause(
input wire clk,
input wire rst,

//内部csr寄存器信号
input wire [63:0]trap_cause,
input wire trap_target_m,
input wire trap_target_s,

//写回和读出信号
input wire mrw_mcause_sel,
input wire srw_scause_sel,
input wire csr_write,
output reg [63:0]mcause,
output reg [63:0]scause,
input wire [63:0]data_csr

);
always@(posedge clk)begin
	if(rst)begin
		mcause	<=	64'b0;
		scause	<=	64'b0;
	end
	else if(trap_target_m)begin
		mcause	<=	trap_cause;
	end
	else if(trap_target_s)begin
		scause	<=	trap_cause;
	end
	else if(mrw_mcause_sel & csr_write)begin
		mcause	<=	data_csr;
	end
	else if(srw_scause_sel & csr_write)begin
		scause	<=	data_csr;
	end
end

endmodule