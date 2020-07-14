module AHB_OHCI
(
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
  output reg HREADY,
  output HRESP,
  // Data out
  output reg [63:0] HRDATA,


  //USB Port 
  input USB_i,
  output USB_o,
  output USB_dir
);


endmodule

