/*
ms tvec寄存器
*/
module m_s_tvec(
input wire clk,
input wire rst,

input wire trap_target_m,
input wire trap_target_s,
output wire [63:0]tvec,
//写回和读出信号
input wire mrw_mtvec_sel,
input wire srw_stvec_sel,
input wire csr_write,
output reg [63:0]mtvec,
output reg [63:0]stvec,
input wire [63:0]data_csr

);

always@(posedge clk)begin
	if(rst)begin
		mtvec	<=	64'b0;
		stvec	<=	64'b0;
	end
	else if(mrw_mtvec_sel & csr_write)begin
		mtvec	<=	data_csr;
	end
	else if(srw_stvec_sel & csr_write)begin
		stvec	<=	data_csr;
	end
end
//如果是对M模式的中断，使用MTVEC寄存器；如果是对S模式的中断，使用STVEC寄存器
assign tvec	=	trap_target_m ? mtvec : trap_target_s ? stvec : 64'b0;
endmodule