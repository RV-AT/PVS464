/*握手：对等发起，如果无正传输的数据即可发起
//0x55AA->发送至对方
//0xAA55<-对方应答
//0xCCCC{LEN}->发送包头2b+2b长度
//{包内容}
//CRC32+0xAA55
*/
module AHB_LVDS
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


    //LVDS Interconnect
    input LVDSCLK,
    output [3:0]LVDST,
    input [3:0]LVDSR,
    output LVDSC,
    output LVDSINT_TFIN,
    output LVDSINT_RFIN,
    output LVDSINT_TERR,
    output LVDSINT_RERR
);
wire hbitsel[7:0];
wire wrdemux[63:0];


// DPBR1K08  LVDSBUF1( 
// 	.doa, 
//     .dia, 
//     .addra, 
//     .cea, 
//     .clka, 
//     .wea,
// 	.dob, 
//     .dib, 
//     .addrb, 
//     .ceb, 
//     .clkb, 
//     .web
// );



endmodule