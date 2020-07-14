//基于访问次数的PTE项选择
module TLB_select_cell(
//entry0
input wire [1:0]id0,
input wire entry0_valid,			//该TLB entry有效
input wire [11:0]entry0_acc_count,	//访问计数
input wire entry0_PTE_G,				//全局有效
//entry1
input wire [1:0]id1,
input wire entry1_valid,			//该TLB entry有效
input wire [11:0]entry1_acc_count,	//访问计数
input wire entry1_PTE_G,				//全局有效
//选出的
output wire [1:0]id_out,
output wire valid_out,			//该TLB entry有效
output wire [11:0]acc_count_out,	//访问计数
output wire PTE_G_out				//全局有效
);
wire sel;			//选择

wire both_valid;		//二者都是有效项
wire both_global;		//二者都是全局表

assign both_valid	=	entry0_valid & entry1_valid;
assign both_global	=	entry0_PTE_G & entry1_PTE_G;
			
assign sel = 	!both_valid ? (entry0_valid) : 		//若两个有一个不是有效页面，选出这个非有效页面
				!both_global ? (entry0_PTE_G) : 	//如果有一个不是全局页面，选出这个非全局页面
				(entry0_acc_count >=entry1_acc_count) ? 1'b1 : 1'b0;	//如果有访问次数较大，选出访问次数小的

assign id_out	=	sel ? id1 : id0;
assign valid_out=	sel ? entry1_valid : entry0_valid;
assign acc_count_out=	sel ? entry1_acc_count : entry0_acc_count;
assign PTE_G_out	=	sel ? entry1_PTE_G : entry0_PTE_G;

endmodule