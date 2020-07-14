//mideleg寄存器逻辑和中断控制，只有S模式的中断可以被移交给S，M模式的都不允许被交给S模式处理

module mideleg_int_ctrl(
input wire clk,
input wire rst,
input wire s_ext_int,	//对S模式的外部中断和SIP寄存器中的可读可写位是分开的

input wire [3:0]priv,	//机器权限

output wire [63:0]int_cause,	//中断原因

output wire int_target_s,
output wire int_target_m,

output wire int_req,

//内部csr寄存器信号
input wire mie,		//mstatus寄存器中的mie位
input wire sie,		//status寄存器中的sie位
input wire [63:0]m_s_ip,
input wire [63:0]m_s_ie,

//写回和读出信号
input wire mrw_mideleg_sel,
input wire csr_write,
output wire [63:0]mideleg,
input wire [63:0]data_csr

);
//mideleg和msip msie寄存器中的位
parameter ssi	=	1;
parameter msi	=	3;
parameter sti	=	5;
parameter mti	=	7;
parameter sei	=	9;
parameter mei	=	11;
//xcause寄存器中的值
parameter mei_cause	=	63'd11;
parameter msi_casue	=	63'd3;
parameter mti_cause	=	63'd7;
parameter sei_cause	=	63'd9;
parameter ssi_casue	=	63'd1;
parameter sti_cause	=	63'd5;

//mideleg寄存器位
reg dmei;
reg dmsi;
reg dmti;
reg	dsei;
reg	dssi;
reg dsti;

wire s;
wire u;

//目标是M的中断接收信号
wire mei_ack_m;
wire msi_ack_m;
wire mti_ack_m;
wire sei_ack_m;
wire ssi_ack_m;
wire sti_ack_m;
//目标是S的中断接受信号
wire sei_ack_s;
wire ssi_ack_s;
wire sti_ack_s;

//mideleg存取逻辑
always@(posedge clk)begin
	if(rst)begin
		dsei	<=	1'b0;
		dssi	<=	1'b0;
		dsti	<=	1'b0;
	end
	else if(csr_write & mrw_mideleg_sel)begin
		dsei	<=	data_csr[sei];
		dssi	<=	data_csr[ssi];
		dsti	<=	data_csr[sti];
	end
end

//中断接受信号，权限优先级由高到低
assign mei_ack_m	=	mie	&	m_s_ip[mei]	&	m_s_ie[mei];		//M模式的中断只能由M模式处理
assign msi_ack_m	=	mie	&	m_s_ip[msi] &	m_s_ie[msi];
assign mti_ack_m	=	mie	&	m_s_ip[mti] &	m_s_ie[mti];
assign sei_ack_m	=	mie	&	!dsei&((m_s_ip[sei]|s_ext_int));	//如果没有被委托，全部跳入M模式
assign ssi_ack_m	=	mie	&	!dssi&(m_s_ip[ssi]);
assign sti_ack_m	=	mie	&	!dsti&(m_s_ip[sti]);

assign sei_ack_s	=	sie	&	(s|u)	&	(m_s_ip[sei]|s_ext_int)	&	m_s_ie[sei]	&	dsei;//如果被委托，只有在工作在S或者U模式运行时，才会受理这个中断
assign ssi_ack_s	=	sie	&	(s|u)	&	m_s_ip[ssi]	&	m_s_ie[ssi]	&	dssi;
assign sti_ack_s	=	sie	&	(s|u)	&	m_s_ip[sti]	&	m_s_ie[sti]	&	dsti;

//译码机器权限

assign s	=	priv[1];
assign u	=	priv[0];

assign int_target_m	=	msi_ack_m | msi_ack_m | mti_ack_m | sei_ack_m | ssi_ack_m | sti_ack_m;
assign int_target_s	=	!int_target_m & (sei_ack_s | ssi_ack_s | sti_ack_s);	//target是M的中断可以完全压制target是S的中断

assign int_req		=	msi_ack_m | msi_ack_m | mti_ack_m | sei_ack_m | ssi_ack_m | sti_ack_m | sei_ack_s | ssi_ack_s | sti_ack_s;
assign int_cause	=	mei_ack_m ? {1'b1,mei_cause} : msi_ack_m ? {1'b1,msi_casue} : mti_ack_m ? {1'b1,mti_cause}:
						(sei_ack_m|sei_ack_s) ? {1'b1,sei_cause} : (ssi_ack_m|ssi_ack_s) ? {1'b1,ssi_casue} : (sti_ack_m|sti_ack_s) ? {1'b1,sti_cause} : 64'b0;
assign mideleg		=	{54'b0,dsei,3'b0,dsti,3'b0,dssi,1'b0};	

endmodule	