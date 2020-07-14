/*
适用于PVS332V0系统的AHB-IS62内存连接，可以提供16MB的片外内存空间
片外是4M*4Byte的空间，在设计中认为可以划分为2M*8个子设备，子设备可以是RAM也可以是一个其他设备
hclk最好不要超过50MHz，该模块设计的时候使用50MHz的时钟进行参考，时间恰好满足IS62的需求
外部建议使用延迟小于15ns的逻辑器件。74LVC或是不错人选

*/
module ahb_is62(

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

//外部数据总线接口
inout wire [31:0]data,
//准备好信号
input wire rdy,
//地址接口（外部储存器粒度为32位）
output wire [21:0]address,
//储存器字节选择信号
output reg sel32_n,
output reg sel24_n,
output reg sel16_n,
output reg sel8_n,
//外部片选信号，用于驱动外部74138工作
output reg cs_n,
//读信号
output reg wr_n,
//输出使能
output reg oe_n 

);
//ahb参数
parameter  nsq = 2'b10;
parameter idle = 2'b00;
parameter t8   = 3'b000;
parameter t16  = 3'b001;
parameter t32  = 3'b010;

//等待状态
parameter tw = 4'b0000;
//读周期，一共四个周期
parameter rt1= 4'b0001;
parameter rt2= 4'b0010;
parameter rt3= 4'b0011;
parameter rt4= 4'b0100;
//写周期，一共四个周期
parameter wt1= 4'b1001;
parameter wt2= 4'b1010;
parameter wt3= 4'b1011;
parameter wt4= 4'b1100;
//状态寄存器
reg [3:0]statu;
//读写指示寄存器
reg w_r;

//传输大小寄存器
reg [2:0]size;

//地址寄存器
reg [23:0]addr;

//写数据寄存器
reg [31:0]wr_data;



//size寄存器更新
always@(posedge hclk)begin
	if(!hresetn)begin
		size <= 3'b0;
	end
	//当AHB传输参数满足该设备地址的时候更新size寄存器
	else if((haddr[31:24]==addr_cfg[31:24])&hsel&(htrans==nsq))begin
		size <= hsize;
	end
	
end

//addr寄存器更新
always@(posedge hclk)begin
	if(!hresetn)begin
		addr <= 24'b0;
	end
	
	else if((haddr[31:24]==addr_cfg[31:24])&hsel&(htrans==nsq))begin
		addr <= haddr[23:0];
	end
	
end
//w_r寄存器更新
always@(posedge hclk)begin
	if(!hresetn)begin
		w_r <= 1'b0;
	end
	
	else if((haddr[31:24]==addr_cfg[31:24])&hsel&(htrans==nsq))begin	//读写指示寄存器在AHB总线参数满足要求的时候更新
		w_r <= hwrite ? 1'b1 : 1'b0;
	end
	
	else if((statu==wt4)|(statu==rt4))begin
		w_r <= 1'b0;
	end
	
	else begin
		w_r <= w_r;
	end
end

	
	

//statu寄存器更新
always@(posedge hclk)begin
	if(!hresetn)begin
		statu <= 4'b0;
	end
	else if(statu==tw)begin					
		if((haddr[31:24]==addr_cfg[31:24])&hsel&(htrans==nsq))begin	//当AHB信号满足该设备地址的时候开始进入读写周期
			statu <= hwrite?wt1 : rt1;
		end
		else begin
			statu <= statu;
		end
	end
	
	else if(statu==rt1)begin
		statu <= rt2;
	end
	
	else if(statu==rt2)begin
	   statu <= rt3;
	end
	
	else if(statu==rt3)begin
		statu <= rdy?rt4 : statu;
	end
	
	else if(statu==rt4)begin
		statu <= tw;
	end
	
	else if(statu==wt1)begin
		statu <= wt2;
	end
	
	else if(statu==wt2)begin
		statu <= wt3;
	end
	
	else if(statu==wt3)begin
		statu <= rdy?wt4 : statu;
	end
	else if(statu==wt4)begin
		statu <= tw;
	end
	
	
end
		
