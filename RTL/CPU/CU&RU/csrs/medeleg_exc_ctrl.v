module medeleg_exc_ctrl(
input wire clk,
input wire rst,

input wire [3:0]priv,	//当前机器权限
//异常产生信号
output wire [63:0]exc_cause,	//异常原因

output wire exc_target_s,
output wire exc_target_m,

//WB送来的信号
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

input wire ecall,			//环境调用
input wire ebreak,			//断点

//写回和读出信号
input wire mrw_medeleg_sel,
input wire csr_write,
output wire [63:0]medeleg,
input wire [63:0]data_csr

);
//异常码
parameter iam	=	64'd0;
parameter iaf	=	64'd1;
parameter ii	=	64'd2;
parameter bk	=	64'd3;
parameter lam	=	64'd4;
parameter laf	=	64'd5;
parameter sam	=	64'd6;
parameter saf	=	64'd7;
parameter ecu	=	64'd8;
parameter ecs	=	64'd9;
parameter ecm	=	64'd11;
parameter ipf	=	64'd12;
parameter lpf	=	64'd13;
parameter spf	=	64'd15;
wire m;
wire s;
wire u;

//注意 ECU = ECALL from M mode是不允许被委托给下一个权限的
reg	diam;
reg diaf;
reg dii;
reg dbk;
reg dlam;
reg dlaf;
reg dsam;
reg dsaf;
reg decu;
reg decs;
reg dipf;
reg dlpf;
reg dspf;
//异常目标权限是M
wire iam_target_m;
wire iaf_target_m;
wire ii_target_m;
wire bk_target_m;
wire lam_target_m;
wire laf_target_m;
wire sam_target_m;
wire saf_target_m;
wire ecu_target_m;
wire ecs_target_m;
wire ipf_target_m;
wire lpf_target_m;
wire spf_target_m;
//异常目标权限是S
wire iam_target_s;
wire iaf_target_s;
wire ii_target_s;
wire bk_target_s;
wire lam_target_s;
wire laf_target_s;
wire sam_target_s;
wire saf_target_s;
wire ecu_target_s;
wire ecs_target_s;
wire ipf_target_s;
wire lpf_target_s;
wire spf_target_s;

assign m	=	priv[3];
assign s	=	priv[1];
assign u	=	priv[0];

always@(posedge clk)begin
	if(rst)begin
		diam	<=	1'b0;
		diaf	<=	1'b0;
		dii		<=	1'b0;
		dbk		<=	1'b0;
		dlam	<=	1'b0;
		dlaf	<=	1'b0;
		dsam	<=	1'b0;
		dsaf	<=	1'b0;
		decu	<=	1'b0;
		decs	<=	1'b0;
		dipf		<=	1'b0;
		dlpf	<=	1'b0;
		dspf	<=	1'b0;	
	end
	else if(csr_write & mrw_medeleg_sel)begin
		diam	<=	data_csr[0];
		diaf	<=	data_csr[1];
		dii		<=	data_csr[2];
		dbk		<=	data_csr[3];
		dlam	<=	data_csr[4];
		dlaf	<=	data_csr[5];
		dsam	<=	data_csr[6];
		dsaf	<=	data_csr[7];
		decu	<=	data_csr[8];
		decs	<=	data_csr[9];
		dipf		<=	data_csr[12];
		dlpf	<=	data_csr[13];
		dspf	<=	data_csr[15];
	end
end
//所有在M模式下运行的时候发生的异常，或者在其他模式下发生的但是没有被委托的异常都会交给M模式
assign iam_target_m	=	(m & ins_addr_mis) | (ins_addr_mis & !diam);
assign iaf_target_m =	(m & ins_acc_fault) | (ins_acc_fault & !diaf);
assign ii_target_m  =	(m & ill_ins) | (ill_ins & !dii);
assign bk_target_m  =	(m & ebreak) | (ebreak & !dbk);
assign lam_target_m =	(m & ld_addr_mis) | (ld_addr_mis & !dlam);
assign laf_target_m =	(m & ld_acc_fault) | (ld_acc_fault & !dlaf);
assign sam_target_m =	(m & st_addr_mis) | (st_addr_mis & !dsam);
assign saf_target_m =	(m & st_acc_fault) | (st_acc_fault & !dsaf);
assign ecu_target_m =	u & ecall & !decu;							//U模式下运行时发生ECALL且没有委托，就会交给M模式运行
assign ecs_target_m =	s & ecall & !decs;							//S模式下运行时发生ECALL且没有委托，就会交给M模式运行
assign ipf_target_m =	(m & ins_page_fault) | (ins_page_fault & !dipf);
assign lpf_target_m =	(m & ld_page_fault) | (ld_page_fault & !dlpf);
assign spf_target_m =	(m & st_page_fault) | (st_page_fault & !dspf);
//当进行了委托，在S和U模式下发生的异常都会被委托给S模式进行处理
assign iam_target_s	=	(s|u) & ins_addr_mis & diam;
assign iaf_target_s =	(s|u) & ins_acc_fault & diaf;
assign ii_target_s  =	(s|u) & ill_ins & dii;
assign bk_target_s  =	(s|u) & ebreak & dbk;
assign lam_target_s =	(s|u) & ld_addr_mis & dlam;
assign laf_target_s =	(s|u) & ld_acc_fault & dlaf;
assign sam_target_s =	(s|u) & st_addr_mis & dsam;
assign saf_target_s =	(s|u) & st_acc_fault & dsaf;
assign ecu_target_s =	u & ecall & decu;							//U模式下运行时发生ECALL且有委托，就会交给S模式运行
assign ecs_target_s =	s & ecall & decs;							//S模式下运行时发生ECALL且有委托，就会交给S 模式运行
assign ipf_target_s =	(s|u) & ins_page_fault & dipf;
assign lpf_target_s =	(s|u) & ld_page_fault & dlpf;
assign spf_target_s =	(s|u) & st_page_fault & dspf;

//根据优先级对cause进行编码
assign exc_cause	=	(bk_target_m|bk_target_s) ? bk : 
						(ipf_target_m|ipf_target_s) ? ipf :
						(iaf_target_m|iaf_target_s) ? iaf:
						(ii_target_m|ii_target_s) ? ii:
						(iam_target_m|iam_target_s)?iam:
						(ecs_target_m|ecs_target_s)?ecs:
						(ecu_target_m|ecu_target_s)?ecu:
						(sam_target_m|sam_target_s)?sam:
						(lam_target_m|lam_target_s)?lam:
						(spf_target_m|spf_target_s)?spf:
						(lpf_target_m|lpf_target_s)?lpf:
						(saf_target_m|saf_target_s)?saf:
						(laf_target_m|laf_target_s)?laf:64'b0;

assign medeleg	=	{48'b0,dspf,1'b0,dlpf,dipf,2'b0,decs,decu,dsaf,dsam,dlaf,dlam,dbk,dii,diaf,diam};

//只有当这条指令有效的时候，才会顺利接受中断
assign exc_target_m	= 	valid & (iam_target_m | iaf_target_m | ii_target_m | bk_target_m | lam_target_m | laf_target_m | sam_target_m | saf_target_m|
						ecu_target_m | ecs_target_m | ipf_target_m | lpf_target_m | spf_target_m);	
assign exc_target_s	= 	valid & (iam_target_s | iaf_target_s | ii_target_s | bk_target_s | lam_target_s | laf_target_s | sam_target_s | saf_target_s|
						ecu_target_s | ecs_target_s | ipf_target_s | lpf_target_s | spf_target_s);



endmodule
