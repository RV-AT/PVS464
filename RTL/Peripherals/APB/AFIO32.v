module AFIO32
(
	inout [31:0]IOBUFO,
	output [31:0]GPIO_DO,
	input[31:0]GPIO_DI,
	input[31:0]GPIO_AFC,
	input[31:0]GPIO_DIR,
	input[63:0]GPIO_PM,
	input[63:0]GPIO_PS,
	output [31:0]AFP_DO,
	input [31:0]AFP_DI,
	input [31:0]AFP_DIR
);
	genvar i;
	wire [31:0]int_do;
	wire [31:0]int_dir;
	assign GPIO_DO=IOBUFO&(~GPIO_AFC);
	assign AFP_DO=IOBUFO&GPIO_AFC;
	generate
        for (i=0;i<31;i=i+1)
        begin:afio_ioctrl
            assign IOBUFO[i]=(int_dir[i])?int_do[i]:1'bz;//1=output,0=input
            assign int_dir[i]=(GPIO_AFC[i])?(AFP_DIR[i]):GPIO_DIR[i];
            assign int_do[i]=(GPIO_AFC[i])?(AFP_DI[i]):GPIO_DI[i];
        end
	endgenerate



endmodule