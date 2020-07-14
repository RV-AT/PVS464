
`define APB_DATA_WIDTH  8
`define SPI_REG_WIDTH   8
`define APB_ADDR_WIDTH  8
//`define CLK_DIV_WIDTH 16
//`timescale 1ns/1ps
module APB_SPI_WRAP
(
// APB SLAVE PORT INTERFACE 
input                             PCLK,
input                             PRESETn,
input [`APB_ADDR_WIDTH-1:0 ]      PADDR,
input                             PWRITE,
input                             PSEL,
input                             PENABLE,
input [`APB_DATA_WIDTH-1:0 ]      PWDATA,
output [`APB_DATA_WIDTH-1:0 ]     PRDATA,
output                            PREADY,
//Interrupt
output wire 					  SPI_INT,
// SPI signals
output scs_o,
output sck_o,
input  miso_i,
output mosi_o,
output [2:0]devs
);

simple_spi_top spi_master_top(
.clk_i(PCLK),         // clock
.rst_i(PRESETn),         // reset (asynchronous active low)
.cyc_i(PSEL),         // cycle
.stb_i(PENABLE),         // strobe
.adr_i(PADDR[7:3]),         // address
.we_i(PWRITE),          // write enable
.dat_i(PWDATA),         // data input
.dat_o(PRDATA),         // data output
.ack_o(PREADY),         // normal bus termination
.inta_o(SPI_INT),        // interrupt output
//SPI INTERFACE
.sck_o(sck_o),         // serial clock output
.mosi_o(mosi_o),        // MasterOut SlaveIN
.miso_i(miso_i),         // MasterIn SlaveOut
.scs_o(scs_o),
.devs_o(devs)
);


endmodule