

module PVS464_Top
(
/*Global Signals*/
input GCLK,
input RST_N,
/*User QPI Signals*/
inout [3:0]QPIO,
output QCSN,
output QCLK,
/*FSB16 Signals*/
inout [15:0]FBD,
output FCS,
output FWR,
output FAEN,
output FCLK,
output [1:0]FTR,
output FSIZ,
input FINT,
input FDRQ,
input FERR,
/*LVDS Packet Interconnect Signals*/
output [3:0]LVDST,
input [3:0]LVDSR,
output LVDSC,
/*UART Signals*/
input UART0_RX,
output UART0_TX,
input UART1_RX,
output UART1_TX,

/*32b QPI PSRAM Signals*/
inout [31:0]MDAT,
output [7:0]MCS,
output MCLK,

/*Peripheral Signals*/
inout SDA,
inout SCL,
input ECINT,
//SDIO
inout [3:0]SDDAT,
output SDCLK,
inout SDCMD,
//Octal Device SPI
output SCLK,
output SCS,
output MOSI,
output [2:0]SSEL,
input MISO,
//USB
inout USB, 

inout [2:0]GPIOA
);
genvar i;
wire srst,srstn; //System Reset
wire USBi,USBo,USB_dir;
wire prst; //PLL Reset
wire pll_stdby;
assign pll_stdby=0;
wire pllok;
wire mainclk;//96MHz output for main Bus/memory
wire lvdsclk; //240M output for LVDS IODDRx2
wire usbclk;  //48M for USB and FSB

wire [63:0]HADDR;
wire [63:0]MTIME;
wire HWRITE;
wire [1:0]HTRANS;
wire [2:0]HSIZE;
wire [2:0]HBURST;
wire [3:0]HPROT;
wire [63:0]HWDATA;
wire HMASTLOCK;
wire HREADYM,HRESPM;
wire TIMER_INT,SOFT_INT,EXT_INTM,EXT_INTS;
wire BMREQ,BMACK;
assign BMREQ=1'b0;
wire [63:0]HRDATAM;
wire [63:0]mtime;
assign USB=(USB_dir)?(USBo):1'bz;
assign USBi=USB;


wire [63:0]HRDATA_XIP;
wire HSEL_XIP,HREADY_XIP,HRESP_XIP;

wire [63:0]HRDATA_PSRAM;
wire HSEL_PSRAM,HREADY_PSRAM,HRESP_PSRAM;

wire [63:0]HRDATA_SPM;
wire HSEL_SPM,HREADY_SPM,HRESP_SPM;

wire [63:0]HRDATA_USB;
wire HSEL_USB,HREADY_USB,HRESP_USB;

wire [63:0]HRDATA_APB;
wire HSEL_APB,HREADY_APB,HRESP_APB;

wire [63:0]HRDATA_SDIO;
wire HSEL_SDIO,HREADY_SDIO,HRESP_SDIO;

wire [63:0]HRDATA_LVDS;
wire HSEL_LVDS,HREADY_LVDS,HRESP_LVDS;

wire [63:0]HRDATA_FSB;
wire HSEL_FSB,HREADY_FSB,HRESP_FSB;


wire [63:0]HRDATA_DUMMY;
wire HSEL_DUMMY,HREADY_DUMMY,HRESP_DUMMY;

