module MUL
(
    input [53:0]rs1,
    input [53:0]rs2,
    input clk,
    output reg [107:0]rd
);
always @(posedge clk)
    rd<=rs1*rs2;


endmodule

