module APB_PSMCREG
(
  input PCLK,
  input PSEL,
  input PENABLE,
  input PWRITE,
  input [7:0] PADDR,
  input [31:0] PWDATA,
  output [31:0] PRDATA,
  output reg PREADY,
  output reg PSLVERR,
  input RESETN,

  output MOSI,
  input MISO,
  output MCS,
  output MCLKO,
  output reg [31:0]psramc_ctrlreg,  //PSRAMEN[31] SPISendDone[8] SPITx[7:0]
  output reg [31:0]psramc_cycPU,    //tPU Cycles (150us)
  output reg [31:0]psramc_cycCEM   //tCEM Cycles (8us)

);
wire [31:0]spi_o;
assign PRDATA=(
  ({32{PADDR[3:0]==4'h0}}&psramc_ctrlreg)|
  ({32{PADDR[3:0]==4'h0}}&psramc_cycPU)|
  ({32{PADDR[3:0]==4'h0}}&psramc_cycCEM)|
  ({32{PADDR[3]}}&spi_o)
);
always @ (posedge PCLK)
begin
  if(!RESETN)
  begin
    psramc_ctrlreg<=32'b0;
  end
  else
  begin
    if(PSEL&PENABLE&PWRITE)
      begin
        case(PADDR[3:0])
          4'h0:psramc_ctrlreg<=PWDATA;
          4'h1:psramc_cycPU<=PWDATA;
          4'h2:psramc_cycCEM<=PWDATA;
        endcase
      end
  end
end
tiny_spi spi_PSRAMC(
   // system
   .rst_i(!RESETN),
   .clk_i(PCLK),
   // memory mapped
   .stb_i(PENABLE&PADDR[3]),
   .we_i(PSEL&PENABLE&PWRITE),
   .dat_o(spi_o),
   .dat_i(PWDATA),
//   .int_o,
   .adr_i(PADDR[2:0]),
   .cyc_i(PSEL), // comment out for avalon
   //.ack_o, // comment out for avalon

   // spi
   .MOSI(MOSI),
   .SCLK(MCLKO),
   .MISO(MISO)
   );

endmodule
