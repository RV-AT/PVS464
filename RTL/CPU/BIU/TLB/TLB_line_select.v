module TLB_line_select(
//entry0
input wire entry0_valid,			//该TLB entry有效
input wire [11:0]entry0_acc_count,	//访问计数
input wire entry0_PTE_G,				//全局有效
//entry1
input wire entry1_valid,			//该TLB entry有效
input wire [11:0]entry1_acc_count,	//访问计数
input wire entry1_PTE_G,				//全局有效
//entry2
input wire entry2_valid,			//该TLB entry有效
input wire [11:0]entry2_acc_count,	//访问计数
input wire entry2_PTE_G,				//全局有效
//entry3
input wire entry3_valid,			//该TLB entry有效
input wire [11:0]entry3_acc_count,	//访问计数
input wire entry3_PTE_G,				//全局有效

//选出的替换页
output wire [3:0]entry_select

);

//第一次比较选出的值
wire [1:0]id0;
wire compare_0and1_valid;
wire [11:0]compare_0and1_acc_count;
wire compare_0and1_PTE_G;

wire [1:0]id1;
wire compare_2and3_valid;
wire [11:0]compare_2and3_acc_count;
wire compare_2and3_PTE_G;

//第二次比较
wire [1:0]id_sel;

//0和1进行比较
TLB_select_cell TLB_select_0and1(
//entry0
.id0				(2'b00),
.entry0_valid		(entry0_valid),			//该TLB entry有效
.entry0_acc_count	(entry0_acc_count),	//访问计数
.entry0_PTE_G		(entry0_PTE_G),				//全局有效
//entry1
.id1				(2'b01),
.entry1_valid		(entry1_valid),			//该TLB entry有效
.entry1_acc_count	(entry1_acc_count),	//访问计数
.entry1_PTE_G		(entry1_PTE_G),				//全局有效
//选出的
.id_out				(id0),
.valid_out			(compare_0and1_valid),			//该TLB entry有效
.acc_count_out		(compare_0and1_acc_count),	//访问计数
.PTE_G_out			(compare_0and1_PTE_G)				//全局有效
);
//2和3比较
TLB_select_cell TLB_select_2and3(
//entry0
.id0				(2'b10),
.entry0_valid		(entry2_valid),			//该TLB entry有效
.entry0_acc_count	(entry2_acc_count),	//访问计数
.entry0_PTE_G		(entry2_PTE_G),				//全局有效
//entry1
.id1				(2'b11),
.entry1_valid		(entry3_valid),			//该TLB entry有效
.entry1_acc_count	(entry3_acc_count),	//访问计数
.entry1_PTE_G		(entry3_PTE_G),				//全局有效
//选出的
.id_out				(id1),
.valid_out			(compare_2and3_valid),			//该TLB entry有效
.acc_count_out		(compare_2and3_acc_count),	//访问计数
.PTE_G_out			(compare_2and3_PTE_G)				//全局有效
);
//第二次比较
//使用第一次选出来的值进行比较
TLB_select_cell TLB_select_final(
//entry0
.id0				(id0),
.entry0_valid		(compare_0and1_valid),			//该TLB entry有效
.entry0_acc_count	(compare_0and1_acc_count),	//访问计数
.entry0_PTE_G		(compare_0and1_PTE_G),				//全局有效
//entry1
.id1				(id1),
.entry1_valid		(compare_2and3_valid),			//该TLB entry有效
.entry1_acc_count	(compare_2and3_acc_count),	//访问计数
.entry1_PTE_G		(compare_2and3_PTE_G),				//全局有效
//选出的
.id_out				(id_sel),
.valid_out			(),			//该TLB entry有效
.acc_count_out		(),	//访问计数
.PTE_G_out			()				//全局有效
);

assign entry_select[0] = (id_sel==2'b00);
assign entry_select[1] = (id_sel==2'b01);
assign entry_select[2] = (id_sel==2'b10);
assign entry_select[3] = (id_sel==2'b11);



endmodule