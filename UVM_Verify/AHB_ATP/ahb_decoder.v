//
//  Module: AHB decoder
//  (defined by ARM Design Kit Technical Reference Manual--AHB component)
//  Author: Lianghao Yuan
//  Email: yuanlianghao@gmail.com
//  Date: 07/13/2015
//  Description:
//  The system decoder decodes the address bus and generates select lines to
//  each of the system bus slaves, indicating that a read or write access to
//  that slave is required. The default configuration is 7 slots. No REMAP
//  signal implemented. 

`ifndef AHB_DECODER_V
`define AHB_DECODER_V

//`include "ahb_defines.v"

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
  output HSELx7,
  output HSELx1,
  output HSELx2,
  output HSELx3,
  output HSELx4,
  output HSELx5,
  output HSELx6
);
	assign HSELx0=(HADDR[35:16]==36'h000);		//Page 0x0000_0000-0x0000_ffff 	(64KiB)
	assign HSELx1=(HSELx0==0)&(HADDR[35:26]==10'h00);     	//Page 0x0001_0000-0x03ff_ffff 	(64MiB)
	assign HSELx2=(HADDR[35:26]==10'h01);		//Page 0x0400_0000-0x07ff_ffff 	(64MiB)
	assign HSELx3=0;		//
	assign HSELx4=0;		//
	assign HSELx5=0;		//
	assign HSELx6=0;		//
	assign HSELx7={HSELx0,HSELx1,HSELx2,HSELx3,HSELx4,HSELx5,HSELx6}==0;//Reserved
endmodule

`endif // AHB_DECODER_V