assign EXT_INTS=1'b0;
prv464_top CPU1(
	//用户配置信号
	.cacheability_block(31'h0000_0000),	//可缓存的区，即物理地址[63:31],这个区间里的内存是可以缓存的
	.clk(mainclk),			//时钟信号，和AHB总线同步
	.rst(srst),			//复位信号，高有效，AHB总线的复位信号是空脚
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
	.hreset_n(srstn),
	.hrdata(HRDATAM),

	.bus_master_req(BMREQ),	//总线主机请求，当其他主机需要占用总线时候发出此请求
	.bus_master_ack(BMACK),	//总线主机允许，当464SX处理器结束总线访问且有主机请求之后，此位为1，表示总线可以被占用

	//外部中断信号
	.m_time_int(TIMER_INT),
	.m_soft_int(SOFT_INT),
	.m_ext_int(EXT_INTM),	//对M模式的中断信号
	.s_ext_int(EXT_INTS),	//对S模式的中断信号.
	//mtime寄存器实时值
	.mtime(MTIME));



wire [3:0]QPIo;
wire [3:0]QPIi;
wire [3:0]QPIdir;
assign QPIi=QPIO;
generate for (i=0;i<=3;i=i+1)
begin:qpiioctrl
	assign QPIO[i]=QPIdir[i]?QPIo[i]:1'bz;
end
endgenerate
AHB_XIP XIPROM1(
    .HSEL(HSEL_XIP),
    .HADDR(HADDR),
    .HWRITE(HWRITE),
    .HTRANS(HTRANS),
    .HSIZE(HSIZE),
    .HBURST(HBURST),
    .HWDATA(HWDATA),
    .HRESETn(srstn),
    .HCLK(mainclk),
    .HMASTLOCK(HMASTLOCK),
    .HREADY(HREADY_XIP),
    .HRESP(HRESP_XIP),
    .HRDATA(HRDATA_XIP),

    .XPIo(QPIo),
    .XPIi(QPIi),
    .XPIdir(QPIdir),
    .XPICS(QCSN),
    .XPICLK(QCLK));


wire [15:0]PSC_cycPU;  
wire [15:0]PSC_cycCEM;    
wire [31:0]PSC_ctrlreg;//EN[31]
wire PSC_CCLKO; //SPI CLK
wire PSC_MOSI;
wire PSC_MISO;
wire PSC_MCS;
wire [31:0]MDATo;
wire [31:0]MDATi;
wire [31:0]MDATdir;
assign MDATi=MDAT;
generate for (i=0;i<=31;i=i+1)
begin:memioctrl
	assign MDAT[i]=MDATdir[i]?MDATo[i]:1'bz;
end
endgenerate
AHB_PSRAM PSRAM1(
    .HSEL(HSEL_PSRAM),
    .HADDR(HADDR),
    .HWRITE(HWRITE),
    .HTRANS(HTRANS),
    .HSIZE(HSIZE),
    .HBURST(HBURST),
    .HWDATA(HWDATA),
    .HRESETn(srstn),
    .HCLK(mainclk),
    .HMASTLOCK(HMASTLOCK),
    // Output pins //
    .HREADY(HREADY_PSRAM),
    .HRESP(HRESP_PSRAM),
    .HRDATA(HRDATA_PSRAM),

    .cycPU(PSC_cycPU),  
    .cycCEM(PSC_cycCEM),    
    .psramc_ctrlreg(PSC_ctrlreg),//EN[31]
    .CCLKO(PSC_CCLKO), //SPI CLK
    .MOSI(PSC_MOSI),
    .MISO(PSC_MISO),
    .MSPICS(PSC_MCS),
    //PSRAM Port 
    .MDATo(MDATo),
    .MDATi(MDATi),
    .MDATdir(MDATdir),
    .MCS(MCS),
    .MCLK(MCLK));

AHB_OHCI AHBUSB1
(
	.HSEL(HSEL_USB),
	.HADDR(HADDR[31:0]),
	.HWRITE(HWRITE),
	.HTRANS(HTRANS),
	.HSIZE(HSIZE),
	.HBURST(HBURST),
	.HWDATA(HWDATA),
	.HRESETn(srstn),
	.HCLK(mainclk),
	.HMASTLOCK(HMASTLOCK),
	.HREADY(HREADY_USB),
	.HRESP(HRESP_USB),
	.HRDATA(HRDATA_USB),
	.USB_i(USBi),
	.USB_o(USBo),
	.USB_dir(USB_dir));

wire [3:0]SDIOo;
wire [3:0]SDIOi;
wire [3:0]SDIOdir;
wire SDCMDi,SDCMDo,SDCMDdir;
assign SDIOi=SDDAT;
generate for (i=0;i<=3;i=i+1)
begin:sdioctrl
	assign SDDAT[i]=SDIOdir[i]?SDIOo[i]:1'bz;
end
endgenerate
assign SDCMDi=SDCMD;
assign SDCMD=SDCMDdir?SDCMDo:1'bz;
AHB_SDIO SDIO1(
    .HSEL(HSEL_SDIO),
	.HADDR(HADDR[31:0]),
	.HWRITE(HWRITE),
	.HTRANS(HTRANS),
	.HSIZE(HSIZE),
	.HBURST(HBURST),
	.HWDATA(HWDATA),
	.HRESETn(srstn),
	.HCLK(mainclk),
	.HMASTLOCK(HMASTLOCK),
    // Output pins //
    .HREADY(HREADY_SDIO),
    .HRESP(HRESP_SDIO),
    .HRDATA(HRDATA_SDIO),
    .SDIO_o(SDIOo),
    .SDIO_i(SDIOi),
    .SDIO_dir(SDIOdir),
    .SDCMD_o(SDCMDo),
    .SDCMD_i(SDCMDi),
    .SDCMD_dir(SDCMDdir),
    .SDIOCLK(SDCLK));

wire i2c_scl_read,i2c_scl_write,i2c_sda_read,i2c_sda_write;
assign SCL=(i2c_scl_write)?1'bz:1'b0;
assign i2c_scl_read=SCL;
assign SDA=(i2c_sda_write)?1'bz:1'b0;
assign i2c_sda_read=SDA;
wire FINTi;


AHB_APB APB1(
    .HSEL(HSEL_APB),
	.HADDR(HADDR[31:0]),
	.HWRITE(HWRITE),
	.HTRANS(HTRANS),
	.HSIZE(HSIZE),
	.HBURST(HBURST),
	.HWDATA(HWDATA),
	.HRESETn(srstn),
	.HCLK(mainclk),
	.HMASTLOCK(HMASTLOCK),
    //Output pins //
    .HREADY(HREADY_APB),
    .HRESP(HRESP_APB),
    .HRDATA(HRDATA_APB),

	.psramc_cycPU(PSC_cycPU),  
    .psramc_cycCEM(PSC_cycCEM),    
    .psramc_ctrlreg(PSC_ctrlreg),//EN[31]
    .MOSI(PSC_MOSI),
    .MISO(PSC_MISO),
    .MCS(PSC_MCS),
    .MCLKO(PSC_CCLKO),
    //UART1
    .uart_txd1(UART0_TX),
    .uart_rxd1(UART0_RX),
    //UART2
    .uart_txd2(UART1_TX),
    . uart_rxd2(UART1_RX),
    //I2C
    .i2c_sda_write(i2c_sda_write),
    .i2c_sda_read(i2c_sda_read),
    .i2c_scl_write(i2c_scl_write),
    .i2c_scl_read(i2c_scl_read),
    //USPI
    .UOSI(MOSI),
    .UISO(MISO),
    .UCS(SCS),
    .UCLKO(SCLK),
    .ssel(SSEL),
    //INTERRUPT
    .timer_int(TIMER_INT),
	.ext_int(EXT_INTM),
	.soft_int(SOFT_INT),
    .ECINT(ECINT),
    .MTIME(MTIME),
    .XTINT(FINTi)
	);

wire [15:0]FBDo;
wire [15:0]FBDi;
wire FBDdir;
assign FBDi=FBD;
assign FBD=FBDdir?16'bzzzz:FBDo;
assign FCS=HSEL_FSB;
AHB_FSB16 FSB1(
.hclk(mainclk),
.hreset_n(srstn),
.hsel(HSEL_FSB),
.hsize(HSIZE),
.htrans(HTRANS),
.hwrite(HWRITE),
.haddr(HADDR[31:0]),	//本桥只占用地址的低32位空间
.hwdata(HWDATA),
.hrdata(HRDATA_FSB),
.hresp(HRESP_FSB),
.hready(HREADY_FSB),
//fsb16信号
.clk(FCLK),
.aen(FAEN),
.size(FSIZ),
.wr_n(FWR),
.error_n(FERR),
.irq_n(FINT|FDRQ),
.Hi_z(FBDdir),	//拉高之后表示高阻态
.AD_out(FBDo),
.AD_in(FBDi),
//对内部中断控制器信号
.FSB_irq(FINTi)

);

AHB_LVDS INTERCON1(
    .HSEL(HSEL_LVDS),
    .HADDR(HADDR),
    .HWRITE(HWRITE),
    .HTRANS(HTRANS),
    .HSIZE(HSIZE),
    .HBURST(HBURST),
    .HWDATA(HWDATA),
    .HRESETn(srstn),
    .HCLK(mainclk),
    .HMASTLOCK(HMASTLOCK),
    // --------------
    // Output pins //
    // --------------
    .HREADY(HREADY_LVDS),
    .HRESP(HRESP_LVDS),
    .HRDATA(HRDATA_LVDS),
    .LVDSCLK(lvdsclk),
    .LVDST(LVDST),
    .LVDSR(LVDSR),
    .LVDSC(LVDSC));

AHB_DUMMY DUMMY(
	.HSEL(HSEL_DUMMY),
	.HADDR(HADDR[31:0]),
	.HWRITE(HWRITE),
	.HTRANS(HTRANS),
	.HSIZE(HSIZE),
	.HBURST(HBURST),
	.HWDATA(HWDATA),
	.HRESETn(srstn),
	.HCLK(mainclk),
	.HMASTLOCK(HMASTLOCK),
    // Output pins //
    .HREADY(HREADY_DUMMY),
    .HRESP(HRESP_DUMMY),
    .HRDATA(HRDATA_DUMMY));

ahb_decoder DEC1(
    .HADDR(HADDR),
    .HSELx0(HSEL_XIP),
    .HSELx1(HSEL_PSRAM), 
    .HSELx2(HSEL_SPM),
	.HSELx3(HSEL_SDIO),
	.HSELx4(HSEL_APB),
	.HSELx5(HSEL_USB),
	.HSELx6(HSEL_FSB),
	.HSELx7(HSEL_LVDS),
    .HSELx8(HSEL_DUMMY) );

ahb_mux_s2m AHBMUX1(
    .HCLK(mainclk),
    .HRESETn(srstn),

    .HSELx0(HSEL_XIP),
    .HSELx1(HSEL_PSRAM),
    .HSELx2(HSEL_SPM),
    .HSELx3(HSEL_SDIO),
    .HSELx4(HSEL_APB),
    .HSELx5(HSEL_USB),
    .HSELx6(HSEL_FSB),
	.HSELx7(HSEL_LVDS),
    .HSELx8(HSEL_DUMMY),

    .HRDATAx0(HRDATA_BOOT),
    .HRDATAx1(HRDATA_XTROM),
    .HRDATAx2(HRDATA_SPM),
	.HRDATAx3(HRDATA_SDIO),
	.HRDATAx4(HRDATA_APB),
	.HRDATAx5(HRDATA_USB),
	.HRDATAx6(HRDATA_FSB),
    .HRDATAx7(HRDATA_LVDS),
	.HRDATAx8(HRDATA_DUMMY),

    .HREADYx0(HREADY_XIP),
    .HREADYx1(HREADY_PSRAM),
    .HREADYx2(HREADY_SPM),
	.HREADYx3(HREADY_SDIO),
	.HREADYx4(HREADY_APB),
	.HREADYx5(HREADY_USB),
	.HREADYx6(HREADY_FSB),
    .HREADYx7(HREADY_LVDS),
	.HREADYx8(HREADY_DUMMY),

    .HRESPx0(HRESP_XIP),
    .HRESPx1(HRESP_PSRAM),
    .HRESPx2(HRESP_SPM),
	.HRESPx3(HRESP_SDIO),
	.HRESPx4(HRESP_APB),
	.HRESPx5(HRESP_USB),
	.HRESPx6(HRESP_FSB),
	.HRESPx7(HRESP_LVDS),
	.HRESPx8(HRESP_DUMMY),

    .HREADY(HREADYM),
    .HRESP(HRESPM),
    .HRDATA(HRDATAM)
    );

MainPLL MAINPLL
(	.refclk(GCLK),
	.reset(prst),
	.stdby(pll_stdby),
	//.dclk(),
	//.dcs(),
	//.dwe(),
	//.di(),
	//.do(),
	//.daddr,
	.extlock(pllok),
	.clk0_out(lvdsclk),
	.clk1_out(mainclk),
	.clk2_out(usbclk));

RST_CON RSTController
(	.INCLK(GCLK),
	.RST_N(RST_N),
	.PLLRDY(pllok),
	.PLLRST(prst),
	.SYSRST(srst),
	.SYSRST_N(srstn));




endmodule
