module l1(
//配置信号
input wire [31:0]cacheability_block,
input wire cache_only,
input wire clk,
input wire rst,

//访问信号
input wire read,
input wire write,
input wire execute,
input wire L1_clear,

input wire [3:0]size,		//

input wire PTE_C,			//可缓存

input wire [63:0]addr_pa,
input wire [63:0]data_write,
output wire [63:0]data_read,
//应答通道
output wire load_acc_fault,
output wire store_acc_fault,
output wire ins_acc_fault,
output wire cache_data_ready,	//可缓存的数据准备好
output wire uncache_data_ready,	//不可缓存的数据准备好

//cache控制器逻辑
output wire write_through_req,	//请求写穿
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
//状态机
parameter stb			=	3'b000;
parameter read_line		=	3'b001;
parameter read_singal	=	3'b010;
parameter write_singal	=	3'b011;
parameter access_fault	=	3'b111;

reg [2:0]main_state;


wire cacheable;		//可以被缓存

assign cacheable	=	(addr_pa[63:31]==cacheability_block) | PTE_C;	//SV39CT分页方案！
//缓存命中
wire entry0_hit;
wire entry1_hit;
wire entry2_hit;
wire entry3_hit;

wire cache_miss;

wire [3:0]entry_select;	//选中的替换entry

//cache entry0
wire [63:0]entry0_pa_out;
wire entry0_valid;
wire [11:0]entry0_access_count;
wire cache_entry0_write;
//cache entry1
wire [63:0]entry1_pa_out;
wire entry1_valid;
wire [11:0]entry1_access_count;
wire cache_entry1_write;
//cache entry2
wire [63:0]entry2_pa_out;
wire entry2_valid;
wire [11:0]entry2_access_count;
wire cache_entry2_write;
//cache entry3
wire [63:0]entry3_pa_out;
wire entry3_valid;
wire [11:0]entry3_access_count;
wire cache_entry3_write;

wire access_ready;

assign access_ready	=	cache_data_ready | uncache_data_ready;

//缓存控制信号
wire [7:0]byte_sel;		//生成的bsel
wire cache_write;
wire we;				//最终的cache写入信号

wire [1:0]read_block_sel;	//读块选择 00=entry0…………
wire [1:0]write_block_sel;	//写块选择
wire [12:0]read_addr;
wire [12:0]write_addr;
wire [63:0]di;
wire [63:0]dout;

assign entry0_hit	=	(addr_pa[63:11]==entry0_pa_out[63:11])&entry0_valid;
assign entry1_hit	=	(addr_pa[63:11]==entry1_pa_out[63:11])&entry1_valid;
assign entry2_hit	=	(addr_pa[63:11]==entry2_pa_out[63:11])&entry2_valid;
assign entry3_hit	=	(addr_pa[63:11]==entry3_pa_out[63:11])&entry3_valid;

//cache更新
assign cache_entry0_write	=	(entry_select[0])&cache_entry_write;
assign cache_entry1_write	=	(entry_select[1])&cache_entry_write;
assign cache_entry2_write	=	(entry_select[2])&cache_entry_write;
assign cache_entry3_write	=	(entry_select[3])&cache_entry_write;

//缓存miss
assign cache_miss	=	(read | write | execute) & !(entry0_hit|entry1_hit|entry2_hit|entry3_hit);

//主状态机
always@(posedge clk)begin
	if(rst)begin
		main_state	<=	stb;
	end
	else begin
		case(main_state)
			stb			:	if(cache_miss)begin		//如果可以被缓存，那么就进入缓存；如果不能被缓存，那就进行单次读写
								main_state	<=	cacheable ? read_line : (read|execute) ? read_singal : write_singal;
							end
							else if(write)begin		//如果是读操作，那单次读
								main_state	<=	write_singal;
							end
			read_line	:	main_state	<=	bus_error ? access_fault : trans_rdy ? stb : main_state;
			read_singal	:	main_state	<=	bus_error ? access_fault : trans_rdy ? stb : main_state;
			write_singal:   main_state	<=	bus_error ? access_fault : trans_rdy ? stb : main_state;
			access_fault:	main_state	<=	stb;
			default		:	main_state	<=	stb;
		endcase
	end
end

//cache表
//cache_entry0
cache_entry		cache_entry0(
.clk				(clk),
.rst				(rst),
.L1_clear			(L1_clear),

.pa_in				(addr_pa),
.pa_out				(entry0_pa_out),
.access_ready		(access_ready&entry0_hit),

.access_count		(entry0_access_count),
.valid				(entry0_valid),
.cache_entry_write	(cache_entry0_write)
);
//cache_entry1
cache_entry		cache_entry1(
.clk				(clk),
.rst				(rst),
.L1_clear			(L1_clear),

.pa_in				(addr_pa),
.pa_out				(entry1_pa_out),
.access_ready		(access_ready&entry1_hit),

.access_count		(entry1_access_count),
.valid				(entry1_valid),
.cache_entry_write	(cache_entry1_write)
);
//cache_entry0
cache_entry		cache_entry2(
.clk				(clk),
.rst				(rst),
.L1_clear			(L1_clear),

.pa_in				(addr_pa),
.pa_out				(entry2_pa_out),
.access_ready		(access_ready&entry2_hit),

.access_count		(entry2_access_count),
.valid				(entry2_valid),
.cache_entry_write	(cache_entry2_write)
);
//cache_entry0
cache_entry		cache_entry3(
.clk				(clk),
.rst				(rst),
.L1_clear			(L1_clear),

.pa_in				(addr_pa),
.pa_out				(entry3_pa_out),
.access_ready		(access_ready&entry3_hit),

.access_count		(entry3_access_count),
.valid				(entry3_valid),
.cache_entry_write	(cache_entry3_write)
);

//替换选择逻辑
//这里用TLB选择逻辑进行偷工减料,只需要把G连线为0即可
TLB_line_select Cache_line_select(
//entry0
.entry0_valid		(entry0_valid),			//该TLB entry有效
.entry0_acc_count	(entry0_access_count),	//访问计数
.entry0_PTE_G		(1'b0),				
//entry1
.entry1_valid		(entry1_valid),			//该TLB entry有效
.entry1_acc_count	(entry1_access_count),	//访问计数
.entry1_PTE_G		(1'b0),				
//entry2
.entry2_valid		(entry2_valid),			//该TLB entry有效
.entry2_acc_count	(entry2_access_count),	//访问计数
.entry2_PTE_G		(1'b0),				
//entry3
.entry3_valid		(entry3_valid),			//该TLB entry有效
.entry3_acc_count	(entry3_access_count),	//访问计数
.entry3_PTE_G		(1'b0),				

//选出的替换页
.entry_select		(entry_select)

);


//缓存控制信号	
byte_sel	byte_sel_unit(
.addr		(addr_pa[2:0]),	//address
.size		(size),	//0001=1Byte;0010=2Byte;0100=4Byte;1000=8Byte
.mask		((main_state==read_line)),	//当进行L1连续行写入时，打开掩码
.bsel		(byte_sel)
);
//当对内存读写成功，cache才可以被写入
assign cache_write	=	write & trans_rdy;
assign di			=	(main_state==read_line) ? line_data : data_write;
//如果是不可缓存的数据，直接将line data打入内部
assign data_read	=	cache_only?dout:(main_state==read_singal) ? line_data	: dout; 	

//缓存块选择
//00 = 0x
assign read_block_sel[1]	= entry2_hit | entry3_hit;
assign read_block_sel[0]	= entry1_hit | entry3_hit;	

//生成cache line写入地址
assign write_block_sel[1]	= entry_select[2] | entry_select[3];
assign write_block_sel[0]	= entry_select[1] | entry_select[3];		
//生成缓存地址
//读地址由命中情况生成
assign read_addr	=	{read_block_sel,addr_pa[10:0]};
//写地址由当前是否处在缓存行更新阶段生成，如果缓存行没有被更新，地址是正常地址
assign write_addr	=	(main_state==read_line) ? {write_block_sel,addr_count} : read_addr;
//如果是进行行更新，写入信号切换到外部cache控制器
assign we	=	(main_state==read_line) ? line_write : cache_write;

//L1缓存
cache l1
(
    .raddr	(read_addr),
    .waddr	(write_addr),
    .di		(di),
    .we		(we),
    .bsel	(byte_sel),
    .do		(dout),
    .clk	(clk)
);
//准备好信号
assign cache_data_ready	=	(entry0_hit | entry1_hit | entry2_hit | entry3_hit) & (read | execute | write&trans_rdy);
assign uncache_data_ready=	(main_state==read_singal) & trans_rdy;
//访问失败信号
assign load_acc_fault	=	(main_state==access_fault) & read;
assign store_acc_fault	=	(main_state==access_fault) & write;
assign ins_acc_fault	=	(main_state==access_fault) & execute;

//cache控制器逻辑
assign write_through_req=	(main_state==write_singal);	//请求写穿
assign read_req			=	(main_state==read_singal);			//请求读一次
assign read_line_req	=	(main_state==read_line);		//请求读一行
assign L1_size	=	size;
				//如果命中，使用的是该项的基地址+缓存内偏移，如果没有命中，则使用输出的pa来进行读缓存行
assign pa	=	addr_pa;
/*(entry0_hit ? {entry0_pa_out[63:11],addr_pa[10:0]} : 64'b0) |
				(entry1_hit ? {entry1_pa_out[63:11],addr_pa[10:0]} : 64'b0) |
				(entry2_hit ? {entry2_pa_out[63:11],addr_pa[10:0]} : 64'b0) |
				(entry3_hit ? {entry3_pa_out[63:11],addr_pa[10:0]} : 64'b0) | 
				(cache_miss	?	addr_pa							   : 64'b0);*/
assign wt_data=		data_write;	
		
		
		
		
endmodule		
		
		
		
		