module biu(
//csr
input wire clk,
input wire rst,

/*
需要写透的情况：

页面打开了T位（Sv39CT分页方案）

对外设的访问不能通过cache，否则数据将会出错。
*/

input wire [31:0]cacheability_block,	//可缓存的区，即物理地址[63:31],这个区间里的内存是可以缓存的

//csr信号
input wire [63:0]satp,			//页表基地址
input wire sum,					//supervis-user访问允许
input wire mxr,					//禁用执行位

//pmp检查信号
//没有PMP 告辞

//if信号
input wire [3:0]if_priv,		//if权限，和机器当前权限相同
input wire [63:0]addr_if,
input wire rd_ins,				//取指令信号
output wire [63:0]ins_read,

output wire ins_acc_fault, 		//指令访问失败
output wire ins_page_fault,		//指令页面错误
output wire cache_ready_if,		//cache准备好信号


//ex信号
input wire unpage,				//只使用物理地址
input wire [3:0]ex_priv,		//ex权限，0001=U 0010=S 0100=H 1000=M 
input wire [63:0]addr_ex,
input wire [63:0]data_write,
output wire[63:0]data_read,
output wire[63:0]data_uncache,
input wire [3:0]size,			//0001=1Byte 0010=2Byte 0100=4Byte 1000=8Byte other=fault			
input wire l1i_reset,			//缓存刷新信号，用于执行fence指令的时候使用
input wire l1d_reset,			//缓存载入信号，用于执行fence.vma时候和cache_flush配合使用
input wire TLB_reset,
input wire read,				//读数据信号
input wire write,				//写数据信号

output wire load_acc_fault,
output wire load_page_fault,
output wire store_acc_fault,
output wire store_page_fault,
output wire cache_ready_ex,		//cache数据准备好
output wire uncache_data_rdy,	//不可cache的数据准备好

//AHB信号
output wire [63:0]haddr,
output wire hwrite,
output wire [2:0]hsize,
output wire [2:0]hburst,
output wire [3:0]hprot,
output wire [1:0]htrans,
output wire hmastlock,
output wire [63:0]hwdata,

input wire hready,
input wire hresp,
input wire hreset_n,
input wire [63:0]hrdata,

input wire bus_master_req,
output wire bus_master_ack
);

wire ins_acc_fault0;
wire ins_acc_fault1;

//TLB-TLB_bu连接
//TLB0
wire [43:0]TLB0_PPN_in;
wire [63:0]TLB0_PTE_in;		//新的页表
wire [63:0]TLB0_PTE_pa_in;		//新的页表的物理地址

wire [63:0]TLB0_PTE_out;
wire [63:0]TLB0_PTE_pa_out_va_out;

wire TLB0_write_through_req;	//写穿请求
wire TLB0_translate_req;		//页面转换请求
wire TLB0_tsl_execute;		//页面转换用的参数
wire TLB0_tsl_read;
wire TLB0_tsl_write;
wire [3:0]TLB0_tsl_priv;

wire TLB0_bu_ready;
wire TLB0_D_set;
wire TLB0_entry_write;
wire TLB0_page_fault;
//TLB1
wire [43:0]TLB1_PPN_in;
wire [63:0]TLB1_PTE_in;		//新的页表
wire [63:0]TLB1_PTE_pa_in;		//新的页表的物理地址

wire [63:0]TLB1_PTE_out;
wire [63:0]TLB1_PTE_pa_out_va_out;

wire TLB1_write_through_req;	//写穿请求
wire TLB1_translate_req;		//页面转换请求
wire TLB1_tsl_execute;		//页面转换用的参数
wire TLB1_tsl_read;
wire TLB1_tsl_write;
wire [3:0]TLB1_tsl_priv;

