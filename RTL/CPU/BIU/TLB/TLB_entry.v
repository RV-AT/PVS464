module TLB_entry(
//时钟信号
input wire clk,
input wire rst,
//VA-PA通道
//命令通道
input wire read,
input wire write,
input wire execute,

input wire access_rdy,		//cache准备好，表示一次访问结束，TLB计数器加1
//地址通道
input wire [63:0]addr_va,

//反馈通道
//output wire load_page_fault,
//output wire store_page_fault,
//output wire ins_page_fault,
//到下一级(Cache)的信号
//output wire read,
//output wire write,
//output wire C,		//该页面在分页方案中允许缓存

//TLB_ctrl控制信号
output reg valid,			//该TLB entry有效
output reg [11:0]acc_count,	//访问计数
output wire PTE_G,				//全局有效
output reg [63:0]PTE_out,		//该页表的页表项
output reg [63:0]PTE_pa_out, 	//该页表的物理地址
output reg [43:0]PPN_out,		//物理页号输出

input wire [26:0]VPN_in,		//该页表对应的VPN
input wire [43:0]PPN_in,
input wire [63:0]PTE_in,		//新的页表
input wire [63:0]PTE_pa_in,		//新的页表的物理地址

output wire TLB_hit,		//命中
input wire TLB_write,		//写页表项
input wire TLB_clear,		//页表清零（清除valid位）
input wire TLB_D_set		//置位脏标志（已经写穿完成）
);
//pte位
//Sv39CT分页方案
parameter V 			= 0;
parameter R				= 1;
parameter W				= 2;
parameter X				= 3;
parameter U				= 4;
parameter G				= 5;
parameter A				= 6;
parameter D 			= 7;
parameter C				= 63;
parameter T				= 62;

reg [26:0]VPN;		//页表VPN


//访问计数
always@(posedge clk)begin		//页表更新时候，访问计数清零
	if(rst | TLB_clear | TLB_write)begin
		acc_count	<=	12'b0;
	end							//访问计数达到最高时候，不再增加
	else if(acc_count == 12'b111111111111)begin
		acc_count	<=	acc_count;
	end							//当一次访问完全成功之后，访问计数+1
	else if(TLB_hit & access_rdy)begin
		acc_count	<=	acc_count + 12'b1;
	end
end

assign TLB_hit	=	(read|write|execute)&(addr_va[38:12]==VPN)&valid;	//该TLB项有效时 VPN相等即命中

//缓存有效
always@(posedge clk)begin
	if(rst | TLB_clear)begin
		valid	<=	1'b0;
	end						//TLB更新完成后 valid为1
	else if(TLB_write)begin
		valid	<=	1'b1;
	end
end

always@(posedge clk)begin
	if(rst)begin
		PTE_out 	<=	64'b0;
		PTE_pa_out	<=	64'b0;
		PPN_out		<=	43'b0;
		VPN			<=	27'b0;
	end
	else if(TLB_write)begin
		PTE_out 	<=	PTE_in;
		PTE_pa_out	<=	PTE_pa_in;
		PPN_out		<=	PPN_in;
		VPN			<=	VPN_in;
	end
	else if(TLB_D_set)begin		//Dset时， PTE进行D位更新
		PTE_out		<=	PTE_out | 64'b10000000;
	end
end
assign PTE_G = PTE_out[G];


endmodule

















