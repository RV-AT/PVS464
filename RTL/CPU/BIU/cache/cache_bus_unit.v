/*
用于cache操作的总线单元
*/
module cache_bus_unit(
input wire clk,
input wire rst,

//cache控制器逻辑
input wire write_through_req,	//请求写穿
input wire read_req,			//请求读一次
input wire read_line_req,		//请求读一行
input wire [3:0]size,
input wire [63:0]pa,			//
input wire [63:0]wt_data,
output wire [63:0]line_data,
output wire [10:0]addr_count,
output wire line_write,			//cache写
output wire cache_entry_write,	//更新缓存entry
output wire trans_rdy,			//传输完成
output wire bus_error,			//访问失败

//AHB总线
//ahb
//ahb
output wire[63:0]haddr,
output wire hwrite,
output wire[2:0]hsize,
output [2:0]hburst,
output [3:0]hprot,
output [1:0]htrans,
output hmastlock,
output reg[63:0]hwdata,

input wire hready,
input wire hresp,
input wire hreset_n,
input wire [63:0]hrdata,

input wire bus_ack,		//总线允许使用
output wire bus_req		//总线请求使用

);
//ahb操作
parameter nseq = 2'b10;
parameter idle = 2'b00;
parameter seq  = 2'b11;


//ahb burst
parameter Single=3'b000;
parameter INCR  =3'b001;
//主状态机
parameter stb  = 4'b0000;
parameter pacov= 4'b0001;		//页面转换，进行此操作时AHB总线交给MMU控制
parameter wr0  = 4'b0010;
parameter wr1  = 4'b0011;
parameter rd0  = 4'b0100;
parameter rd1  = 4'b0101;
parameter rd_b0= 4'b1001;		//read burst 批量读入，阶段0，使用一个nseq开启seq传输
parameter rd_b1= 4'b1010;		//read burst 阶段1，使用seq连续传输，直到最后一个地址
parameter rd_b2= 4'b1011;		//read burst 阶段2，末尾最后一个数据传输

parameter acc_fault=4'b11111;	//访问失败

reg [3:0]statu;					//状态机

reg [7:0]addr_counter;				//偏移地址计数器
reg [63:0]haddr_temp;
wire [7:0]last_addr;				//cache地址寄存器，在写入模式下需要利用该寄存器延迟一拍


//主状态机萝莉
always@(posedge clk)begin
	if(rst)begin
		statu <= stb;
	end
	else begin
		case(statu)
			//当请求占用总线时，bus unit等待
			stb:				if(!bus_ack)begin
									statu	<=	statu;
								end
								else if(read_line_req)begin
									statu	<=	rd_b0;
								end
								else if(read_req)begin
									statu	<=	rd0;
								end
								else if(write_through_req)begin
									statu	<=	wr0;
								end
				
			//连续读read burst
			rd_b0:	statu <= rd_b1;
			//单次写，打出TRANS和HBURST
			wr0:	statu <= wr1;
			//单次读
			rd0:	statu <= rd1;

			//当传输到最后一个数据时候，停止传输，并等待传输完成
			rd_b1:	statu <= hresp?acc_fault:((addr_counter==8'b111111111)&hready)?rd_b2:statu;		//特别注意，同步内存写入不需要延迟一个clk，但是读出需要延迟一个clk
			wr1:	statu <= hresp?acc_fault:hready?stb:statu;
			rd1:	statu <= hresp?acc_fault:hready?stb:statu;
	
	//状态机第三层
			rd_b2:	statu <= hresp?acc_fault:hready?stb:statu;
	
	//状态机第四层
		acc_fault:	statu <= stb;
			default: statu<= stb;
		endcase
	end	
end

//addr_counter
//addr_counter在计到顶之后停止计数,并等待状态回到stb进行清零
always@(posedge clk)begin
	if(rst|(statu==stb))begin
		addr_counter <= 8'b0;
	end
	
	else if(addr_counter==8'b111111111)begin
		addr_counter <= addr_counter;
	end
	else if((statu==rd_b0)|(statu==rd_b1))begin
		addr_counter <= hready?(addr_counter + 8'b1):addr_counter;
	end
end	
assign last_addr 	= addr_counter - 8'b1;
//从cache写入到内存里的时候，因为同步储存器读取需要一个clk的延迟，故在sync且准备好时候始终保持cache_counter和addr_counter一致
//由于AHB总线总是在第二个周期给出应答信号，此时addr counter已经自动+1，故切换到上一个地址
//
assign line_write = ((statu==rd_b1)|(statu==rd_b2))?hready:1'b0;
assign addr_count	= (statu==rd_b2) ? {addr_counter,3'b0} : {last_addr,3'b0};

//AHB总线
//AHB输出寄存器
always@(posedge clk)begin
	if(rst)begin
		hwdata		<=	64'b0;
		haddr_temp	<=	64'b0;
	end
	else if(statu==stb)begin
		hwdata		<=	wt_data;
		haddr_temp	<=	pa;
	end
end

assign haddr	=	read_line_req ? {haddr_temp[63:11],addr_counter,3'b0} : haddr_temp;
assign hwrite	= (statu==wr0);

assign hsize[0]	= size[1] | size[3];
assign hsize[1]	= size[2] | size[3];
assign hsize[2] = 1'b0;

assign hburst= ((statu==wr0)|(statu==rd0))?Single:((statu==rd_b0)|(statu==rd_b1))?INCR:Single;
assign hprot = 4'b0011;
assign htrans= ((statu==wr0)|(statu==rd0)|(statu==rd_b0))?nseq:((statu==rd_b1))?seq:idle;	//Burst传输第一个是NSEQ
assign hmastlock= 1'b0;

//cache控制器逻辑

assign line_data			=	hrdata;
assign cache_entry_write	=	trans_rdy & read_line_req;	//更新缓存entry
assign trans_rdy			=	((statu==rd1)|(statu==wr1)|(statu==rd_b2))?hready:1'b0;		//传输完成
assign bus_error			=	(statu==acc_fault);			//访问失败
assign bus_req				=	write_through_req | read_line_req | read_req;



endmodule













