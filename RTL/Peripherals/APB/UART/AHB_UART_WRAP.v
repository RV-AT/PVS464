
`define APB_DATA_WIDTH  8
`define SPI_REG_WIDTH   8
`define APB_ADDR_WIDTH  8
//`define CLK_DIV_WIDTH 16
//`timescale 1ns/1ps
module APB_UART_WRAP
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
    output wire 					  UART_INT,
    // UART signals
    output TxD,
    `ifdef USE_FUNC_MODEM
        input  RxD,
        output rts_pad_o, 
        input  cts_pad_i, 
        output dtr_pad_o, 
        input  dsr_pad_i, 
        input  ri_pad_i, 
        input  dcd_pad_i
    `else
        input  RxD
    `endif
);



uart_top	WB_UART(
	.wb_clk_i(PCLK), 
	.wb_rst_i(!PRESETn), 
    .wb_adr_i(PADDR[7:3]), 
    .wb_dat_i({24'b0,PWDATA}), 
    .wb_dat_o(PRDATA), 
    .wb_we_i(PWRITE), 
    .wb_stb_i(PENABLE), 
    .wb_cyc_i(PSEL), 
    .wb_ack_o(PREADY), 
    .wb_sel_i({4{PSEL}}),
	.int_o(UART_INT), // interrupt request

	// UART	signals
	// serial input/output
	.stx_pad_o(TxD), 
    .srx_pad_i(RxD),

	// modem signals
    `ifdef USE_FUNC_MODEM
        .rts_pad_o(rts_pad_o), 
        .cts_pad_i(cts_pad_i), 
        .dtr_pad_o(dtr_pad_o), 
        .dsr_pad_i(dsr_pad_i), 
        .ri_pad_i(ri_pad_i), 
        .dcd_pad_i(dcd_pad_i)
    `else
        .cts_pad_i(1'b0), 
        .dsr_pad_i(1'b0), 
        .ri_pad_i(1'b1), 
        .dcd_pad_i(1'b0)
    `endif
	);

endmodule

