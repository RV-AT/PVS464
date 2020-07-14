module AHB_SDIO
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


    //SDIO port
    output [3:0]SDIO_o,
    input [3:0]SDIO_i,
    output [3:0]SDIO_dir,
    output SDCMD_o,
    input SDCMD_i,
    output SDCMD_dir,
    output SDIOCLK
);

endmodule