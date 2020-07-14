module TLB(
input wire clk,
input wire rst,
//csr信号
input wire mxr,
input wire sum,
input wire vm_on,		//虚拟内存被打开了
//VA-PA通道
//命令通道
input wire read,
input wire write,
input wire execute,

input wire TLB_clear,	//TLB刷新
input wire [3:0]priv,	//权限

input wire access_rdy,	//访问准备好
//地址通道
input wire [63:0]addr_va,
output wire [63:0]addr_pa,
//辅助控制信号
output wire PTE_C,				//可以缓存
//应答信号
output wire TLB_ready,			//TLB准备好,检查转换通过
output wire load_page_fault,	//
output wire store_page_fault,
output wire ins_page_fault,

//TLB ctrl信号

input wire [43:0]PPN_in,
input wire [63:0]PTE_in,		//新的页表
input wire [63:0]PTE_pa_in,		//新的页表的物理地址

output wire [63:0]PTE_out,
output wire [63:0]PTE_pa_out_va_out,

output wire write_through_req,	//写穿请求
output wire translate_req,		//页面转换请求
output wire tsl_execute,		//页面转换用的参数
output wire tsl_read,
output wire tsl_write,
output wire [3:0]tsl_priv,

input wire ready,
input wire entry_write,
input wire TLB_D_set,
input wire page_fault


);
//pte位
//Sv39CT分页方案
parameter V 			= 0;
parameter R				= 1;
parameter W				= 2;
parameter X				= 3;
parameter U				= 4;
parameter G				= 5;
parameter A				= 6;
parameter D 			= 7;
parameter C				= 63;
parameter T				= 62;
//状态机参数
parameter stb	=	2'b00;	//等待状态
parameter tsl	=	2'b01;	//翻译
parameter wt	=	2'b10;	//写穿
parameter pf	=	2'b11;	//页面错误

wire TLB_hit;
wire TLB_miss;
wire page_check_ok;			//对选中的页面进行检查
wire access_check_ok;		//访问检查成功
wire write_through_check;	//PTE写穿检查

wire [43:0]PPN_out;				//最终选出的PPN号

reg [1:0]main_state;
//TLB entry信号
//TLB_ctrl控制信号
//entry0
wire entry0_valid;			//该TLB entry有效
wire [11:0]entry0_acc_count;	//访问计数
wire entry0_PTE_G;				//全局有效
wire [63:0]entry0_PTE_out;		//该页表的页表项
wire [63:0]entry0_PTE_pa_out; 	//该页表的物理地址
wire [43:0]entry0_PPN_out;		//物理页号输出

wire entry0_TLB_hit;		//命中
wire entry0_TLB_write;		//写页表项

wire entry0_TLB_D_set;		//置位脏标志（已经写穿完成）
//entry1
wire entry1_valid;			//该TLB entry有效
wire [11:0]entry1_acc_count;	//访问计数
wire entry1_PTE_G;				//全局有效
wire [63:0]entry1_PTE_out;		//该页表的页表项
wire [63:0]entry1_PTE_pa_out; 	//该页表的物理地址
wire [43:0]entry1_PPN_out;		//物理页号输出

wire entry1_TLB_hit;		//命中
wire entry1_TLB_write;		//写页表项

wire entry1_TLB_D_set;		//置位脏标志（已经写穿完成）
//entry2
wire entry2_valid;			//该TLB entry有效
wire [11:0]entry2_acc_count;	//访问计数
wire entry2_PTE_G;				//全局有效
wire [63:0]entry2_PTE_out;		//该页表的页表项
wire [63:0]entry2_PTE_pa_out; 	//该页表的物理地址
wire [43:0]entry2_PPN_out;		//物理页号输出

wire entry2_TLB_hit;		//命中
wire entry2_TLB_write;		//写页表项

wire entry2_TLB_D_set;		//置位脏标志（已经写穿完成）
//entry3
wire entry3_valid;			//该TLB entry有效
wire [11:0]entry3_acc_count;	//访问计数
wire entry3_PTE_G;				//全局有效
wire [63:0]entry3_PTE_out;		//该页表的页表项
wire [63:0]entry3_PTE_pa_out; 	//该页表的物理地址
wire [43:0]entry3_PPN_out;		//物理页号输出

wire [3:0]entry_select;		//需要替换的页

wire entry3_TLB_hit;		//命中
wire entry3_TLB_write;		//写页表项

wire entry3_TLB_D_set;		//置位脏标志（已经写穿完成）

assign TLB_miss			=	(write | read | execute) & !TLB_hit;
assign TLB_hit			=	(entry0_TLB_hit | entry1_TLB_hit | entry2_TLB_hit | entry3_TLB_hit);
assign TLB_ready		=	!write_through_check & TLB_hit;
//查找到的页表进行页面检查
page_check page_check(
//csr
.priv		(priv),
.mxr		(mxr),
.sum		(sum),
//读写控制
.read		(read),
.write		(write),
.execute	(execute),

//PTE
.PTE_U		(PTE_out[U]),
.PTE_W		(PTE_out[W]),
.PTE_R		(PTE_out[R]),
.PTE_X		(PTE_out[X]),

//检查正确
.check_ok	(page_check_ok)
);

