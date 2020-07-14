`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.12
// Design Name	: 
// Module Name	: datagene
// Project Name	: 
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: 模拟写入数据到sdram模块
//				
// Revision		: V1.0
// Additional Comments	:  
// 
////////////////////////////////////////////////////////////////////////////////
module datagene(
				clk,rst_n,
				wrf_din,wrf_wrreq,
				moni_addr,syswr_done,
				sdram_rd_ack
			);

input clk;		//FPAG输入时钟信号25MHz
input rst_n;	//FPGA输入复位信号

	//wrFIFO输入控制接口
output[15:0] wrf_din;		//sdram数据写入缓存FIFO输入数据总线
output wrf_wrreq;			//sdram数据写入缓存FIFO数据输入请求，高有效

output[21:0] moni_addr;	//sdram读写地址产生
output syswr_done;		//所有数据写入sdram完成标志位

input sdram_rd_ack;			//系统读SDRAM响应信号,作为rdFIFO的输写有效信号,这里捕获它的下降沿作为读地址自增加标志位

reg sdr_rdackr1,sdr_rdackr2;

//------------------------------------------
//捕获sdram_rd_ack下降沿标志位
always @(posedge clk or negedge rst_n)		
		if(!rst_n) begin
				sdr_rdackr1 <= 1'b0;
				sdr_rdackr2 <= 1'b0;
			end
		else begin
				sdr_rdackr1 <= sdram_rd_ack;
				sdr_rdackr2 <= sdr_rdackr1;				
			end

wire neg_rdack = ~sdr_rdackr1 & sdr_rdackr2;

//------------------------------------------
//上电500us延时等待sdram就绪
reg[13:0] delay;	//500us延时计数器

always @(posedge clk or negedge rst_n)
	if(!rst_n) delay <= 14'd0;
	else if(delay < 14'd12500) delay <= delay+1'b1;

wire delay_done = (delay == 14'd12500);	//1ms延时结束

//------------------------------------------
//每640ns写入8个16bit数据到sdram，
//上电后所有地址写入完毕时间需要不到360ms时间
reg[5:0] cntwr;	//写sdram定时计数器

always @(posedge clk or negedge rst_n)
	if(!rst_n) cntwr <= 6'd0;
	else if(delay_done) cntwr <= cntwr+1'b1;

//------------------------------------------
//读写sdram地址产生
reg[18:0] addr;		//sdram地址寄存器

always @(posedge clk or negedge rst_n)
	if(!rst_n) addr <= 19'd0;
	else if(!wr_done && cntwr == 6'h3f) addr <= addr+1'b1;//写地址产生
	else if(wr_done && neg_rdack) addr <= addr+1'b1;	//读地址产生	////////////test

assign moni_addr = {addr,3'b000};

reg wr_done;	//所有数据写入sdram完成标志位
always @(posedge clk or negedge rst_n)
	if(!rst_n) wr_done <= 1'b0;
	else if(addr == 19'h7ffff) wr_done <= 1'b1;

assign syswr_done = wr_done;

//------------------------------------------
//写sdram请求信号产生，即wrfifo的写入有效信号
reg wrf_wrreqr;		//wrfifo的写入有效信号
reg[15:0] wrf_dinr;	//wrfifo的写入数据

always @(posedge clk or negedge rst_n)
	if(!rst_n) wrf_wrreqr <= 1'b0;
	else if(!wr_done) begin	//上电0.5ms延时完成
		if(cntwr == 6'h05) wrf_wrreqr <= 1'b1;	//写请求信号产生
		else if(cntwr == 6'h0d) wrf_wrreqr <= 1'b0;	//请求信号撤销
	end

always @(posedge clk or negedge rst_n)
	if(!rst_n) wrf_dinr <= 16'd0;
	else if(!wr_done && ((cntwr > 6'h05) && (cntwr <= 6'h0d))) begin	//上电0.5ms延时完成
			wrf_dinr <= wrf_dinr+1'b1;	//写入数据递增
		end
	
assign wrf_wrreq = wrf_wrreqr;
assign wrf_din = wrf_dinr;


endmodule
