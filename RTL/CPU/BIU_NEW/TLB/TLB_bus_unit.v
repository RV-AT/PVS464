/*
管理TLB的bus unit
*/
module TLB_bus_unit(
input wire clk,
input wire rst,
//csr
input wire [63:0]satp,
input wire mxr,
input wire sum,

//TLB0
output wire [43:0]TLB_PPN_in,
output wire [63:0]TLB_PTE_in,		//新的页表
output wire [63:0]TLB_PTE_pa_in,		//新的页表的物理地址

input wire [63:0]TLB_PTE_out,
input wire [63:0]TLB_PTE_pa_out_va_out,

input wire TLB_write_through_req,	//写穿请求
input wire TLB_translate_req,		//页面转换请求
input wire TLB_tsl_execute,		//页面转换用的参数
input wire TLB_tsl_read,
input wire TLB_tsl_write,
input wire [3:0]TLB_tsl_priv,

output wire TLB_bu_ready,
output wire TLB_entry_write,
output wire TLB_D_set,
output wire TLB_page_fault,

//ahb
//ahb
output [63:0]haddr,
output hwrite,
output [3:0]hsize,
output [2:0]hburst,
output [3:0]hprot,
output [1:0]htrans,
output hmastlock,
output [63:0]hwdata,

input wire hready,
input wire hresp,
input wire hreset_n,
input wire [63:0]hrdata,

input wire bus_ack,		//总线允许使用
output wire bus_req		//总线请求使用
);
//ahb操作
parameter nseq = 2'b010;
parameter idle = 2'b000;

//权限
parameter user = 4'b0001;
parameter supe = 4'b0010;
parameter mach = 4'b1000;

//pte位
//SV39CT分页方案
parameter V	= 0;	
parameter R = 1;
parameter W = 2;
parameter X = 3;
parameter U = 4;
parameter A = 6;
parameter D = 7;
parameter C = 63;


parameter stb 	  = 4'b0000;	//等待状态，当需要进行页面检查时候跳转
parameter s2_1	  = 4'b0001;	//访问页表
parameter s2_2	  = 4'b0010;
parameter s4  	  = 4'b0011;	//页面有效性检查，如果是指针则继续进行页表访问
parameter s5  	  = 4'b0100;	//页面权限检查，如果权限不符合则直接引起页面异常
parameter pte_upd0= 4'b0101;	//页表更新，如果A不为1，则将A置1
parameter pte_upd1= 4'b0110;
parameter ready	  =4'b0111;		//转换完成
parameter page_fault=4'b1000;	
parameter acc_fault=4'b1001;



reg [63:0]a;			//中间临时地址，也作为页表地址
reg [63:0]pte_temp;		//页表数据
reg [63:0]p_address;	//转换完成之后的物理地址
reg [1:0]i;				//计数器，本机支持Sv39分页方案，故i=2
reg [3:0]statu;			//主状态机

wire page_unvalid;		//s4检查页面不有效，当v=0或者其他情况时候为1，引起页面错误
wire pointer_page;		//s4检查页面是否是指针，指向下一个页表
wire leaf_page;			//s4检查页面是否是末端页面，若为1则跳到S5
wire page_chk_ok;		//s5页面检查正常，如果不正常

wire [8:0]va_vpn;		//va_vpn选择