assign access_check_ok	=	page_check_ok & TLB_hit;
							
assign write_through_check	= TLB_hit & access_check_ok & write & !PTE_out[D];

assign PTE_C	=	PTE_out[C];
//主状态机
always@(posedge clk)begin
//如果没有打开虚拟内存，TLB不起作用
	if(rst | !vm_on)begin
		main_state	<=	stb;
	end
	else begin
		case(main_state)
			stb	:	main_state	<=	write_through_check ? wt : TLB_miss ? tsl : main_state;
			wt	:	main_state	<=	page_fault ? pf : ready ? stb : main_state;
			tsl	:	main_state	<=	page_fault ? pf : ready ? stb : main_state;
			pf	:	main_state	<=	stb;
		endcase
	end
end


//选择命中的PTE项和他的PPN及物理地址输出
assign PTE_out		=	(entry0_TLB_hit ? entry0_PTE_out : 64'b0)	|
						(entry1_TLB_hit ? entry1_PTE_out : 64'b0)	|
						(entry2_TLB_hit ? entry2_PTE_out : 64'b0)	|
						(entry3_TLB_hit ? entry3_PTE_out : 64'b0)	;
					

assign PPN_out		=	(entry0_TLB_hit ? entry0_PPN_out : 44'b0) |
						(entry1_TLB_hit ? entry1_PPN_out : 44'b0) |
						(entry2_TLB_hit ? entry2_PPN_out : 44'b0) |
						(entry3_TLB_hit ? entry3_PPN_out : 44'b0) ;

//生成的物理页号与偏移地址相加得到最终的物理地址
//注意 在Sv39分页方案中，物理地址高位被进符号位拓展
assign addr_pa		=	{{8{PPN_out[43]}},PPN_out,addr_va[11:0]};

//TLB选择器，用于选出要替换的项
TLB_line_select TLB_line_select(
//entry0
.entry0_valid		(entry0_valid),			//该TLB entry有效
.entry0_acc_count	(entry0_acc_count),	//访问计数
.entry0_PTE_G		(entry0_PTE_G),				//全局有效
//entry1
.entry1_valid		(entry1_valid),			//该TLB entry有效
.entry1_acc_count	(entry1_acc_count),	//访问计数
.entry1_PTE_G		(entry0_PTE_G),				//全局有效
//entry2
.entry2_valid		(entry2_valid),			//该TLB entry有效
.entry2_acc_count	(entry2_acc_count),	//访问计数
.entry2_PTE_G		(entry2_PTE_G),				//全局有效
//entry3
.entry3_valid		(entry3_valid),			//该TLB entry有效
.entry3_acc_count	(entry3_acc_count),	//访问计数
.entry3_PTE_G		(entry3_PTE_G),				//全局有效

//选出的替换页
.entry_select		(entry_select)

);
//Entry读写信号
assign entry0_TLB_write	=	entry_select[0] & entry_write;
assign entry1_TLB_write	=	entry_select[1] & entry_write;
assign entry2_TLB_write	=	entry_select[2] & entry_write;
assign entry3_TLB_write	=	entry_select[3] & entry_write;
//entry脏位
assign entry0_TLB_D_set	=	entry0_TLB_hit & TLB_D_set;
assign entry1_TLB_D_set	=	entry1_TLB_hit & TLB_D_set;
assign entry2_TLB_D_set	=	entry2_TLB_hit & TLB_D_set;
assign entry3_TLB_D_set	=	entry3_TLB_hit & TLB_D_set;


assign PTE_pa_out_va_out	=	(entry0_TLB_hit ? entry0_PTE_pa_out : 64'b0 )|
								(entry1_TLB_hit ? entry1_PTE_pa_out : 64'b0 )|
								(entry2_TLB_hit ? entry2_PTE_pa_out : 64'b0 )|
								(entry3_TLB_hit ? entry3_PTE_pa_out : 64'b0 )|
								(TLB_miss		?	addr_va			: 64'b0 );
								
							
//4-entry TLB	
//entry0							
TLB_entry	TLB_entry0(	
.clk			(clk),
.rst			(rst),							
//VA-PA通道
//命令通道
.read			(read),
.write			(write),
.execute		(execute),

.access_rdy		(access_rdy),		//cache准备好，表示一次访问结束，TLB计数器加1
//地址通道
.addr_va		(addr_va),

//TLB_ctrl控制信号
.valid			(entry0_valid),			//该TLB entry有效
.acc_count		(entry0_acc_count),	//访问计数
.PTE_G			(entry0_PTE_G),				//全局有效
.PTE_out		(entry0_PTE_out),		//该页表的页表项
.PTE_pa_out		(entry0_PTE_pa_out), 	//该页表的物理地址
.PPN_out		(entry0_PPN_out),		//物理页号输出

.VPN_in			(addr_va[38:12]),		//该页表对应的VPN
.PPN_in			(PPN_in),
.PTE_in			(PTE_in),		//新的页表
.PTE_pa_in		(PTE_pa_in),				//新的页表的物理地址

.TLB_hit		(entry0_TLB_hit),		//命中
.TLB_write		(entry0_TLB_write),		//写页表项
.TLB_clear		(TLB_clear),		//页表清零（清除valid位）
.TLB_D_set		(entry0_TLB_D_set)		//置位脏标志（已经写穿完成）
);								
//entry1							
TLB_entry	TLB_entry1(	
.clk			(clk),
.rst			(rst),								
//VA-PA通道
//命令通道
.read			(read),
.write			(write),
.execute		(execute),

.access_rdy		(access_rdy),		//cache准备好，表示一次访问结束，TLB计数器加1
//地址通道
.addr_va		(addr_va),

//TLB_ctrl控制信号
.valid			(entry1_valid),			//该TLB entry有效
.acc_count		(entry1_acc_count),	//访问计数
.PTE_G			(entry1_PTE_G),				//全局有效
.PTE_out		(entry1_PTE_out),		//该页表的页表项
.PTE_pa_out		(entry1_PTE_pa_out), 	//该页表的物理地址
.PPN_out		(entry1_PPN_out),		//物理页号输出

.VPN_in			(addr_va[38:12]),		//该页表对应的VPN
.PPN_in			(PPN_in),
.PTE_in			(PTE_in),		//新的页表
.PTE_pa_in		(PTE_pa_in),				//新的页表的物理地址

.TLB_hit		(entry1_TLB_hit),		//命中
.TLB_write		(entry1_TLB_write),		//写页表项
.TLB_clear		(TLB_clear),		//页表清零（清除valid位）
.TLB_D_set		(entry1_TLB_D_set)		//置位脏标志（已经写穿完成）
);									
//entry1							
TLB_entry	TLB_entry2(		
.clk			(clk),
.rst			(rst),							
//VA-PA通道
//命令通道
.read			(read),
.write			(write),
.execute		(execute),

.access_rdy		(access_rdy),		//cache准备好，表示一次访问结束，TLB计数器加1
//地址通道
.addr_va		(addr_va),

//TLB_ctrl控制信号
.valid			(entry2_valid),			//该TLB entry有效
.acc_count		(entry2_acc_count),	//访问计数
.PTE_G			(entry2_PTE_G),				//全局有效
.PTE_out		(entry2_PTE_out),		//该页表的页表项
.PTE_pa_out		(entry2_PTE_pa_out), 	//该页表的物理地址
.PPN_out		(entry2_PPN_out),		//物理页号输出

.VPN_in			(addr_va[38:12]),		//该页表对应的VPN
.PPN_in			(PPN_in),
.PTE_in			(PTE_in),		//新的页表
.PTE_pa_in		(PTE_pa_in),				//新的页表的物理地址

.TLB_hit		(entry2_TLB_hit),		//命中
.TLB_write		(entry2_TLB_write),		//写页表项
.TLB_clear		(TLB_clear),		//页表清零（清除valid位）
.TLB_D_set		(entry2_TLB_D_set)		//置位脏标志（已经写穿完成）
);										
															
TLB_entry	TLB_entry3(		
.clk			(clk),
.rst			(rst),							
//VA-PA通道
//命令通道
.read			(read),
.write			(write),
.execute		(execute),

.access_rdy		(access_rdy),		//cache准备好，表示一次访问结束，TLB计数器加1
//地址通道
.addr_va		(addr_va),

//TLB_ctrl控制信号
.valid			(entry3_valid),			//该TLB entry有效
.acc_count		(entry3_acc_count),	//访问计数
.PTE_G			(entry3_PTE_G),				//全局有效
.PTE_out		(entry3_PTE_out),		//该页表的页表项
.PTE_pa_out		(entry3_PTE_pa_out), 	//该页表的物理地址
.PPN_out		(entry3_PPN_out),		//物理页号输出

.VPN_in			(addr_va[38:12]),		//该页表对应的VPN
.PPN_in			(PPN_in),
.PTE_in			(PTE_in),		//新的页表
.PTE_pa_in		(PTE_pa_in),				//新的页表的物理地址

.TLB_hit		(entry3_TLB_hit),		//命中
.TLB_write		(entry3_TLB_write),		//写页表项
.TLB_clear		(TLB_clear),		//页表清零（清除valid位）
.TLB_D_set		(entry3_TLB_D_set)		//置位脏标志（已经写穿完成）
);
//TLB总线单元信号
assign write_through_req	=	(main_state==wt);	//写穿请求
assign translate_req		=	(main_state==tsl);		//页面转换请求
assign tsl_read	=	read;
assign tsl_write=	write;
assign tsl_execute=execute;
assign tsl_priv	=	priv;
//应答信号
assign load_page_fault	=	read & TLB_hit & !access_check_ok | read & (main_state==pf);
assign store_page_fault	=	write & TLB_hit & !access_check_ok | write & (main_state==pf);
assign ins_page_fault	=	execute & TLB_hit & !access_check_ok | execute & (main_state==pf);


endmodule	

