module UART_Tx(clk,rst,en,ChkEn,send,dat,busy,TINT,TxD);
input clk,rst,en,ChkEn,send;
input [7:0] dat;
output reg TxD,busy,TINT;
wire [4:0]TbN;
reg [8:0]TBUF;
reg [3:0]TbC;
reg[3:0]status;
reg[3:0]next_status;
assign TbN=(ChkEn)?9:8;
parameter Idle=2'b00;
parameter Start=2'b01;
parameter Tb=2'b10;
parameter Stop=2'b11;
always @(posedge clk or posedge rst)
begin
if (rst)
	begin
	status<=Idle;
	//TBUF<=8'b0;
	end
else status<=next_status;
end

always @(*)
begin
	case (status)
	Idle:
		begin
		if(send&en) next_status=Start;
		else next_status=Idle;
		end
	Start:next_status=Tb;
	Tb:if(TbC!=TbN)next_status=Tb;
		else next_status=Stop;
	Stop:
		begin
		next_status=Idle;
		end
	default:next_status=Idle;
	endcase
end

always @ (posedge clk or posedge rst)
begin
	if(rst)
	begin
		TxD<=1;
		TBUF<=0;
		busy<=0;
		TbC<=0;
		TINT<=0;
	end
	else
		case (next_status)
			Start:
				begin
				TxD<=1'b0;
				TBUF<={~(^dat),dat};
				busy<=1'b1;
				TINT<=0;
				TbC<=0;
				end
			Tb:
				begin 
					{TBUF,TxD}<=TBUF;
					TbC=TbC+1;
				end	
			Stop:begin TxD<=1'b1;busy<=1'b0;TINT<=1; end
			default:begin TxD<=1'b1;busy<=1'b0;TINT<=1'b0;end
		endcase
end
endmodule