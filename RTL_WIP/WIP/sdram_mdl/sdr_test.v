`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.11
// Design Name	: 
// Module Name	: sdr_test
// Project Name	: 
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: 
//				
// Revision		: V1.0
// Additional Comments	:  
// 
////////////////////////////////////////////////////////////////////////////////
module sdr_test(
				clk,rst_n,
				sdram_clk,sdram_cke,sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n,
				sdram_ba,sdram_addr,sdram_data,//sdram_udqm,sdram_ldqm	
				rs232_tx,
	/*			sdram_rd_req,sdram_wr_ack,sdram_rd_ack,
				sys_data_out,sdram_busy,sys_data_in,sys_dout_rdy,
			*/	rdf_dout/*,rdf_rdreq*/
			);

input clk;			//系统时钟，100MHz
input rst_n;		//复位信号，低电平有效

	// FPGA与SDRAM硬件接口
output sdram_clk;			//	SDRAM时钟信号
output sdram_cke;			//  SDRAM时钟有效信号
output sdram_cs_n;			//	SDRAM片选信号
output sdram_ras_n;			//	SDRAM行地址选通脉冲
output sdram_cas_n;			//	SDRAM列地址选通脉冲
output sdram_we_n;			//	SDRAM写允许位
output[1:0] sdram_ba;		//	SDRAM的L-Bank地址线
output[11:0] sdram_addr;	//  SDRAM地址总线
//output sdram_udqm;			// SDRAM高字节屏蔽
//output sdram_ldqm;			// SDRAM低字节屏蔽
inout[15:0] sdram_data;		// SDRAM数据总线

output rs232_tx;		//RS232发送数据信号

////////////////////////////////////////////////
	// SDRAM的封装接口测试引出
/*output sdram_rd_req;			//系统读SDRAM请求信号
output sdram_wr_ack;		//系统写SDRAM响应信号
output sdram_rd_ack;		//系统读SDRAM响应信号	
output[15:0] sys_data_in;	//写SDRAM时数据暂存器，4个突发读写字数据，默认为00地址bit15-0;01地址bit31-16;10地址bit47-32;11地址bit63-48

output[15:0] sys_data_out;	//读SDRAM时数据暂存器,(格式同上)
output sdram_busy;			// SDRAM忙标志，高表示SDRAM处于工作中
output sys_dout_rdy;			// SDRAM数据输出完成标志
*/
output[15:0] rdf_dout;		//sdram数据读出缓存FIFO输出数据总线	
//output rdf_rdreq;			//sdram数据读出缓存FIFO数据输出请求，高有效

////////////////////////////////////////////////


	// SDRAM的封装接口
wire sdram_wr_req;			//系统写SDRAM请求信号
wire sdram_rd_req;			//系统读SDRAM请求信号
wire sdram_wr_ack;			//系统写SDRAM响应信号,作为wrFIFO的输出有效信号
wire sdram_rd_ack;			//系统读SDRAM响应信号,作为rdFIFO的输写有效信号	
wire[21:0] sys_addr;		//读写SDRAM时地址暂存器，(bit21-20)L-Bank地址:(bit19-8)为行地址，(bit7-0)为列地址 
wire[15:0] sys_data_in;		//写SDRAM时数据暂存器

wire[15:0] sys_data_out;	//sdram数据读出缓存FIFO输入数据总线
wire sdram_busy;			// SDRAM忙标志，高表示SDRAM处于工作中
wire sys_dout_rdy;			// SDRAM数据输出完成标志

	//wrFIFO输入控制接口
wire[15:0] wrf_din;		//sdram数据写入缓存FIFO输入数据总线
wire wrf_wrreq;			//sdram数据写入缓存FIFO数据输入请求，高有效
	//rdFIFO输出控制接口
wire[15:0] rdf_dout;		//sdram数据读出缓存FIFO输出数据总线	
wire rdf_rdreq;			//sdram数据读出缓存FIFO数据输出请求，高有效

	//系统控制相关信号接口
wire clk_25m;	//PLL输出25MHz时钟
wire clk_100m;	//PLL输出100MHz时钟
wire sys_rst_n;	//系统复位信号，低有效


//------------------------------------------------
//例化系统复位信号和PLL控制模块
sys_ctrl		uut_sysctrl(
					.clk(clk),
					.rst_n(rst_n),
					.sys_rst_n(sys_rst_n),
					.clk_25m(clk_25m),
					.clk_100m(clk_100m),
					.sdram_clk(sdram_clk)
					);

//------------------------------------------------
//例化SDRAM封装控制模块
sdram_top		uut_sdramtop(				// SDRAM
							.clk(clk_100m),
							.rst_n(sys_rst_n),
							.sdram_wr_req(sdram_wr_req),
							.sdram_rd_req(sdram_rd_req),
							.sdram_wr_ack(sdram_wr_ack),
							.sdram_rd_ack(sdram_rd_ack),	
							.sys_addr(sys_addr),
							.sys_data_in(sys_data_in),
							.sys_data_out(sys_data_out),
							.sys_dout_rdy(sys_dout_rdy),
							//.sdram_clk(sdram_clk),
							.sdram_busy(sdram_busy),
							.sdram_cke(sdram_cke),
							.sdram_cs_n(sdram_cs_n),
							.sdram_ras_n(sdram_ras_n),
							.sdram_cas_n(sdram_cas_n),
							.sdram_we_n(sdram_we_n),
							.sdram_ba(sdram_ba),
							.sdram_addr(sdram_addr),
							.sdram_data(sdram_data)
						//	.sdram_udqm(sdram_udqm),
						//	.sdram_ldqm(sdram_ldqm)
					);
	

//------------------------------------------------
//读写SDRAM数据缓存FIFO模块例化	
sdfifo_ctrl			uut_sdffifoctrl(
						.clk_25m(clk_25m),
						.clk_100m(clk_100m),
						.wrf_din(wrf_din),
						.wrf_wrreq(wrf_wrreq),
						.sdram_wr_ack(sdram_wr_ack),
						//.sys_addr(sys_addr),
						.sys_data_in(sys_data_in),
						.sdram_wr_req(sdram_wr_req),
						.sys_data_out(sys_data_out),
						.rdf_rdreq(rdf_rdreq),
						.sdram_rd_ack(sdram_rd_ack),
						.rdf_dout(rdf_dout),
						.sdram_rd_req(sdram_rd_req),
						.syswr_done(syswr_done),
						.tx_start(tx_start)		
						);	
						
//------------------------------------------------
//例化模拟写入数据到sdram模块
wire syswr_done;		//所有数据写入sdram完成标志位
datagene			uut_datagene(
						.clk(clk_25m),
						.rst_n(sys_rst_n),
						.wrf_din(wrf_din),
						.wrf_wrreq(wrf_wrreq),
						.moni_addr(sys_addr),
						.syswr_done(syswr_done),
						.sdram_rd_ack(sdram_rd_ack)
					);


//------------------------------------------------
//例化串口数据发送控制模块
wire tx_start;		//串口发送数据启动标志位，高有效
uart_ctrl		uut_uartctrl(
					.clk(clk_25m),
					.rst_n(sys_rst_n),
					.tx_data(rdf_dout[7:0]),
					.tx_start(tx_start),		///////////
					.fifo232_rdreq(rdf_rdreq),
					.rs232_tx(rs232_tx)
					);

endmodule
