module IOP_WRAP
(
    input sysclk,
    input sysrst,
    output [10:0]IOPIADDR,
    input  [15:0]IOPIDATA,
    output [20:0]IOPRADDR,
    output [20:0]IOPWADDR,
    output [7:0]IOPWDATA,
    input  [7:0]IOPRDATA,
    input IOPWWAIT,
    input IOPRWAIT
);

r408_top iop408(
.clk(sysclk),
.rst(sysrst),
.pc(IOPIADDR),
.ins(IOPIDATA),
.addr(),
.wdata(),
.rdata(),
.write(),
.read(),
.rdy(IOPRWAIT)
);
endmodule
