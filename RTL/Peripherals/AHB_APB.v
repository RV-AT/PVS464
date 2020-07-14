//This is the top module of APB in PVS464A Project
//Targeted at Anlogic EG4D20 
module AHB_APB
(
    // --------------------------
    // Input pins: AHB signals //
    // --------------------------
    // Select
    input HSEL,
    // Address and control
    input [35:0] HADDR,
    input HWRITE,
    input [1:0] HTRANS,
    input [2:0] HSIZE,
    input [2:0] HBURST,
    // Data in
    input [63:0] HWDATA,
    // Reset and clock
    input HRESETn,
    input HCLK,
    input HMASTLOCK,
    // --------------
    // Output pins //
    // --------------
    // Transfer responses
    output HREADY,
    output HRESP,
    // Data out
    output [63:0] HRDATA,

    //USER Ports 
    //PSRAM CONTROLLER
    output MOSI,
    input MISO,
    output MCS,
    output MCLKO,
    output [31:0]psramc_ctrlreg,  //PSRAMEN[31] SPISendDone[8] SPITx[7:0]
    output [15:0]psramc_cycPU,    //tPU Cycles (150us)
    output [15:0]psramc_cycCEM ,
    //UART1
    output uart_txd1,
    input  uart_rxd1,
    //UART2
    output uart_txd2,
    input  uart_rxd2,
    //I2C
    output i2c_sda_write,
    input i2c_sda_read,
    output i2c_scl_write,
    input i2c_scl_read,
    //USPI
    output UOSI,
    input UISO,
    output UCS,
    output UCLKO,
    output [2:0]ssel,
    //INTERRUPTS
    output ext_int,
    output soft_int,
    output timer_int,
    input ECINT,
    input XTINT,
    output MTIME
    

);
wire [31:0] PRDATA,
            PWDATA,
            PADDR;
wire    PREADY,PENABLE,
        PWRITE;

wire PSEL_PSRC,PRESP_PSRC,PREADY_PSRC;
wire [31:0]PRDATA_PSRC;

wire PSEL_UART1,PRESP_UART1,PREADY_UART1;
wire [31:0]PRDATA_UART1;
assign PRESP_UART1=1'b0;

wire PSEL_UART2,PRESP_UART2,PREADY_UART2;
wire [31:0]PRDATA_UART2;
assign PRESP_UART2=1'b0;

wire PSEL_I2C,PRESP_I2C,PREADY_I2C;
wire [31:0]PRDATA_I2C;

wire PSEL_SPI,PRESP_SPI,PREADY_SPI;
wire [31:0]PRDATA_SPI;
assign PRESP_SPI=1'b0;

wire PSEL_MFGPIO,PRESP_MFGPIO,PREADY_MFGPIO;
wire [31:0]PRDATA_MFGPIO;

wire PSEL_CREG,PRESP_CREG,PREADY_CREG;
wire [31:0]PRDATA_CREG;

wire PSEL_DUMMY,PRESP_DUMMY,PREADY_DUMMY;
wire [31:0]PRDATA_DUMMY;
assign PRESP_DUMMY=1'b0;
assign PREADY_DUMMY=1'b1;
assign PRDATA_DUMMY=32'hxxxxxxxx;

wire uart_int1,uart_int2,i2c_int,uspi_int;
wire [63:0]INT_ARR;

apb_ctrl APB_BRIDGE1(
    .hclk(HCLK),
    .hresetn(HRESETn),
    .haddr_i(HADDR[32:1]),
    .htrans_i(HTRANS),
    .hready_o(HREADY),
    .hresp_o(HRESP),
    .hwrite_i(HWRITE),
    .hrdata_o(HRDATA[31:0]),
    .hwdata_i(HWDATA[31:0]),
    .hsel_apb_i(HSEL),
    .prdata_i(PRDATA),
    .hready_r_i(PREADY),
    .pwdata_o(PWDATA),
    .penable_o(PENABLE),
    .paddr_o(PADDR),
    .pwrite_o(PWRITE),
    .pslverr_i(PSLVERR)
);

APB_PSMCREG PSRAMCON(
  .PCLK(HCLK),
  .PSEL(PSEL_PSRC),
  .PENABLE(PENABLE),
  .PWRITE(PWRITE),
  .PADDR(PADDR[7:0]),
  .PWDATA(PWDATA),
  .PRDATA(PRDATA_PSRC),
  .PREADY(PREADY_PSRC),
  .PSLVERR(PRESP_PSRC),
  .RESETN(HRESETn),
  .MOSI(MOSI),
  .MISO(MISO),
  .MCS(MCS),
  .MCLKO(MCLKO),
  .psramc_ctrlreg(psramc_ctrlreg),  //PSRAMEN[31] SPISendDone[8] SPITx[7:0]
  .psramc_cycPU(psramc_cycPU),    //tPU Cycles (150us)
  .psramc_cycCEM(psramc_cycCEM)   //tCEM Cycles (8us)
);

APB_UART_WRAP APBUART1(
     
    .PCLK(HCLK),
    .PRESETn(HRESETn),
    .PADDR(PADDR[7:0]),
    .PWRITE(PWRITE),
    .PSEL(PSEL_UART1),
    .PENABLE(PENABLE),
    .PWDATA(PWDATA),
    .PRDATA(PRDATA_UART1),
    .PREADY(PREADY_UART1),
    .UART_INT(uart_int1) ,
    // UART signals
    .TxD(uart_txd1),
    .RxD(uart_rxd1)
);
  


