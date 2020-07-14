module BUS_TB();
	reg RST_N;
    wire SysRST;
	wire SysRST_N;
    reg HCLK;
    reg [33:0]HADDR;
    wire HWRITE,HMASTLOCK;
    wire[31:0]HWDATA;
    reg [1:0]HSIZE;
    wire [2:0]HBURST;
    wire [3:0]HPROT;
    wire [1:0]HTRANS;
    //Master side ports (MUXed)
    wire[31:0]HRDATAM;
    wire HREADYM,HRESPM;
    
    
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
	wire [21:0]SRAM_Addr;
    wire [31:0]SRAM_Data;
	wire [3:0]SRAM_BSEL;
    wire SRAM_CS;
    wire SRAM_WR;
    wire SRAM_OE;
	wire SRAM_RDY;
    //intterupt wires
	assign SysRST=!SysRST_N;
	
	//Crappy master here
	initial
	begin
		#0 HADDR<=0; HCLK<=0; RST_N<=0;
		#10 RST_N<=1;
	
	end 
	wire [14:0]INCREMENT;
	wire [2:0]TSIZE;
	reg [7:0]RAND;
	assign INCREMENT=
	(({15{HSEL_BOOT}}&15'h0004)|
	({15{HSEL_OCRAM|HSEL_ESRAM}}&RAND)|
	({15{HSEL_DUMMY}}&15'h4000)
	
	);
	assign TSIZE=
	(({3{HSEL_BOOT}}&3'h2)|
	({3{HSEL_OCRAM|HSEL_ESRAM}}&(RAND[0]?3'h1:3'h2))|
	({3{HSEL_DUMMY}}&3'h2)
	);
    always #5 HCLK=~HCLK;
	
	always @(posedge HCLK)
	begin
		RAND<=$random;
		if(HREADYM)
		begin
			HADDR<=HADDR+INCREMENT;
			HSIZE<=TSIZE;
		end
		if(HADDR[33:32]!=0)$stop;
	end
   
	
	//Bus related code should be pasted here (exclude the CPU(bus master))
    ahb_decoder
    BUSMAPPER1
	(
		.HADDR(HADDR),
		.HSELx0(HSEL_BOOT),
		.HSELx7(HSEL_OCRAM),
		.HSELx1(HSEL_FLASH),
		.HSELx2(HSEL_CREGS),
		.HSELx3(HSEL_CPERI),
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
	
    ahb_reset_ctrl 
    RSTCTRL1
	( 
      .HCLK(HCLK),
      .nPOReset(RST_N),
      .HRESETn(SysRST_N)
     );
     


endmodule