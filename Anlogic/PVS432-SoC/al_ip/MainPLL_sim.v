// Verilog netlist created by TD v4.6.14756
// Wed May 20 11:19:06 2020

`timescale 1ns / 1ps
module MainPLL  // al_ip/MainPLL.v(25)
  (
  daddr,
  dclk,
  dcs,
  di,
  dwe,
  refclk,
  reset,
  stdby,
  clk0_out,
  clk1_out,
  clk2_out,
  clk3_out,
  do,
  extlock
  );

  input [5:0] daddr;  // al_ip/MainPLL.v(47)
  input dclk;  // al_ip/MainPLL.v(43)
  input dcs;  // al_ip/MainPLL.v(44)
  input [7:0] di;  // al_ip/MainPLL.v(46)
  input dwe;  // al_ip/MainPLL.v(45)
  input refclk;  // al_ip/MainPLL.v(40)
  input reset;  // al_ip/MainPLL.v(41)
  input stdby;  // al_ip/MainPLL.v(42)
  output clk0_out;  // al_ip/MainPLL.v(50)
  output clk1_out;  // al_ip/MainPLL.v(51)
  output clk2_out;  // al_ip/MainPLL.v(52)
  output clk3_out;  // al_ip/MainPLL.v(53)
  output [7:0] do;  // al_ip/MainPLL.v(49)
  output extlock;  // al_ip/MainPLL.v(48)

  wire clk0_buf;  // al_ip/MainPLL.v(55)

  EG_PHY_GCLK bufg_feedback (
    .clki(clk0_buf),
    .clko(clk0_out));  // al_ip/MainPLL.v(57)
  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  EG_PHY_PLL #(
    .CLKC0_CPHASE(3),
    .CLKC0_DIV(4),
    .CLKC0_DIV2_ENABLE("DISABLE"),
    .CLKC0_ENABLE("ENABLE"),
    .CLKC0_FPHASE(0),
    .CLKC1_CPHASE(15),
    .CLKC1_DIV(16),
    .CLKC1_DIV2_ENABLE("DISABLE"),
    .CLKC1_ENABLE("ENABLE"),
    .CLKC1_FPHASE(0),
    .CLKC2_CPHASE(19),
    .CLKC2_DIV(20),
    .CLKC2_DIV2_ENABLE("DISABLE"),
    .CLKC2_ENABLE("ENABLE"),
    .CLKC2_FPHASE(0),
    .CLKC3_CPHASE(7),
    .CLKC3_DIV(8),
    .CLKC3_DIV2_ENABLE("DISABLE"),
    .CLKC3_ENABLE("ENABLE"),
    .CLKC3_FPHASE(0),
    .CLKC4_CPHASE(1),
    .CLKC4_DIV(1),
    .CLKC4_DIV2_ENABLE("DISABLE"),
    .CLKC4_ENABLE("DISABLE"),
    .CLKC4_FPHASE(0),
    .DERIVE_PLL_CLOCKS("DISABLE"),
    .DPHASE_SOURCE("DISABLE"),
    .DYNCFG("ENABLE"),
    .FBCLK_DIV(24),
    .FEEDBK_MODE("NORMAL"),
    .FEEDBK_PATH("CLKC0_EXT"),
    .FIN("50.000"),
    .FREQ_LOCK_ACCURACY(2),
    .GEN_BASIC_CLOCK("DISABLE"),
    .GMC_GAIN(0),
    .GMC_TEST(14),
    .ICP_CURRENT(9),
    .IF_ESCLKSTSW("DISABLE"),
    .INTFB_WAKE("DISABLE"),
    .KVCO(2),
    .LPF_CAPACITOR(2),
    .LPF_RESISTOR(8),
    .NORESET("DISABLE"),
    .ODIV_MUXC0("DIV"),
    .ODIV_MUXC1("DIV"),
    .ODIV_MUXC2("DIV"),
    .ODIV_MUXC3("DIV"),
    .ODIV_MUXC4("DIV"),
    .PLLC2RST_ENA("DISABLE"),
    .PLLC34RST_ENA("DISABLE"),
    .PLLMRST_ENA("DISABLE"),
    .PLLRST_ENA("ENABLE"),
    .PLL_LOCK_MODE(0),
    .PREDIV_MUXC0("VCO"),
    .PREDIV_MUXC1("VCO"),
    .PREDIV_MUXC2("VCO"),
    .PREDIV_MUXC3("VCO"),
    .PREDIV_MUXC4("VCO"),
    .REFCLK_DIV(5),
    .REFCLK_SEL("INTERNAL"),
    .STDBY_ENABLE("ENABLE"),
    .STDBY_VCO_ENA("DISABLE"),
    .SYNC_ENABLE("DISABLE"),
    .VCO_NORESET("DISABLE"))
    pll_inst (
    .daddr(daddr),
    .dclk(dclk),
    .dcs(dcs),
    .di(di),
    .dwe(dwe),
    .fbclk(clk0_out),
    .psclk(1'b0),
    .psclksel(3'b000),
    .psdown(1'b0),
    .psstep(1'b0),
    .refclk(refclk),
    .reset(reset),
    .stdby(stdby),
    .clkc({open_n47,clk3_out,clk2_out,clk1_out,clk0_buf}),
    .do(do),
    .extlock(extlock));  // al_ip/MainPLL.v(92)

endmodule 

