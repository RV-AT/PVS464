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
  input [31:0] HADDR,
  input HWRITE,
  input [1:0] HTRANS,
  input [2:0] HSIZE,
  input [2:0] HBURST,
  // Data in
  input [31:0] HWDATA,
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
  `ifdef SIMULATION
  output reg [31:0] HRDATA
  `else
   output [31:0] HRDATA
   `endif
);

	BOOTROM BOOTROM1
	(
		.addra(HADDR[16:2]),
		.clka(~HCLK),
		.douta(HRDATA),
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