/*
biu_cell单元，是PRV464SX2处理器总线接口部件中的一个部分
*/
module biu_cell(
//全局信号
input wire clk,
input wire rst,

input wire cache_only,
input wire [31:0]cacheability_block,	//可缓存的区，即物理地址[63:31],这个区间里的内存是可以缓存的

//csr信号
input wire [63:0]satp,			//页表基地址
input wire sum,					//supervis-user访问允许
input wire mxr,					//禁用执行位
//访问接口
input wire unpage,				//只使用物理地址
input wire [3:0]priv,			//权限，0001=U 0010=S 0100=H 1000=M 
input wire [63:0]v_addr,
input wire [63:0]data_write,
output wire[63:0]data_read,
output wire[63:0]data_uncache,
input wire [3:0]size,			//0001=1Byte 0010=2Byte 0100=4Byte 1000=8Byte other=fault			
input wire TLB_clear,			//TLB清零
input wire L1_clear,

input wire read,				//读数据信号
input wire write,				//写数据信号
input wire execute,

output wire ins_page_fault,
output wire ins_acc_falt,
output wire load_acc_fault,
output wire load_page_fault,
output wire store_acc_fault,
output wire store_page_fault,
output wire cache_data_ready,		//cache数据准备好
output wire uncache_data_rdy,	//不可cache的数据准备好

//对TLB bus unit信号
input wire [43:0]PPN_in,
input wire [63:0]PTE_in,		//新的页表
input wire [63:0]PTE_pa_in,		//新的页表的物理地址

output wire [63:0]PTE_out,
output wire [63:0]PTE_pa_out_va_out,

output wire TLB_write_through_req,	//写穿请求
output wire translate_req,		//页面转换请求
output wire tsl_execute,		//页面转换用的参数
output wire tsl_read,
output wire tsl_write,
output wire [3:0]tsl_priv,

input wire ready,
input wire entry_write,
input wire TLB_D_set,
input wire page_fault,

//对Cache bus unit信号
output wire L1_write_through_req,	//请求写穿 
output wire read_req,			//请求读一次
output wire read_line_req,		//请求读一行
output wire [3:0]L1_size,
output wire [63:0]pa,			//
output wire [63:0]wt_data,
input wire [63:0]line_data,
input wire [10:0]addr_count,
input wire line_write,			//cache写
input wire cache_entry_write,	//更新缓存entry
input wire trans_rdy,			//传输完成
input wire bus_error			//访问失败
);

wire [63:0]addr_pa_TLB;	//TLB产生的物理地址
wire [63:0]PA;			//最终生成的PA

wire TLB_ready;

//对TLB控制信号
wire TLB_write;
wire TLB_read;
wire TLB_execute;

//对l1信号
wire L1_write;
wire L1_read;
wire L1_execute;

wire vm_on;			//虚拟内存被打开了
wire PTE_C;			//页面可以缓存

//虚存打开检查
//这里支持Sv39CT分页方案
assign vm_on = (satp[63:60]==4'b1000);

//物理地址
//当虚拟内存打开并且没有禁用页表时，使用转换后的地址
assign PA	=	(vm_on&!unpage) ? addr_pa_TLB : v_addr ;  

//TLB控制信号
assign TLB_read		=	(vm_on&!unpage) ? read : 1'b0;
assign TLB_write	=	(vm_on&!unpage) ? write: 1'b0;
assign TLB_execute	=	(vm_on&!unpage) ? execute:1'b0;

//L1控制信号
/*	vm_on	unpage	TLB_ready	通
	0		0		0			1
	0		0		1			1
	0		1		0			1
	0		1		1			1
	1		0		0			0
	1		0		1			1
	1		1		x			1
通： 通=1时候表示控制信号可以进到下一级，通=0表示VA-PA没有完成，需要等待TLB查询页表

*/	
assign L1_read		=	(vm_on & !unpage & !TLB_ready) ? 1'b0 : read;
assign L1_write		=	(vm_on & !unpage & !TLB_ready) ? 1'b0 : write;
assign L1_execute	=	(vm_on & !unpage & !TLB_ready) ? 1'b0 : execute;

TLB 			TLB(
.clk				(clk),
.rst				(rst),	
//csr信号
.mxr				(mxr),
.sum				(sum),
.vm_on				(vm_on),		//虚拟内存被打开了
//VA-PA通道
//命令通道
.read				(TLB_read),
.write				(TLB_write),
.execute			(TLB_execute),

.TLB_clear			(TLB_clear),	//TLB刷新
.priv				(priv),	//权限

.access_rdy			(cache_data_ready | uncache_data_rdy),	//访问准备好
//地址通道
.addr_va			(v_addr),
.addr_pa			(addr_pa_TLB),
//辅助控制信号
.PTE_C				(PTE_C),				//可以缓存
//应答信号
.TLB_ready			(TLB_ready),			//TLB准备好,检查转换通过
.load_page_fault	(load_page_fault),	//
.store_page_fault	(store_page_fault),
.ins_page_fault		(ins_page_fault),

//TLB ctrl信号
.PPN_in				(PPN_in),
.PTE_in				(PTE_in),		//新的页表
.PTE_pa_in			(PTE_pa_in),		//新的页表的物理地址

.PTE_out			(PTE_out),
.PTE_pa_out_va_out	(PTE_pa_out_va_out),

.write_through_req	(TLB_write_through_req),	//写穿请求
.translate_req		(translate_req),		//页面转换请求
.tsl_execute		(tsl_execute),		//页面转换用的参数
.tsl_read			(tsl_read),
.tsl_write			(tsl_write),
.tsl_priv			(tsl_priv),

.ready				(ready),
.entry_write		(entry_write),
.TLB_D_set			(TLB_D_set),		//TLB脏位设置
.page_fault			(page_fault)

);

//L1缓存

l1				L1(
//配置信号
.cache_only			(cache_only),
.cacheability_block	(cacheability_block),
.clk				(clk),
.rst				(rst),

//访问信号
.read				(L1_read),
.write				(L1_write),
.execute			(L1_execute),
.L1_clear			(L1_clear),			//L1缓存清零，用于fence指令同步数据

.size				(size),				//

.PTE_C				(PTE_C),			//页表项表示可缓存

.addr_pa			(PA),
.data_write			(data_write),
.data_read			(data_read),
//应答通道
.load_acc_fault		(load_acc_fault),
.store_acc_fault	(store_acc_fault),
.ins_acc_fault		(ins_acc_falt),
.cache_data_ready	(cache_data_ready),	//可缓存的数据准备好
.uncache_data_ready	(uncache_data_rdy),	//不可缓存的数据准备好

//cache控制器逻辑
.write_through_req	(L1_write_through_req),	//请求写穿
.read_req			(read_req),			//请求读一次
.read_line_req		(read_line_req),		//请求读一行
.L1_size			(L1_size),
.pa					(pa),			//
.wt_data			(wt_data),
.line_data			(line_data),
.addr_count			(addr_count),
.line_write			(line_write),			//cache写
.cache_entry_write	(cache_entry_write),	//更新缓存entry
.trans_rdy			(trans_rdy),			//传输完成
.bus_error			(bus_error)			//访问失败

);
assign data_uncache	=	data_read;


endmodule















