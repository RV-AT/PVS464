/*
适用于PRV464的IF（取指单元）

2020.3.7

*/
module ins_fetch(

input wire clk,
input wire rst,
input wire [3:0]priv,		//当前机器权限状态

//中断控制器信号
input wire int_req,			//中断请求信号，当准备处理中断时为1请求,中断请求信号在IF阶段被插入，只有当机器确保流水线排空之后才会处理中断
//pip控制器信号
//插空信号
input wire nop_if,
input wire if_hold,			//if保持信号
//流水线刷新信号
input wire pip_flush,
input wire [63:0]new_pc,	//新PC输入
//对cache控制器信号
output wire [63:0]addr,

output wire rd,				//取指令信号
output wire [3:0]if_priv,
input wire [63:0]ins_in,
input wire ins_acc_fault_biu, 		//指令访问失败
input wire ins_page_fault_biu,		//指令页面错误
input wire cache_ready,				//cache准备好信号

/*

*/

//对下一级（ID）信号
//指令输出
output wire [31:0]ins_out,
//指令对应的PC值输出
output reg [63:0]ins_pc,
//机器控制段

output reg ins_acc_fault,	//指令访问失败
output reg ins_addr_mis, 	//指令地址错误
output reg ins_page_fault,	//指令页面错误
output reg int_acc,			//中断接收信号
output reg valid			//指令有效信号


);
parameter pc_rst = 64'h0000_0000_0000_0000;	//pc复位地址,如果需要改变复位地址修改这里即可

reg hold;

reg [31:0]ins_hold;			//ins保持寄存器
reg [63:0]pc;
wire addr_mis;				//PC不对齐信号

wire [31:0]ins_shift;		//移位后的指令


assign addr_mis = (pc[1:0]!=2'b00);

assign ins_shift= ins_pc[2]?ins_in[63:32] : ins_in[31:0];


//pc更新逻辑
//当pip_flush时，pc被更新到pc_new
//当nop_if,或者L1没有准备好的时候，pc被保持
always@(posedge clk)begin
	if(rst)begin
		pc <= pc_rst;
	end
	else if(pip_flush)begin
		pc <= new_pc;
	end
	else if(nop_if|if_hold)begin
		pc <= pc;
	end
	else begin
		pc <= (cache_ready)?pc + 64'd4 : pc;
	end
end

always@(posedge clk)begin
	if(rst)begin
		ins_pc <= 64'b0;
	end
	else if(if_hold)begin
		ins_pc <= ins_pc;
	end
	else begin
		ins_pc <= pc;
	end
end

always@(posedge clk)begin
	if(rst)begin
		ins_hold <= 32'b0;
	end
	else if(if_hold & !hold)begin
		ins_hold <= ins_shift;
	end
end
always@(posedge clk)begin
	if(rst)begin
		hold <= 1'b0;
	end
	else if(hold==1'b0)begin
		hold <= if_hold?1'b1:hold;
	end
	else if(hold==1'b1)begin
		hold <= !if_hold?1'b0:hold;
	end
end

//指令错误值更新
always@(posedge clk)begin
	if(rst)begin
		ins_acc_fault <= 1'b0;
		ins_page_fault<= 1'b0;
		ins_addr_mis  <= 1'b0;
		int_acc		  <= 1'b0;
	end
	else if(if_hold)begin
		ins_acc_fault <= ins_acc_fault;
		ins_page_fault<= ins_page_fault;
		ins_addr_mis  <= ins_addr_mis;
		int_acc       <= int_acc;
	end
	else begin
		ins_acc_fault <= ins_acc_fault_biu;
		ins_page_fault<= ins_page_fault_biu;
		ins_addr_mis  <= addr_mis;
		int_acc       <= int_req;
	end
end

//指令有效位更新
//当插入等待状态时，valid保持
always@(posedge clk)begin
	if(rst|ins_acc_fault|ins_page_fault|ins_addr_mis)begin
		valid <= 1'b0;
	end
	else if(cache_ready&!nop_if)begin
		valid <= 1'b1;
	end
	else if(if_hold)begin
		valid <= valid;
	end
	else begin
		valid <= 1'b0;
	end
end

assign ins_out = hold?ins_hold:ins_shift;
assign if_priv = priv;
assign addr    = pc;
assign rd		= !nop_if&!if_hold;



endmodule
