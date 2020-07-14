`define SPIio 4'b0010   //@SPI Mode, SIO[3:2]in Read mode, SIO[1] is SO, sio[0] is si
`define QPIo 4'b1111
`define QPIi 4'b0000
`define HiZ 1'b0
`define WRITE 1'b1
`define WCMD 1'b0
`define WDAT 1'b1
module AHB_PSRAM
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
    output HRESP,
    // Data out
    output reg [63:0] HRDATA,

    input [15:0]cycPU,  
    input [15:0]cycCEM,    
    input [31:0]psramc_ctrlreg,//EN[31]
    input CCLKO, //SPI CLK
    input MOSI,
    output MISO,
    input MSPICS,
    //PSRAM Port 
    output [31:0]MDATo,
    input [31:0]MDATi,
    output [31:0]MDATdir,
    output reg [7:0]MCS,
    output MCLK

);


parameter cycRWait = 6; //This is a fixed value (at least for APMemory devices)
parameter PWUP = 4'h0 ;
parameter DEVRST = 4'h1;
parameter WPREP = 4'h2;
parameter WWCMD = 4'h3;
parameter WWDATH = 4'h4;
parameter WWDATL = 4'h5;
parameter RPREP = 4'h6;
parameter RWCMD = 4'h7;
parameter RWAIT = 4'h8;
parameter RREADH = 4'h9;
parameter RREADL = 4'hA;
parameter IDLE = 4'hf;
integer i;



reg [3:0]io_dir;
//wire [3:0]broadcast;
wire [31:0]broadcast_do;
reg [31:0]mdato_mux;//
reg [26:0]adrlatch;//地址缓冲寄存器

reg [63:0]rdbuffer;//读缓冲，用于完成高低4b交错
reg [31:0]wrbuffer;//写缓冲寄存器，满足AHB时序
//reg [63:0]wrdemux;//AHB低位映射至对应芯片

reg [3:0]next_state;
reg [3:0]fsm_state;
reg [9:0]delay_cnt;
reg [9:0]seq_cnt;
reg [7:0]cmdreg;//发送命令寄存器
reg mcs_oe;

assign MISO=MDATo[0]; //SPI INPUT IS ONLY FOR THE LOWEST DEVICE (CHIP0)

reg mclk_oe;//MCLK时钟门控信号
assign MCLK=((psramc_ctrlreg[31])?(mclk_oe&HCLK):CCLKO);//门控

reg datao_sel;//数据输出选择0=广播命令1=分别写对应的数据
assign MDATo=(datao_sel)?broadcast_do:mdato_mux;

wire burst_en;
assign burst_en=HSEL&HBURST[0]&(HSIZE==3'b011);//burst条件：INCR模式，位64b读写

reg [3:0]domux;//命令选择
reg [2:0]dosel;//命令选择信号
always@(*)//命令选择器，用于顺序发1b命令+地址
begin
  casex(dosel)
  3'h0:domux=cmdreg[7:4];
  3'h1:domux=cmdreg[3:0];
  3'h2:domux=adrlatch[23:20];
  3'h3:domux=adrlatch[19:16];
  3'h4:domux=adrlatch[15:12];
  3'h5:domux=adrlatch[11:8];
  3'h6:domux=adrlatch[7:4];
  3'h7:domux=adrlatch[3:0];
  default:domux=4'hx;
  endcase
end
assign broadcast_do={domux,domux,domux,domux,
                    domux,domux,domux,domux,
                    domux,domux,domux,domux,
                    domux,domux,domux,domux};
assign MDATdir={io_dir,io_dir,io_dir,io_dir,
                io_dir,io_dir,io_dir,io_dir,
                io_dir,io_dir,io_dir,io_dir,
                io_dir,io_dir,io_dir,io_dir};
always @(*)//片外-片内桥接组合逻辑块：MCS产生，读写映射逻辑
begin
    casex(HSIZE)//MCS 产生
    3'h0:
    begin
      MCS=~(
      ({8{HADDR[2:0]==3'h0}}&8'h01)|
      ({8{HADDR[2:0]==3'h1}}&8'h02)|
      ({8{HADDR[2:0]==3'h2}}&8'h04)|
      ({8{HADDR[2:0]==3'h3}}&8'h08)|
      ({8{HADDR[2:0]==3'h4}}&8'h10)|
      ({8{HADDR[2:0]==3'h5}}&8'h20)|
      ({8{HADDR[2:0]==3'h6}}&8'h40)|
      ({8{HADDR[2:0]==3'h7}}&8'h80)&
      {8{mcs_oe}});
    end
    3'h1:
    begin
      MCS=~(
      ({8{HADDR[2:1]==2'h0}}&8'h03)|
      ({8{HADDR[2:1]==2'h1}}&8'h0C)|
      ({8{HADDR[2:1]==2'h2}}&8'h30)|
      ({8{HADDR[2:1]==2'h3}}&8'hC0)&
      {8{mcs_oe}});
    end
    3'h2:
    begin
      MCS=~(
      ({8{ HADDR[2]}}&8'h0F)|
      ({8{~HADDR[2]}}&8'hF0)&
      {8{mcs_oe}});
    end
    3'h3:
    begin
      MCS=8'h0&
      {8{mcs_oe}};
    end
    default:
    begin
      MCS=8'hxx;
    end
    endcase  
    HRDATA=rdbuffer;
end

//Data TRx FSM
always@(posedge HCLK)
begin
  if(!HRESETn)
  begin
    fsm_state<=PWUP;
  end
  else
  begin
    fsm_state<=next_state;
  end
end 

always@(*)
begin
  case (fsm_state)
    PWUP:next_state=
          ((delay_cnt<=cycPU)|(!psramc_ctrlreg[31]))?(PWUP):
          (IDLE);
    IDLE:next_state=(!HSEL)?IDLE:
            ((HWRITE)?WPREP:RPREP);
    RPREP:next_state=RWCMD;
    RWCMD:next_state=(seq_cnt>=4'h7)?(RWAIT):(RWCMD);
    RWAIT:next_state=(delay_cnt>=cycRWait)?RREADH:RWAIT;
    RREADH:next_state=RREADL;
    RREADL:next_state=(burst_en)?RREADH:RPREP;
    WPREP:next_state=WWCMD;
    WWCMD:next_state=(seq_cnt>=4'h7)?(WWDATH):(RWCMD);
    WWDATH:next_state=RREADL;
    WWDATL:next_state=(burst_en)?WWDATH:WPREP;
    default: next_state=PWUP;
  endcase
end
always @ (posedge HCLK)
begin
  if(!HRESETn)
  begin
    rdbuffer<=0;
    HREADY<=0;
    delay_cnt<=0;
    seq_cnt<=0;
  end
  else
  begin
    case (fsm_state)
      PWUP:
      begin
        rdbuffer<=0;
        HREADY<=0;
        delay_cnt<=delay_cnt+1;
        seq_cnt<=0;
        mclk_oe<=`HiZ;
        mcs_oe<=`HiZ;
        io_dir<=`QPIi;
      end
      RPREP:
      begin
        adrlatch<=HADDR[27:3];
        cmdreg<=8'hEB;
        HREADY<=1'b0;
        seq_cnt<=4'h0;
        datao_sel<=`WCMD;
        io_dir<=`QPIo;
        mclk_oe<=`WRITE;
        mcs_oe<=`WRITE;//Output mode
      end
      RWCMD:
      begin
        seq_cnt<=seq_cnt+1;
        delay_cnt<=0;
        dosel<=seq_cnt;
        //datao_sel<=1'b1;
      end
      RWAIT:
      begin
        delay_cnt<=delay_cnt+1;//read mode
        io_dir<=`QPIi;
      end
      RREADH:
      begin
        {rdbuffer[63:60],rdbuffer[55:52],
        rdbuffer[47:44],rdbuffer[39:36],
        rdbuffer[31:28],rdbuffer[23:20],
        rdbuffer[15:12],rdbuffer[7:4]}<=MDATi;
      end
      RREADL:
      begin
        {rdbuffer[59:56],rdbuffer[51:48],
        rdbuffer[43:40],rdbuffer[35:32],
        rdbuffer[27:24],rdbuffer[19:16],
        rdbuffer[11:8],rdbuffer[3:0]}<=MDATi;
        HREADY<=1'b1;
      end
      WPREP:
      begin
        adrlatch<=HADDR[27:3];
        cmdreg<=8'h02;
        HREADY<=1'b0;
        io_dir<=`QPIo;
      end
      WWCMD:
      begin
        seq_cnt<=seq_cnt+1;
        delay_cnt<=0;
        if (seq_cnt==4'h7)
        begin
        HREADY<=1'b1;
        end
        datao_sel<=`WCMD;
      end
      WWDATH:
      begin
        datao_sel<=`WDAT;
        mdato_mux<={HWDATA[63:60],HWDATA[55:52],
        HWDATA[47:44],HWDATA[39:36],
        HWDATA[31:28],HWDATA[23:20],
        HWDATA[15:12],HWDATA[7:4]};
        wrbuffer<={HWDATA[59:56],HWDATA[51:48],
        HWDATA[43:40],HWDATA[35:32],
        HWDATA[27:24],HWDATA[19:16],
        HWDATA[11:8],HWDATA[3:0]};
        HREADY<=1'b0;
      end
      WWDATL:
      begin
        mdato_mux<=wrbuffer;
        HREADY<=1'b1;
      end
      IDLE:
      begin
        HREADY<=1'b1;
        datao_sel<=1'b0;
        mcs_oe<=1'b0;
        mclk_oe<=1'b0;
      end      
    endcase
  end
end 


endmodule

