module m_cycle_event(
input wire clk,
input wire rst,

input wire valid,
//写回和读出信号
input wire mrw_mcycle_sel,
input wire mrw_instret_sel,
input wire mrw_mcountinhibit_sel,
input wire csr_write,

input wire [63:0]data_csr,

output reg [63:0]mcycle,
output reg [63:0]minstret,
output wire [63:0]mcountinhibit

);

//mcountinhibit寄存器位
reg cy;
reg ir;
//cycle和instret寄存器
//valid=1即有效指令，minstret寄存器+1
always@(posedge clk)begin
	if(rst)begin
		mcycle	<=	64'b0;
		minstret<= 	64'b0;
	end
	else if(mrw_mcycle_sel & csr_write)begin
		mcycle	<=	data_csr;
	end
	else if(mrw_instret_sel & csr_write)begin
		minstret<=  data_csr;
	end
	else begin
		mcycle	<=	!cy ? mcycle + 64'd1 : mcycle;
		minstret<=	!ir ? (valid ? minstret + 64'd1 : minstret) : minstret;
	end
end

always@(posedge clk)begin
	if(rst)begin
		cy	<=	1'b0;
		ir	<=	1'b0;
	end
	else if(mrw_mcountinhibit_sel & csr_write)begin
		cy	<=	data_csr[0];
		ir	<=	data_csr[2];
	end
end

assign mcountinhibit	=	{61'b0,ir,1'b0,cy};

endmodule