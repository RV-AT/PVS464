/*
�Ž�������ģ�飬APB�Ž���Э��״̬��ģ��
*/
module apb_ctrl(
                hclk,
                hresetn,
                htrans_i,//[1:0],
                hwrite_i,
                hsel_apb_i,
                hready_r_i,
                haddr_i,
                hwdata_i,
                pslverr_i,
                prdata_i,//[31:0],
                //output
                pselx_en_o,
                penable_o,
                hready_o,  //this signal should be set high at the default conditions
                hresp_o,//[1:0],
                pwdata_o,
                paddr_o,
                pwrite_o,
                hrdata_o,
                ////////////////////
                //fpga����ʹ��
                addr_delay,
                iiaddr,
                cur_state,
                pre_state
                /////////////////
                );
input hclk,
      hresetn,
      hwrite_i,
      hsel_apb_i,
      hready_r_i,
      pslverr_i;
  
input [1:0]  htrans_i;
input [31:0] haddr_i,
             hwdata_i,
             prdata_i;
output pselx_en_o;
output penable_o;
output hready_o;
output [1:0] hresp_o;
output [31:0] pwdata_o,
              paddr_o,
              hrdata_o;
output [3:0] cur_state,
             pre_state;
output pwrite_o;
output [31:0] addr_delay,
              iiaddr;
reg pselx_en_o,
    penable_o,   
    ihready;
wire [1:0] htrans_i;
wire hready_o;
reg [1:0]  hresp_o;
reg [3:0] cur_state;
reg [3:0] nex_state;
reg [3:0] ipre_state;
reg iwrite;
reg [31:0] addr_delay;
reg [31:0] haddr_hold;
//reg iready;
wire [1:0] trans_st_judge;
wire valid;
reg hwritereg;
reg [3:0] pre_state;
reg [31:0] iwdata,
           iiwdata,
           iaddr,
           irdata,
           iiaddr;
wire [31:0] hrdata_o;
wire [31:0] haddr_i,
            hwdata_i,
            pwdata_o,
            paddr_o,
            prdata_i,
            wdata_delay;
//ENCODING FOR THE STATE MACHINE
parameter DELAY = 1'b1;
parameter ST_IDLE = 4'b0111;
parameter ST_READ = 4'b0110;
parameter ST_RENABLE = 4'b0101;
parameter ST_WWAIT = 4'b0100;
parameter ST_WRITE = 4'b0011;
parameter ST_WENABLE = 4'b0010;
parameter ST_WRITEP = 4'b0001;
parameter ST_WENABLEP = 4'b0000;
parameter ST_RWAIT = 4'b1000;
parameter ST_WWRITEP = 4'b1001;
parameter ST_WWREAD = 4'b1010;

//THE TRANS TYPE
parameter TR_IDLE = 2'B00;
parameter TR_BUSY = 2'B01;
parameter TR_NONSEQ = 2'B10;
parameter TR_SEQ = 2'b11;
//------------------------------
//RESPONSE DEFINE
parameter RES_OK = 1'B0;
parameter RES_ERR = 1'B1;
//-------------------------------

reg [1:0] htrans_reg1,
          htrans_reg2;
always @(posedge hclk)
  begin
    htrans_reg1 = htrans_i;
    htrans_reg2 = htrans_reg1;
  end 
assign valid = ( (htrans_i == TR_NONSEQ) | (htrans_i == TR_SEQ)) ? 1'b1 : 1'b0;
//assign state_en = hsel_apb_i ;
assign hready_o = ihready;
always @(posedge hclk)
  if ( !hresetn )
    begin
      hwritereg = 1'b1;
    end
  else
    begin
      hwritereg = hwrite_i;
    end
   
assign trans_st_judge[1] = hsel_apb_i;//,hwrite); 
assign trans_st_judge[0] = hwrite_i; 
always @(hresetn  or trans_st_judge or valid or cur_state or hsel_apb_i or hwrite_i)// posedge hclk)
  begin
    if (!hresetn )
      begin
