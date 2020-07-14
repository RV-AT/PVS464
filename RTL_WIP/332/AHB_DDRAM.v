/*
IP: AHB-DDR1 SDRAM Pesudo SRAM Interface
Engineer:HongXY
Device: Anlogic EG4D20EG176
Note:This is a DDR controller designed to be used without any configuration.Specified for the 8MB DDR in the EG4D chip.

*/
module AHB_DDRAM
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
  // Data out
  
   output [31:0] HRDATA,
   
   
);
parameter cCAS = 2;
parameter cRAS = 2;
reg [31:0]DOUT;
reg [15:0]DATP;
reg [15:0]DATN;

EG_PHY_DDR_8M_16 DDR1
    (.clk(SD_CLK),// SDRAM差分时钟正端1bit位宽
    .clk_n(SD_CKN),// SDRAM差分时钟负端1bit位宽
    .ras_n(SD_RAS_N),// SDRAM 行选通1bit位宽
    .cas_n(SD_CAN_N),//SDRAM列选通1bit位宽
    .we_n(SD_WE_N),//SDRAM写使能1bit位宽
    .cs_n(SD_CS_N),        //SDRAM片选信号1bit位宽
    .addr(SD_SA),//SDRAM地址11bits位宽
    .ba(SD_BA),// SDRAM BANK地址2bits位宽
    .dq(SD_DQ),//SDRAM 数据16 bits位宽
    .ldqs(SD_LDQS),        //SDRAM低字节数据选通信号1bit位宽
    .udqs(SD_UDQS),//SDRAM高字节数据选通信号1bit位宽
    .ldm(SD_LDM),//SDRAM低字节数据屏蔽信号1bit位宽
    .udm(SD_UDM),//SDRAM高字节数据屏蔽信号1bit位宽
    .cke(SD_CKE));//SDRAM 时钟使能1bit位宽
    





endmodule