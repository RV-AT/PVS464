/*
sip寄存器是mip寄存器的一个子集
*/
module m_s_ip(
input wire clk,
input wire rst,

//外部中断信号
input wire m_time_int,
input wire m_soft_int,
input wire m_ext_int,	//对M模式的中断信号
input wire s_ext_int,	//对S模式的中断信号

//写回和读出信号
input wire mrw_mip_sel,
input wire srw_sip_sel,
input wire csr_write,
output wire [63:0]m_s_ip,
output wire [63:0]s_ip,
input wire [63:0]data_csr

);

reg ssip;
reg msip;
reg stip;
reg mtip;
reg seip;
reg meip;


always@(posedge clk)begin
	if(rst)begin
		ssip<=	1'b0;
		msip<=	1'b0;
		stip<=	1'b0;
		mtip<=	1'b0;
		seip<=	1'b0;
		meip<=	1'b0;
	end
	else if(mrw_mip_sel & csr_write)begin
		ssip<=	data_csr[1];
		msip<=	m_soft_int;
		stip<=	data_csr[5];
		mtip<=	m_time_int;
		seip<=	data_csr[9] | s_ext_int;
		meip<=	m_ext_int;
	end
	else if(srw_sip_sel & csr_write)begin
		ssip<=  data_csr[1];
	end
	else begin
		msip<=	m_soft_int;
		mtip<=	m_time_int;
		meip<=	m_ext_int;
	end
end
//注意 seip读出的值是和外部中断进行与关系后读出的，这样的目的是不让s模式错过任何一个外部中断
assign m_s_ip	=	{52'b0,meip,1'b0,(seip|s_ext_int),1'b0,mtip,1'b0,stip,1'b0,msip,1'b0,ssip,1'b0};
assign s_ip		=	{54'b0,(seip|s_ext_int),3'b0,stip,3'b0,ssip,1'b0};


endmodule
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		