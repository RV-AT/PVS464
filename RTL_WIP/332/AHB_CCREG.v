
module AHB_CCREG
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
	  
	  output [31:0] HRDATA,
	   
	  //reg IOs
	  output timer_int,
	  output ext_int,
	  output soft_int,
	  input [63:0]INT_ARR
);
	reg [63:0]MTIME;
	reg [63:0]MTIMECMP;
	genvar i;
	integer j;
	wire [63:0]IPA;//Gateway
	reg [63:0]IE;//enable
	reg [4:0]IPRIO[63:1];//priority of each interrupt
	reg [4:0]ITHRES;//global threshold
	wire [63:1]ICLAIM;//interrupt claim reg
	wire [63:1]ICOMPLETE;//interrupt complete
	wire [5:0]IID;//prior coded ICLAIM
	wire [3:0]COD_INZERO;
	wire [63:1]SELICLAIM;//ICLAIM/ICOMPLETE寄存器一个非常恶心的写法：31位分别对应读取的结果（地址是否等于ICLAIM地址&相应的ICLAIM），结果直接送总线（反正正常情况下未选中应该为0）
	wire [3:0]CODO0;
	wire [3:0]CODO1;
	wire [3:0]CODO2;
	wire [3:0]CODO3;
	reg HWI;
	assign HRESP=0;
	assign HREADY=1;
	assign timer_int=(MTIMECMP!=0)?((MTIME>MTIMECMP)?1'b1:1'b0):1'b0;
	assign IPA[0]=0;
	pcod16s4 cod1(.di({ICLAIM[15:1],1'b0}),.dato(CODO0),.ni(COD_INZERO[0]),.en(1'b1));
	pcod16s4 cod2(.di(ICLAIM[31:16]),.dato(CODO1),.ni(COD_INZERO[1]),.en(COD_INZERO[0]));
	pcod16s4 cod3(.di(ICLAIM[47:32]),.dato(CODO2),.ni(COD_INZERO[2]),.en(COD_INZERO[1:0]==2'b11));
	pcod16s4 cod4(.di(ICLAIM[63:48]),.dato(CODO3),.ni(COD_INZERO[3]),.en(COD_INZERO[2:0]==02'b111));
	assign IID=
	{(!COD_INZERO[1])?2'b01:
	(!COD_INZERO[2])?2'b10:
	(!COD_INZERO[3])?2'b11:2'b00
	,CODO0|CODO1|CODO2|CODO3};
	assign HRDATA=
	(({32{HADDR[16:2]==14'h00}}&MTIME[31:0])|
	({32{HADDR[16:2]==14'h01}}&MTIME[63:32])|
	({32{HADDR[16:2]==14'h02}}&MTIMECMP[31:0])|
	({32{HADDR[16:2]==14'h03}}&MTIMECMP[63:32])|
	{31'b0,(SELICLAIM!=0)}|
	({32{HADDR[16:2]==15'h7800}}&{27'h0,ITHRES})|
	({32{HADDR[16:12]==7'h79}}&{27'h0,IPRIO[HADDR[9:2]]})|
	({32{HADDR[16:2]==15'h7A00}}&{IE[31:1],1'b0})|
	({32{HADDR[16:2]==15'h7A01}}&IE[63:32])|
	({32{HADDR[16:2]==15'h7A04}}&{IPA[31:1],1'b0})|
	({32{HADDR[16:2]==15'h7A05}}&IPA[63:32])|
	({32{HADDR[16:2]==15'h7A08}}&{27'h0,IID})|
	32'h00000000);
	
	always@(posedge HCLK or negedge HRESETn)
	begin
		if(!HRESETn)
		begin
			MTIME<=0;
			MTIMECMP<=0;
			for (j=1;j<=63;j=j+1) IPRIO[j]=0;
			ITHRES<=0;
			IE<=0;
			HWI<=0;
		end
		else
		begin
			if(HWRITE)HWI<=HSEL;
			else HWI<=0;

			if(HSEL&HWI&HADDR[16:3]==0)
			begin
				if(HADDR[2])MTIME<={HWDATA,MTIME[31:0]};
				else MTIME<={MTIME[63:32],HWDATA};
			end
			else MTIME<=MTIME+1;
			if(HSEL&HWI&HADDR[16:3]==14'h0001)
			begin
				if(HADDR[2])MTIMECMP<={HWDATA,MTIMECMP[31:0]};
				else MTIMECMP<={MTIMECMP[63:32],HWDATA};
			end
			if(HSEL&HWI&HADDR[16:3]==15'h3D00)
			begin
				if(HADDR[2])IE<={HWDATA,IE[31:0]};
				else IE<={IE[63:32],HWDATA};
			end
		end
	end
	generate
	for(i=1;i<=63;i=i+1)
	begin
		plic_cell PCELL1
			(
			.int_src(INT_ARR[i]),
			.rst_n(HRESETn),
			.prio(IPRIO[i]),
			.thres(ITHRES),
			.ip(IPA[i]),
			.en(IE[i]),
			.iclaim(ICLAIM[i]),
			.ack(ICOMPLETE[i])
			);
		assign ICOMPLETE[i]=(HWI&HSEL&(HADDR[16:2]==(15'h7900+i)))?1'b1:1'b0;
		
	end
	for(i=1;i<=63;i=i+1)
	begin
		assign SELICLAIM[i]=(ICLAIM[i]&HSEL&(HADDR[16:2]==(15'h7900+i)))?1'b1:1'b0;
	end
	endgenerate
	assign soft_int=(HWI&HSEL&(HADDR[16:2]==(15'h7A09)))?1'b1:1'b0;
	assign ext_int=(ICLAIM!=0);
endmodule