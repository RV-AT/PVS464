`define SPIio 4'b0010   //@SPI Mode, SIO[3:2]in Read mode, SIO[1] is SO, sio[0] is si
`define QPIo 4'b1111
`define QPIi 4'b0000

`define QPICMD_EXIT     8'hff	//This Command set is for WINBOND device ONLY
`define QPICMD_FASRD    8'h0B
`define QPICMD_WRPRD    8'h0C
`define QPICMD_SETRD    8'hC0


`define SPICMD_RSTEN    8'h66
`define SPICMD_DORST    8'h99
`define SPICMD_GOQPI    8'h38

`define DUMMY_2CK   2'b00
`define DUMMY_4CK   2'b01
`define DUMMY_6CK   2'b10
`define DUMMY_8CK   2'b11

`define WRAP_8B     2'b00
`define WRAP_16B    2'b01
`define WRAP_32B    2'b10
`define WRAP_64B    2'b11

`define RD_SETWORD {2'b00,`DUMMY_8CK,2'b00,`WRAP_64B}
`define SPI_SETSEQ {`SPICMD_RSTEN,`SPICMD_DORST,`SPICMD_GOQPI}
//ATTENTION: FPGA NEEDS TO ENABLE THE PULL UP RESISTORS OF ALL QPI IOs
//This version only support 8/16/32/64bit QPI fetch. Erase and write ignored
module AHB_XIP
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

    //SPI/QPI Flash Port 
    output [3:0]XPIo,
    input [3:0]XPIi,
    output reg[3:0]XPIdir,
    output reg XPICS,
    output XPICLK

);

parameter cycRdWait = 8; //set read Dummy to maximum to achieve fast read
parameter cycRSTWait = 1800; //W25Q128 takes 30us to rst


parameter PWUP = 4'h0 ;
parameter QPIEXIT = 4'h1;
parameter GAP1 = 4'h2;
parameter DEVRST = 4'h3;
parameter RSTWAIT = 4'h4;
parameter SPIINIT = 4'h5;
parameter QPIINIT = 4'h6;
parameter RPREP = 4'h7;
parameter RWCMD = 4'h8;
parameter RWAIT = 4'h9;
parameter RREAD = 4'hA;
parameter RDATAO= 4'hB;
parameter IDLE = 4'hf;
integer i;



reg [3:0]io_dir;
reg [23:0]adrlatch;//地址缓冲寄存器

reg [63:0]rdbuffer;//读缓冲
reg [63:0]rddemux;//完成字节/半字/字寻址缓冲

reg [3:0]next_state;
reg [3:0]fsm_state;
reg [10:0]delay_cnt;
reg [9:0]seq_cnt;
reg [7:0]cmdreg;//发送命令寄存器

reg mclk_oe;//MCLK时钟门控信号
assign XPICLK=(mclk_oe&HCLK);//门控

