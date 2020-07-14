/*
Module Float Arithmetic Computation Unit
opcode:
000:NOP
001:SQRT
010:FADD
011:FSUB
100:FMUL
101:FDIV
110:FMIN
111:FMAX
WID:0=float,1=double
*/
module FALU
(
    input [63:0]op1,
    input [63:0]op2,
    input [2:0]opcode,
    input wid,
    output [63:0]out,
    input clk,
    input rst
);
wire sign1,sign2;
wire [9:0]exp1;
wire [9:0]exp2;
wire exp_sgn1,exp_sgn2;
wire [9:0]exp_diff;

wire [52:0]val1;
wire [52:0]val2;
wire [15:0]opstat;//MSB|Sign2/Sign1/Inf2/Inf1/NaN2/NaN1|LSB
wire [63:0]fmax;
wire [63:0]fmin;

assign sign1=(wid)?op1[63]:op1[31];
assign sign2=(wid)?op2[63]:op2[31];
assign exp1=(wid)?op1[62:52]:{{2{op1[30]}},op1[30:23]};
assign exp2=(wid)?op2[62:52]:{{2{op1[30]}},op2[30:23]};
assign val1=(wid)?op1[51:0]:{{30{op1[22]}},op1[22:0]};
assign val2=(wid)?op2[51:0]:{{30{op1[22]}},op2[22:0]};
assign exp_sgn1=exp1[9];
assign exp_sgn2=exp2[9];
//op status generation
assign opstat[0]=(val1!=0&(wid&(exp1==11'h7ff)));//NaN Gen
assign opstat[1]=(val2!=0&(wid&(exp2==11'h7ff)));
assign opstat[2]=(val1==0&(wid&(exp1==11'h7ff)));//Inf Gen(have sign bits, so this won't care about +-)
assign opstat[3]=(val2==0&(wid&(exp2==11'h7ff)));
assign opstat[4]=sign1;
assign opstat[5]=sign2;

//FCMP

reg [1:0]exp_cmp; //00=expA>expB,01=expA<expB,10=expA=expB
wire much_larger;
assign diff_sym=sign1^sign2;
assign exp_diff=exp1-exp2;
assign much_larger=(exp_diff>11'd52);
//generate difference of exponential word
always @(*)
begin
    casex({exp_sgn1|exp_sgn2})
    2'b00:      
        begin
            exp_cmp={(exp_diff==0),exp_diff[9]};
        end
    2'b01:      
        begin
            exp_cmp=2'b0;
        end
    2'b10:        
        begin
            exp_cmp=2'b1;
        end
    2'b11:        
        begin
            exp_cmp={(exp_diff==0),~exp_diff[9]};
        end
    default:
        begin
            exp_cmp=1'bx;
        end
    endcase
end
//FMAX/FMIN generation
wire a_larger;
wire a_equ_b;
assign a_larger=(sign1>sign2)|
            (exp_cmp==2'b00)|
            ((exp_cmp==2'b10)&(val1>val2));
assign a_equ_b=(op1==op2);
assign fmax=(a_larger)?op1:op2;
assign fmin=(a_larger)?op2:op1;

//FADDER






endmodule