//        cur_state = ST_IDLE;
        nex_state = ST_IDLE;
      end
    else
      begin
        // synopsys translate_off
        //#DELAY;
        //synopsys translate_on
        case (cur_state)
        ST_IDLE :
          begin
            if (valid)
              begin
                case (trans_st_judge)
                2'b00,2'b01:
                  begin
                    nex_state = ST_IDLE;
                  end
                2'b11:
                  begin
                    nex_state = ST_WWAIT;
                  end
                2'b10:
                  begin
                    nex_state = ST_READ;
                  end
                default:
                  begin
                    nex_state = ST_IDLE;
                  end
                endcase
              end
            else
              begin
                nex_state = ST_IDLE;
              end
          end
        ST_READ:
          begin
            nex_state = ST_RENABLE;  
          end
        ST_RWAIT:
          begin
            nex_state = ST_RENABLE;
          end
        ST_RENABLE :
          begin
            if(hsel_apb_i)
              begin
                if (!valid)
                  begin
                    nex_state = ST_IDLE;
                  end
                else
                  begin
                    if (hwrite_i)
                      begin
                        nex_state = ST_WWAIT;
                      end
                    else
                      begin
                        nex_state = ST_READ;
                      end
                  end
              end
            else
              begin
                nex_state = ST_IDLE;
              end
          end
      
        ST_WWAIT:
          begin
            if (valid)
              begin
                nex_state = ST_WRITEP;
              end
            else
              begin
                nex_state = ST_WRITE;
              end
          end
        ST_WRITE:
          begin
            if(valid)
              begin
                nex_state = ST_WENABLEP;
              end
            else
              begin
                nex_state = ST_WENABLE;
              end
          end
        ST_WENABLE:
          begin
            if (valid)
              begin
                if(hwrite_i)
                  begin
                    nex_state = ST_WWAIT;
                  end
                else
                  begin
                    nex_state = ST_READ;
                  end
               end
            else
              begin
                nex_state = ST_IDLE;
              end
              
          end
        ST_WRITEP:
          begin
            nex_state = ST_WENABLEP;
          end
        ST_WENABLEP:
          begin
            nex_state = ST_IDLE;
          end
        ST_WWREAD:
          begin
            nex_state = ST_READ;
          end
        default:
          begin
            nex_state = ST_IDLE;
          end
        endcase
      end
  end

always @(posedge hclk)

  begin
    ipre_state = cur_state;
    cur_state = nex_state;
  end
always @(cur_state or ipre_state)
  begin
    pre_state = ipre_state;
  end

//assign addr_delay = haddr_i & 32'hffff_ffff;
always @(posedge hclk)
  if (!hresetn )
    begin
    haddr_hold <= 32'h0;
    end
  //else if ((nex_state == `ST_WWAIT )|(nex_state == `ST_READ ))
  else if ((nex_state == 4'b0100 )|(nex_state == 4'b0110 ))
    begin
    haddr_hold <= haddr_i;
    end
  else
    begin
    haddr_hold <= haddr_hold;
    end
  
always @(posedge hclk)
//always @ (haddr_i)
  begin
  case (cur_state)
  ST_IDLE,
  ST_WENABLE:
    begin
    addr_delay = haddr_i;
    end
  default:
    begin
      addr_delay = addr_delay;
    end
  endcase
  end
always @(posedge hclk)
//always @ (haddr_i)
  begin
  case (cur_state)
  ST_WWAIT:
    begin
    iiwdata = hwdata_i;
    end
  default:
    begin
      iiwdata = iiwdata;
    end
  endcase
  end  


always @(cur_state or hresetn or addr_delay or pre_state or iiwdata or iiaddr or hwdata_i or haddr_i or prdata_i or haddr_hold)
//always @(posedge hclk)
if (!hresetn)
begin
  pselx_en_o = 1'b0;
  penable_o = 1'b0;
  ihready = 1'b0;  //8.27
  hresp_o = RES_OK;
  iwdata = 32'h0000_0000;
  iaddr = 32'h0000_0000;
  iwrite = 1'b1;