wire burst_en;
assign burst_en=HSEL&HBURST[0]&(HSIZE==3'b011);//burst条件：INCR模式，位64b读写

reg [4:0]domux;//命令选择 MDATo 输出
assign XPIo=domux;
reg [3:0]dosel;//命令选择信号

reg [24:0]SPISR;//SPI 命令移位寄存器
always@(*)//命令选择器，
begin
  casex(dosel)
  4'h0:domux=cmdreg[7:4];//送QPI命令，用于顺序发1b命令+地址
  4'h1:domux=cmdreg[3:0];
  4'h2:domux=adrlatch[23:20];
  4'h3:domux=adrlatch[19:16];
  4'h4:domux=adrlatch[15:12];
  4'h5:domux=adrlatch[11:8];
  4'h6:domux=adrlatch[7:4];
  4'h7:domux=adrlatch[3:0];//送命令结束
  4'h8:domux={2'bxx,SPISR[23],1'bx};//送SPI命令，初始化使用
  default:domux=4'hx;
  endcase
end

reg [3:0]rdlen;

always @(*)
begin
    casex(HSIZE)
    3'h0:
    begin
      HRDATA=(
      ({64{HADDR[2:0]==3'h0}}&{56'h0,rdbuffer[7:0]})|
      ({64{HADDR[2:0]==3'h1}}&{52'h0,rdbuffer[7:0],8'h0})|
      ({64{HADDR[2:0]==3'h2}}&{48'h0,rdbuffer[7:0],16'h0})|
      ({64{HADDR[2:0]==3'h3}}&{32'h0,rdbuffer[7:0],24'h0})|
      ({64{HADDR[2:0]==3'h4}}&{24'h0,rdbuffer[7:0],32'h0})|
      ({64{HADDR[2:0]==3'h5}}&{16'h0,rdbuffer[7:0],36'h0})|
      ({64{HADDR[2:0]==3'h6}}&{8'h0,rdbuffer[7:0],48'h0})|
      ({64{HADDR[2:0]==3'h7}}&{rdbuffer[7:0],56'h0}));
      rdlen=1-1;
    end
    3'h1:
    begin
      HRDATA=(
      ({64{HADDR[2:1]==3'h0}}&{48'h0,rdbuffer[15:0]})|
      ({64{HADDR[2:1]==3'h1}}&{32'h0,rdbuffer[15:0],16'h0})|
      ({64{HADDR[2:1]==3'h2}}&{16'h0,rdbuffer[15:0],32'h0})|
      ({64{HADDR[2:1]==3'h3}}&{rdbuffer[15:0],48'h0}));
      rdlen=3-1;
    end
    3'h2:
    begin
      HRDATA=(
      ({64{ HADDR[2]}}&{32'h0,rdbuffer[31:0]})|
      ({64{~HADDR[2]}}&{rdbuffer[31:0],32'h0}));
      rdlen=7-1;
    end
    3'h3:
    begin
      HRDATA=rdbuffer;
      rdlen=15-1;
    end
    default:
    begin
      HRDATA=64'hxxxxxxxxxxxxxxxx;
      rdlen<=4'hx;
    end
    endcase  
     
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
    PWUP:next_state=QPIEXIT;  //上电
    QPIEXIT:next_state=(seq_cnt==1)?(GAP1):(QPIEXIT);//送HiZ退出QPI模式（如果在QPI）
    GAP1:next_state=DEVRST; //一个等待周期
    DEVRST:next_state=(seq_cnt==15)?(RSTWAIT):(DEVRST); //SPI复位
    RSTWAIT:next_state=(delay_cnt==cycRSTWait)?SPIINIT:RSTWAIT;//读等待状态
    SPIINIT:next_state=(seq_cnt==15)?QPIINIT:SPIINIT;//SPI初始化，
    QPIINIT:next_state=(seq_cnt==19)?IDLE:QPIINIT;  //QPI初始化，写等待时长
    IDLE:next_state=(!HSEL)?IDLE:RPREP;
    RPREP:next_state=RWCMD; //AHB置忙，装载QPI命令
    RWCMD:next_state=(seq_cnt==10'hf)?(RWAIT):(RWCMD);//写读指令和地址
    RWAIT:next_state=(delay_cnt>=cycRdWait)?RREAD:RWAIT;//等待取数据周期
    RREAD:next_state=(seq_cnt==rdlen)?RREAD:RDATAO;//数据送buffer
    RDATAO:next_state=(burst_en)?RREAD:RPREP;//送出buffer，AHB置闲
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
    XPIdir<=`QPIi;
    XPICS<=1'b1;
    SPISR<=`SPI_SETSEQ;
  end
  else
  begin
    case (fsm_state)
      PWUP:
      begin
        HREADY<=1'b0;
        XPIdir<=`QPIi;
        seq_cnt<=0;
        XPICS<=1'b1;
        cmdreg<=`QPICMD_SETRD;
        adrlatch[23:16]<=`RD_SETWORD;
      end
      QPIEXIT:
      begin
          XPIdir<=`QPIi;
          XPICS<=1'b0;
          mclk_oe<=1'b1;
          seq_cnt<=seq_cnt+1;
      end
      GAP1:
      begin
          XPICS<=1'b1;
          XPIdir<=`SPIio;
          seq_cnt<=0;
      end
      DEVRST:
      begin
          XPICS<=1'b1;
          dosel<=4'h8;
          seq_cnt<=seq_cnt+1;
          delay_cnt<=0;
          SPISR<={SPISR[22:0],1'b0};
      end
      RSTWAIT:
      begin
          XPICS<=1'b1;
          delay_cnt<=delay_cnt+1;
      end
      SPIINIT:
      begin
          XPICS<=1'b1;
          dosel<=4'h8;
          seq_cnt<=seq_cnt+1;
          delay_cnt<=0;
          SPISR<={SPISR[22:0],1'b0};
      end
      QPIINIT:
      begin
          XPIdir<=`QPIo;
          dosel<=seq_cnt[1:0];
          seq_cnt<=seq_cnt+1;
      end
      RPREP:
      begin
        HREADY<=1'b0;
        cmdreg<=`QPICMD_FASRD;
        adrlatch<=HADDR[23:0];
        seq_cnt<=1'b0;
        delay_cnt<=1'b0;
        XPICS<=1'b0;
        io_dir<=`QPIo;
      end
      RWCMD:
      begin
        seq_cnt<=seq_cnt+1;
        mclk_oe<=1'b1;
      end
      RWAIT:
      begin
        io_dir<=`QPIi;
        seq_cnt<=0;
        delay_cnt<=delay_cnt+1;
      end
      RREAD:
      begin
        rdbuffer<={rdbuffer[59:0],XPIi};
        seq_cnt<=seq_cnt+1;
      end
      RDATAO:
      begin
        rdbuffer<={rdbuffer[59:0],XPIi};
        HREADY<=1'b1; 
      end
      IDLE:
      begin
        HREADY<=1'b1;
        XPIdir<=`QPIi;
        mclk_oe<=1'b0;
        seq_cnt<=1'b0;
        XPICS<=1'b0;
      end      
    endcase
  end
end 
assign HRESP=1'b0;
endmodule

