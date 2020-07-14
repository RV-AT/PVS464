module SyncFIFO
(
	input clk,
	input rst_n,
	input wr_en,rd_en,
	input  [7:0]data_in,
	output reg[7:0]data_out,
	output empty,full
	
);



reg	[7:0]ram[15:0];
reg    [3:0] wr_ptr,rd_ptr;//写和读指针
reg    [3:0] counter;//用来判断空满

always@(posedge clk or negedge rst_n)
begin
 if(!rst_n)
 begin
  counter<=0;
  data_out<=0;
  wr_ptr<=0;
  rd_ptr<=0;
 end
 else
 begin
  case({wr_en,rd_en})
   2'b00: counter<=counter;
   2'b01: 
          begin
		   data_out<=ram[rd_ptr];//先进先出，因此读的话依旧按照次序来
		   counter<=counter-1;
		   rd_ptr<=(rd_ptr==15)?0:rd_ptr+1;
		  end
   2'b10:
          begin
		   ram[wr_ptr]<=data_in;//写操作
		   counter<=counter+1;
		   wr_ptr<=(wr_ptr==15)?0:wr_ptr+1;
		  end
   2'b11:
         begin
		  ram[wr_ptr]<=data_in;//读写同时进行，此时counter不增加
		  data_out<=ram[rd_ptr];
		  wr_ptr<=(wr_ptr==15)?0:wr_ptr+1;
		  rd_ptr<=(rd_ptr==15)?0:rd_ptr+1;
		 end 
  endcase
 end
end

assign empty=(counter==0)?1:0;
assign full =(counter==15)?1:0;






endmodule