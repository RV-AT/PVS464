module m_s_ie(
input wire clk,
input wire rst,

//外部中断信号
input wire m_ext_int,	//对M模式的中断信号
input wire s_ext_int,	//对S模式的中断信号

//写回和读出信号
input wire mrw_mie_sel,
input wire srw_sie_sel,
input wire csr_write,
output wire [63:0]m_s_ie,
output wire [63:0]s_ie,
input wire [63:0]data_csr

);

reg ssie;
reg msie;
reg stie;
reg mtie;
reg seie;
reg meie;

always@(posedge clk)begin
	if(rst)begin
		ssie<=	1'b0;
		msie<=	1'b0;
		stie<=	1'b0;
		mtie<=	1'b0;
		seie<=	1'b0;
		meie<=	1'b0;
	end
	else if(mrw_mie_sel & csr_write)begin
		ssie<=	data_csr[1];
		msie<=	data_csr[3];
		stie<=	data_csr[5];
		mtie<=	data_csr[7];
		seie<=	data_csr[9];
		meie<=  data_csr[11];
	end
	else if(srw_sie_sel & csr_write)begin
		ssie<=	data_csr[1];

		stie<=	data_csr[5];

		seie<=	data_csr[9];
	end
end
assign m_s_ie	=	{52'b0,meie,1'b0,seie,1'b0,mtie,1'b0,stie,1'b0,msie,1'b0,ssie,1'b0};
assign s_ie		=	{54'b0,seie,3'b0,stie,3'b0,ssie,1'b0};

endmodule
