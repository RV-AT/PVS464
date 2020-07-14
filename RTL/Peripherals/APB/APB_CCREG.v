
module APB_CCREG
(
	input PCLK,
	input PSEL,
	input PENABLE,
	input PWRITE,
	input [16:0] PADDR,
	input [31:0] PWDATA,
	output reg [31:0] PRDATA,
	output reg PREADY,
	output PSLVERR,
	input PRESETn,
	   
	//reg IOs
	output reg [63:0]MTIME,
	output timer_int,
	output ext_int,
	output soft_int,
	input [63:0]INT_ARR
);

	localparam IDLE   = 2'b00;
	localparam SETUP  = 2'b01;
	localparam ENABLE = 2'b10;

	reg  [1:0]    STATE;

	
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
	assign PSLVERR=0;
	assign timer_int=(MTIMECMP!=0)?((MTIME>MTIMECMP)?1'b1:1'b0):1'b0;
	assign IPA[0]=0;
	pcod16s4 cod1(.di({ICLAIM[15:1],1'b0}),.dato(CODO0),.ni(COD_INZERO[0]),.en(1'b1));
	pcod16s4 cod2(.di(ICLAIM[31:16]),.dato(CODO1),.ni(COD_INZERO[1]),.en(COD_INZERO[0]));
	pcod16s4 cod3(.di(ICLAIM[47:32]),.dato(CODO2),.ni(COD_INZERO[2]),.en(COD_INZERO[1:0]==2'b11));
	pcod16s4 cod4(.di(ICLAIM[63:48]),.dato(CODO3),.ni(COD_INZERO[3]),.en(COD_INZERO[2:0]==3'b111));
	assign IID=
	{(!COD_INZERO[1])?2'b01:
	(!COD_INZERO[2])?2'b10:
	(!COD_INZERO[3])?2'b11:2'b00
	,CODO0|CODO1|CODO2|CODO3};

	always@(posedge PCLK or negedge PRESETn)
	begin
	if(!PRESETn)
	begin
		STATE <= IDLE;
		PREADY <= 0;
	end	
	else
	begin 
		PREADY <= 0;    
		case(STATE)
		IDLE:  begin 
				PREADY <= 1;
				//if(PSEL && !PENABLE)
				if(PSEL)
					STATE  <= SETUP;             
				else 
					STATE  <= IDLE;			  
				end
		SETUP: begin
				if(PENABLE)	 
					STATE  <= ENABLE;
				else
					STATE  <= IDLE;					
				end
		ENABLE:begin  
				if(PENABLE)
					STATE  <= SETUP;  			   
				else	           
					STATE  <= IDLE;	
				end
		endcase
	end
	end 


	assign write_en =  PWRITE && (STATE==ENABLE);
	assign read_en  = !PWRITE && (STATE==SETUP);

//always@(PADDR,PWDATA,write_en)
always@(posedge PCLK or negedge PRESETn)
  begin
  if(!PRESETn)
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
       if(write_en)
       begin   
         if(PADDR[16:3]==0)
			begin
				if(PADDR[2])MTIME<={PWDATA,MTIME[31:0]};
				else MTIME<={MTIME[63:32],PWDATA};
			end
			else MTIME<=MTIME+1;
			if(PADDR[16:3]==14'h0001)
			begin
				if(PADDR[2])MTIMECMP<={PWDATA,MTIMECMP[31:0]};
				else MTIMECMP<={MTIMECMP[63:32],PWDATA};
			end
			if(PADDR[16:3]==15'h3D00)
			begin
				if(PADDR[2])IE<={PWDATA,IE[31:0]};
				else IE<={IE[63:32],PWDATA};
			end
       end
	   else if(read_en && PENABLE)
	   begin
         PRDATA<= 
			(({32{PADDR[16:2]==14'h00}}&MTIME[31:0])|
			({32{PADDR[16:2]==14'h01}}&MTIME[63:32])|
			({32{PADDR[16:2]==14'h02}}&MTIMECMP[31:0])|
			({32{PADDR[16:2]==14'h03}}&MTIMECMP[63:32])|
			{31'b0,(SELICLAIM!=0)}|
			({32{PADDR[16:2]==15'h7800}}&{27'h0,ITHRES})|
			({32{PADDR[16:12]==7'h79}}&{27'h0,IPRIO[PADDR[9:2]]})|
			({32{PADDR[16:2]==15'h7A00}}&{IE[31:1],1'b0})|
			({32{PADDR[16:2]==15'h7A01}}&IE[63:32])|
			({32{PADDR[16:2]==15'h7A04}}&{IPA[31:1],1'b0})|
			({32{PADDR[16:2]==15'h7A05}}&IPA[63:32])|
			({32{PADDR[16:2]==15'h7A08}}&{27'h0,IID})|
			32'h00000000);   
	   end
    end
end
	

			
	generate
	for(i=1;i<=63;i=i+1)
	begin:plic_cellgen
		plic_cell PCELL1
			(
			.int_src(INT_ARR[i]),
			.rst_n(PRESETn),
			.prio(IPRIO[i]),
			.thres(ITHRES),
			.ip(IPA[i]),
			.en(IE[i]),
			.iclaim(ICLAIM[i]),
			.ack(ICOMPLETE[i])
			);
		assign ICOMPLETE[i]=(write_en&(PADDR[16:2]==(15'h7900+i)))?1'b1:1'b0;
		assign SELICLAIM[i]=(ICLAIM[i]&PSEL&(PADDR[16:2]==(15'h7900+i)))?1'b1:1'b0;
	end
	endgenerate
	assign soft_int=(write_en&(PADDR[16:2]==(15'h7A09)))?1'b1:1'b0;
	assign ext_int=(ICLAIM!=0);

endmodule