//`include "compile_param.v"
//`include "ahb_defines.v"

module AHB_ROM
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
  output [1:0] HRESP,
  // Data out
 
   output [63:0] HRDATA

);
wire [63:0]OMUX;
assign HRDATA=OMUX;
wire [31:0]W32;
wire [63:0]DO64;
assign OMUX=(HSEL)?
  (
    (HSIZE==3'b010)?
      ({32'b0,W32}):
      DO64
  ):
  64'b0;
assign W32=(HADDR[2])?(DO64[63:32]):(DO64[31:0]);
	BOOTROM64 BOOTROM1
	(
		.addra(HADDR[13:3]),
		.clka(HCLK),
		.douta(DO64),
		.ena(HSEL)
	);




// --------------------
// Output generation //
// --------------------
// Normal output signals generation
assign HMASTLOCK_o=HMASTLOCK;

assign HRESP=0;
assign HREADY=1;
endmodule