/*

适用于PSoC32V0处理器的AHB-SPI收发器，只支持AHB总线上的IDLE,NSEQ传输
SPI支持模式0，1Kbps-12Mbps速率调节

欢迎使用AHB-SPI收发器！
该收发器只支持AHB总线的NSEQ和IDLE传输，并且只支持SPI模式0。
SPI收发器输入端有个地址配置接口，正常使用的时候请对该接口连接到一个固定地址并且确保低2位为0，以确保该收发器能正常工作。
当且仅当输入地址满足：输入地址在配置地址到配置地址+12字节的范围内，且HSEL选中，收发器寄存器可用。

该SPI收发器寄存器地址：
addr_cfg 到 addr_cfg+3是spi_cfg寄存器，该寄存器包括：
[31:16]:寄存器波特率配置参数，波特率 = 1/{（该寄存器的值+1）*4} * 50MHz
[15:13]:额外的外部设备片选信号，可以节约IO，该寄存器的值被输入到ssel引脚，和CS信号共同控制一片外部的74HS138进行多设备操作，如果只有一个SPi设备，可以接138.
[12:6]:保留，无意义
[5]:RTXOK，即收发OK，在完成一次收发之后自动置1，当程序对RTX位置1时候，这个位自动变为0直到收发完成。
[4]:RXOK，即收OK，在完成一次收之后自动置1，当程序对RX位置1时候，这个位自动变为0直到收完成
[3]:TXOK，如法炮制
[2]:RTX：收发使能位，当程序对这个位置1时候，收发器开始收发，收发完成之后自动清零
[1]:RX: 收使能，如上
[0]:TX: 发使能

addr_cfg+4到addr_cfg+7是spi_tx_data,这里存放的时候要发送的数据。
addr_cfg+8到addr_cfg+11是spi_rx_data,这里存放的是收到的数据

注意！以上寄存器在RTXOK，TXOK，RXOK之前不能更改，否则会造成数据错误。

*/
module ahb_spi_v0(
//地址配置
input wire [31:0]addr_cfg,
//ahb总线接口
input wire hsel,
input wire [31:0]haddr,
input wire hwrite,
input wire [2:0]hsize,
input wire [2:0]hburst,
input wire [3:0]hprot,
input wire [1:0]htrans,
input wire hmastlock,
input wire [31:0]hwdata,
input wire hresetn,
input wire hclk,

output wire hreadyout,
output wire hresp,
output wire [31:0]hrdata,
//SPI接口
//从设备选择，如果需要用的话外接一片74LS138作为从设备选择
output wire [2:0]ssel,
output wire cs,
//时钟极性
output wire cpol,
//时钟相位
output wire cpha,

output wire sck,
output wire mosi,
input wire miso
);
parameter  nsq = 2'b10;
parameter idle = 2'b00;
parameter t8   = 3'b000;
parameter t16  = 3'b001;
parameter t32  = 3'b010;

wire tx_ok;
wire rx_ok;
wire rtx_ok;
wire clk_div;

wire tx_done;
wire rx_done;
wire rtx_done;

reg [31:0]addr;

