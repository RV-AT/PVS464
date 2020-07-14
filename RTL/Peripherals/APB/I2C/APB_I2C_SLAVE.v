
`define APB_DATA_WIDTH  8
`define SPI_REG_WIDTH   8
`define APB_ADDR_WIDTH  8
//`define CLK_DIV_WIDTH 16
//`timescale 1ns/1ps
module APB_I2C_SLAVE
(
// APB SLAVE PORT INTERFACE 
input                             PCLK,
input                             PRESETn,
input [`APB_ADDR_WIDTH-1:0 ]      PADDR,
input                             PWRITE,
input                             PSEL,
input                             PENABLE,
input [`APB_DATA_WIDTH-1:0 ]      PWDATA,
output [`APB_DATA_WIDTH-1:0 ] PRDATA,
output                        PREADY,
//Interrupt
output wire 					  I2C_INT,
// I2C signals
// i2c clock line
input  wire scl_pad_i,       // SCL-line input
output wire scl_pad_o,       // SCL-line output (always 1'b0)
output wire scl_padoen_o,    // SCL-line output enable (active low)

// i2c data line
input  wire sda_pad_i,       // SDA-line input
output wire sda_pad_o,       // SDA-line output (always 1'b0)
output wire sda_padoen_o    // SDA-line output enable (active low)
);

i2c_master_top i2c_master_top(
.wb_clk_i		(PCLK), 
.wb_rst_i		(!PRESETn), 
.arst_i			(), 		//NO ASYNC 
.wb_adr_i		(PADDR[7:3]),
.wb_dat_i		(PWDATA), 
.wb_dat_o		(PRDATA),
.wb_we_i		(PWRITE), 
.wb_stb_i		(PENABLE), 	//因为ENABLE信号比PSEL信号延后一个周期，故连接STB
.wb_cyc_i		(PSEL),		//因为PSEL信号在ENABLE信号前一周期出现，所以PSEL信号连接CYC 
.wb_ack_o		(PREADY), 
.wb_inta_o		(I2C_INT),

//I2C INTERFACE
.scl_pad_i		(scl_pad_i), 
.scl_pad_o		(scl_pad_o), 
.scl_padoen_o	(scl_padoen_o), 
.sda_pad_i		(sda_pad_i), 
.sda_pad_o		(sda_pad_o), 
.sda_padoen_o	(sda_padoen_o) 
);


endmodule