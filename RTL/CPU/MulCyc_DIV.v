
module MulCyc_Div
	(
	input clk,
	input rst_n,
	input [63:0]DIVIDEND,
	input [63:0]DIVIDSOR,
	input start,
	input clr, //Clear wire
	output reg[63:0]DIV,
	output reg[63:0]MOD,
	output reg DBZ, //Divide by zero
	output reg ready //Calculate done
	);
	parameter IDLE = 2'd0;
	parameter CALC = 2'd1;
	parameter ERR  = 2'd2;
	parameter DONE = 2'd3;
	reg [127:0]mid;
	reg [1:0]state;
	reg [6:0]SCNT;
	reg [1:0]next_state;
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)state<=0;
		else state=next_state;
	end
	always @(*)
	begin
		case(state)
		IDLE:
		begin
			if(start)
				if(DIVIDSOR!=0)next_state=CALC;
				else next_state=ERR;
			else next_state=IDLE;
		end
		CALC:
		begin
			if(SCNT==6'h3F)next_state=DONE;
			else next_state=CALC;
		end
		ERR:
		begin
			if(clr)next_state=DONE;
			else next_state=ERR;
		end
		DONE:
		begin
			next_state=IDLE;
		end
		endcase
		
	end
	wire [127:0]DVS;//divisor
	wire [127:0]mid_s;
	wire [127:0]mid_o;
	assign DVS={DIVIDSOR,64'h00000000};
	assign mid_s={mid[126:0],1'b0};
	assign mid_o=(mid_s[127:64]>=DIVIDSOR)?(mid_s-DVS+1):mid_s;
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
		begin
			DIV<=0;
			MOD<=0;
			DBZ<=0;
			SCNT<=0;
			ready<=1;
			DIV<=0;
			MOD<=0;
			mid<=0;
		end
		else
			case(next_state)
			IDLE:
			begin
				mid<={64'h00000000,DIVIDEND};
				SCNT<=0;
				ready<=1;
				DBZ<=0;
			end
			CALC:
			begin
				ready<=0;
				SCNT<=SCNT+1;
				mid<=mid_o;
			end
			ERR:
			begin
				DBZ<=1;
			end
			DONE:
			begin
				DIV=mid[63:0];
				MOD=mid[127:64];
				ready<=1;
				DBZ<=0;
			end
			endcase
		
	end
endmodule
