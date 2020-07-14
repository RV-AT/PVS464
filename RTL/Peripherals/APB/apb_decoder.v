
module apb_decoder
(
  // -------------
  // Input pins //
  // -------------
  input [31:0] PADDR,
  // --------------
  // Output pins //
  // --------------
  output PSELx0,
  output PSELx1,
  output PSELx2,
  output PSELx3,
  output PSELx4,
  output PSELx5,
  output PSELx6,
  output PSELx7,
  output PSELx8
);
/*
     全范围大段            中段           外设最小段          忽略
 [ 31    :     17 ]    [16    :    9]  [8   :    3]   [2   :   0]
 Big mseg number_____mseg number__ Small mseg___   Offset
*/

//段号译码
parameter seg0  = 8'h00;
parameter seg1  = 8'h01;
parameter seg2  = 8'h02;
parameter seg3  = 8'h03;
parameter seg4  = 8'h04;
parameter seg5  = 8'h05;
parameter seg6  = 8'h06;
parameter seg7  = 8'h07;
parameter seg8  = 8'h08;
parameter seg9  = 8'h09;
parameter seg10 = 8'h0A;
parameter seg11 = 8'h0B;
parameter seg12 = 8'h0C;
parameter seg13 = 8'h0D;
parameter seg14 = 8'h0E;
parameter seg15 = 8'h0F;
parameter seg16 = 8'h10;
parameter seg17 = 8'h11;
parameter seg18 = 8'h12;
parameter seg19 = 8'h13;
parameter seg20 = 8'h14;
parameter seg21 = 8'h15;
parameter seg22 = 8'h16;
parameter seg23 = 8'h17;
parameter seg24 = 8'h18;
parameter seg25 = 8'h19;
parameter seg26 = 8'h1A;
parameter seg27 = 8'h1B;
parameter seg28 = 8'h1C;
parameter seg29 = 8'h1D;
parameter seg30 = 8'h1E;
parameter seg31 = 8'h1F;



//小段号译码
wire sseg0;
wire sseg1;
wire sseg2;
wire sseg3;
wire sseg4;
wire sseg5;
wire sseg6;
wire sseg7;
wire sseg8;
wire sseg9;
wire sseg10;
wire sseg11;
wire sseg12;
wire sseg13;
wire sseg14;
wire sseg15;
wire sseg16;
wire sseg17;
wire sseg18;
wire sseg19;
wire sseg20;
wire sseg21;
wire sseg22;
wire sseg23;
wire sseg24;
wire sseg25;
wire sseg26;
wire sseg27;
wire sseg28;
wire sseg29;
wire sseg30;
wire sseg31;
//段号译码
wire mseg0;
wire mseg1;
wire mseg2;
wire mseg3;
wire mseg4;
wire mseg5;
wire mseg6;
wire mseg7;
wire mseg8;
wire mseg9;
wire mseg10;
wire mseg11;
wire mseg12;
wire mseg13;
wire mseg14;
wire mseg15;
wire mseg16;
wire mseg17;
wire mseg18;
wire mseg19;
wire mseg20;
wire mseg21;
wire mseg22;
wire mseg23;
wire mseg24;
wire mseg25;
wire mseg26;
wire mseg27;
wire mseg28;
wire mseg29;
wire mseg30;
wire mseg31;
//大段号译码
wire bseg0;
wire bseg1;
wire bseg2;
wire bseg3;
wire bseg4;
wire bseg5;
wire bseg6;
wire bseg7;
wire bseg8;
wire bseg9;
wire bseg10;
wire bseg11;
wire bseg12;
wire bseg13;
wire bseg14;
wire bseg15;
assign sseg0 = (PADDR[15:8]==seg0);
assign sseg1 = (PADDR[15:8]==seg1);
assign sseg2 = (PADDR[15:8]==seg2);
assign sseg3 = (PADDR[15:8]==seg3);
assign sseg4 = (PADDR[15:8]==seg4);
assign sseg5 = (PADDR[15:8]==seg5);
assign sseg6 = (PADDR[15:8]==seg6);
assign sseg7 = (PADDR[15:8]==seg7);
assign sseg8 = (PADDR[15:8]==seg8);
assign sseg9 = (PADDR[15:8]==seg9);
assign sseg10 = (PADDR[15:8]==seg10);
assign sseg11 = (PADDR[15:8]==seg11);
assign sseg12 = (PADDR[15:8]==seg12);
assign sseg13 = (PADDR[15:8]==seg13);
assign sseg14 = (PADDR[15:8]==seg14);
assign sseg15 = (PADDR[15:8]==seg15);
assign sseg16 = (PADDR[15:8]==seg16);
assign sseg17 = (PADDR[15:8]==seg17);
assign sseg18 = (PADDR[15:8]==seg18);
assign sseg19 = (PADDR[15:8]==seg19);
assign sseg20 = (PADDR[15:8]==seg20);
assign sseg21 = (PADDR[15:8]==seg21);
assign sseg22 = (PADDR[15:8]==seg22);
assign sseg23 = (PADDR[15:8]==seg23);
assign sseg24 = (PADDR[15:8]==seg24);
assign sseg25 = (PADDR[15:8]==seg25);
assign sseg26 = (PADDR[15:8]==seg26);
assign sseg27 = (PADDR[15:8]==seg27);
assign sseg28 = (PADDR[15:8]==seg28);
assign sseg29 = (PADDR[15:8]==seg29);
assign sseg30 = (PADDR[15:8]==seg30);
assign sseg31 = (PADDR[15:8]==seg31);

