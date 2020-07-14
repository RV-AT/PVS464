//`include "compile_param.v"
//`include "ahb_defines.v"


module AHB_OCRAM
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
  output [1:0] HRESP,
  // Data out
  output [31:0] HRDATA
);

wire [31:0]DI;
wire [31:0]DI8;
wire [31:0]DI16;

wire [7:0]DO8;
wire [7:0]DO16;
wire [7:0]DO24;
wire [7:0]DO32;

wire [7:0]MUX8O;
wire [15:0]MUX16O;

reg [3:0]WE_F;
wire [3:0]WE_DEC8;
wire [3:0]WE_DEC16;
reg [14:0]WADDR;
 //Xilinx native BRAM IP used, configured @ 8bit data width and 32768 depth

	BLKRAM8 OCRAM_L8
	(
		.addra(WADDR),
		.clka(HCLK),
		.dina(DI[7:0]),
		.ena(HSEL),
		.wea(WE_F[0]),
		.addrb(HADDR[16:2]),
		.clkb(HCLK),
		.doutb(DO8),
		.enb(HSEL)
		
	);
	BLKRAM8 OCROM_L16
	(
		.addra(WADDR),
		.clka(HCLK),
		.dina(DI[15:8]),
		.ena(HSEL),
		.wea(WE_F[1]),
		.addrb(HADDR[16:2]),
		.clkb(HCLK),
		.doutb(DO16),
		.enb(HSEL)
	);
	BLKRAM8 OCROM_H24
	(
		.addra(WADDR),
		.clka(HCLK),
		.dina(DI[23:16]),
		.ena(HSEL),
		.wea(WE_F[2]),
		.addrb(HADDR[16:2]),
		.clkb(HCLK),
		.doutb(DO24),
		.enb(HSEL)
	);
	BLKRAM8 OCROM_H32
	(
		.addra(WADDR),
		.clka(HCLK),
		.dina(DI[31:24]),
		.ena(HSEL),
		.wea(WE_F[3]),
		.addrb(HADDR[16:2]),
		.clkb(HCLK),
		.doutb(DO32),
		.enb(HSEL)
	);

assign MUX8O=	//8 Bit Output MUX
	(({8{HADDR[1:0]==2'b00}}&DO8)|
	({8{HADDR[1:0]==2'b01}}&DO16)|
	({8{HADDR[1:0]==2'b10}}&DO24)|
	({8{HADDR[1:0]==2'b11}}&DO32));
assign MUX16O=	//16 Bit Output MUX
	(({16{~HADDR[1]}}&{DO16,DO8})|
	({16{HADDR[1]}}&{DO32,DO24}));
assign HRDATA=	//Bus Output MUX
	(({32{HSIZE[1:0]==2'b00}}&{24'b0,MUX8O})|
	({32{HSIZE[1:0]==2'b01}}&{16'b0,WE_DEC16})|
	({32{HSIZE[1:0]==2'b10}}&{DO32,DO24,DO16,DO8}));

assign DI8=	//8 Bit Input MUX
	(({32{HADDR[1:0]==2'b00}}&{24'b0,HWDATA[7:0]})|
	({32{HADDR[1:0]==2'b01}}&{16'b0,HWDATA[7:0],8'b0})|
	({32{HADDR[1:0]==2'b10}}&{8'b0,HWDATA[7:0],16'b0})|
	({32{HADDR[1:0]==2'b11}}&{HWDATA[7:0],24'b0}));
assign DI16=	//16 Bit Input MUX
	(({32{~HADDR[1]}}&{16'b0,HWDATA[15:0]})|
	({32{HADDR[1]}}&{HWDATA[15:0],16'b0}));
assign DI=	//Bus Input MUX
	(({32{HSIZE[1:0]==2'b00}}&DI8)|
	({32{HSIZE[1:0]==2'b01}}&DI16)|
	({32{HSIZE[1:0]==2'b10}}&HWDATA));	
	
assign WE_DEC8= //8bit WE Signal gen
	(({4{HADDR[1:0]==2'b00}}&4'b0001)|
	({4{HADDR[1:0]==2'b01}}&4'b0010)|
	({4{HADDR[1:0]==2'b10}}&4'b0100)|
	({4{HADDR[1:0]==2'b11}}&4'b1000));
assign WE_DEC16=
	(({16{~HADDR[1]}}&4'b0011)|
	({16{HADDR[1]}}&4'b1100));	
// --------------------
// Output generation //
// --------------------
// Normal output signals generation
assign HMASTLOCK_o=HMASTLOCK;
always @(posedge HCLK or negedge HRESETn)
begin
	if(!HRESETn)
	begin
		WE_F<=0;
		WADDR<=0;
	end
	else
	begin
		if(HWRITE)
		begin
			WE_F<= //WE Signal select
			(({4{HSIZE[1:0]==2'b00}}&WE_DEC8)|
			({4{HSIZE[1:0]==2'b01}}&WE_DEC16)|
			({4{HSIZE[1:0]==2'b10}})&{4{HWRITE&HSEL}});
			WADDR<=HADDR[16:2];
		end
		else WE_F<=0;
	end
	
end


assign HRESP=0;
assign HREADY=1;
endmodule