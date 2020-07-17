/*******************************
//对主机端视作一块可读可写的SRAM
//组成：
//8xB32K 真双口         主机端  /   IOP408          SPM&DMA BUFFER 
//4xB9K  简单双口1R1W   主机端  /   IOP408          IOP408固件区            64x512 / 16 x 2048
//1xB9K  简单双口1R1W   主机端  /   IOP408          IOP408 DETECT/POST区    16x512 / 8x1024
//?????  FIFO          主机端  /   IOP408          Fetch Queue
//4xB9K  真双口         主机端  /   LVDS            互联全局映射BUFFER      64x512 / 64x512
//4xB32K 真双口         IOP408 /   USB SIE         USB数据解析BUFFER        8x1024/8x1024
*******************************/
module AHB_MFSPM
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
    output [63:0] HRDATA,

    //IOP408 
    //I-ROM
    input [10:0]IOPIADDR,
    output [15:0]IOPIDATA,
    //D-RAM
    input [20:0]IOPRADDR,
    input [20:0]IOPWADDR,
    input [7:0]IOPWDATA,
    output[7:0]IOPRDATA,
    output IOPWWAIT,
    output IOPRWAIT

);




endmodule