assign mseg0 = (PADDR[23:16]==seg0);
assign mseg1 = (PADDR[23:16]==seg1);
assign mseg2 = (PADDR[23:16]==seg2);
assign mseg3 = (PADDR[23:16]==seg3);
assign mseg4 = (PADDR[23:16]==seg4);
assign mseg5 = (PADDR[23:16]==seg5);
assign mseg6 = (PADDR[23:16]==seg6);
assign mseg7 = (PADDR[23:16]==seg7);
assign mseg8 = (PADDR[23:16]==seg8);
assign mseg9 = (PADDR[23:16]==seg9);
assign mseg10 = (PADDR[23:16]==seg10);
assign mseg11 = (PADDR[23:16]==seg11);
assign mseg12 = (PADDR[23:16]==seg12);
assign mseg13 = (PADDR[23:16]==seg13);
assign mseg14 = (PADDR[23:16]==seg14);
assign mseg15 = (PADDR[23:16]==seg15);
assign mseg16 = (PADDR[23:16]==seg16);
assign mseg17 = (PADDR[23:16]==seg17);
assign mseg18 = (PADDR[23:16]==seg18);
assign mseg19 = (PADDR[23:16]==seg19);
assign mseg20 = (PADDR[23:16]==seg20);
assign mseg21 = (PADDR[23:16]==seg21);
assign mseg22 = (PADDR[23:16]==seg22);
assign mseg23 = (PADDR[23:16]==seg23);
assign mseg24 = (PADDR[23:16]==seg24);
assign mseg25 = (PADDR[23:16]==seg25);
assign mseg26 = (PADDR[23:16]==seg26);
assign mseg27 = (PADDR[23:16]==seg27);
assign mseg28 = (PADDR[23:16]==seg28);
assign mseg29 = (PADDR[23:16]==seg29);
assign mseg30 = (PADDR[23:16]==seg30);
assign mseg31 = (PADDR[23:16]==seg31);

assign bseg0 = (PADDR[31:24]==seg0);
assign bseg1 = (PADDR[31:24]==seg1);
assign bseg2 = (PADDR[31:24]==seg2);
assign bseg3 = (PADDR[31:24]==seg3);
assign bseg4 = (PADDR[31:24]==seg4);
assign bseg5 = (PADDR[31:24]==seg5);
assign bseg6 = (PADDR[31:24]==seg6);
assign bseg7 = (PADDR[31:24]==seg7);
assign bseg8 = (PADDR[31:24]==seg8);
assign bseg9 = (PADDR[31:24]==seg9);
assign bseg10 = (PADDR[31:24]==seg10);
assign bseg11 = (PADDR[31:24]==seg11);
assign bseg12 = (PADDR[31:24]==seg12);
assign bseg13 = (PADDR[31:24]==seg13);
assign bseg14 = (PADDR[31:24]==seg14);
assign bseg15 = (PADDR[31:24]==seg15);



assign PSELx0=bseg0 & mseg0 & sseg0;
assign PSELx1=bseg0 & mseg0 & sseg1;
assign PSELx2=bseg0 & mseg0 & sseg2;
assign PSELx3=bseg0 & mseg0 & sseg3;
assign PSELx4=bseg0 & mseg0 & sseg4;
assign PSELx5=bseg0 & mseg0 & sseg5;
assign PSELx6=bseg0 & mseg0 & sseg6;
assign PSELx7=bseg0 & mseg1  ;
assign PSELx8={PSELx0,PSELx1,PSELx2,PSELx3,PSELx4,PSELx5,PSELx6,PSELx7}==0;
endmodule

