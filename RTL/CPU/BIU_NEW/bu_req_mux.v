/*

*/
module bu_req_mux(
input wire clk,
input wire rst,
//TLB0
output wire [43:0]TLB0_PPN_in,			//						fanout=8
output wire [63:0]TLB0_PTE_in,		//新的页表					fanout=8
output wire [63:0]TLB0_PTE_pa_in,		//新的页表的物理地址	fanout=8

input wire [63:0]TLB0_PTE_out,
input wire [63:0]TLB0_PTE_pa_out_va_out,

input wire TLB0_write_through_req,	//写穿请求
input wire TLB0_translate_req,		//页面转换请求
input wire TLB0_tsl_execute,		//页面转换用的参数
input wire TLB0_tsl_read,
input wire TLB0_tsl_write,
input wire [3:0]TLB0_tsl_priv,

output wire TLB0_bu_ready,
output wire TLB0_entry_write,
output wire TLB0_D_set,
output wire TLB0_page_fault,
//TLB1
output wire [43:0]TLB1_PPN_in,
output wire [63:0]TLB1_PTE_in,		//新的页表
output wire [63:0]TLB1_PTE_pa_in,		//新的页表的物理地址

input wire [63:0]TLB1_PTE_out,
input wire [63:0]TLB1_PTE_pa_out_va_out,

input wire TLB1_write_through_req,	//写穿请求
input wire TLB1_translate_req,		//页面转换请求
input wire TLB1_tsl_execute,		//页面转换用的参数
input wire TLB1_tsl_read,
input wire TLB1_tsl_write,
input wire [3:0]TLB1_tsl_priv,

output wire TLB1_bu_ready,
output wire TLB1_entry_write,
output wire TLB1_D_set,
output wire TLB1_page_fault,

//TLB_bus_unit
input wire [43:0]TLB_PPN_in,
input wire [63:0]TLB_PTE_in,		//新的页表
input wire [63:0]TLB_PTE_pa_in,		//新的页表的物理地址

output wire [63:0]TLB_PTE_out,
output wire [63:0]TLB_PTE_pa_out_va_out,

output wire TLB_write_through_req,	//写穿请求
output wire TLB_translate_req,		//页面转换请求
output wire TLB_tsl_execute,		//页面转换用的参数
output wire TLB_tsl_read,
output wire TLB_tsl_write,
output wire [3:0]TLB_tsl_priv,

input wire TLB_bu_ready,
input wire TLB_entry_write,
input wire TLB_D_set,
input wire TLB_page_fault,
//cache bug unit
//L1-I
input wire I_write_through_req,	//请求写穿
input wire I_read_req,			//请求读一次
input wire I_read_line_req,		//请求读一行
input wire [3:0]I_size,
input wire [63:0]I_pa,			//
input wire [63:0]I_wt_data,
output wire [63:0]I_line_data,
output wire [10:0]I_addr_count,
output wire I_line_write,			//cache写
output wire I_cache_entry_write,	//更新缓存entry
output wire I_trans_rdy,			//传输完成
output wire I_bus_error,			//访问失败
//L1-D
input wire D_write_through_req,	//请求写穿
input wire D_read_req,			//请求读一次
input wire D_read_line_req,		//请求读一行
input wire [3:0]D_size,
input wire [63:0]D_pa,			//
input wire [63:0]D_wt_data,
output wire [63:0]D_line_data,
output wire [10:0]D_addr_count,
output wire D_line_write,			//cache写
output wire D_cache_entry_write,	//更新缓存entry
output wire D_trans_rdy,			//传输完成
output wire D_bus_error,			//访问失败
//L1 bus unit
output wire write_through_req,	//请求写穿
output wire read_req,			//请求读一次
output wire read_line_req,		//请求读一行
output wire [3:0]size,
output wire [63:0]pa,			//
output wire [63:0]wt_data,
input wire [63:0]line_data,
input wire [10:0]addr_count,
input wire line_write,			//cache写
input wire cache_entry_write,	//更新缓存entry
input wire trans_rdy,			//传输完成
input wire bus_error			//访问失败
);

reg [1:0]TLB_access_state;	//访问状态
wire TLB1_access;		//TLB1尝试访问页表
wire TLB0_access;

always@(posedge clk)begin
	if(rst )begin
		TLB_access_state	<=	2'b0;
	end
	else begin
		case(TLB_access_state)
			2'b00	:	if(TLB1_write_through_req|TLB1_translate_req)begin
							TLB_access_state	<=	2'b01;			//TLB1访问允许
						end
						else if(TLB0_write_through_req|TLB0_translate_req)begin
							TLB_access_state	<=	2'b10;			//TLB0访问允许
						end
	
			2'b01	:	TLB_access_state	<=	(TLB_bu_ready | TLB_page_fault) ? 2'b00 : TLB_access_state;
			2'b10	:	TLB_access_state	<=	(TLB_bu_ready | TLB_page_fault) ? 2'b00 : TLB_access_state;
		endcase
	end
