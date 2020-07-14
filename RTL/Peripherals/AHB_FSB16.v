module AHB_FSB16(

//ahb 接口
input wire hclk,
input wire hreset_n,
input wire hsel,
input wire [2:0]hsize,
input wire [1:0]htrans,
input wire hwrite,
input wire [31:0]haddr,	//本桥只占用地址的低32位空间
input wire [63:0]hwdata,
output wire [63:0]hrdata,
output wire hresp,
output wire hready,
//fsb16信号
output wire clk,
output wire rst_n,
output wire aen,
output reg size,
output wire wr_n,
input wire rdy_n,
input wire error_n,
input wire irq_n,
output reg Hi_z,	//拉高之后表示高阻态
output wire [15:0]AD_out,
input wire [15:0]AD_in,
//对内部中断控制器信号
output wire FSB_irq

);
//AHB传输参数
parameter Idld = 2'b00;
//状态机
parameter stb 				= 3'h0;	//等待状态
parameter read_addr_frame0	= 3'h1; //地址帧
parameter read_addr_frame1	= 3'h2;
parameter write_addr_frame0	= 3'h3;
parameter write_addr_frame1	= 3'h4;
parameter nop_frame			= 3'h5; //空帧
parameter read_frame		= 3'h6; //读帧
parameter write_frame		= 3'h7; //写帧

reg[2:0]state;

reg [31:0]ADDR_reg;		
reg [15:0]output_reg;	//输出寄存器	
reg [15:0]DATA_reg;		//AD复用寄存器

//主状态机
always@(posedge hclk)begin
	if(!hreset_n)begin
		state <= stb;
	end
	else begin
		case(state)
			stb				:	if(hsel & (htrans!=Idld) & !hwrite)begin
									state	<=	read_addr_frame0;
								end
								else if(hsel & (htrans!=Idld) & hwrite)begin
									state	<=	write_addr_frame0;
								end
	//地址帧
			read_addr_frame0:	state <= read_addr_frame1;
	
			read_addr_frame1:	state <= nop_frame;
	
			write_addr_frame0:	state <= write_addr_frame1;
	
			write_addr_frame1:	state <= write_frame;
	
			nop_frame		:	state <= read_frame;
	
	//数据帧
	//一个AHB传输可能被分为多个小的数据帧进行传输，trans_ready信号指示了当前传输是否完成
	//发生了错误，马上转到stb状态
			read_frame		:	state <= (!rdy_n | !error_n) ? stb : state;
			write_frame		:	state <= (!rdy_n | !error_n) ? stb : state;
	
		default				:	state <= stb;
		endcase
	end
end
	
//输出到AHB寄存器
always@(posedge hclk)begin
	if(!rdy_n)begin
		output_reg	<= AD_in;
	end
end

//输出寄存器
always@(posedge hclk)begin
	if(state==write_addr_frame0)begin
		case(haddr[3:1])
			2'b00	:	DATA_reg	<=	hwdata[15:0];
			2'b01	:	DATA_reg	<=	hwdata[31:16];
			2'b10	:	DATA_reg	<=	hwdata[47:32];
			2'b11	:	DATA_reg	<=	hwdata[63:48];
		endcase
	end
end

//地址寄存器
always@(posedge hclk)begin
	if(hsel & (htrans!=Idld))begin
		ADDR_reg	<=	haddr[31:0];
	end
end

//高阻态指示寄存器
always@(posedge hclk)begin
	if(state==read_addr_frame1)begin	//当地址传输完成 进入高阻态
		Hi_z	<=	1'b1;
	end
	else if(state==stb)begin
		Hi_z	<=	1'b0;
	end
end
//FSB16信号
//fsb16信号
assign clk	 = hclk;
assign rst_n = hreset_n;
//地址帧时，进行地址使能
assign aen	 = (state==read_addr_frame0)|(state==read_addr_frame1)|(state==write_addr_frame0)|(state==write_addr_frame1);
//传输大小为8bit时，SIZE为0，否则SIZE=1
always@(posedge hclk)begin
	if(hsel & (htrans!=Idld))begin
		size	<=	(hsize!=3'b000);		//如果不是8位传输 那size=1
	end
	else if(!rdy_n)begin
		size	<=	1'b0;					//传输完成后复位
	end
end


assign wr_n	 = (state==write_addr_frame0) | (state==write_addr_frame1);

assign AD_out	=	(((state==read_addr_frame0)|(state==write_addr_frame0))	?ADDR_reg[15:0]	:16'b0) |
					(((state==read_addr_frame1)|(state==write_addr_frame1))	?ADDR_reg[31:16]:16'b0) |
					(((state==write_frame))									?DATA_reg		:16'b0) ;

//AHB响应
assign hresp	=	!error_n;
assign hready	=	!rdy_n;
assign FSB_irq	=	!irq_n;
assign hrdata	=	{output_reg,output_reg,output_reg,output_reg};



endmodule	
