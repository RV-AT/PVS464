/*
bu_mux: bus unit mux, 用于选择TLB bu和L1 bu访问总线

*/
module bu_mux(
input wire clk,
input wire rst,
//TLB bu ahb
input [63:0]TLB_bu_haddr,
input TLB_bu_hwrite,
input [3:0]TLB_bu_hsize,
input [2:0]TLB_bu_hburst,
input [3:0]TLB_bu_hprot,
input [1:0]TLB_bu_htrans,
input TLB_bu_hmastlock,
input [63:0]TLB_bu_hwdata,

output wire TLB_bu_hready,
output wire TLB_bu_hresp,
output wire TLB_bu_hreset_n,
output wire [63:0]TLB_bu_hrdata,

output wire TLB_bu_bus_ack,		//总线允许使用
input wire TLB_bu_bus_req,		//总线请求使用

//TLB bu ahb
input [63:0]L1_bu_haddr,
input L1_bu_hwrite,
input [3:0]L1_bu_hsize,
input [2:0]L1_bu_hburst,
input [3:0]L1_bu_hprot,
input [1:0]L1_bu_htrans,
input L1_bu_hmastlock,
input [63:0]L1_bu_hwdata,

output wire L1_bu_hready,
output wire L1_bu_hresp,
output wire L1_bu_hreset_n,
output wire [63:0]L1_bu_hrdata,

output wire L1_bu_bus_ack,		//总线允许使用
input wire L1_bu_bus_req,		//总线请求使用

//第三方设备请求总线
output wire Ext_bus_ack,
input wire Ext_bus_req,

//AHB接口
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
input wire [63:0]hrdata

);
reg [1:0]bus_mux_state;	//总线状态


always@(posedge clk)begin
	if(rst)begin
		bus_mux_state	<=	2'b00;
	end
	else begin
		case(bus_mux_state)
			2'b00	:	bus_mux_state	<=	TLB_bu_bus_req ? 2'b01 : L1_bu_bus_req ? 2'b10 : Ext_bus_req ? 2'b11 : bus_mux_state;
			2'b01	:	bus_mux_state	<=	!TLB_bu_bus_req ? 2'b00 : bus_mux_state;
			2'b10	:	bus_mux_state	<=	!L1_bu_bus_req  ? 2'b00 : bus_mux_state;
			2'b11	:	bus_mux_state	<=	!Ext_bus_req ? 2'b00 : bus_mux_state;
		endcase
	end
end
assign TLB_bu_bus_ack	=	(bus_mux_state==2'b01);
assign L1_bu_bus_ack	=	(bus_mux_state==2'b10);
assign Ext_bus_ack		=	(bus_mux_state==2'b11);
//对外AHB总线从TLB-bu和L1-bu裁决之后送出
//对外AHB总线
assign haddr	=	TLB_bu_bus_ack	?	TLB_bu_haddr	: L1_bu_haddr;
assign hwrite	=	TLB_bu_bus_ack	?	TLB_bu_hwrite	: L1_bu_hwrite;
assign hsize	=	TLB_bu_bus_ack	?	TLB_bu_hsize	: L1_bu_hsize;
assign hburst	=	TLB_bu_bus_ack	?	TLB_bu_hburst	: L1_bu_hburst;
assign hprot	=	TLB_bu_bus_ack	?	TLB_bu_hprot	: L1_bu_hprot;
assign htrans	=	TLB_bu_bus_ack	?	TLB_bu_htrans	: L1_bu_htrans;
assign hmastlock=	TLB_bu_bus_ack	?	TLB_bu_hmastlock: L1_bu_hmastlock;
assign hwdata	=	TLB_bu_bus_ack	?	TLB_bu_hwdata	: L1_bu_hwdata;

//TLB-bu
assign L1_bu_hready		=	hready;
assign L1_bu_hresp		=	hresp;
assign L1_bu_hreset_n	=	hreset_n;
assign L1_bu_hrdata		=	hrdata;
//L1-bu
assign TLB_bu_hready		=	hready;
assign TLB_bu_hresp		=	hresp;
assign TLB_bu_hreset_n	=	hreset_n;
assign TLB_bu_hrdata		=	hrdata;

endmodule