//  irdata = 32'h0000_0000;
end
else
begin
  case (cur_state)
  ST_IDLE:
    begin
      pselx_en_o = 1'b0;
      penable_o = 1'b0;
      ihready = 1'b1; //1.13
      iwrite = 1'b0;
      hresp_o = RES_OK;
    end
  ST_READ:
    begin
      pselx_en_o = 1'b1;
      penable_o = 1'b0;
      ihready = 1'b0;
      hresp_o = (pslverr_i)?RES_ERR:RES_OK;
      //iaddr = addr_delay;
      iaddr = haddr_hold;
      iwrite = 1'b0;
    end
  ST_RWAIT:
    begin
      pselx_en_o = 1'b1;
      penable_o = 1'b1;
      ihready = 1'b0;
      iaddr = haddr_hold;
      hresp_o = hresp_o;
    end
  ST_WWAIT:
    begin
      
      //iiaddr = addr_delay;
      iaddr = haddr_hold;
      pselx_en_o = 1'b0;
      penable_o = 1'b0;
      ihready = 1'b0;
      hresp_o = hresp_o;
      #1;
    //  iiwdata = hwdata_i;
      
    end
  ST_WRITE:
    begin
     case(pre_state)
     ST_WWAIT:
       begin
         iwdata =iiwdata;
         pselx_en_o = 1'b1;
         penable_o = 1'b0;
         ihready = 1'b0;
         hresp_o = hresp_o;
         iwrite = 1'b1;
         //iaddr = iiaddr;
         iaddr = haddr_hold;
       end
     default:
       begin
         pselx_en_o = 1'b1;
         penable_o = 1'b0;
         ihready = 1'b0;
         hresp_o = (pslverr_i)?RES_ERR:RES_OK;
         iwdata =hwdata_i;
         //iaddr = haddr_i;
         iaddr = haddr_hold;
         iwrite = 1'b1;
       end
     endcase
         

    end
  ST_WRITEP:
    begin
    
    
    if (pre_state == ST_WWAIT)
      begin
        
        pselx_en_o = 1'b1;
        penable_o = 1'b0;
        ihready = 1'b0;
        iwdata =iiwdata;
        //iaddr = iiaddr;
        iaddr = haddr_hold;
        iwrite = 1'b1;
        hresp_o = hresp_o;
      end
    else
      begin
        
        pselx_en_o = 1'b1;
        penable_o = 1'b0;
        ihready = 1'b0;
        
        //iaddr = haddr_i;
        iaddr = haddr_hold;
        iwrite = 1'b1;
        hresp_o = hresp_o;
        #1;
        iwdata =hwdata_i;
      end   
      
     end

  ST_RENABLE :
    begin
      pselx_en_o = 1'b1;
      penable_o = 1'b1;
      ihready = 1'b1;
      hresp_o = RES_OK;
//      irdata = prdata_i;
      //iaddr = addr_delay;
      iaddr = haddr_hold;
    end
  ST_WENABLE:
    begin
      pselx_en_o = 1'b1;
      penable_o = 1'b1;
      iwrite = 1'b1;
      ihready = 1'b1;
      hresp_o = RES_OK;
      iwdata = iwdata;
      //iaddr = iiaddr;
      iaddr = haddr_hold;
    end
  ST_WENABLEP:
    begin
      pselx_en_o = 1'b1;
      penable_o = 1'b1;
      iwrite = 1'b1;
      hresp_o = RES_OK;
      ihready = 1'b1;
      //iaddr = iiaddr;
      iaddr = haddr_hold;
      iwdata = hwdata_i;

    end
  ST_WWREAD:
    begin
      ihready = 1'b0;
    end
  default:
    begin
      pselx_en_o = 1'b0;
      penable_o = 1'b0;
      hresp_o = RES_OK;
      ihready = 1'b1;    
//      iiaddr = iiaddr;
     //9.24
      iwdata = 32'h0000_0000;
      iaddr = 32'h0000_0000;
      iwrite = 1'b1;
//      irdata = irdata;
      ////////////
    end
  endcase
end
assign paddr_o = iaddr;
assign pwdata_o = iwdata;
assign pwrite_o = iwrite;
assign hrdata_o = irdata;
always @(posedge hclk)
  if (!hresetn )
  begin
  irdata <= 32'h00;
  end
  else if (cur_state == ST_RENABLE)
  begin
  irdata <= prdata_i;
  end
  else
  begin
  irdata <= irdata;
  end
endmodule