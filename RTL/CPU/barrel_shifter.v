/*
Type: 00/01=Left Shift
10=Right Shift, 0 Filled
11=Right Shift,with symbol extent


*/


module barrel_shifter
(
    input [63:0]datain,
    input [1:0]type,
    input [5:0]shiftnum,
    output [63:0]dataout
);
wire [63:0]shift0;
wire [63:0]shift1;
wire [63:0]shift2;
wire [63:0]shift3;
wire [63:0]shift4;
wire [63:0]shift5;
assign shift0=(
    (shiftnum[0])?
    (type[1]?{{1{datain[63]&type[0]}},datain[63:1]}:{datain[62:0],1'b0}):
    (datain));
assign shift1=(
    (shiftnum[1])?
    (type[1]?{{2{datain[63]&type[0]}},shift0[63:2]}:{shift0[61:0],2'b0}):
    (shift0)
    );
assign shift2=(
    (shiftnum[2])?
    (type[1]?{{4{datain[63]&type[0]}},shift1[63:4]}:{shift1[59:0],4'b0}):
    (shift1)
    );
assign shift3=(
    (shiftnum[3])?
    (type[1]?{{8{datain[63]&type[0]}},shift2[63:8]}:{shift2[55:0],8'b0}):
    (shift2)
    );
assign shift4=(
    (shiftnum[4])?
    (type[1]?{{16{datain[63]&type[0]}},shift3[63:16]}:{shift3[47:0],16'b0}):
    (shift3)
    );
assign shift5=(
    (shiftnum[5])?
    (type[1]?{{32{datain[63]&type[0]}},shift4[63:32]}:{shift4[31:0],32'b0}):
    (shift4)
    );
assign dataout=shift5;

endmodule

