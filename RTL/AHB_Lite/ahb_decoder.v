
module ahb_decoder
(
  // -------------
  // Input pins //
  // -------------
  input [35:0] HADDR,
  // --------------
  // Output pins //
  // --------------
  output HSELx0,
  output HSELx1,
  output HSELx2,
  output HSELx3,
  output HSELx4,
  output HSELx5,
  output HSELx6,
  output HSELx7,
  output HSELx8
);
/*
RV/AT机中，规定地址[15:0]为段内偏移，[16:23]为小段号，[31:24]为段号，[35:32]为大段号
 [ 35    :     32 ]    [31    :    24]  [23   :    18]   [17   :   0]
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
assign sseg0 = (HADDR[23:18]==seg0);
assign sseg1 = (HADDR[23:18]==seg1);
assign sseg2 = (HADDR[23:18]==seg2);
assign sseg3 = (HADDR[23:18]==seg3);
assign sseg4 = (HADDR[23:18]==seg4);
assign sseg5 = (HADDR[23:18]==seg5);
assign sseg6 = (HADDR[23:18]==seg6);
assign sseg7 = (HADDR[23:18]==seg7);
assign sseg8 = (HADDR[23:18]==seg8);
assign sseg9 = (HADDR[23:18]==seg9);
assign sseg10 = (HADDR[23:18]==seg10);
assign sseg11 = (HADDR[23:18]==seg11);
assign sseg12 = (HADDR[23:18]==seg12);
assign sseg13 = (HADDR[23:18]==seg13);
assign sseg14 = (HADDR[23:18]==seg14);
assign sseg15 = (HADDR[23:18]==seg15);
assign sseg16 = (HADDR[23:18]==seg16);
assign sseg17 = (HADDR[23:18]==seg17);
assign sseg18 = (HADDR[23:18]==seg18);
assign sseg19 = (HADDR[23:18]==seg19);
assign sseg20 = (HADDR[23:18]==seg20);
assign sseg21 = (HADDR[23:18]==seg21);
assign sseg22 = (HADDR[23:18]==seg22);
assign sseg23 = (HADDR[23:18]==seg23);
assign sseg24 = (HADDR[23:18]==seg24);
assign sseg25 = (HADDR[23:18]==seg25);
assign sseg26 = (HADDR[23:18]==seg26);
assign sseg27 = (HADDR[23:18]==seg27);
assign sseg28 = (HADDR[23:18]==seg28);
assign sseg29 = (HADDR[23:18]==seg29);
assign sseg30 = (HADDR[23:18]==seg30);
assign sseg31 = (HADDR[23:18]==seg31);

assign mseg0 = (HADDR[31:24]==seg0);
assign mseg1 = (HADDR[31:24]==seg1);
assign mseg2 = (HADDR[31:24]==seg2);
assign mseg3 = (HADDR[31:24]==seg3);
assign mseg4 = (HADDR[31:24]==seg4);
assign mseg5 = (HADDR[31:24]==seg5);
assign mseg6 = (HADDR[31:24]==seg6);
assign mseg7 = (HADDR[31:24]==seg7);
assign mseg8 = (HADDR[31:24]==seg8);
assign mseg9 = (HADDR[31:24]==seg9);
assign mseg10 = (HADDR[31:24]==seg10);
assign mseg11 = (HADDR[31:24]==seg11);
assign mseg12 = (HADDR[31:24]==seg12);
assign mseg13 = (HADDR[31:24]==seg13);
assign mseg14 = (HADDR[31:24]==seg14);
assign mseg15 = (HADDR[31:24]==seg15);
assign mseg16 = (HADDR[31:24]==seg16);
assign mseg17 = (HADDR[31:24]==seg17);
assign mseg18 = (HADDR[31:24]==seg18);
assign mseg19 = (HADDR[31:24]==seg19);
assign mseg20 = (HADDR[31:24]==seg20);
assign mseg21 = (HADDR[31:24]==seg21);
assign mseg22 = (HADDR[31:24]==seg22);
assign mseg23 = (HADDR[31:24]==seg23);
assign mseg24 = (HADDR[31:24]==seg24);
assign mseg25 = (HADDR[31:24]==seg25);
assign mseg26 = (HADDR[31:24]==seg26);
assign mseg27 = (HADDR[31:24]==seg27);
assign mseg28 = (HADDR[31:24]==seg28);
assign mseg29 = (HADDR[31:24]==seg29);
assign mseg30 = (HADDR[31:24]==seg30);
assign mseg31 = (HADDR[31:24]==seg31);

assign bseg0 = (HADDR[35:32]==seg0);
assign bseg1 = (HADDR[35:32]==seg1);
assign bseg2 = (HADDR[35:32]==seg2);
assign bseg3 = (HADDR[35:32]==seg3);
assign bseg4 = (HADDR[35:32]==seg4);
assign bseg5 = (HADDR[35:32]==seg5);
assign bseg6 = (HADDR[35:32]==seg6);
assign bseg7 = (HADDR[35:32]==seg7);
assign bseg8 = (HADDR[35:32]==seg8);
assign bseg9 = (HADDR[35:32]==seg9);
assign bseg10 = (HADDR[35:32]==seg10);
assign bseg11 = (HADDR[35:32]==seg11);
assign bseg12 = (HADDR[35:32]==seg12);
assign bseg13 = (HADDR[35:32]==seg13);
assign bseg14 = (HADDR[35:32]==seg14);
assign bseg15 = (HADDR[35:32]==seg15);



assign HSELx0=bseg0 & (mseg0 | mseg1 | mseg2 | mseg3);//(HADDR[35:26]==10'h00); Page 0x0000_0000-0x03ff_ffff 	(64MiB) XIP ROM
assign HSELx1=bseg0 & (mseg4 | mseg5 | mseg6 | mseg7 | mseg8 | mseg9 | mseg10 | mseg11|
    mseg12 | mseg13 | mseg14 | mseg15 | mseg16 | mseg17 | mseg18 | mseg19);//(HADDR[35:26]==10'h01);		//Page 0x0400_0000-0x07ff_ffff 	(256MiB) MAIN MEMORY
assign HSELx2=bseg1 & mseg0 & (sseg0|sseg1|sseg2|sseg3|sseg4|sseg5|sseg6|sseg7) ;  //page 0x1_0000_0000-0x1_001f_ffff  (2M) SPM        
assign HSELx3=bseg1 & mseg0 & (sseg8|sseg9|sseg10|sseg11|sseg12|sseg13|sseg14|sseg15) ;		//page 0x1_0020_0000-0x1_003f_ffff  (2M)  SDIO 
assign HSELx4=bseg1 & mseg0 & (sseg16|sseg17|sseg18|sseg19|sseg20|sseg21|sseg22|sseg23);		//page 0x1_0040_0000-0x1_005f_ffff  (2M)  APB
assign HSELx5=bseg1 & mseg0 & (sseg24|sseg25|sseg26|sseg27|sseg28|sseg29|sseg30|sseg31);		//page 0x1_0060_0000-0x1_007f_ffff  (2M)  USB
assign HSELx6=bseg1 & mseg1;		//16M FSB16
assign HSELx7=bseg1 & mseg2&& (sseg0|sseg1|sseg2|sseg3|sseg4|sseg5|sseg6|sseg7) ; //2M LVDS PTBUS
assign HSELx8={HSELx0,HSELx1,HSELx2,HSELx3,HSELx4,HSELx5,HSELx6,HSELx7}==0;//Reserved
endmodule

