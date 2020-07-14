
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

reg [63:00] RS1 [31:00] ;
reg [63:00] RS2 [31:00] ;

always @ ( posedge clk ) begin
	if ( w_en ) begin
		RS1 [ rd0_addr ] <= rd0_data ;
		RS2 [ rd0_addr ] <= rd0_data ;
	end
end

assign rs1_data = RS1 [ rs1_addr ] ;
assign rs2_data = RS2 [ rs2_addr ] ;

/****************************************************************/

endmodule