//cs，sel更新
always@(posedge hclk)begin
	if(!hresetn)begin
		cs_n <= 1'b1;
		sel32_n<= 1'b1;
		sel24_n<= 1'b1;
		sel16_n<= 1'b1;
		sel8_n <= 1'b1;
	end
	//总线状态在tw状态时
	else if(statu==tw)begin
	
		cs_n    <= ((haddr[31:24]==addr_cfg[31:24])&hsel&(htrans==nsq)&!hwrite)?1'b0:1'b1;
		sel32_n <= (((haddr[1:0]==2'b00)&(hsize==t32))|((haddr[1:0]==2'b10)&(hsize==t16))|((haddr[1:0]==2'b11)&(hsize==t8)))?1'b0:1'b1;
		sel24_n <= (((haddr[1:0]==2'b00)&(hsize==t32))|((haddr[1:0]==2'b10)&(hsize==t16))|((haddr[1:0]==2'b01)&(hsize==t16))|((haddr[1:0]==2'b10)&(hsize==t8)))?1'b0:1'b1;
		sel16_n <= (((haddr[1:0]==2'b00)&(hsize==t32))|((haddr[1:0]==2'b01)&(hsize==t16))|((haddr[1:0]==2'b00)&(hsize==t16))|((haddr[1:0]==2'b01)&(hsize==t8)))?1'b0:1'b1;
		sel8_n  <= (((haddr[1:0]==2'b00)&(hsize==t32))|((haddr[1:0]==2'b00)&(hsize==t16))|((haddr[1:0]==2'b00)&(hsize==t8)))?1'b0:1'b1;
	end	
	
	else if(statu==wt1)begin
		cs_n    <= 1'b0;
		sel32_n <= (((addr[1:0]==2'b00)&(size==t32))|((addr[1:0]==2'b10)&(size==t16))|((addr[1:0]==2'b11)&(size==t8)))?1'b0:1'b1;
		sel24_n <= (((addr[1:0]==2'b00)&(size==t32))|((addr[1:0]==2'b10)&(size==t16))|((addr[1:0]==2'b01)&(size==t16))|((addr[1:0]==2'b10)&(size==t8)))?1'b0:1'b1;
		sel16_n <= (((addr[1:0]==2'b00)&(size==t32))|((addr[1:0]==2'b01)&(size==t16))|((addr[1:0]==2'b00)&(size==t16))|((addr[1:0]==2'b01)&(size==t8)))?1'b0:1'b1;
		sel8_n  <= (((addr[1:0]==2'b00)&(size==t32))|((addr[1:0]==2'b00)&(size==t16))|((addr[1:0]==2'b00)&(size==t8)))?1'b0:1'b1;
	end
	else if((statu==wt4)|(statu==rt4))begin
		cs_n	  <= 1'b1;
		sel32_n <= 1'b1;
		sel24_n <= 1'b1;
		sel16_n <= 1'b1;
		sel8_n  <= 1'b1;
	end
	
end

//wr更新
always@(posedge hclk)begin
	if(!hresetn)begin
		wr_n <= 1'b1;
	end
	
	else if(statu==wt1)begin
		wr_n <= 1'b0;
	end
	
	else if(statu==wt3)begin
		wr_n <= rdy ? 1'b1 : wr_n;
	end
	else begin
		wr_n <= wr_n;
	end
	
end


//oe更新
always@(posedge hclk)begin
	if(!hresetn)begin
		oe_n <= 1'b1;
	end
	
	else if(statu==tw)begin
		oe_n <= ((haddr[31:24]==addr_cfg[31:24])&!hwrite&hsel&(htrans==nsq))?1'b0:1'b1;
	end
	else if(statu==rt4)begin
		oe_n <= 1'b1;
	end
	
	else begin
		oe_n <= oe_n;
	end
	
end

//wr_data更新
always@(posedge hclk)begin
	if(!hresetn)begin
		wr_data <= 32'b0;
	end
	
	else if(statu==wt1)begin //当处理器处在写的第一周期结束之后送数据
		wr_data <= hwdata;
	end
	
	else if(statu==wt4)begin
		wr_data <= 32'b0;
	end
	else begin
		wr_data <= wr_data;
	end
end

assign data = w_r ? wr_data : 32'bz;
assign address = addr[23:2];
assign hrdata = w_r?32'b0:data;
assign hreadyout = (statu==wt4) | (statu==rt4)|(statu==idle);
assign hresp = 1'b0;

endmodule






