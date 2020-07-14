/************************************************************\
 **  Copyright (c) 2011-2021 Anlogic, Inc.
 **  All Right Reserved.
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** File	:	D:/Projects/FPGA/PVS464/Anlogic/PVS432-SoC/al_ip/LVDS_DDRRX.v
 ** Date	:	2020 04 26
 ** TD version	:	4.6.14756
\************************************************************/

`timescale 1ns / 1ps

module LVDS_DDRRX ( q1, q0, d, clk, rst );
output 		q1;
output 		q0;
input  		d;
input  		clk;
input  		rst;

		EG_LOGIC_IDDR #(
		.ASYNCRST("ENABLE"),
		.PIPEMODE("PIPED"))
		iddr (
		.q1(q1),
		.q0(q0),
		.clk(clk),
		.d(d),
		.rst(rst));

endmodule