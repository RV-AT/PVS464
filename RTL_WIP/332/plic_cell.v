module plic_cell(
input int_src,
input rst_n,
input [4:0]prio,
input [4:0]thres,
input en,
input ack,
output ip,
output iclaim

);
wire rst;
assign rst=!rst_n;
reg gate;
assign ip=gate;
always@(posedge int_src or posedge rst or posedge ack)
begin
    if(rst)
    gate<=1'b0;
    else
    gate<=(ack)?1'b0:((int_src&en)?1'b1:1'b0);
end
assign iclaim=(prio>thres)&gate;


endmodule