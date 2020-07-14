module AHB_UART
	(
	  // --------------------------
	  // Input pins: AHB signals //
	  // --------------------------
	  // Select
	  input HSEL,
	  // Address and control
	  input [31:0] HADDR,
	  input HWRITE,
	  input [1:0] HTRANS,
	  input [2:0] HSIZE,
	  input [2:0] HBURST,
	  // Data in
	  input [31:0] HWDATA,
	  // Reset and clock
	  input HRESETn,
	  input HCLK,
	  input HMASTLOCK,
	  // --------------
	  // Output pins //
	  // --------------
	  // Transfer responses
	  output HREADY,
	  output [1:0] HRESP,
	  // Data out
	  
	   output [31:0] HRDATA,
	   input UART_Rx,
	   output UART_Tx,
	   output [7:0]UART_INT
	);
	//This module will IGNORE all width requests, only providing 32bit data
	wire BaudL,BaudOut,TINT,RINT,RxError,TxBusy;
    reg [31:0]UART_CFG;//module enable, int enable,fifo enable&sel
	reg [15:0]UART_DIV;
	wire [31:0]UART_STAT;
	reg [7:0]TxReg;
	reg HWI;
	reg [3:0]WADDR;
    wire [7:0]TxDat;
	wire [7:0]RxReg;
    wire [7:0]TFIFOO;
    wire TBUFE,RBUFF;//Send Buffer Full/ Receive Buffer Empty
    assign RBUFF=0;
    reg send,TFIFOHS,TFIFOWR;
	assign UART_INT=({TBUFE,RBUFF,RxError,TINT,RINT}&UART_CFG[31:24]);
	assign UART_STAT={TBUFE,RBUFF,TxBusy,RxError,RINT,TINT};
    assign TxDat=(UART_CFG[4])?TFIFOO:TxReg;
    assign HRDATA=
	(({32{HADDR[6:2]==5'h00}}&UART_CFG)|
	({32{HADDR[6:2]==5'h01}}&UART_DIV)|
	({32{HADDR[6:2]==5'h02}}&({24'b0,RxReg}))|
	({32{HADDR[6:2]==5'h03}}&UART_STAT)|
	32'h00000000);
    always @(posedge HCLK or negedge HRESETn)
    begin
        if(!HRESETn)
        begin
            UART_CFG<=0;
            UART_DIV<=0;
            HWI<=0;
            WADDR<=0;
            send<=1'b0;
            TFIFOHS<=1'b0;
        end
        else
        begin
            if(HWRITE)
            begin
                HWI<=HSEL;
                WADDR<=HADDR[6:2];
                if(UART_CFG[4]&HSEL&HADDR[6:2]==5'h02)
                    TFIFOWR<=1'b1;
            end
            else 
            begin
                HWI<=1'b0;
                TFIFOWR<=1'b0;
            end
            
            if(HWI)
            case (WADDR)
                4'h0:UART_CFG<=HWDATA;
                4'h1:UART_DIV<=HWDATA[15:0];
                4'h2:
                begin
                    if(!UART_CFG[4])
                    begin
                        send<=1'b1;
                        TxReg<=HWDATA[7:0] ;
                    end
                end
            endcase
            else 
            begin
                if(TxBusy)send<=1'b0;
                else if((!TBUFE)&UART_CFG[4])send<=1;
                else send<=0;
            end 
            TFIFOHS=(UART_CFG[4])?TINT:1'b0;
        end
    end 
	BaudGen UBG1(
        .clkdivL(UART_DIV[15:0]),
        .en(UART_CFG[7]),
        .clk(HCLK),
        .rst(~HRESETn),
        .BaudOut(BaudOut),
        .BaudOutL(BaudL)
        );
	UART_Tx UTX1(
        .clk(BaudL),
        .rst(~HRESETn),
        .en(UART_CFG[2]),
        .ChkEn(UART_CFG[0]),
        .send(send),
        .dat(TxDat),
        .busy(TxBusy),
        .TINT(TINT),
        .TxD(UART_Tx)
        );
	UART_Rx URX1(
        .clk(BaudOut),
        .rst(~HRESETn),
        .en(UART_CFG[1]),
        .ChkEn(UART_CFG[0]),
        .RxD(UART_Rx),
        .dat(RxReg),
        .ERR(RxError),
        .INT(RINT)
        );
    SyncFIFO TFIFO1(
        .clk(HCLK),
        .rst_n(HRESETn),
        .wr_en(TFIFOWR),
        .rd_en({TFIFOHS,TINT}==2'b01),
        .data_in(HWDATA),
        .data_out(TFIFOO),
        .empty(TBUFE)
	);
	

	assign HRESP=0;
	assign HREADY=1;

endmodule