`timescale 1ns/100ps
module AHB_XIP_TB();

    wire [3:0]XPIi,XPIo,XPIdir,XPI;
    wire XPICS,XPICLK;
        
    reg SysRST;
    wire SysRST_N;
    reg HCLK;
    wire [35:0]HADDR;
    wire HWRITE,HMASTLOCK;
    wire [63:0]HWDATA;
    wire [2:0]HSIZE;
    wire [2:0]HBURST;
    wire [3:0]HPROT;
    wire [1:0]HTRANS;
    //Master side ports (MUXed)
    wire[63:0]HRDATAM;
    wire HREADYM;
	wire HRESPM;
    
    
    //AHB Periheral select
    reg HSEL;
	wire [63:0]HRDATA;
	wire HREADY;
	wire HRESP;

    //Initialization and stimulation source block
    initial
    begin
        #0 HCLK=0;SysRST=1;
        #10 SysRST=0;
    end
    assign SysRST_N=!SysRST;
    always #5 HCLK=~HCLK;

    //SRAM-like read request gen

reg rreq;			//请求读一次
reg rbreq;	//请求读一行
reg [3:0]rsize;
reg [63:0]raddr;		//
wire [63:0]rbdata;
wire [10:0]rlen;
wire rbdo;			//cache写
wire rrdy;			//传输完成
wire berr;			//访问失败
genvar i;
reg dice1;
reg [23:0]dice2;
reg [1:0]dice3;
initial 
begin
   HSEL<=1'b1;
end
always@(posedge HCLK or posedge SysRST)
begin
    if(rrdy|SysRST)
    begin
        dice1<=$random;
        dice2<=$random;
        dice3<=$random;
        if(dice1)
        begin
            rbreq<=1'b1;
            rreq<=1'b0;
            raddr<={48'b0,dice2[23:3],3'b000};
            rsize<=3'b011;
        end
        else 
        begin
            rbreq<=1'b1;
            rreq<=1'b0;
            raddr<={48'b0,dice2[23:3],3'b000};
            rsize<=dice3;
        end
    end
end
cache_bus_unit TSG
(
.clk(HCLK),
.rst(SysRST),

.write_through_req(1'b0),	//请求写穿
.read_req(rreq),			//请求读一次
.read_line_req(rbreq),		//请求读一行
.size(rsize),
.pa(raddr),			//
.wt_data(64'b0),
.line_data(rbdata),
.addr_count(rlen),
.line_write(rbdo),			//cache写
.cache_entry_write(),	//更新缓存entry
.trans_rdy(rrdy),			//传输完成
.bus_error(berr),			//访问失败

//AHB总线
//ahb
//ahb
.haddr(HADDR),
.hwrite(HWRITE),
.hsize(HSIZE),
.hburst(HBURST),
.hprot(HPROT),
.htrans(HTRANS),
.hmastlock(HMASTLOCK),
.hwdata(HWDATA),

.hready(HREADYM),
.hresp(HRESPM),
.hreset_n(SysRST_N),
.hrdata(HRDATA),

.bus_ack(1'b0),		//总线允许使用
.bus_req()		//总线请求使用

);
//wire [3:0]XPIo;
//wire [3:0]XPIi;
//wire [3:0]XPIdir;
assign XPIi=XPI;
generate for (i=0;i<=3;i=i+1)
begin:XPIioctrl
	assign XPI[i]=XPIdir[i]?XPIo[i]:1'bz;
    pullup(XPI[i]);
end
endgenerate
AHB_XIP DUT
(
    .HSEL(HSEL),
    .HADDR(HADDR),
    .HWRITE(HWRITE),
    .HTRANS(HTRANS),
    .HSIZE(HSIZE),
    .HBURST(HBURST),
    .HWDATA(HWDATA),
    .HRESETn(SysRST_N),
    .HCLK(HCLK),
    .HMASTLOCK(HMASTLOCK),
    .HREADY(HREADYM),
    .HRESP(HRESPM),
    .HRDATA(HRDATA),
    .XPIo(XPIo),
    .XPIi(XPIi),
    .XPIdir(XPIdir),
    .XPICS(XPICS),
    .XPICLK(XPICLK)

);

W25Q128JVxIM DEVICE1
(
    .CSn(XPICS),
    .CLK(XPICLK), 
    .DIO(XPI[0]), 
    .DO(XPI[1]), 
    .WPn(XPI[2]), 
    .HOLDn(XPI[3])
);


endmodule