end
assign TLB1_access	=	(TLB_access_state==2'b01);
assign TLB0_access	=	(TLB_access_state==2'b10);
		
//根据请求选出最终送到TLB BU的信号
assign TLB_PTE_out	=	TLB1_access ? TLB1_PTE_out : TLB0_PTE_out;
assign TLB_PTE_pa_out_va_out	=	TLB1_access ? TLB1_PTE_pa_out_va_out : TLB0_PTE_pa_out_va_out;

assign TLB_write_through_req	=	TLB1_access & TLB1_write_through_req | TLB0_access & TLB0_write_through_req;	//写穿请求
assign TLB_translate_req		=	TLB1_access & TLB1_translate_req | TLB0_access & TLB0_translate_req;		//页面转换请求
assign TLB_tsl_execute			=	TLB1_access ? TLB1_tsl_execute : TLB0_tsl_execute;		//页面转换用的参数
assign TLB_tsl_read				=	TLB1_access ? TLB1_tsl_read : TLB0_tsl_read;
assign TLB_tsl_write			=	TLB1_access ? TLB1_tsl_write : TLB0_tsl_write;
assign TLB_tsl_priv				=	TLB1_access ? TLB1_tsl_priv  : TLB0_tsl_priv;

//送TLB0的反馈信号
assign TLB0_PPN_in	=	TLB_PPN_in;
assign TLB0_PTE_in	=	TLB_PTE_in;		//新的页表
assign TLB0_PTE_pa_in=	TLB_PTE_pa_in;		//新的页表的物理地址

assign TLB0_bu_ready	=	TLB0_access & TLB_bu_ready;
assign TLB0_entry_write	=	TLB0_access & TLB_entry_write;
assign TLB0_D_set		=	TLB0_access & TLB_D_set;
assign TLB0_page_fault	=	TLB0_access & TLB_page_fault;

//送TLB1的反馈信号
assign TLB1_PPN_in	=	TLB_PPN_in;
assign TLB1_PTE_in	=	TLB_PTE_in;		//新的页表
assign TLB1_PTE_pa_in=	TLB_PTE_pa_in;		//新的页表的物理地址

assign TLB1_bu_ready	=	TLB1_access & TLB_bu_ready;
assign TLB1_entry_write	=	TLB1_access & TLB_entry_write;
assign TLB1_D_set		=	TLB1_access & TLB_D_set;
assign TLB1_page_fault	=	TLB1_access & TLB_page_fault;

//D尝试访问内存
reg [1:0]cache_access_state;
wire D_access;
wire I_access;

always@(posedge clk)begin
	if(rst)begin
		cache_access_state	<=	2'b00;
	end
	else begin
		case(cache_access_state)
			2'b00	:	if(D_read_req|D_read_line_req|D_write_through_req)begin
							cache_access_state	<=	2'b01;			//D访问允许
						end
						else if(I_read_req|I_read_line_req|I_write_through_req)begin
							cache_access_state	<=	2'b10;			//TLB0访问允许
						end
			2'b01	:	cache_access_state	<=	(trans_rdy | bus_error) ? 2'b00 : cache_access_state;
			2'b10	:	cache_access_state	<=	(trans_rdy | bus_error) ? 2'b00 : cache_access_state;
		endcase
	end
end
assign D_access	=	(cache_access_state==2'b01);
assign I_access	=	(cache_access_state==2'b10);

//送cache bus unit信号
//只有access信号需要进行选择
assign write_through_req	=	D_access & D_write_through_req | I_access & I_write_through_req;	//请求写穿
assign read_req				=	D_access & D_read_req | I_access & I_read_req;			//请求读一次
assign read_line_req		=	D_access & D_read_line_req | I_access & I_read_line_req;		//请求读一行

assign size					=	D_access ? D_size : I_size;
assign pa					=	D_access ? D_pa : I_pa;			
assign wt_data				=	D_access ? D_wt_data : I_wt_data;
//L1-I反馈信号
assign I_line_data	=	line_data;
assign I_addr_count	=	addr_count;
assign I_line_write	=	I_access & line_write;			//cache写
assign I_cache_entry_write	=	I_access & cache_entry_write;	//更新缓存entry
assign I_trans_rdy	=	I_access & trans_rdy;		//传输完成
assign I_bus_error	=	I_access & bus_error;			//访问失败
//L1D反馈信号
assign D_line_data	=	line_data;
assign D_addr_count	=	addr_count;
assign D_line_write	=	D_access & line_write;			//cache写
assign D_cache_entry_write	=	D_access & cache_entry_write;	//更新缓存entry
assign D_trans_rdy	=	D_access & trans_rdy;		//传输完成
assign D_bus_error	=	D_access & bus_error;			//访问失败


endmodule