assign page_unvalid = !pte_temp[A]|(pointer_page&(i==2'b00));	//当A=0时或者三级转换已经用光但还是指针页面时候，发生页面异常
assign pointer_page = !pte_temp[X]&!pte_temp[W]&!pte_temp[R];	//R W X 均为0时候是指针页面
assign leaf_page    = pte_temp[R]|pte_temp[X];					//R或X为1 是有效的子页面

//进行页面检查
page_check page_check(
//csr
.priv		(TLB_tsl_priv),
.mxr		(mxr),
.sum		(sum),
//读写控制
.read		(TLB_tsl_read),
.write		(TLB_tsl_write),
.execute	(TLB_tsl_execute),

//PTE
.PTE_U		(pte_temp[U]),
.PTE_W		(pte_temp[W]),
.PTE_R		(pte_temp[R]),
.PTE_X		(pte_temp[X]),

//检查正确
.check_ok	(page_chk_ok)
);
					  
assign va_vpn = (i==2'b10)?TLB_PTE_pa_out_va_out[20:12]:(i==2'b01)?TLB_PTE_pa_out_va_out[29:21]:(i==2'b00)?TLB_PTE_pa_out_va_out[38:30]:9'b0;

				  

//statu主状态机
always@(posedge clk)begin
	if(rst)begin
		statu <= stb;
	end
	else begin			//如果有总线主机请求，则等待请求完毕
		case(statu)
			stb:	if(!bus_ack)begin
						statu 	<= 	statu; 
					end
					else if(TLB_translate_req)begin 
						statu	<=	s2_1; 
					end
					else if(TLB_write_through_req)begin
						statu	<=	pte_upd0;
					end
	
			s2_1:	statu <= s2_2;
	
			s2_2:	statu <= hresp?page_fault: hready?s4:statu;
	
			s4	:	statu <= page_unvalid?page_fault:pointer_page?s2_1:leaf_page?s5:statu;
								//如果内存A位没有置1 那么置1
								//如果页面检查失败，那么产生页面错误
			s5	:	if(page_chk_ok&!pte_temp[A])begin
						statu <= 	pte_upd0;
					end
					else begin
						statu <=	page_chk_ok ? ready:page_fault;
					end
	
		pte_upd0:	statu <= pte_upd1;
								//如果页面更新失败 产生页面错误
		pte_upd1:	statu <= hresp?page_fault:hready?ready:statu;
	
		   ready:	statu <= stb;
	
		page_fault:	statu <= stb;
	
		endcase
	end
	
end

//i寄存器更新
//i只有当当前是页表指针时候才-1s，否则不-1s
//i在stb状态+2s
always@(posedge clk)begin
	if(rst|(statu==stb))begin
		i <= 2'b10;
	end
	else if(statu==s4)begin
		i <= pointer_page?(i-2'b1):i;
	end
end
//p_address寄存器更新
//p_address寄存器在没有打开虚拟内存时候直接保存物理地址
always@(posedge clk)begin
	if(rst)begin
		p_address <= 64'b0;
	end
	else if(statu==s5)begin
		case(i)
			2'b10:p_address <= {8'b0,pte_temp[53:28],TLB_PTE_pa_out_va_out[29:12],12'b0};
			2'b01:p_address <= {8'b0,pte_temp[53:19],TLB_PTE_pa_out_va_out[20:12],12'b0};
			2'b00:p_address <= {8'b0,pte_temp[53:10],12'b0};
		endcase	
	end
end
	
//a寄存器更新
//a寄存器保持当前页表地址
always@(posedge clk)begin
	if(rst)begin
		a <= 64'b0;
	end
	//等待状态时，第一次进入页面转换时，页表地址为satp+va.ppn[2]
	else if(statu==stb)begin
		a <= (TLB_translate_req)?{8'b0,satp[43:0],va_vpn,3'b0}:TLB_PTE_pa_out_va_out;
	end
	
	else if(statu==s4)begin
		a <= pointer_page?{8'b0,pte_temp[53:10],va_vpn,3'b0}:a;
	end
	
end

//pte_temp寄存器更新

always@(posedge clk)begin
	if(rst)begin
		pte_temp <= 64'b0;
	end
	//页面更新时候 pte temp被更新为TLB送出的页表；或者是自身页表置A
	else if(statu==pte_upd0)begin
		pte_temp <= TLB_write_through_req ? (TLB_PTE_out | 64'b10000000) : (pte_temp | 64'b1000000);
	end
	else if(statu==s2_2)begin
		pte_temp <= hready?hrdata:pte_temp;
	end
	
end

//TLB应答通道

assign TLB_entry_write	=	TLB_translate_req & (statu==ready);
assign TLB_page_fault	=	(statu==page_fault);
assign TLB_D_set		=	(statu==ready)&TLB_write_through_req;
assign TLB_bu_ready 	= 	(statu==ready);		//传输准备好信号

assign TLB_PTE_pa_in	=	a;			//物理地址
assign TLB_PPN_in  		=	p_address[55:12];//得到PPN号
assign TLB_PTE_in		=	pte_temp;		//读入数据

//ahb总线
assign haddr = a;
assign hwrite= (statu==pte_upd0);
assign hsize = 4'b011;
assign hburst= 3'b000;
assign hprot = 4'b0011;
assign htrans= ((statu==s2_1)|(statu==pte_upd0))?nseq:idle;
assign hmastlock = 1'b0;
assign hwdata = pte_temp;

//总线请求使用
assign bus_req	=	TLB_translate_req | TLB_write_through_req;


endmodule