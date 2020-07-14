`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.04
// Design Name	: 
// Module Name	: uart_tx
// Project Name	: sdrsvgaprj
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: 串口数据发送底层模块
//					1bit起始位+8bit数据+1bit停止位
// Revision		: V1.0
// Additional Comments	:  
// 
////////////////////////////////////////////////////////////////////////////////
module uart_tx(
				clk,rst_n,
				tx_data,tx_start,clk_bps,
				rs232_tx,bps_start,fifo232_rdreq
			);

input clk;			// 25MHz主时钟
input rst_n;		//低电平复位信号
input[7:0] tx_data;	//待发送数据
input tx_start;		//串口发送数据启动标志位，高有效
input clk_bps;		//发送数据标志位，高有效

output rs232_tx;	// RS232发送数据信号
output bps_start;	//波特率时钟计数器启动信号,高有效
output fifo232_rdreq;	//FIFO读请求信号，高有效

//---------------------------------------------------------
reg tx_en;			//发送数据使能信号，高有效
reg[3:0] num;

always @ (posedge clk or negedge rst_n)
	if(!rst_n) tx_en <= 1'b0;
	else if(num==4'd11) tx_en <= 1'b0;	//数据发送完成			
	else if(tx_start) tx_en <= 1'b1;	//进入发送数据状态中

assign bps_start = tx_en;

//tx_en脉冲上升沿检测，作为FIFO读使能信号
reg tx_enr1,tx_enr2;	//tx_en寄存器
always @(posedge clk or negedge rst_n)
	if(!rst_n) begin
			tx_enr1 <= 1'b1;
			tx_enr2 <= 1'b1;
		end
	else begin
			tx_enr1 <= tx_en;
			tx_enr2 <= tx_enr1;
		end

assign fifo232_rdreq = tx_enr1 & ~tx_enr2;	//tx_en上升沿置高一个时钟周期

//---------------------------------------------------------
reg rs232_tx_r;		// RS232发送数据信号

always @ (posedge clk or negedge rst_n)
	if(!rst_n) begin
			num <= 4'd0;
			rs232_tx_r <= 1'b1;
		end
	else if(tx_en) begin
			if(clk_bps)	begin
					num <= num+1'b1;
					case (num)
						4'd0: rs232_tx_r <= 1'b0; 	//发送起始位
						4'd1: rs232_tx_r <= tx_data[0];	//发送bit0
						4'd2: rs232_tx_r <= tx_data[1];	//发送bit1
						4'd3: rs232_tx_r <= tx_data[2];	//发送bit2
						4'd4: rs232_tx_r <= tx_data[3];	//发送bit3
						4'd5: rs232_tx_r <= tx_data[4];	//发送bit4
						4'd6: rs232_tx_r <= tx_data[5];	//发送bit5
						4'd7: rs232_tx_r <= tx_data[6];	//发送bit6
						4'd8: rs232_tx_r <= tx_data[7];	//发送bit7
						4'd9: rs232_tx_r <= 1'b1;	//发送结束位
					 	default: rs232_tx_r <= 1'b1;
						endcase
				end
			else if(num==4'd11) num <= 4'd0;	//复位,实际发送一个数据时间为10.5个波特率时钟周期
		end

assign rs232_tx = rs232_tx_r;



endmodule
