module m_s_scratch(
input wire clk,
input wire rst,

input wire mrw_mscratch_sel,
input wire srw_sscratch_sel,

output reg [63:0]mscratch,
output reg [63:0]sscratch,
input wire csr_write,
input wire [63:0]data_csr

);

always@(posedge clk)begin
	if(rst)begin
		sscratch	<=	64'b0;
		mscratch	<=	64'b0;
	end
	else if(mrw_mscratch_sel & csr_write)begin
		mscratch	<=	data_csr;
	end
	else if(srw_sscratch_sel & csr_write)begin	
		sscratch	<=	data_csr;
	end
end

endmodule