reg [31:0]spi_cfg;
reg [7:0]spi_tx_data;
wire [31:0]spi_rx_data;
//AHB状态信号
reg statu;
//寄存器选择信号
wire spi_cfg_sel;
wire spi_tx_data_sel;
wire spi_rx_data_sel;
//寄存器选择信号寄存
reg r_spi_cfg_sel;
reg r_spi_tx_data_sel;
reg r_spi_rx_data_sel;
//寄存器写有效信号
reg spi_cfg_write;
reg [2:0]write_size;
reg spi_tx_data_write;
//寄存器选中信号
assign spi_cfg_sel = hsel&(haddr[31:0]==addr_cfg[31:0]);
assign spi_tx_data_sel = hsel&(haddr[31:0]==(addr_cfg[31:0]+32'd4));
assign spi_rx_data_sel = hsel&(haddr[31:0]==(addr_cfg[31:0]+32'd8));

//下面always块主管内部几个控制寄存器的赋值

always@(posedge hclk)begin
	if(!hresetn)begin
		spi_cfg_write <= 1'b0;
		write_size    <= 2'b0;
		spi_tx_data_write <= 1'b0;
		statu			  <= 1'b0;	
		addr			  <= 32'b0;
		r_spi_cfg_sel <= 1'b0;
		r_spi_tx_data_sel <= 1'b0;
		r_spi_rx_data_sel <= 1'b0;
	end
	else begin
		addr					<= haddr;
		spi_cfg_write 		<= (spi_cfg_sel&hwrite&(htrans==nsq))?1'b1:1'b0;		
		spi_tx_data_write <= (spi_tx_data_sel&hwrite&(htrans==nsq))?1'b1:1'b0;
		write_size 			<= (spi_cfg_sel|spi_tx_data_sel|spi_rx_data_sel)?hsize:write_size;
		statu					<= ((spi_cfg_sel|spi_tx_data_sel|spi_rx_data_sel)&(htrans==nsq))?1'b1:1'b0;
		r_spi_cfg_sel 	 	<= spi_cfg_sel;
		r_spi_tx_data_sel	<= spi_tx_data_sel;
		r_spi_rx_data_sel	<= spi_rx_data_sel;
	end
end
//spi_cfg寄存器更新
always@(posedge hclk)begin
	if(!hresetn)begin
		spi_cfg <= 32'b0;		
	end
	//在处理器写值时
	else if((statu==1'b1)&(spi_cfg_write))begin
		spi_cfg[7:0]<=(((write_size==t8)&(addr[1:0]==2'b00))|((write_size==t16)&(addr[1:0]==2'b00))
							|((write_size==t32)&(addr[1:0]==2'b00)))?hwdata[7:0]:spi_cfg[7:0];
		
		spi_cfg[15:8]<=(((write_size==t8)&(addr[1:0]==2'b01))|((write_size==t16)&(addr[1:0]==2'b00))
							|((write_size==t16)&(addr[1:0]==2'b01))|((write_size==t32)&(addr[1:0]==2'b00)))?hwdata[15:8]:spi_cfg[15:8];

		spi_cfg[23:16]<=(((write_size==t8)&(addr[1:0]==2'b10))|((write_size==t16)&(addr[1:0]==2'b10))
							|((write_size==t16)&(addr[1:0]==2'b11))|((write_size==t32)&(addr[1:0]==2'b00)))?hwdata[23:16]:spi_cfg[23:16];

		spi_cfg[31:24]<=(((write_size==t8)&(addr[1:0]==2'b11))|((write_size==t16)&(addr[1:0]==2'b10))
							|((write_size==t16)&(addr[1:0]==2'b11))|((write_size==t32)&(addr[1:0]==2'b00)))?hwdata[31:24]:spi_cfg[31:24];
	end
	
	//没有写回需求的时候更新cfg寄存器的0到5位（指示收发器状态）
	else begin
		spi_cfg[0]<= (spi_cfg[0]&tx_done)?1'b0:spi_cfg[0];
		spi_cfg[1]<= (spi_cfg[1]&rx_done)?1'b0:spi_cfg[1];
		spi_cfg[2]<= (spi_cfg[2]&rtx_done)?1'b0:spi_cfg[2];
		spi_cfg[3]<= (spi_cfg[0]&tx_done)?1'b1:(spi_cfg[0])?1'b0:spi_cfg[3];
		spi_cfg[4]<= (spi_cfg[1]&rx_done)?1'b1:(spi_cfg[1])?1'b0:spi_cfg[4];
		spi_cfg[5]<= (spi_cfg[2]&rtx_done)?1'b1:(spi_cfg[2])?1'b0:spi_cfg[5];
	end
	
end
//data_tx更新		
always@(posedge hclk)begin
	if(!hresetn)begin
		spi_tx_data <= 8'b0;
	end
	else if((statu==1'b1)&(spi_tx_data_write))begin
		spi_tx_data <=(((write_size==t8)|(write_size==t16)|(write_size==t32))&(addr[1:0]==2'b00))?hwdata[7:0]:spi_tx_data;
	end
end

assign hrdata = ((statu&r_spi_cfg_sel)?spi_cfg:32'b0)|
					 ((statu&r_spi_tx_data_sel)?spi_tx_data:32'b0)|
					 ((statu&r_spi_rx_data_sel)?spi_rx_data:32'b0);
					 
assign hreadyout = 1'b1;

assign hresp = 1'b0;

assign ssel = spi_cfg[15:13];

assign cpol = 1'b0;
assign cpha = 1'b0;

clk_ctrl clk_ctrl(
.clk(hclk),
.rst(!hresetn),
.rtx_ok(1'b0),
.rx_ok(rx_ok),
.tx_ok(tx_ok),
//分频系数
.divclk(spi_cfg[31:16]),
//经过时钟同步之后的信号
.rtx_done(rtx_done),
.rx_done (rx_done),
.tx_done (tx_done),
//分频之后的信号
.clk_div(clk_div)

);

spi_module spi_module(
.I_clk(clk_div), // 全局时钟50MHz
.I_rst_n(hresetn), // 复位信号，低电平有效
.I_rx_en(spi_cfg[1]), // 单工读使能信号
.I_tx_en(spi_cfg[0]), // 单工发送使能信号
.rtx_en (spi_cfg[2]), // 双工模式信号
.I_data_in (spi_tx_data), // 要发送的数据
.O_data_out(spi_rx_data), // 接收到的数据
.O_tx_done (tx_ok), // 发送一个字节完毕标志位
.O_rx_done (rx_ok), // 接收一个字节完毕标志位
    
    // 四线标准SPI信号定义
.I_spi_miso(miso), // SPI串行输入，用来接收从机的数据
.O_spi_sck (sck), // SPI时钟
.O_spi_cs  (cs) , // SPI片选信号
.O_spi_mosi(mosi) // SPI输出，用来给从机发送数据          
);


endmodule