wire TLB1_bu_ready;
wire TLB1_D_set;
wire TLB1_entry_write;
wire TLB1_page_fault;
//L1I D与L1_bu连接
//L1-I
wire I_write_through_req;	//请求写穿
wire I_read_req;			//请求读一次
wire I_read_line_req;		//请求读一行
wire [3:0]I_size;
wire [63:0]I_pa;			//
wire [63:0]I_wt_data;
wire [63:0]I_line_data;
wire [10:0]I_addr_count;
wire I_line_write;			//cache写
wire I_cache_entry_write;	//更新缓存entry
wire I_trans_rdy;			//传输完成
wire I_bus_error;			//访问失败
//L1-D
wire D_write_through_req;	//请求写穿
wire D_read_req;			//请求读一次
wire D_read_line_req;		//请求读一行
wire [3:0]D_size;
wire [63:0]D_pa;			//
wire [63:0]D_wt_data;
wire [63:0]D_line_data;
wire [10:0]D_addr_count;
wire D_line_write;			//cache写
wire D_cache_entry_write;	//更新缓存entry
wire D_trans_rdy;			//传输完成
wire D_bus_error;			//访问失败
//L1 bus unit
wire write_through_req;	//请求写穿
wire read_req;			//请求读一次
wire read_line_req;		//请求读一行
wire [3:0]bu_size;
wire [63:0]pa;			//
wire [63:0]wt_data;
wire [63:0]line_data;
wire [10:0]addr_count;
wire line_write;			//cache写
wire cache_entry_write;	//更新缓存entry
wire trans_rdy;			//传输完成
wire bus_error;			//访问失败
//TLB bu
wire TLB_write_through_req;
wire TLB_translate_req;
wire TLB_tsl_execute;
wire TLB_tsl_read;
wire TLB_tsl_write;
wire [3:0]TLB_tsl_priv;
wire TLB_bu_ready;
wire TLB_entry_write;
wire TLB_D_set;
wire TLB_page_fault;

wire [43:0]TLB_PPN_in;
wire [63:0]TLB_PTE_in;		//新的页表
wire [63:0]TLB_PTE_pa_in;		//新的页表的物理地址
wire [63:0]TLB_PTE_out;
wire [63:0]TLB_PTE_pa_out_va_out;
wire[63:0]TLB_bu_haddr;
wire TLB_bu_hwrite;
wire [3:0]TLB_bu_hsize;
wire [2:0]TLB_bu_hburst;
wire [3:0]TLB_bu_hprot;
wire [1:0]TLB_bu_htrans;
wire TLB_bu_hmastlock;
wire [63:0]TLB_bu_hwdata;

wire TLB_bu_hready;
wire TLB_bu_hresp;
wire TLB_bu_hreset_n;
wire [63:0]TLB_bu_hrdata;

wire TLB_bu_bus_ack;		//总线允许使用
wire TLB_bu_bus_req;		//总线请求使用

//TLB bu ahb
wire [63:0]L1_bu_haddr;
wire L1_bu_hwrite;
wire [2:0]L1_bu_hsize;
wire [2:0]L1_bu_hburst;
wire [3:0]L1_bu_hprot;
wire [1:0]L1_bu_htrans;
wire L1_bu_hmastlock;
wire [63:0]L1_bu_hwdata;

wire L1_bu_hready;
wire L1_bu_hresp;
wire L1_bu_hreset_n;
wire [63:0]L1_bu_hrdata;

wire L1_bu_bus_ack;		//总线允许使用
wire L1_bu_bus_req;		//总线请求使用

//biu_cell_I(指令用的cell）

