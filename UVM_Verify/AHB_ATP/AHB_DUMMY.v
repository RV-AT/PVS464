//`include "compile_param.v"
//`include "ahb_defines.v"

module AHB_DUMMY
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

assign HRESP=0;
assign HREADY=1;
assign HRDATA=0;

endmodule