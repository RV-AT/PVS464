module UART_Rx(clk,rst,en,ChkEn,RxD,dat,ERR,INT);
input clk,rst,RxD,ChkEn,en;
output reg[7:0]dat;
output reg ERR,INT;
reg [8:0]RBUF;
reg[3:0]status;
reg[3:0]next_status;
reg[3:0]OSRCNT;
reg [3:0]BCNT;
reg [3:0]RSTAT;
wire [3:0]BSEL;//8bit or 9 bit;
parameter Idle		=3'b000;
parameter wait16	=3'b001;
parameter CLR		=3'b010;
parameter Rb		=3'b100;
parameter Stop		=3'b101;
assign BSEL=(ChkEn)?4'h8:4'h7;
always @(posedge clk or posedge rst)
begin
if (rst)
	begin
	status<=Idle;
	end
else status<=next_status;
end

always @(*)
begin
	case (status)
	Idle:
		begin
		if((!RxD)&en) next_status=wait16;
		else next_status=Idle;
		end

	wait16:
		begin
		if(RSTAT>=4'hc)next_status=CLR;
		else next_status=wait16;
		end
	CLR:
		begin
		next_status=Rb;
		end
	Rb:
		begin
		if(BCNT>BSEL)next_status=Stop;
		else next_status=Rb;
		end
	Stop:
		begin
		if(RSTAT<=5'h0e) next_status=Stop;
		else 
			if(RxD) next_status=Idle;
			else next_status=wait16;
		end
	endcase
end

always @ (posedge clk or posedge rst)
begin
	if(rst)
		begin
			INT<=0;
			ERR<=0;
			BCNT<=0;
			OSRCNT<=0;
			RBUF<=0;
			dat<=0;
		end
	else
		begin
			case (next_status)
				Idle:
				begin
					OSRCNT<=0;
					RSTAT<=0;
					BCNT<=0;	
					RBUF<=0;
					INT<=0;
				end
				wait16:
				begin
					RSTAT<=RSTAT+1;
				end
				CLR:
				begin
					BCNT<=0;
					OSRCNT<=0;
				end
				Rb:
				begin 
					
					if(RSTAT<=4'he)
					begin
						OSRCNT<=OSRCNT+RxD;
						RSTAT<=RSTAT+1;
					end
					else
						begin
							RSTAT<=0;
							BCNT<=BCNT+1;
							RBUF<={OSRCNT[3],RBUF[8:1]};
							OSRCNT<=0;
						end
				end
				Stop:
				begin 
					dat<=(ChkEn)?RBUF[7:0]:RBUF[8:1];
					INT<=1'b1;
					ERR<=ChkEn&(RBUF[8])^(^RBUF[7:0]);
					RSTAT<=RSTAT+1;
				end
				default:INT<=1'b0;
			endcase
		end
end
endmodule	