biu_cell		I_biu_cell(
//全局信号
.clk				(clk),
.rst				(rst),

.cache_only		(1'b1),
.cacheability_block(cacheability_block),	//可缓存的区，即物理地址[63:31],这个区间里的内存是可以缓存的

//csr信号
.satp				(satp),			//页表基地址
.mxr				(mxr),
.sum				(sum),
//访问接口
.unpage				(1'b0),			//只使用物理地址
.priv				(if_priv),			//权限，0001=U 0010=S 0100=H 1000=M 
.v_addr				(addr_if),
.data_write			(64'b0),
.data_read			(ins_read),
.data_uncache		(),
.size				(4'b1000),			//0001=1Byte 0010=2Byte 0100=4Byte 1000=8Byte other=fault			
.TLB_clear			(TLB_reset),			//TLB清零
.L1_clear			(l1i_reset),

.read				(1'b0),				//读数据信号
.write				(1'b0),				//写数据信号
.execute			(rd_ins),

.ins_page_fault		(ins_page_fault),
.ins_acc_falt		(ins_acc_fault0),
.load_acc_fault		(),
.load_page_fault	(),
.store_acc_fault	(),
.store_page_fault	(),
.cache_data_ready	(cache_ready_if),		//cache数据准备好
.uncache_data_rdy	(ins_acc_fault1),		//不可cache的数据准备好,对于IF来说也是错误

//对TLB bus unit信号
.PPN_in				(TLB0_PPN_in),
.PTE_in				(TLB0_PTE_in),		//新的页表
.PTE_pa_in			(TLB0_PTE_pa_in),		//新的页表的物理地址

.PTE_out			(TLB0_PTE_out),
.PTE_pa_out_va_out	(TLB0_PTE_pa_out_va_out),

.TLB_write_through_req	(TLB0_write_through_req),	//写穿请求
.translate_req			(TLB0_translate_req),		//页面转换请求
.tsl_execute			(TLB0_tsl_execute),		//页面转换用的参数
.tsl_read				(TLB0_tsl_read),
.tsl_write				(TLB0_tsl_write),
.tsl_priv				(TLB0_tsl_priv),

.ready				(TLB0_bu_ready),
.entry_write		(TLB0_entry_write),
.TLB_D_set			(TLB0_D_set),
.page_fault			(TLB0_page_fault),

//对Cache bus unit信号
.L1_write_through_req	(I_write_through_req),	//请求写穿
.read_req				(I_read_req),			//请求读一次
.read_line_req			(I_read_line_req),		//请求读一行
.L1_size				(I_size),
.pa						(I_pa),			//
.wt_data				(I_wt_data),
.line_data				(I_line_data),
.addr_count				(I_addr_count),
.line_write				(I_line_write),			//cache写
.cache_entry_write		(I_cache_entry_write),	//更新缓存entry
.trans_rdy				(I_trans_rdy),			//传输完成
.bus_error				(I_bus_error)			//访问失败
);
//数据缓存
biu_cell		D_biu_cell(
//全局信号
.clk				(clk),
.rst				(rst),

.cache_only		(1'b0),
.cacheability_block(cacheability_block),	//可缓存的区，即物理地址[63:31],这个区间里的内存是可以缓存的

//csr信号
.satp				(satp),			//页表基地址
.mxr				(mxr),
.sum				(sum),
//访问接口
.unpage				(unpage),			//只使用物理地址
.priv				(ex_priv),			//权限，0001=U 0010=S 0100=H 1000=M 
.v_addr				(addr_ex),
.data_write			(data_write),
.data_read			(data_read),
.data_uncache		(),
.size				(size),			//0001=1Byte 0010=2Byte 0100=4Byte 1000=8Byte other=fault			
.TLB_clear			(TLB_reset),			//TLB清零
.L1_clear			(l1d_reset),

.read				(read),				//读数据信号
.write				(write),				//写数据信号
.execute			(1'b0),

.ins_page_fault		(),
.ins_acc_falt		(),
.load_acc_fault		(load_acc_fault),
.load_page_fault	(load_page_fault),
.store_acc_fault	(store_acc_fault),
.store_page_fault	(store_page_fault),
.cache_data_ready	(cache_ready_ex),		//cache数据准备好
.uncache_data_rdy	(uncache_data_rdy),		//不可cache的数据准备好

//对TLB bus unit信号
.PPN_in				(TLB1_PPN_in),
.PTE_in				(TLB1_PTE_in),		//新的页表
.PTE_pa_in			(TLB1_PTE_pa_in),		//新的页表的物理地址

.PTE_out			(TLB1_PTE_out),
.PTE_pa_out_va_out	(TLB1_PTE_pa_out_va_out),

.TLB_write_through_req	(TLB1_write_through_req),	//写穿请求
.translate_req			(TLB1_translate_req),		//页面转换请求
.tsl_execute			(TLB1_tsl_execute),		//页面转换用的参数
.tsl_read				(TLB1_tsl_read),
.tsl_write				(TLB1_tsl_write),
.tsl_priv				(TLB1_tsl_priv),

.ready				(TLB1_bu_ready),
.entry_write		(TLB1_entry_write),
.TLB_D_set			(TLB1_D_set),
.page_fault			(TLB1_page_fault),

//对Cache bus unit信号
.L1_write_through_req	(D_write_through_req),	//请求写穿
.read_req				(D_read_req),			//请求读一次
.read_line_req			(D_read_line_req),		//请求读一行
.L1_size				(D_size),
.pa						(D_pa),			//
.wt_data				(D_wt_data),
.line_data				(D_line_data),
.addr_count				(D_addr_count),
.line_write				(D_line_write),			//cache写
.cache_entry_write		(D_cache_entry_write),	//更新缓存entry
.trans_rdy				(D_trans_rdy),			//传输完成
.bus_error				(D_bus_error)			//访问失败
);

//BUS REQ MUX
bu_req_mux		bu_req_mux(
.clk				(clk),
.rst				(rst),
//TLB0
.TLB0_PPN_in			(TLB0_PPN_in),			//						fanout=8
.TLB0_PTE_in			(TLB0_PTE_in),		//新的页表					fanout=8
.TLB0_PTE_pa_in			(TLB0_PTE_pa_in),		//新的页表的物理地址	fanout=8

.TLB0_PTE_out			(TLB0_PTE_out),
.TLB0_PTE_pa_out_va_out	(TLB0_PTE_pa_out_va_out),

.TLB0_write_through_req	(TLB0_write_through_req),	//写穿请求
.TLB0_translate_req		(TLB0_translate_req),		//页面转换请求
.TLB0_tsl_execute		(TLB0_tsl_execute),		//页面转换用的参数
.TLB0_tsl_read			(TLB0_tsl_read),
.TLB0_tsl_write			(TLB0_tsl_write),
.TLB0_tsl_priv			(TLB0_tsl_priv),

.TLB0_bu_ready			(TLB0_bu_ready),
.TLB0_entry_write		(TLB0_entry_write),
.TLB0_D_set				(TLB0_D_set),
.TLB0_page_fault		(TLB0_page_fault),
//TLB1
.TLB1_PPN_in			(TLB1_PPN_in),			//						fanout=8
.TLB1_PTE_in			(TLB1_PTE_in),		//新的页表					fanout=8
.TLB1_PTE_pa_in			(TLB1_PTE_pa_in),		//新的页表的物理地址	fanout=8

.TLB1_PTE_out			(TLB1_PTE_out),
.TLB1_PTE_pa_out_va_out	(TLB1_PTE_pa_out_va_out),

.TLB1_write_through_req	(TLB1_write_through_req),	//写穿请求
.TLB1_translate_req		(TLB1_translate_req),		//页面转换请求
.TLB1_tsl_execute		(TLB1_tsl_execute),		//页面转换用的参数
.TLB1_tsl_read			(TLB1_tsl_read),
.TLB1_tsl_write			(TLB1_tsl_write),
.TLB1_tsl_priv			(TLB1_tsl_priv),

.TLB1_bu_ready			(TLB1_bu_ready),
.TLB1_entry_write		(TLB1_entry_write),
.TLB1_D_set				(TLB1_D_set),
.TLB1_page_fault		(TLB1_page_fault),

//TLB_bus_unit
.TLB_PPN_in				(TLB_PPN_in),			//						fanout=8
.TLB_PTE_in				(TLB_PTE_in),		//新的页表					fanout=8
.TLB_PTE_pa_in			(TLB_PTE_pa_in),		//新的页表的物理地址	fanout=8

.TLB_PTE_out			(TLB_PTE_out),
.TLB_PTE_pa_out_va_out	(TLB_PTE_pa_out_va_out),

.TLB_write_through_req	(TLB_write_through_req),	//写穿请求
.TLB_translate_req		(TLB_translate_req),		//页面转换请求
.TLB_tsl_execute		(TLB_tsl_execute),		//页面转换用的参数
.TLB_tsl_read			(TLB_tsl_read),
.TLB_tsl_write			(TLB_tsl_write),
.TLB_tsl_priv			(TLB_tsl_priv),

.TLB_bu_ready			(TLB_bu_ready),
.TLB_entry_write		(TLB_entry_write),
.TLB_D_set				(TLB_D_set),
.TLB_page_fault			(TLB_page_fault),
//cache bug unit
//L1-I
.I_write_through_req	(I_write_through_req),	//请求写穿
.I_read_req				(I_read_req),			//请求读一次
.I_read_line_req		(I_read_line_req),		//请求读一行
.I_size					(I_size),
.I_pa					(I_pa),			//
.I_wt_data				(I_wt_data),
.I_line_data			(I_line_data),
.I_addr_count			(I_addr_count),
.I_line_write			(I_line_write),			//cache写
.I_cache_entry_write	(I_cache_entry_write),	//更新缓存entry
.I_trans_rdy			(I_trans_rdy),			//传输完成
.I_bus_error			(I_bus_error),			//访问失败
//L1-D
.D_write_through_req	(D_write_through_req),	//请求写穿
.D_read_req				(D_read_req),			//请求读一次
.D_read_line_req		(D_read_line_req),		//请求读一行
.D_size					(D_size),
.D_pa					(D_pa),			//
.D_wt_data				(D_wt_data),
.D_line_data			(D_line_data),
.D_addr_count			(D_addr_count),
.D_line_write			(D_line_write),			//cache写
.D_cache_entry_write	(D_cache_entry_write),	//更新缓存entry
.D_trans_rdy			(D_trans_rdy),			//传输完成
.D_bus_error			(D_bus_error),			//访问失败
//L1 bus unit
.write_through_req		(write_through_req),	//请求写穿
.read_req				(read_req),			//请求读一次
.read_line_req			(read_line_req),		//请求读一行
.size					(bu_size),
.pa						(pa),			//
.wt_data				(wt_data),
.line_data				(line_data),
.addr_count				(addr_count),
.line_write				(line_write),			//cache写
.cache_entry_write		(cache_entry_write),	//更新缓存entry
.trans_rdy				(trans_rdy),			//传输完成
.bus_error				(bus_error)				//访问失败
);
//TLB bus unit
TLB_bus_unit	TLB_bus_unit(
.clk					(clk),
.rst					(rst),
//csr
.satp					(satp),			//页表基地址
.mxr					(mxr),
.sum					(sum),

//TLB0
.TLB_PPN_in				(TLB_PPN_in),			//						fanout=8
.TLB_PTE_in				(TLB_PTE_in),		//新的页表					fanout=8
.TLB_PTE_pa_in			(TLB_PTE_pa_in),		//新的页表的物理地址	fanout=8

.TLB_PTE_out			(TLB_PTE_out),
.TLB_PTE_pa_out_va_out	(TLB_PTE_pa_out_va_out),

.TLB_write_through_req	(TLB_write_through_req),	//写穿请求
.TLB_translate_req		(TLB_translate_req),		//页面转换请求
.TLB_tsl_execute		(TLB_tsl_execute),		//页面转换用的参数
.TLB_tsl_read			(TLB_tsl_read),
.TLB_tsl_write			(TLB_tsl_write),
.TLB_tsl_priv			(TLB_tsl_priv),

.TLB_bu_ready			(TLB_bu_ready),
.TLB_entry_write		(TLB_entry_write),
.TLB_D_set				(TLB_D_set),
.TLB_page_fault			(TLB_page_fault),

//ahb
//ahb
.haddr					(TLB_bu_haddr),
.hwrite					(TLB_bu_hwrite),
.hsize					(TLB_bu_hsize),
.hburst					(TLB_bu_hburst),
.hprot					(TLB_bu_hprot),
.htrans					(TLB_bu_htrans),
.hmastlock				(TLB_bu_hmastlock),
.hwdata					(TLB_bu_hwdata),

.hready					(TLB_bu_hready),
.hresp					(TLB_bu_hresp),
.hreset_n				(),
.hrdata					(TLB_bu_hrdata),

.bus_ack				(TLB_bu_bus_ack),		//总线允许使用
.bus_req				(TLB_bu_bus_req)	//总线请求使用
);

//L1 bus unit
cache_bus_unit		L1_bus_unit(
.clk					(clk),
.rst					(rst),

//cache控制器逻辑
.write_through_req		(write_through_req),	//请求写穿
.read_req				(read_req),			//请求读一次
.read_line_req			(read_line_req),		//请求读一行
.size					(bu_size),
.pa						(pa),			//
.wt_data				(wt_data),
.line_data				(line_data),
.addr_count				(addr_count),
.line_write				(line_write),			//cache写
.cache_entry_write		(cache_entry_write),	//更新缓存entry
.trans_rdy				(trans_rdy),			//传输完成
.bus_error				(bus_error),				//访问失败

//AHB总线
//ahb
.haddr					(L1_bu_haddr),
.hwrite					(L1_bu_hwrite),
.hsize					(L1_bu_hsize),
.hburst					(L1_bu_hburst),
.hprot					(L1_bu_hprot),
.htrans					(L1_bu_htrans),
.hmastlock				(L1_bu_hmastlock),
.hwdata					(L1_bu_hwdata),

.hready					(L1_bu_hready),
.hresp					(L1_bu_hresp),
.hreset_n				(),
.hrdata					(L1_bu_hrdata),

.bus_ack				(L1_bu_bus_ack),		//总线允许使用
.bus_req				(L1_bu_bus_req)	//总线请求使用

);
//bu mux
bu_mux bu_mux(
.clk					(clk),
.rst					(rst),
//TLB bu ahb
//ahb
.TLB_bu_haddr				(TLB_bu_haddr),
.TLB_bu_hwrite				(TLB_bu_hwrite),
.TLB_bu_hsize				(TLB_bu_hsize),
.TLB_bu_hburst				(TLB_bu_hburst),
.TLB_bu_hprot				(TLB_bu_hprot),
.TLB_bu_htrans				(TLB_bu_htrans),
.TLB_bu_hmastlock			(TLB_bu_hmastlock),
.TLB_bu_hwdata				(TLB_bu_hwdata),

.TLB_bu_hready				(TLB_bu_hready),
.TLB_bu_hresp				(TLB_bu_hresp),
.TLB_bu_hreset_n			(),
.TLB_bu_hrdata				(TLB_bu_hrdata),

.TLB_bu_bus_ack			(TLB_bu_bus_ack),		//总线允许使用
.TLB_bu_bus_req			(TLB_bu_bus_req),	//总线请求使用

//TLB bu ahb
.L1_bu_haddr					(L1_bu_haddr),
.L1_bu_hwrite					(L1_bu_hwrite),
.L1_bu_hsize					(L1_bu_hsize),
.L1_bu_hburst					(L1_bu_hburst),
.L1_bu_hprot					(L1_bu_hprot),
.L1_bu_htrans					(L1_bu_htrans),
.L1_bu_hmastlock				(L1_bu_hmastlock),
.L1_bu_hwdata					(L1_bu_hwdata),

.L1_bu_hready					(L1_bu_hready),
.L1_bu_hresp					(L1_bu_hresp),
.L1_bu_hreset_n				(),
.L1_bu_hrdata					(L1_bu_hrdata),

.L1_bu_bus_ack				(L1_bu_bus_ack),		//总线允许使用
.L1_bu_bus_req				(L1_bu_bus_req),	//总线请求使用

//第三方设备请求总线
.Ext_bus_ack			(bus_master_ack),
.Ext_bus_req			(bus_master_req),

//AHB接口
//ahb
.haddr					(haddr),
.hwrite					(hwrite),
.hsize					(hsize),
.hburst					(hburst),
.hprot					(hprot),
.htrans					(htrans),
.hmastlock				(hmastlock),
.hwdata					(hwdata),

.hready					(hready),
.hresp					(hresp),
.hreset_n				(),
.hrdata					(hrdata)
);

assign ins_acc_fault	=	ins_acc_fault0 | ins_acc_fault1;

endmodule

