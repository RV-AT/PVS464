`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.04
// Design Name	: 
// Module Name	: uart_ctrl
// Project Name	: sdrsvgaprj
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: 串口数据发送控制模块
//				
// Revision		: V1.0
// Additional Comments	:  
// 
////////////////////////////////////////////////////////////////////////////////
module uart_ctrl(
				clk,rst_n,
				tx_data,tx_start,
				fifo232_rdreq,
				rs232_tx
			);

input clk;			// 25MHz主时钟
input rst_n;		//低电平复位信号
input[7:0] tx_data;	//待发送数据
input tx_start;		//串口发送数据启动标志位，高有效

output fifo232_rdreq;	//FIFO读请求信号，高有效
output rs232_tx;		//RS232发送数据信号

//----------------------------------------------------------------
	//串口发送底层模块和串口波特率选择模块接口
wire clk_bps;		//发送数据标志位，高有效
wire bps_start;		//波特率时钟计数器启动信号,高有效

//----------------------------------------------------------------
//例化串口数据发送底层模块
uart_tx		uut_tx(
				.clk(clk),
				.rst_n(rst_n),
				.tx_data(tx_data),
				.tx_start(tx_start),
				.clk_bps(clk_bps),
				.rs232_tx(rs232_tx),
				.bps_start(bps_start),
				.fifo232_rdreq(fifo232_rdreq)				
				);

//例化串口数据发送波特率控制模块
uart_speed_select		uut_ss(
							.clk(clk),
							.rst_n(rst_n),
							.bps_start(bps_start),
							.clk_bps(clk_bps)
							);


endmodule
