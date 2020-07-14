`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.04
// Design Name	: 
// Module Name	: uart_speed_select
// Project Name	: sdrsvgaprj
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: 串口数据发送波特率控制模块
//				
// Revision		: V1.0
// Additional Comments	:  
// 
////////////////////////////////////////////////////////////////////////////////
module uart_speed_select(
				clk,rst_n,
				bps_start,clk_bps
			);

input clk;			// 25MHz时钟
input rst_n;		//低电平复位信号
input bps_start;	//波特率时钟计数器启动信号，高有效
output clk_bps;		//发送数据标志位，高有效

/*
`define 	bps9600 		5207/2	//波特率为9600bps
`define	 	bps19200 		2603/2	//波特率为19200bps
`define		bps38400 		1301/2	//波特率为38400bps
`define		bps57600 		867/2	//波特率为57600bps
`define		bps115200		433/2	//波特率为115200bps

`define 	bps9600_2 		2603/2
`define		bps19200_2		1301/2
`define		bps38400_2		650/2
`define		bps57600_2		433/2
`define		bps115200_2		216/2 
*/

	//以下波特率分频计数值可参照上面的参数进行更改
`define		BPS_PARA		2604	//波特率为9600时的分频计数值
`define 	BPS_PARA_2		1302		//波特率为9600时的分频计数值的一半，用于数据采样

//----------------------------------------------------------
//----------------------------------------------------------
reg[12:0] cnt;			//分频计数器
reg clk_bps_r;			//波特率数据改变标志位
reg[2:0] uart_ctrl;		// uart波特率选择寄存器


always @ (posedge clk or negedge rst_n)
	if(!rst_n) cnt <= 13'd0;
	else if(cnt == `BPS_PARA) cnt <= 13'd0;	//波特率计数溢出后清零
	else if(bps_start) cnt <= cnt+1'b1;		//波特率时钟计数启动
	else cnt <= 13'd0;		//波特率计数停止

always @ (posedge clk or negedge rst_n)
	if(!rst_n) clk_bps_r <= 1'b0;
	else if(cnt == `BPS_PARA_2) clk_bps_r <= 1'b1;	// clk_bps_r高电平作为发送数据的数据改变点
	else clk_bps_r <= 1'b0;

assign clk_bps = clk_bps_r;

endmodule



