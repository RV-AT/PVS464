module AHB_XIP_TB();

wire [3:0]XPIi,XPIo,XPIdir,XPI;
wire XPICS,XPICLK;

AHB_XIP DUT
(
    .HSEL,
    .HADDR,
    .HWRITE,
    .HTRANS,
    .HSIZE,
    .HBURST,
    .HWDATA,
    .HRESETn,
    .HCLK,
    .HMASTLOCK,
    .HREADY,
    .HRESP,
    .HRDATA,
    .XPIo(XPIo),
    .XPIi(XPIi),
    .XPIdir(XPIdir),
    .XPICS(XPICS),
    .XPICLK(XPICLK)

);

W25Q128JVxIM DEVICE1
(
    .CSn(XPICS),
    .CLK(XPICLK), 
    .DIO(XPI[0]), 
    .DO(XPI[1]), 
    .WPn(XPI[2]), 
    .HOLDn(XPI[3])
);
endmodule