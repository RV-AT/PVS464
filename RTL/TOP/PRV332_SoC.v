`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Nobody but himself
// Engineer: Xiaoyu HONG
// 
// Create Date: 2019/10/13 14:35:41
// Design Name: PVS332
// Module Name: PRV332_SoC
// Project Name: PVS332
// Target Devices: XC7S15
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PRV332_SoC(  
    input CLK,
    input RST_N,
    inout [22:0] AFGPIO, //Bus68K on[7:0] CS[8] WR[9] CKO[10] UART_Tx[11] UART_Rx[12] SPSEL[15:13] Dbg[19:16] EINT[21:20] LED [22]
    //SPI/QPI
	output SPI_CS,
	output SPI_MOSI,
    input SPI_MISO, 
    output SPI_SCLK,
    //SRAM
    output [21:0]SRAM_Addr,
    inout [31:0]SRAM_Data,
	output [3:0]SRAM_BSEL,
    output SRAM_CS,
    output SRAM_WR,
    output SRAM_OE,
	input SRAM_RDY
    );
    //AHB Bus 
    wire SysRST,SysRST_N;
    wire HCLK;
    wire[33:0]HADDR;
    wire HWRITE,HMASTLOCK;
    wire[31:0]HWDATA;
    wire [2:0]HSIZE;
    wire [2:0]HBURST;
    wire [3:0]HPROT;
    wire [1:0]HTRANS;
    //Master side ports (MUXed)
    wire[31:0]HRDATAM;
    wire HREADYM;
	wire [1:0]HRESPM;
    
    
    //AHB Periheral select
    wire HSEL_BOOT;
    wire HSEL_OCRAM;
    wire HSEL_CREGS;
    wire HSEL_CPERI;
	wire HSEL_FLASH;
    wire HSEL_ESRAM;
    wire HSEL_SDRAM;
    wire HSEL_DUMMY;
    
	wire [31:0]HRDATA_BOOT;
	wire [31:0]HRDATA_OCRAM;
	wire [31:0]HRDATA_CREGS;
	wire [31:0]HRDATA_CPERI;
	wire [31:0]HRDATA_FLASH;
	wire [31:0]HRDATA_ESRAM;
	wire [31:0]HRDATA_SDRAM;
	wire [31:0]HRDATA_DUMMY;
	
	wire HREADY_BOOT;
	wire HREADY_OCRAM;
    wire HREADY_CREGS;
    wire HREADY_CPERI;
	wire HREADY_FLASH;
    wire HREADY_ESRAM;
    wire HREADY_SDRAM;
    wire HREADY_DUMMY;
	
	wire [1:0]HRESP_BOOT;
	wire [1:0]HRESP_OCRAM;
	wire [1:0]HRESP_CREGS;
	wire [1:0]HRESP_CPERI;
	wire [1:0]HRESP_FLASH;
	wire [1:0]HRESP_ESRAM;
	wire [1:0]HRESP_SDRAM;
	wire [1:0]HRESP_DUMMY;
	
	//"APB" Periphral select
	wire [31:0]PERISEL;
	wire [31:0]HPDATA_SPI;
	wire [31:0]HPDATA_UART;
	wire [31:0]HPDATA_S68000;
	wire [31:0]HPDATA_GPIOC;
	wire [31:0]HPDATA_TIM;
	
	wire HPREADY_SPI;
	wire HPREADY_UART;
	wire HPREADY_S68000;
	wire HPREADY_GPIOC;
	wire HPREADY_TIM;
	
	wire [2:0]SSEL;
	wire [2:0]PSEL;
	wire [2:0]SPSEL;
	
	wire [31:0]GPIOA_DI;
	wire [31:0]GPIOA_DO;
	wire [31:0]GPIOA_AFC;
	wire [31:0]GPIOA_DIR;
	wire [63:0]GPIOA_PM;
	wire [63:0]GPIOA_PS;
	wire [31:0]AFP_DI;
	wire [7:0]UART_INT;
	wire UART_Rx,UART_Tx;
	wire [3:0]Dbg;
    //intterupt wires
    wire timer_int,soft_int,ext_int;
	wire S68000_WR,S68000_CS,S68000_CKO,S68000_DIR;
	wire [15:0]S68000_DO;
	wire [15:0]S68000_DI;
	assign S68000_DI=AFP_DI[7:0];
	assign UART_Rx=AFP_DI[12];
    assign SysRST=!SysRST_N;
    assign HCLK=CLK;
	assign HSIZE[2]=0;
	
    (* DONT_TOUCH = "true" *)prv332sv0 
	CPU1
	(
		.clk(HCLK),
		.rst(SysRST),
		//中断信号
		.timer_int(timer_int),
		.soft_int(soft_int),
		.ext_int(ext_int),
		//Signal to AHB
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
		.hrdata(HRDATAM)
    
    );
	
	
    ahb_decoder
    BUSMAPPER1
	(
		.HADDR(HADDR),
		.HSELx0(HSEL_BOOT),
		.HSELx7(HSEL_OCRAM),
		.HSELx1(HSEL_CREGS),
		.HSELx2(HSEL_CPERI),
		.HSELx3(HSEL_FLASH),
		.HSELx4(HSEL_ESRAM),
		.HSELx5(HSEL_SDRAM),
		.HSELx6(HSEL_DUMMY)
	);
    

	ahb_mux_s2m
	BUS_MUX1
	(
	  .HCLK(HCLK),
	  .HRESETn(SysRST_N),
	  // Slave datas
	  .HRDATAx0(HRDATA_BOOT),
	  .HRDATAx7(HRDATA_OCRAM),
	  .HRDATAx1(HRDATA_CREGS),
	  .HRDATAx2(HRDATA_CPERI),
	  .HRDATAx3(HRDATA_FLASH),
	  .HRDATAx4(HRDATA_ESRAM),
	  .HRDATAx5(HRDATA_SDRAM),
	  .HRDATAx6(HRDATA_DUMMY),
	  // Control signals
	  .HSELx0(HSEL_BOOT),
	  .HSELx7(HSEL_OCRAM),
	  .HSELx1(HSEL_CREGS),
	  .HSELx2(HSEL_CPERI),
	  .HSELx3(HSEL_FLASH),
	  .HSELx4(HSEL_ESRAM),
	  .HSELx5(HSEL_SDRAM),
	  .HSELx6(HSEL_DUMMY),
	  // Slave responses
	  .HREADYx0(HREADY_BOOT),
	  .HREADYx7(HREADY_OCRAM),
	  .HREADYx1(HREADY_CREGS),
	  .HREADYx2(HREADY_CPERI),
	  .HREADYx3(HREADY_FLASH),
	  .HREADYx4(HREADY_ESRAM),
	  .HREADYx5(HREADY_SDRAM),
	  .HREADYx6(HREADY_DUMMY),

	  .HRESPx0(HRESP_BOOT),
	  .HRESPx7(HRESP_OCRAM),
	  .HRESPx1(HRESP_CREGS),
	  .HRESPx2(HRESP_CPERI),
	  .HRESPx3(HRESP_FLASH),
	  .HRESPx4(HRESP_ESRAM),
	  .HRESPx5(HRESP_SDRAM),
	  .HRESPx6(HRESP_DUMMY),
	  // --------------
	  // Output pins //
	  // --------------
	  .HREADY(HREADYM),
	  .HRESP(HRESPM),
	  .HRDATA(HRDATAM)
	);
	
	AHB_ROM
	ROM1
	(
		.HSEL(HSEL_BOOT),
		.HADDR(HADDR[31:0]),
		.HWRITE(HWRITE),
		.HTRANS(HTRANS),
		.HSIZE(HSIZE),
		.HBURST(HBURST),
		.HWDATA(HWDATA),
		.HRESETn(SysRST_N),
		.HCLK(HCLK),
		.HMASTLOCK(HMASTLOCK),
		.HREADY(HREADY_BOOT),
		.HRESP(HRESP_BOOT),
		.HRDATA(HRDATA_BOOT)
	);
	
	AHB_OCRAM
	OCRAM1(
	  .HSEL(HSEL_OCRAM),
	  // Address and control
	  .HADDR(HADDR[31:0]),
	  .HWRITE(HWRITE),
	  .HTRANS(HTRANS),
	  .HSIZE(HSIZE),
	  .HBURST(HBURST),
	  // Data in
	  .HWDATA(HWDATA),
	  // Reset and clock
	  .HRESETn(SysRST_N),
	  .HCLK(HCLK),
	  .HMASTLOCK(HMASTLOCK),
	  // --------------
	  // Output pins //
	  // --------------
	  // Transfer responses
	  .HREADY(HREADY_OCRAM),
	  .HRESP(HRESP_OCRAM),
	  // Data out
	  .HRDATA(HRDATA_OCRAM)
	);
	
	AHB_CCREG
	CREGS1
	(
		.HSEL(HSEL_CREGS),
		.HADDR(HADDR[31:0]),
		.HWRITE(HWRITE),
		.HTRANS(HTRANS),
		.HSIZE(HSIZE),
		.HBURST(HBURST),
		.HWDATA(HWDATA),
		.HRESETn(SysRST_N),
		.HCLK(HCLK),
		.HMASTLOCK(HMASTLOCK),
		.HREADY(HREADY_CREGS),
		.HRESP(HRESP_CREGS),
		.HRDATA(HRDATA_CREGS),
		.timer_int(timer_int),
		.ext_int(ext_int),
		.soft_int(soft_int),
		.INT_ARR({56'b0,{UART_INT}})
	);
	
	AHB_DUMMY
	AHB_FLASH1
	(
		.HSEL(HSEL_FLASH),
		.HADDR(HADDR[31:0]),
		.HWRITE(HWRITE),
		.HTRANS(HTRANS),
		.HSIZE(HSIZE),
		.HBURST(HBURST),
		.HWDATA(HWDATA),
		.HRESETn(SysRST_N),
		.HCLK(HCLK),
		.HMASTLOCK(HMASTLOCK),
		.HREADY(HREADY_FLASH),
		.HRESP(HRESP_FLASH),
		.HRDATA(HRDATA_FLASH)
	);
	
	ahb_is62
	ExtSRAM1(

		//地址配置
		.addr_cfg(32'h70000000),
		//ahb总线接口
		.hsel(HSEL_ESRAM),
		.haddr(HADDR[31:0]),
		.hwrite(HWRITE),
		.hsize(HSIZE),
		.hburst(HBURST),
		.hprot(HPROT),
		.htrans(HTRANS),
		.hmastlock(HMASTLOCK),
		.hwdata(HWDATA),
		.hresetn(SysRST_N),
		.hclk(HCLK),

		.hreadyout(HREADY_ESRAM),
		.hresp(HRESP_ESRAM),
		.hrdata(HRDATA_ESRAM),

		.data(SRAM_Data),
		.rdy(SRAM_RDY),
		.address(SRAM_Addr),
		.sel32_n(SRAM_BSEL[3]),
		.sel24_n(SRAM_BSEL[2]),
		.sel16_n(SRAM_BSEL[1]),
		.sel8_n(SRAM_BSEL[0]),
		.cs_n(SRAM_CS),
		.wr_n(SRAM_WR),
		.oe_n(SRAM_OE) 

		);
	
	AHB_DUMMY
	AHB_SDRAM1
	(
		.HSEL(HSEL_SDRAM),
		.HADDR(HADDR[31:0]),
		.HWRITE(HWRITE),
		.HTRANS(HTRANS),
		.HSIZE(HSIZE),
		.HBURST(HBURST),
		.HWDATA(HWDATA),
		.HRESETn(SysRST_N),
		.HCLK(HCLK),
		.HMASTLOCK(HMASTLOCK),
		.HREADY(HREADY_SDRAM),
		.HRESP(HRESP_SDRAM),
		.HRDATA(HRDATA_SDRAM)
	);
	
	AHB_DUMMY
	DUMMY1
	(
		.HSEL(HSEL_DUMMY),
		.HADDR(HADDR[31:0]),
		.HWRITE(HWRITE),
		.HTRANS(HTRANS),
		.HSIZE(HSIZE),
		.HBURST(HBURST),
		.HWDATA(HWDATA),
		.HRESETn(SysRST_N),
		.HCLK(HCLK),
		.HMASTLOCK(HMASTLOCK),
		.HREADY(HREADY_DUMMY),
		.HRESP(HRESP_DUMMY),
		.HRDATA(HRDATA_DUMMY)
	);
	
	
	PERI_DECODE
	PERIMAPPER1(
	.HSEL(HSEL_CPERI),
	.HADDR(HADDR[16:7]), //Divide peripheral Address base into 128 Bytes minimum (32 words)
	.SSEL(PERISEL) //Subrange SELect
	);
	assign HRESP_CPERI=0;
	PERI_MUX
	PERIMUX1(
		.HRESETn(SysRST_N),
		.HCLK(HCLK),
		.PERISEL(PERISEL),
		.PERIDATAR(HRDATA_CPERI),
		.PERIREADY(HREADY_CPERI),
		
		.PERIDATA0(HPDATA_SPI),
		.PERIDATA1(HPDATA_UART),
		.PERIDATA2(HPDATA_S68000),
		.PERIDATA3(HPDATA_GPIOC),
		.PERIREADY0(HPREADY_SPI),
		.PERIREADY1(HPREADY_UART),
		.PERIREADY2(HPREADY_S68000),
		.PERIREADY3(HPREADY_GPIOC)
	);
	
	ahb_spi_v0
	AHB_SPI1(
	.addr_cfg(32'h0ffe0000),
	.hsel(PERISEL[1]),
	.haddr(HADDR[31:0]),
	.hwrite(HWRITE),
	.hsize(HSIZE),
	.hburst(HBURST),
	.hprot(HPROT),
	.htrans(HTRANS),
	.hmastlock(HMASTLOCK),
	.hwdata(HWDATA),
	.hresetn(SysRST_N),
	.hclk(HCLK),

	.hreadyout(HPREADY_SPI),
	.hrdata(HPDATA_SPI),
	.ssel(SSEL),
	.cs(SPI_CS),

	.sck(SPI_SCLK),
	.mosi(SPI_MOSI),
	.miso(SPI_MISO)
	);
	
	AHB_UART
	AHB_UART1
	(
		.HSEL(PERISEL[2]),
		.HADDR(HADDR[31:0]),
		.HWRITE(HWRITE),
		.HTRANS(HTRANS),
		.HSIZE(HSIZE),
		.HBURST(HBURST),
		.HWDATA(HWDATA),
		.HRESETn(SysRST_N),
		.HCLK(HCLK),
		.HMASTLOCK(HMASTLOCK),
		.HREADY(HPREADY_UART),
		.HRDATA(HPDATA_UART),
		.UART_Rx(UART_Rx),
		.UART_Tx(UART_Tx),
		.UART_INT(UART_INT)
	);
	 (* DONT_TOUCH = "true" *)AHB_GPIOC
	AHB_GPIOC1
	(
		.HSEL(PERISEL[4]),
		.HADDR(HADDR[31:0]),
		.HWRITE(HWRITE),
		.HTRANS(HTRANS),
		.HSIZE(HSIZE),
		.HBURST(HBURST),
		.HWDATA(HWDATA),
		.HRESETn(SysRST_N),
		.HCLK(HCLK),
		.HMASTLOCK(HMASTLOCK),
		.HREADY(HPREADY_GPIOC),
		.HRDATA(HPDATA_GPIOC),
		.GPIO1_DI(GPIOA_DI),
		.GPIO1_DO(GPIOA_DO),
		.GPIO1_AFC(GPIOA_AFC),
		.GPIO1_DIR(GPIOA_DIR),
		.GPIO1_PM(GPIOA_PM),
		.GPIO1_PS(GPIOA_PS)
	);
	
	
    ahb_reset_ctrl 
    RSTCTRL1
	( 
      .HCLK(HCLK),
      .nPOReset(RST_N),
      .HRESETn(SysRST_N)
     );
	 
	AFIO32
	GPIO_A(
			.IOBUFO(AFGPIO),
			.GPIO_DO(GPIOA_DI),
			.GPIO_DI(GPIOA_DO),
			.GPIO_AFC(GPIOA_AFC),
			.GPIO_DIR(GPIOA_DIR),
			.GPIO_PM(GPIOA_PM),
			.GPIO_PS(GPIOA_PS),
			.AFP_DI({12'h000,Dbg,SPSEL,1'b0,UART_Tx,S68000_CKO,S68000_WR,S68000_CS,S68000_DO[7:0]}),
			.AFP_DIR({12'h000,4'b1111,3'b111,1'b0,1'b1,3'b111,{8{S68000_DIR}}}),
			.AFP_DO(AFP_DI)
		);
     
endmodule