APB_UART_WRAP APBUART2(
    .PCLK(HCLK),
    .PRESETn(HRESETn),
    .PADDR(PADDR[7:0]),
    .PWRITE(PWRITE),
    .PSEL(PSEL_UART2),
    .PENABLE(PENABLE),
    .PWDATA(PWDATA),
    .PRDATA(PRDATA_UART2),
    .PREADY(PREADY_UART2),
    .UART_INT(uart_int2) ,
    // UART signals
    .TxD(uart_txd2),
    .RxD(uart_rxd2)
);


assign PRESP_I2C=1'b0;
APB_I2C_SLAVE APBI2C1(
// APB SLAVE PORT INTERFACE 
.PCLK(HCLK),
.PRESETn(HRESETn),
.PADDR(PADDR[7:0]),
.PWRITE(PWRITE),
.PSEL(PSEL_I2C),
.PENABLE(PENABLE),
.PWDATA(PWDATA),
.PRDATA(PRDATA_I2C),
.PREADY(PREADY_I2C),
//Interrupt
.I2C_INT(i2c_int),
// I2C signals
// i2c clock line
.scl_pad_i(i2c_scl_read),       // SCL-line input
.scl_padoen_o(i2c_scl_write),    // SCL-line output enable (active low)

// i2c data line
.sda_pad_i(i2c_sda_read),       // SDA-line input
.sda_padoen_o(i2c_sda_write)    // SDA-line output enable (active low)
);

APB_SPI_WRAP APBSPI(
    .PCLK(HCLK),
    .PRESETn(HRESETn),
    .PADDR(PADDR[7:0]),
    .PWRITE(PWRITE),
    .PSEL(PSEL_SPI),
    .PENABLE(PENABLE),
    .PWDATA(PWDATA),
    .PRDATA(PRDATA_SPI),
    .PREADY(PREADY_SPI),
    //Interrupt
    .SPI_INT(uspi_int),
    // SPI signals
    .scs_o(UCS),
    .sck_o(UCLKO),
    .miso_i(UISO),
    .mosi_o(UOSI),
    .devs(ssel)
);
assign INT_ARR={64'b0,XTINT,uart_int2,uart_int1,i2c_int,uspi_int,ECINT};
assign PRESP_CREG=1'b0;
APB_CCREG CTRLREG1(
.PCLK(HCLK),
.PRESETn(HRESETn),
.PADDR(PADDR[16:0]),
.PWRITE(PWRITE),
.PSEL(PSEL_CREG),
.PENABLE(PENABLE),
.PWDATA(PWDATA),
.PRDATA(PRDATA_CREG),
.PREADY(PREADY_CREG),
.timer_int(timer_int),
.ext_int(ext_int),
.soft_int(soft_int),
.INT_ARR(INT_ARR),
.MTIME(MTIME)
);

apb_decoder APBDEC1(
  .PADDR(PADDR),
  .PSELx0(PSEL_PSRC),
  .PSELx1(PSEL_UART1),
  .PSELx2(PSEL_UART2),
  .PSELx3(PSEL_SPI),
  .PSELx4(PSEL_I2C),
  .PSELx5(PSEL_MFGPIO),
  //.PSELx6(),
  .PSELx7(PSEL_CREG),
  .PSELx8(PSEL_DUMMY)
);

apb_mux APBMUX(
  .HCLK(HCLK),
  .HRESETn(HRESETn),
  // Slave datas
  .PRDATAx0(PRDATA_PSRC),
  .PRDATAx1(PRDATA_UART1),
  .PRDATAx2(PRDATA_UART2),
  .PRDATAx3(PRDATA_SPI),
  .PRDATAx4(PRDATA_I2C),
  .PRDATAx5(PRDATA_MFGPIO),
  .PRDATAx6(PRDATA_DUMMY),
  .PRDATAx7(PRDATA_CREG),
  .PRDATAx8(PRDATA_DUMMY),
  // Control signals
  .PSELx0(PSEL_PSRC),
  .PSELx1(PSEL_UART1),
  .PSELx2(PSEL_UART2),
  .PSELx3(PSEL_SPI),
  .PSELx4(PSEL_I2C),
  .PSELx5(PSEL_MFGPIO),
  .PSELx6(PSEL_DUMMY),
  .PSELx7(PSEL_CREG),
  .PSELx8(PSEL_DUMMY),
  // Slave responses
  .PREADYx0(PREADY_PSRC),
  .PREADYx1(PREADY_UART1),
  .PREADYx2(PREADY_UART2),
  .PREADYx3(PREADY_SPI),
  .PREADYx4(PREADY_I2C),
  .PREADYx5(PREADY_MFGPIO),
  .PREADYx6(PREADY_DUMMY),
  .PREADYx7(PREADY_CREG),
  .PREADYx8(PREADY_DUMMY),

  .PRESPx0(PRESP_PSRC),
  .PRESPx1(PRESP_UART1),
  .PRESPx2(PRESP_UART2),
  .PRESPx3(PRESP_SPI),
  .PRESPx4(PRESP_I2C),
  .PRESPx5(PRESP_MFGPIO),
  .PRESPx6(PRESP_DUMMY),
  .PRESPx7(PRESP_CREG),
  .PRESPx8(PRESP_DUMMY), 
  // --------------
  // Output pins //
  // --------------
  .PREADY(PREADY),
  .PRESP(PSLVERR),
  .PRDATA(PRDATA)
);

endmodule
