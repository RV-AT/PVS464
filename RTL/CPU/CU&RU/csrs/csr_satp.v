module csr_satp(
input wire clk,
input wire rst,

input wire srw_satp_sel,
input wire [63:0]data_csr,
input wire csr_write,

output wire [63:0]satp
);


reg [3:0]mode;
reg [43:0]ppn;

always@(posedge clk)begin
	if(rst)begin
		mode<=	4'b0;
		ppn	<=	44'b0;
	end
	else if(srw_satp_sel & csr_write)begin
		mode <=	data_csr[63:60];
		ppn	<=	data_csr[43:0];
	end
end

assign satp=	{mode,16'b0,ppn};

endmodule