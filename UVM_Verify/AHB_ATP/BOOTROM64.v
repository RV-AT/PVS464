/************************************************************************************8
Boot ROM 64 x 1024
For System Boot Test 

*************************************************************************************////
`timescale 1us / 100ps
module BOOTROM64(input [9:0]addra,input clka,output reg[63:0]douta,input ena);
reg [63:0]BRAM64[1023:0]; //1K Word * 4 Byte Cost 4 BRAM9K
integer i;
initial
begin 
	$readmemb("D:/Projects/FPGA/PVS464/SIM/bin.mif",BRAM64);
	//#0 for (i=0;i<1023;i=i+1) 
	//	BRAM64[i]=$random;
	#5 douta<=0;
end
always@(posedge clka )
begin
	douta<=(ena)?BRAM64[addra]:64'b0;
end

endmodule