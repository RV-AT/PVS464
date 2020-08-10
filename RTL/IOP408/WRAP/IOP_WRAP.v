module IOP_WRAP
(
    input sysclk,
    input sysrst,
    output [10:0]IOPIADDR,
    input  [15:0]IOPIDATA,
    input 
);

wire [23:0]IOPRADDR;
wire [23:0]IOPWADDR;
wire [7:0]IOPWDATA;
wire [7:0]IOPRDATA;
wire IOPWRITE;
wire IOPREAD;
wire IOPWRDY;
wire IOPRRDY;

r408e_top iop408(
.clk(sysclk),
.rst(sysrst),
.pc(IOPIADDR),
.ins(IOPIDATA),
.raddr(IOPRADDR),
.waddr(IOPWADDR),
.wdata(IOPWDATA),
.rdata(IOPRDATA),
.write(IOPWRITE),
.read(IOPREAD),
.rrdy(IOPRRDY),
.wrdy(IOPWRDY)
);


endmodule
