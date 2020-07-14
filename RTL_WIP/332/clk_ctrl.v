/*
适用于ahb_spi_v0的时钟控制器
提供SPI分频
SPI准备好信号同步
*/
module clk_ctrl(
input wire clk,
input wire rst,
input wire rtx_ok,
input wire rx_ok,
input wire tx_ok,
//分频系数
input wire [15:0]divclk,
//经过时钟同步之后的信号
output wire rtx_done,
output wire rx_done,
output wire tx_done,
//分频之后的信号
output reg clk_div

);
reg [1:0]rtx_statu;
reg [1:0]rx_statu;
reg [1:0]tx_statu;
//分频计数器
reg [15:0]counter;

always@(posedge clk)begin
	if(rst)begin
		clk_div <= 1'b0;
		counter <= 16'b0;
	end
	else begin
		clk_div <= (counter==divclk)? !clk_div : clk_div;
		counter <= (counter==divclk)? 16'b0:counter+16'd1;
	end
end

//检查rtx_ok的上升沿信号
always@(posedge clk)begin
	if(rst)begin

		rtx_statu <= 2'b0;

	end
	else if(rtx_statu==2'b00)begin
		rtx_statu <= rtx_ok?2'b01 : rtx_statu;
	end
	else if(rtx_statu==2'b01)begin
		rtx_statu <= 2'b10;
	end
	else if(rtx_statu==2'b10)begin
		rtx_statu <= !rtx_ok?2'b00:rtx_statu;
	end
end
assign rtx_done = (rtx_statu==2'b01);		
		
//检查rx_ok的上升沿信号
always@(posedge clk)begin
	if(rst)begin

		rx_statu <= 2'b0;

	end
	else if(rx_statu==2'b00)begin
		rx_statu <= rx_ok?2'b01 : rx_statu;
	end
	else if(rx_statu==2'b01)begin
		rx_statu <= 2'b10;
	end
	else if(rx_statu==2'b10)begin
		rx_statu <= !rx_ok?2'b00:rx_statu;
	end
end
assign rx_done = (rx_statu==2'b01);		
		
//检查tx_ok的上升沿信号
always@(posedge clk)begin
	if(rst)begin

		tx_statu <= 2'b0;

	end
	else if(tx_statu==2'b00)begin
		tx_statu <= tx_ok?2'b01 : tx_statu;
	end
	else if(tx_statu==2'b01)begin
		tx_statu <= 2'b10;
	end
	else if(tx_statu==2'b10)begin
		tx_statu <= !tx_ok?2'b00:tx_statu;
	end
end
assign tx_done = (tx_statu==2'b01);		
		
		
endmodule
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	
	
	
	
	
	
	
	
	
	
