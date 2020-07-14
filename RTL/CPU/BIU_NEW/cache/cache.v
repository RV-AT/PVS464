module cache
(
    input [12:0]raddr,
    input [12:0]waddr,
    input [63:0]di,
    input we,
    input [7:0]bsel,
    output [63:0]do,
    input clk
);
cachemem8 cacheblk0
(   .clk(clk),
    .raddr(raddr[12:3]),
    .waddr(waddr[12:3]),
    .di(di[7:0]),
    .do(do[7:0]),
    .we(we&bsel[0])
);
cachemem8 cacheblk1
(   .clk(clk),
    .raddr(raddr[12:3]),
    .waddr(waddr[12:3]),
    .di(di[15:8]),
    .do(do[15:8]),
    .we(we&bsel[1])
);
cachemem8 cacheblk2
(   .clk(clk),
    .raddr(raddr[12:3]),
    .waddr(waddr[12:3]),
    .di(di[23:16]),
    .do(do[23:16]),
    .we(we&bsel[2])
);
cachemem8 cacheblk3
(   .clk(clk),
    .raddr(raddr[12:3]),
    .waddr(waddr[12:3]),
    .di(di[31:24]),
    .do(do[31:24]),
    .we(we&bsel[3])
);
cachemem8 cacheblk4
(   .clk(clk),
    .raddr(raddr[12:3]),
    .waddr(waddr[12:3]),
    .di(di[39:32]),
    .do(do[39:32]),
    .we(we&bsel[4])
);
cachemem8 cacheblk5
(   .clk(clk),
    .raddr(raddr[12:3]),
    .waddr(waddr[12:3]),
    .di(di[47:40]),
    .do(do[47:40]),
    .we(we&bsel[5])
);
cachemem8 cacheblk6
(   .clk(clk),
    .raddr(raddr[12:3]),
    .waddr(waddr[12:3]),
    .di(di[55:48]),
    .do(do[55:48]),
    .we(we&bsel[6])
);
cachemem8 cacheblk7
(   .clk(clk),
    .raddr(raddr[12:3]),
    .waddr(waddr[12:3]),
    .di(di[63:56]),
    .do(do[63:56]),
    .we(we&bsel[7])
);

endmodule

module cachemem8
(
    input clk,
    input [9:0]raddr,
    input [9:0]waddr,
    input [7:0]di,
    output reg[7:0]do,
    input we
);
reg [7:0]memcell[1023:0];

always @(posedge clk)
begin
	do<=memcell[raddr]; 
    if(we)
      memcell[waddr]<=di;
//    else
 //     memcell[waddr]<=memcell[waddr];
end

endmodule
