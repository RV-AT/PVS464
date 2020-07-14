`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.11
// Design Name	: 
// Module Name	: sdfifo_ctrl
// Project Name	: 
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: SDRAM fifo控制模块						
//				
// Revision		: V1.0
// Additional Comments	:  
// 
////////////////////////////////////////////////////////////////////////////////
module sdfifo_ctrl(
				clk_25m,clk_100m,
				wrf_din,wrf_wrreq,
				sdram_wr_ack,/*sys_addr,*/sys_data_in,sdram_wr_req,
				sys_data_out,rdf_rdreq,sdram_rd_ack,rdf_dout,sdram_rd_req,
				syswr_done,tx_start
			);

input clk_25m;	//PLL输出25MHz时钟
input clk_100m;	//PLL输出100MHz时钟

	//wrfifo
input[15:0] wrf_din;		//sdram数据写入缓存FIFO输入数据总线
input wrf_wrreq;			//sdram数据写入缓存FIFO数据输入请求，高有效
input sdram_wr_ack;			//系统写SDRAM响应信号,作为wrFIFO的输出有效信号

//output[21:0] sys_addr;		//读写SDRAM时地址暂存器，(bit21-20)L-Bank地址:(bit19-8)为行地址，(bit7-0)为列地址 
output[15:0] sys_data_in;	//sdram数据写入缓存FIFO输出数据总线，即写SDRAM时数据暂存器
output sdram_wr_req;		//系统写SDRAM请求信号

	//rdfifo
input[15:0] sys_data_out;	//sdram数据读出缓存FIFO输入数据总线
input rdf_rdreq;			//sdram数据读出缓存FIFO数据输出请求，高有效
input sdram_rd_ack;			//系统读SDRAM响应信号,作为rdFIFO的输写有效信号

output[15:0] rdf_dout;		//sdram数据读出缓存FIFO输出数据总线
output sdram_rd_req;		//系统读SDRAM请求信号

input syswr_done;		//所有数据写入sdram完成标志位
output tx_start;		//串口发送数据启动标志位，高有效

//------------------------------------------------
wire[8:0] wrf_use;			//sdram数据写入缓存FIFO已用存储空间数量
wire[8:0] rdf_use;			//sdram数据读出缓存FIFO已用存储空间数量	

//assign sys_addr = 22'h1a9e21;	//测试用
assign sdram_wr_req = ((wrf_use >= 9'd8) & ~syswr_done);	//FIFO（8个16bit数据）即发出写SDRAM请求信号
assign sdram_rd_req = ((rdf_use <= 9'd256) & syswr_done);	//sdram写入完成且FIFO半空（256个16bit数据）即发出读SDRAM请求信号
assign tx_start = ((rdf_use != 9'd0) & syswr_done);		//启动串口发送数据

//------------------------------------------------
//例化SDRAM写入数据缓存FIFO模块
wrfifo			uut_wrfifo(
					.data(wrf_din),
					.rdclk(clk_100m),
					.rdreq(sdram_wr_ack),
					.wrclk(clk_25m),
					.wrreq(wrf_wrreq),
					.q(sys_data_in),
					.wrusedw(wrf_use)
					);	

//------------------------------------------------
//例化SDRAM读出数据缓存FIFO模块
rdfifo			uut_rdfifo(
					.data(sys_data_out),
					.rdclk(clk_25m),
					.rdreq(rdf_rdreq),
					.wrclk(clk_100m),
					.wrreq(/*rdf_wrreq*/sdram_rd_ack),
					.q(rdf_dout),
					.wrusedw(rdf_use)
					);	

endmodule
