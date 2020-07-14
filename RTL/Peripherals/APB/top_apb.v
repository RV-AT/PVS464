/*//////////////////////////
//��������ģ�飬������ģ��
*////////////////////////////

module top_apb(
               hclk,
               hreset_n,
               haddr_i,//[31:0],
               htrans_i,//[1:0],//��������źţ�����AHB
               hwrite_i,
               hwdata_i,//[31:0],
               hsel_apb_i,//apbѡ���ź�
               prdata_i,//[31:0],
               hready_r_i,
               //hready_w_i,
               //output
               hrdata_o,//[31:0],
               hready_o,
               hresp_o,//[1:0],
               pwdata_o,//[31:0],
               penable_o,
               psel_slave_o,
               paddr_o,//[31:0],
               pwrite_o,
               //////
               //fpga����ʹ��
               addr_delay,
               iiaddr,
               apb_state,
               apb_pre_state,
	       write
               );

input hclk,
      hreset_n,
      hwrite_i,
      hsel_apb_i,
      hready_r_i;
input [31:0] haddr_i;
input [1:0] htrans_i;
input [31:0] hwdata_i,
             prdata_i;
output [31:0] hrdata_o,
              pwdata_o,
              paddr_o;
output [1:0] hresp_o;
output [6:0] psel_slave_o;
output hready_o,
       penable_o,
       pwrite_o;
output [31:0] addr_delay,
              iiaddr;
output [3:0] apb_state,apb_pre_state;
wire [3:0] apb_state,apb_pre_state;
output write;
wire [31:0] haddr_i,
            hwdata_i,
            prdata_i,
            hrdata_o,
            pwdata_o,
            paddr_o,
            addr_delay,
            iiaddr;
wire [1:0] htrans_i,
           hresp_o,
           ptrans_i;
wire [6:0] psel_slave_o;  
reg write;
always @(hwrite_i)
  begin
    write = hwrite_i;
  end         
apb_transfer apb_transfer(
                          hclk,//.hclk 
                          hreset_n,//.hreset_n 
                          paddr_o,//addr_delay,
                          pselx_en_i,//.pselx_en_i
                          
                          psel_slave_o
                          );
apb_ctrl apb_ctrl(
                  hclk,//.hclk 
                  hreset_n,//.hreset_n 
                  htrans_i,//.ptrans_i[1:0]
                  write,
						//hwrite_i,//.pwrite_i
                  hsel_apb_i,//.psel_apb_i 
                  hready_r_i,//.hready_r_i 
                  haddr_i,
                  hwdata_i,
                  prdata_i,
                  //output
                  pselx_en_i,//.pselx_en_o
                  penable_o,//.penable_o 
                  hready_o,  //.hready_o  this signal should be set high at the default conditions
                  hresp_o,//.hresp_o [1:0]
                  pwdata_o,
                  paddr_o,
                  pwrite_o,
                  hrdata_o,
                  addr_delay,
                  iiaddr,
                  apb_state,
                  apb_pre_state
                  );                       
endmodule