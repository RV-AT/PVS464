module port8080
	(
	input [7:0]data_i, //Data Bus
	output reg [7:0]data_o,
	output reg wr,
	output reg rd,
	output reg rs,
	
	input [7:0]datain,//INTERNAL BUS
	output reg [7:0]dataout,
	input [7:0]cmd,
	input [2:0]func,//01 SEND COMMAND 10 READ DATA 11 WRITE DATA
	input start,	//START TRANSMISSION/ CONTINUE SIGNAL FOR BULK READ/WRITE (3T)
	output reg busy,
	output reg done,  //COUNT PULSE FOR BULK R/W
	input clk,
	input rst
	);
reg [3:0]status;
reg [3:0]next_status;
parameter Idle=4'b0000;
parameter SC0=4'b0001;
parameter SC1=4'b0010;
parameter SC2=4'b0011;
parameter RB0=4'b0100;
parameter RB1=4'b0101;
parameter RB2=4'b0110;
parameter WB0=4'b0111;
parameter WB1=4'b1000;
parameter WB2=4'b1010;
always @(posedge clk or negedge rst)
begin
if (!rst)
	begin
	status<=Idle;
	//dat<=8'b0;
	end
else status<=next_status;
	
end

always @(*)
begin
//next_status=Idle;
	case (status)
	Idle:
		begin
		if(!start) next_status=Idle;
		else 
			case(func)
				2'b00: next_status=Idle; 
				2'b01: next_status=SC0;//SEND COMMAND
				2'b10: next_status=RB0;//READ BYTE
				2'b11: next_status=WB0;//WRITE BYTE
				default:next_status=Idle;
			endcase
		end
	SC0:next_status=SC1;
	SC1:next_status=SC2;
	SC2:next_status=Idle;
	RB0:next_status=RB1;
	RB1:next_status=RB2;
	RB2:if(!start)next_status=Idle;else next_status=RB0;
	WB0:next_status=WB1;
	WB1:next_status=WB2;
	WB2:if(!start)next_status=Idle;else next_status=WB0;
	default:next_status=Idle;
	endcase
end

always @ (posedge clk or negedge rst)
begin
if(!rst)begin {data_o,wr,rd,rs,busy,done}<=13'b0000000011000;dataout<=8'b0;end//
else
	case (next_status)
		SC0:begin data_o<=cmd;{wr,rd,rs,busy,done}<=5'b11110;end//
		SC1:begin {wr,rd,rs,busy,done}<=5'b01111;end//
		SC2:begin {wr,rd,rs,busy,done}<=5'b11110;end//
		
		RB0:begin {wr,rd,rs,busy,done}<=5'b10010;end//设置功能读字节，同时拉低RD
		RB1:begin {wr,rd,rs,busy,done}<=5'b11010;end//拉高RD
		RB2:begin dataout<=data_i;{wr,rd,rs,busy,done}<=5'b11011;end
		
		WB0:begin data_o<=datain;{wr,rd,rs,busy,done}<=5'b11010;end
		WB1:begin {wr,rd,rs,busy,done}<=5'b01011;end
		WB2:begin {wr,rd,rs,busy,done}<=5'b11010;end
		Idle:begin{wr,rd,rs,busy,done}<=5'b11000;end
		default:{wr,rd,rs,busy,done}<=5'b11000;
	endcase
end

endmodule
	
	