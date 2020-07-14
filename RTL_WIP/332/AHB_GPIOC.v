module AHB_GPIOC
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
  // Data out
  
   output [31:0] HRDATA,
   
   input [31:0]GPIO1_DI,		//Data Input Port
   output reg[31:0]GPIO1_DO,	//Data Output port
   output reg[31:0]GPIO1_AFC,	//Function Select
   output reg[31:0]GPIO1_DIR,	//GPIO Direction 0=HiZ input 1=Output mode 
   output reg[63:0]GPIO1_PM,	//GPIO Port Mode, 00=Push Pull/HiZ 01=Pull up 02=Pull down
   output reg[63:0]GPIO1_PS		//GPIO Pull Strengh Select,00=disable out/OD
   
);
	//This Module ACCEPTS 8bit &16bit access
	reg [31:0]GPIO1_DIS;//Data Input,Sampled
	genvar i;
	wire [31:0]DI;
	wire [31:0]DI8;
	wire [31:0]DI16;


	wire [7:0]MUX8O;

	wire [15:0]MUX16O;
	wire [31:0]MUXO;
	reg [4:0]WADDR;
	reg [3:0]WE_F;
	wire [3:0]WE_DEC8;
	wire [3:0]WE_DEC16;
	assign MUX8O=	//8 Bit Output MUX
		(({8{HADDR[1:0]==2'b00}}&MUXO[7:0])|
		({8{HADDR[1:0]==2'b01}}&MUXO[15:8])|
		({8{HADDR[1:0]==2'b10}}&MUXO[23:16])|
		({8{HADDR[1:0]==2'b11}}&MUXO[31:24]));
	assign MUX16O=	//16 Bit Output MUX
		(({16{~HADDR[1]}}&{MUXO[15:8],MUXO[7:0]})|
		({16{HADDR[1]}}&{MUXO[31:24],MUXO[23:16]}));
	assign HRDATA=	//Bus Output MUX
		(({32{HSIZE[1:0]==2'b00}}&{24'b0,MUX8O})|
		({32{HSIZE[1:0]==2'b01}}&{16'b0,WE_DEC16})|
		({32{HSIZE[1:0]==2'b10}}&{MUXO[31:24],MUXO[23:16],MUXO[15:8],MUXO[7:0]}));

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

	assign MUXO=
	(({32{HADDR[7:2]==5'h00}}&GPIO1_DO)|
	({32{HADDR[7:2]==5'h01}}&GPIO1_DIS)|
	({32{HADDR[7:2]==5'h02}}&GPIO1_DIR)|
	({32{HADDR[7:2]==5'h03}}&GPIO1_PM[31:0])|
	({32{HADDR[7:2]==5'h04}}&GPIO1_PM[63:32])|
	({32{HADDR[7:2]==5'h05}}&GPIO1_PS[31:0])|
	({32{HADDR[7:2]==5'h06}}&GPIO1_PS[63:32])|
	({32{HADDR[7:2]==5'h07}}&GPIO1_AFC)|
	32'h00000000);
	
	always @(posedge HCLK or negedge HRESETn)	
	begin
		if(!HRESETn)
		begin
			GPIO1_AFC<=32'h00000000;
			GPIO1_DIR<=32'h00000000;
			GPIO1_PM<=64'h00000000;
			GPIO1_PS<=64'h00000000;	
			WE_F<=0;
			WADDR<=0;
		end
		else
		begin
			if(HWRITE)
			begin
				WE_F<= //WE Signal select
				({4{HSIZE[1:0]==2'b00}}&WE_DEC8|
				{4{HSIZE[1:0]==2'b01}}&WE_DEC16|
				{4{HSIZE[1:0]==2'b10}}&{4{HWRITE}})&{4{HSEL}};
				WADDR<=HADDR[6:2];
			end
			else WE_F<=0;
			if(HSEL&(WE_F!=0))
			begin
			case (WADDR)
				5'h00:
					begin
						if(WE_F[0])
							GPIO1_DO[7:0]<=DI[7:0];
						if(WE_F[1])
							GPIO1_DO[15:8]<=DI[15:8];
						if(WE_F[2])
							GPIO1_DO[23:16]<=DI[23:16];
						if(WE_F[3])
							GPIO1_DO[31:24]<=DI[31:24];
					end
				5'h02:
					begin
						if(WE_F[0])
							GPIO1_DIR[7:0]<=DI[7:0];
						if(WE_F[1])
							GPIO1_DIR[15:8]<=DI[15:8];
						if(WE_F[2])
							GPIO1_DIR[23:16]<=DI[23:16];
						if(WE_F[3])
							GPIO1_DIR[31:24]<=DI[31:24];
					end
				5'h03:
					begin
						if(WE_F[0])
							GPIO1_PM[7:0]<=DI[7:0];
						if(WE_F[1])
							GPIO1_PM[15:8]<=DI[15:8];
						if(WE_F[2])
							GPIO1_PM[23:16]<=DI[23:16];
						if(WE_F[3])
							GPIO1_PM[31:24]<=DI[31:24];
					end
				5'h04:
					begin
						if(WE_F[0])
							GPIO1_PM[39:32]<=DI[7:0];
						if(WE_F[1])
							GPIO1_PM[47:40]<=DI[15:8];
						if(WE_F[2])
							GPIO1_PM[55:48]<=DI[23:16];
						if(WE_F[3])
							GPIO1_PM[63:56]<=DI[31:24];
					end
				5'h05:
					begin
						if(WE_F[0])
							GPIO1_PS[7:0]<=DI[7:0];
						if(WE_F[1])
							GPIO1_PS[15:8]<=DI[15:8];
						if(WE_F[2])
							GPIO1_PS[23:16]<=DI[23:16];
						if(WE_F[3])
							GPIO1_PS[31:24]<=DI[31:24];
					end
				5'h06:
					begin
						if(WE_F[0])
							GPIO1_PM[39:32]<=DI[7:0];
						if(WE_F[1])
							GPIO1_PM[47:40]<=DI[15:8];
						if(WE_F[2])
							GPIO1_PM[55:48]<=DI[23:16];
						if(WE_F[3])
							GPIO1_PM[63:56]<=DI[31:24];
					end
				5'h07:
					begin
						if(WE_F[0])
							GPIO1_AFC[7:0]<=DI[7:0];
						if(WE_F[1])
							GPIO1_AFC[15:8]<=DI[15:8];
						if(WE_F[2])
							GPIO1_AFC[23:16]<=DI[23:16];
						if(WE_F[3])
							GPIO1_AFC[31:24]<=DI[31:24];
					end
			endcase
			end
		end
	end
	assign HREADY=1;
	generate
	for(i=0;i<=31;i=i+1)
	begin
		always@(posedge HCLK or negedge HRESETn)
		if(!HRESETn)
			GPIO1_DIS[i]<=1'b0;
		else
			GPIO1_DIS[i]<=(~(GPIO1_AFC[i]|GPIO1_DIR[i]))?(GPIO1_DI[i]):1'b0;
	end
	endgenerate
endmodule