module pcod16s4(input [15:0]di,input en,output [3:0]dato,output ni);
assign ni=(di==0);//no interrupt
assign dato=({4{en&(!ni)}})&(~(
{4{di==16'bXXXXXXXXXXXXXXX1}}&4'hF|
{4{di==16'bXXXXXXXXXXXXXX10}}&4'hE|
{4{di==16'bXXXXXXXXXXXXX100}}&4'hD|
{4{di==16'bXXXXXXXXXXXX1000}}&4'hC|
{4{di==16'bXXXXXXXXXXX10000}}&4'hB|
{4{di==16'bXXXXXXXXXX100000}}&4'hA|
{4{di==16'bXXXXXXXXX1000000}}&4'h9|
{4{di==16'bXXXXXXXX10000000}}&4'h8|
{4{di==16'bXXXXXXX100000000}}&4'h7|
{4{di==16'bXXXXXX1000000000}}&4'h6|
{4{di==16'bXXXXX10000000000}}&4'h5|
{4{di==16'bXXXX100000000000}}&4'h4|
{4{di==16'bXXX1000000000000}}&4'h3|
{4{di==16'bXX10000000000000}}&4'h2|
{4{di==16'bX100000000000000}}&4'h1|
{4{di==16'b1000000000000000}}&4'h0|4'h0
));



endmodule