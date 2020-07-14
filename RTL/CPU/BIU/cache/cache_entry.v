module cache_entry(
input wire clk,
input wire rst,

input wire L1_clear,

input wire access_ready,

input wire [63:0]pa_in,
output reg [63:0]pa_out,

output reg [11:0]access_count,
output reg valid,
input wire cache_entry_write
);

always@(posedge clk)begin
	if(rst | L1_clear)begin
		pa_out	<=	64'b0;
		valid	<=	1'b0;
	end
	else if(cache_entry_write)begin
		pa_out	<=	pa_in;
		valid	<=	1'b1;
	end
end

always@(posedge clk)begin
	if(rst)begin
		access_count	<=	12'h0;
	end
	else if(access_count == 12'b111111111111)begin
		access_count	<=	access_count;
	end
	else if(access_ready)begin
		access_count	<=	access_count + 12'h1;
	end
end

endmodule
