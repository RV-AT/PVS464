module APB_MFGPIO
(
  // --------------------------
  // Input pins: AHB signals //
  // --------------------------
  // Select
  input PSEL,
  // Address and control
  input [31:0] PADDR,
  input PWRITE,
  // Data in
  input [31:0] PWDATA,
  // Reset and clock
  input HRESETn,
  input HCLK,
  // --------------
  // Output pins //
  // --------------
  // Transfer responses 
  output HREADY,
  // Data out
  
   output [31:0] PRDATA,
   
   input [31:0]GPIO1_DI,		//Data Input Port
   output reg[31:0]GPIO1_DO,	//Data Output port
   output reg[31:0]GPIO1_AFC,	//Function Select
   output reg[31:0]GPIO1_DIR,	//GPIO Direction 0=HiZ input 1=Output mode 
   output reg[63:0]GPIO1_PM,	//GPIO Port Mode, 00=Push Pull/HiZ 01=Pull up 02=Pull down
   output reg[63:0]GPIO1_PS		//GPIO Pull Strengh Select,00=disable out/OD
   
);
	

	reg [31:0]GPIO1_DIS;//Data Input,Sampled
	genvar i;
	
	
	
	always @(posedge HCLK or negedge HRESETn)	
	begin
		if(!HRESETn)
		begin
			GPIO1_AFC<=32'h00000000;
			GPIO1_DIR<=32'h00000000;
			GPIO1_PM<=64'h00000000;
			GPIO1_PS<=64'h00000000;
		end
		//else
		
	end	
	assign HREADY=1;
	generate
	for(i=0;i<=31;i=i+1)
	begin:gpio_dirgen
		always@(posedge HCLK or negedge HRESETn)
		if(!HRESETn)
			GPIO1_DIS[i]<=1'b0;
		else
			GPIO1_DIS[i]<=(~(GPIO1_AFC[i]|GPIO1_DIR[i]))?(GPIO1_DI[i]):1'b0;
	end
	endgenerate
endmodule