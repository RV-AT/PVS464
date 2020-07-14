
/****************************************************************/

module Anlogic_GPR_Sample (
	/*input      [000:000]*/ clk         ,
	/*input      [000:000]*/ clk_en      ,
	/*input  reg [004:000]*/ rd0_addr    ,
	/*input      [004:000]*/ rs1_addr    ,
	/*input      [004:000]*/ rs2_addr    ,
	/*input  reg [063:000]*/ rd0_data    ,
	/*output     [063:000]*/ rs1_data    ,
	/*output     [063:000]*/ rs2_data     
) ;

	input  clk    ;
	input  clk_en ;

/****************************************************************/

	wire clk    ;
	wire clk_en ;

/****************************************************************/

	input  rd0_addr ;
	input  rs1_addr ;
	input  rs2_addr ;
	input  rd0_data ;
	output rs1_data ;
	output rs2_data ;

/****************************************************************/

/*Input*/

	wire [004:000] rd0_addr ;
	wire [004:000] rs1_addr ;
	wire [004:000] rs2_addr ;
	wire [063:000] rd0_data ;

/*Output*/

	wire [063:000] rs1_data ;
	wire [063:000] rs2_data ;

/****************************************************************/

wire w_en ;

assign w_en = ( rd0_addr == 5'b00000 ) ? ( 1'b0 ) : ( clk_en ) ;

/****************************************************************/

LUTRAM_GPR SR1 (
	.wclk  ( clk      ) ,
	.we    ( w_en     ) ,
	.waddr ( rd0_addr ) ,
	.d_i   ( rd0_data ) ,
	.raddr ( rs1_addr ) ,
	.d_o   ( rs1_data )  
) ;

/******************************************************/

LUTRAM_GPR SR2 (
	.wclk  ( clk      ) ,
	.we    ( w_en     ) ,
	.waddr ( rd0_addr ) ,
	.d_i   ( rd0_data ) ,
	.raddr ( rs2_addr ) ,
	.d_o   ( rs2_data )  
) ;

/****************************************************************/

endmodule

/****************************************************************/
/***************************SUB_MODULE***************************/
/****************************************************************/

module LUTRAM_GPR (
	wclk  ,
	we    ,
	waddr ,
	d_i   ,
	raddr ,
	d_o    
) ;

/****************************************************************/

	parameter DATA_WIDTH_W = 64; 
	parameter ADDR_WIDTH_W = 05;
	parameter DATA_DEPTH_W = 32;
	parameter DATA_WIDTH_R = 64;
	parameter ADDR_WIDTH_R = 05;
	parameter DATA_DEPTH_R = 32;

/****************************************************************/

	input  wclk ;
	input  we   ;

/****************************************************************/

	wire wclk ;
	wire we   ;

/****************************************************************/

/*Input*/

	input  d_i   ;
	input  waddr ;
	input  raddr ;

/*Output*/

	output d_o   ;

/****************************************************************/

	wire [DATA_WIDTH_W-1:0] d_i   ;
	wire [ADDR_WIDTH_W-1:0] waddr ;
	wire [ADDR_WIDTH_R-1:0] raddr ;
	wire [DATA_WIDTH_R-1:0] d_o   ;

EG_LOGIC_DRAM # (
		.INIT_FILE    ("Anlogic_GPR_Sample_64bit_INIT.mif") ,
		.DATA_WIDTH_W ( DATA_WIDTH_W ) ,
		.ADDR_WIDTH_W ( ADDR_WIDTH_W ) ,
		.DATA_DEPTH_W ( DATA_DEPTH_W ) ,
		.DATA_WIDTH_R ( DATA_WIDTH_R ) ,
		.ADDR_WIDTH_R ( ADDR_WIDTH_R ) ,
		.DATA_DEPTH_R ( DATA_DEPTH_R ) )
	DRAM_inst (
		.di    ( d_i   ) ,
		.waddr ( waddr ) ,
		.wclk  ( wclk  ) ,
		.we    ( we    ) ,
		.do    ( d_o   ) ,
		.raddr ( raddr )  
) ;

/****************************************************************/

endmodule

/****************************************************************/
