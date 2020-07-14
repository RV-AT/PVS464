// Verilog netlist created by TD v4.6.14756
// Tue May 19 10:52:18 2020

`timescale 1ns / 1ps
module BRAM32K_16  // al_ip/BRAM32K_16.v(14)
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

  input [11:0] addra;  // al_ip/BRAM32K_16.v(25)
  input [11:0] addrb;  // al_ip/BRAM32K_16.v(26)
  input cea;  // al_ip/BRAM32K_16.v(29)
  input ceb;  // al_ip/BRAM32K_16.v(30)
  input clka;  // al_ip/BRAM32K_16.v(31)
  input clkb;  // al_ip/BRAM32K_16.v(32)
  input [15:0] dia;  // al_ip/BRAM32K_16.v(23)
  input [15:0] dib;  // al_ip/BRAM32K_16.v(24)
  input [1:0] wea;  // al_ip/BRAM32K_16.v(27)
  input [1:0] web;  // al_ip/BRAM32K_16.v(28)
  output [15:0] doa;  // al_ip/BRAM32K_16.v(19)
  output [15:0] dob;  // al_ip/BRAM32K_16.v(20)


  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  // address_offset=0;data_offset=0;depth=4096;width=8;num_section=1;width_per_section=8;section_size=16;working_depth=4096;working_width=8;address_step=1;bytes_in_per_section=1;
  EG_PHY_BRAM32K #(
    .DATA_WIDTH_A("8"),
    .DATA_WIDTH_B("8"),
    .MODE("DP16K"),
    .OCEAMUX("0"),
    .OCEBMUX("0"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RSTAMUX("0"),
    .RSTBMUX("0"),
    .SRMODE("SYNC"),
    .WRITEMODE_A("NORMAL"),
    .WRITEMODE_B("NORMAL"))
    inst_4096x16_sub_000000_000 (
    .addra(addra[11:1]),
    .addrb(addrb[11:1]),
    .bytea(addra[0]),
    .byteb(addrb[0]),
    .clka(clka),
    .clkb(clkb),
    .csa(cea),
    .csb(ceb),
    .dia({open_n49,open_n50,open_n51,open_n52,open_n53,open_n54,open_n55,open_n56,dia[7:0]}),
    .dib({open_n57,open_n58,open_n59,open_n60,open_n61,open_n62,open_n63,open_n64,dib[7:0]}),
    .wea(wea[0]),
    .web(web[0]),
    .doa({open_n69,open_n70,open_n71,open_n72,open_n73,open_n74,open_n75,open_n76,doa[7:0]}),
    .dob({open_n77,open_n78,open_n79,open_n80,open_n81,open_n82,open_n83,open_n84,dob[7:0]}));
  // address_offset=0;data_offset=8;depth=4096;width=8;num_section=1;width_per_section=8;section_size=16;working_depth=4096;working_width=8;address_step=1;bytes_in_per_section=1;
  EG_PHY_BRAM32K #(
    .DATA_WIDTH_A("8"),
    .DATA_WIDTH_B("8"),
    .MODE("DP16K"),
    .OCEAMUX("0"),
    .OCEBMUX("0"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RSTAMUX("0"),
    .RSTBMUX("0"),
    .SRMODE("SYNC"),
    .WRITEMODE_A("NORMAL"),
    .WRITEMODE_B("NORMAL"))
    inst_4096x16_sub_000000_008 (
    .addra(addra[11:1]),
    .addrb(addrb[11:1]),
    .bytea(addra[0]),
    .byteb(addrb[0]),
    .clka(clka),
    .clkb(clkb),
    .csa(cea),
    .csb(ceb),
    .dia({open_n87,open_n88,open_n89,open_n90,open_n91,open_n92,open_n93,open_n94,dia[15:8]}),
    .dib({open_n95,open_n96,open_n97,open_n98,open_n99,open_n100,open_n101,open_n102,dib[15:8]}),
    .wea(wea[1]),
    .web(web[1]),
    .doa({open_n107,open_n108,open_n109,open_n110,open_n111,open_n112,open_n113,open_n114,doa[15:8]}),
    .dob({open_n115,open_n116,open_n117,open_n118,open_n119,open_n120,open_n121,open_n122,dob[15:8]}));

endmodule 

