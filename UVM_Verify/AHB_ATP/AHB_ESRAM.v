/******************************************************************
//AHB 2 External Slow RAM
This file is a test model for simulation ONLY!
It is an inaccurate simulation of SDRAM behaviour.
only 32b RW supported (now)

This Is For Xinyu PAN's PVS464 Project

******************************************************************/

module AHB_ESRAM
(
  // --------------------------
  // Input pins: AHB signals //
  // --------------------------
  // Select
  input HSEL,
  // Address and control
  input [35:0] HADDR,
  input HWRITE,
  input [1:0] HTRANS,
  input [2:0] HSIZE,
  input [2:0] HBURST,
  // Data in
  input [63:0] HWDATA,
  // Reset and clock
  input HRESETn,
  input HCLK,
  input HMASTLOCK,
  // --------------
  // Output pins //
  // --------------
  // Transfer responses
  output reg HREADY,
  output [1:0] HRESP,
  // Data out
  output reg [63:0] HRDATA
);

parameter rand_seek_delay=3;
parameter IDLE=3'h0;
parameter RWAIT=3'h1;
parameter RDO=3'h2;
parameter WWAIT=3'h3;
parameter WDI=3'h4;
reg [2:0]delay_cnt;
reg [2:0]burst_cnt;
reg [2:0]rw_fsm;
reg [2:0]next_status;
reg [31:0]stor_array[4194304:0]; //16M Stroage Array
wire BURSTFLAG;
wire [4:0]burst_len;
assign BURSTFLAG=(burst_cnt!=7)&(burst_cnt<=burst_len);

assign burst_len=(
  ({5{HBURST==3'h0}}&4'h1)| //BL=1
  ({5{HBURST==3'h1}}&5'h1F)| //Infinity length
  ({5{HBURST==3'h2}}&4'h3)| //BL=4
  ({5{HBURST==3'h3}}&4'h3)|
  ({5{HBURST==3'h4}}&4'h7)|
  ({5{HBURST==3'h5}}&4'h7)|
  ({5{HBURST==3'h6}}&4'hf)|
  ({5{HBURST==3'h7}}&4'hf));
always@(posedge HCLK or negedge HRESETn)
begin
  if(!HRESETn)
  begin
    rw_fsm<=IDLE;
  end
  else
  begin
    rw_fsm<=next_status;
  end
end 

always@(*)
begin
  case (rw_fsm)
    IDLE:next_status=
          (HSEL)?
          ((HWRITE)?WWAIT:RWAIT)
          :IDLE; 
    RWAIT:next_status=
          (delay_cnt==rand_seek_delay)?
          RDO:RWAIT;
    RDO:next_status=
        (BURSTFLAG)?RDO:
        ((HSEL)?
        ((HWRITE)?WWAIT:RWAIT)
        :IDLE);
    WWAIT:next_status=
          (delay_cnt==rand_seek_delay)?
          WDI:WWAIT;
    WDI:next_status=
        (BURSTFLAG)?WDI:
        ((HSEL)?
        ((HWRITE)?WWAIT:RWAIT)
        :IDLE);
    default: next_status=IDLE;
  endcase
end
always @ (posedge HCLK or negedge HRESETn)
begin
  if(!HRESETn)
  begin
    HRDATA<=0;
    HREADY<=1;
    delay_cnt<=0;
    burst_cnt<=0;
  end
  else
  begin
    case (next_status)
      IDLE:
      begin
        HRDATA<=0;
        HREADY<=1;
        delay_cnt<=0;
        burst_cnt<=0;
      end
      RWAIT:
      begin
        burst_cnt<=0;
        HREADY<=0;
        delay_cnt<=delay_cnt+1;
      end 
      RDO:
      begin
        HREADY<=1;
        HRDATA<=stor_array[HADDR[23:2]];
        if(BURSTFLAG)
          burst_cnt<=burst_cnt+1;
      end
      WWAIT:
      begin
        HREADY<=0;
        delay_cnt<=delay_cnt+1;
      end 
      WDI:
      begin
        HREADY<=1;
        delay_cnt<=0;
        HRDATA<=stor_array[HADDR[23:2]];
        if(BURSTFLAG)
          burst_cnt<=burst_cnt+1;
      end
      default: 
      begin
        HRDATA<=0;
        HREADY<=1;
        delay_cnt<=0;
        burst_cnt<=0;
      end
    endcase
  end
end 
assign HRESP=0;
endmodule
