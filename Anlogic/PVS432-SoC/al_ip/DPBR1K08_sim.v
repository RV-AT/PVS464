// Verilog netlist created by TD v4.6.14756
// Tue May 26 00:57:15 2020

`timescale 1ns / 1ps
module DPBR1K08  // al_ip/DPBR1K08.v(14)
  (
  addra,
  addrb,
  cea,
  ceb,
  clka,
  clkb,
  dia,
  dib,
  wea,
  web,
  doa,
  dob
  );

  input [9:0] addra;  // al_ip/DPBR1K08.v(25)
  input [9:0] addrb;  // al_ip/DPBR1K08.v(26)
  input cea;  // al_ip/DPBR1K08.v(29)
  input ceb;  // al_ip/DPBR1K08.v(30)
  input clka;  // al_ip/DPBR1K08.v(31)
  input clkb;  // al_ip/DPBR1K08.v(32)
  input [8:0] dia;  // al_ip/DPBR1K08.v(23)
  input [8:0] dib;  // al_ip/DPBR1K08.v(24)
  input wea;  // al_ip/DPBR1K08.v(27)
  input web;  // al_ip/DPBR1K08.v(28)
  output [8:0] doa;  // al_ip/DPBR1K08.v(19)
  output [8:0] dob;  // al_ip/DPBR1K08.v(20)


  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  // address_offset=0;data_offset=0;depth=1024;width=9;num_section=1;width_per_section=9;section_size=9;working_depth=1024;working_width=9;address_step=1;bytes_in_per_section=1;
  EG_PHY_BRAM #(
    .CSA0("1"),
    .CSA1("1"),
    .CSA2("1"),
    .CSB0("1"),
    .CSB1("1"),
    .CSB2("1"),
    .DATA_WIDTH_A("9"),
    .DATA_WIDTH_B("9"),
    .MODE("DP8K"),
    .OCEAMUX("0"),
    .OCEBMUX("0"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("SYNC"),
    .RSTAMUX("0"),
    .RSTBMUX("0"),
    .WRITEMODE_A("NORMAL"),
    .WRITEMODE_B("NORMAL"))
    inst_1024x9_sub_000000_000 (
    .addra({addra,3'b111}),
    .addrb({addrb,3'b111}),
    .cea(cea),
    .ceb(ceb),
    .clka(clka),
    .clkb(clkb),
    .dia(dia),
    .dib(dib),
    .wea(wea),
    .web(web),
    .doa(doa),
    .dob(dob));

endmodule 

