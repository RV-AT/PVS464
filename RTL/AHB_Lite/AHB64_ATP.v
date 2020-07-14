/*************************************
AHB64 Automatic Test Platform
This is an automatic AHB Bus tester

read or write address 0xF55aaaa55 will stop simulation
*************************************/
`timescale 1us / 100ps
module AHB64_ATP();
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
	wire [1:0]HRESPM;
    
    
    //AHB Periheral select
    wire HSEL_BOOT;
	wire HSEL_XTROM;
	wire HSEL_MSRAM;
    wire HSEL_DUMMY;
    
	wire [63:0]HRDATA_BOOT;
	wire [63:0]HRDATA_XTROM;
	wire [63:0]HRDATA_MSRAM; 
    wire [63:0]HRDATA_DUMMY; 

	wire HREADY_BOOT;
	wire HREADY_XTROM;
	wire HREADY_MSRAM;
    wire HREADY_DUMMY;

	wire [1:0]HRESP_BOOT;
	wire [1:0]HRESP_XTROM;
    wire [1:0]HRESP_MSRAM;
    wire [1:0]HRESP_DUMMY;

    //Initialization and stimulation source block
    initial
    begin
        #0 HCLK=0;SysRST=1;
        #10 SysRST=0;
    end
    assign SysRST_N=!SysRST;
    always #5 HCLK=~HCLK;






/*
always@(posedge HCLK or negedge SysRST_N) if(!SysRST_N)HADDR=36'h0;
else HADDR<=HADDR+17'h10000;
*/

	prv464_top CPU1(
    .cacheability_block(32'b0),	//可缓存的区，即物理地址[63:31],这个区间里的内存是可以缓存的
    .clk(HCLK),			//时钟信号，和AHB总线同步
    .rst(SysRST),			//复位信号，高有效，AHB总线的复位信号是空脚
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
    .hrdata(HRDATAM),

    //外部中断信号
    .m_time_int(1'B0),
    .m_soft_int(1'B0),
    .m_ext_int(1'B0),	//对M模式的中断信号
    .s_ext_int(1'B0),	//对S模式的中断信号
    //外部时钟信号
    .mtime(64'B0));

    AHB_ROM BOOTROM1(HSEL_BOOT,HADDR,HWRITE,HTRANS,HSIZE,HBURST,HWDATA,
    SysRST_N,HCLK,HMASTLOCK,HREADY_BOOT,HRESP_BOOT,HRDATA_BOOT);

    AHB_ESRAM MSRAM1(HSEL_MSRAM,HADDR,HWRITE,HTRANS,HSIZE,HBURST,HWDATA,
    SysRST_N,HCLK,HMASTLOCK,HREADY_MSRAM,HRESP_MSRAM,HRDATA_MSRAM);

    AHB_DUMMY XTROM1(HSEL_XTROM,HADDR,HWRITE,HTRANS,HSIZE,HBURST,HWDATA,SysRST_N,
    HCLK,HMASTLOCK,HREADY_XTROM,HRESP_XTROM,HRDATA_XTROM);//eXTernal SPI flash ROM leave blank 

    //AHB Related Modules
    ahb_decoder DEC1(
    .HADDR(HADDR),
    .HSELx0(HSEL_BOOT),
    .HSELx1(HSEL_XTROM), 
    .HSELx2(HSEL_MSRAM),
    .HSELx7(HSEL_DUMMY) );

    ahb_mux_s2m AHBMUX1(
    .HCLK(HCLK),
    .HRESETn(SysRST_N),
    .HRDATAx0(HRDATA_BOOT),
    .HRDATAx1(HRDATA_XTROM),
    .HRDATAx2(HRDATA_MSRAM),
    .HRDATAx7(HRDATA_DUMMY),
    .HSELx0(HSEL_BOOT),
    .HSELx1(HSEL_XTROM),
    .HSELx2(HSEL_MSRAM),
    .HSELx3(1'b0),
    .HSELx4(1'b0),
    .HSELx5(1'b0),
    .HSELx6(1'b0),
    .HSELx7(HSEL_DUMMY),
    .HREADYx0(HREADY_BOOT),
    .HREADYx1(HREADY_XTROM),
    .HREADYx2(HREADY_MSRAM),
    .HREADYx7(HREADY_DUMMY),
    .HRESPx0(HRESP_BOOT),
    .HRESPx7(HRESP_XTROM),
    .HRESPx1(HRESP_MSRAM),
    .HRESPx2(HRESP_DUMMY),
    .HREADY(HREADYM),
    .HRESP(HRESPM),
    .HRDATA(HRDATAM)
    );

    AHB_DUMMY DUMMY1(HSEL_DUMMY,HADDR,HWRITE,HTRANS,HSIZE,HBURST,HWDATA,SysRST_N,
    HCLK,HMASTLOCK,HREADY_DUMMY,HRESP_DUMMY,HRDATA_DUMMY);


    always @ (HADDR)
    if(HADDR==36'hF55AAAA55) 
        begin
            #5 $monitor("Simulation Successfully Finished");
            #5 $stop; //Stop Condition
        end
    else if (HADDR==36'hFAA5555AA)
    begin
        #5 $monitor("Simulation Failed");
        #5 $stop; //Stop Condition
    end
    


endmodule

