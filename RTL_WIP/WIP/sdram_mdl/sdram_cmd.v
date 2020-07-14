`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.11
// Design Name	: 
// Module Name	: sdram_cmd
// Project Name	: 
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: SDRAM命令模块
//				
// Revision		: V1.0
// Additional Comments	:  
// 
////////////////////////////////////////////////////////////////////////////////
module sdram_cmd(
				clk,rst_n,
				sdram_cke,sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n,sdram_ba,sdram_addr,
				sys_addr,
				init_state,work_state
			);
	//系统信号
input clk;					//50MHz
input rst_n;				//低电平复位信号
	// SDRAM硬件接口
output sdram_cke;			// SDRAM时钟有效信号
output sdram_cs_n;			//	SDRAM片选信号
output sdram_ras_n;			//	SDRAM行地址选通脉冲
output sdram_cas_n;			//	SDRAM列地址选通脉冲
output sdram_we_n;			//	SDRAM写允许位
output[1:0] sdram_ba;		//	SDRAM的L-Bank地址线
output[11:0] sdram_addr;	// SDRAM地址总线
	// SDRAM封装接口
input[21:0] sys_addr;		// 读写SDRAM时地址暂存器，(bit21-20)L-Bank地址:(bit19-8)为行地址，(bit7-0)为列地址 
	// SDRAM内部接口
input[4:0] init_state;		// SDRAM初始化状态寄存器
input[3:0] work_state;		// SDRAM读写状态寄存器


`include "sdr_para.v"		// 包含SDRAM参数定义模块

//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------
reg[4:0] sdram_cmd_r;	//	SDRAM操作命令
reg[1:0] sdram_ba_r;
reg[11:0] sdram_addr_r;

assign {sdram_cke,sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n} = sdram_cmd_r;
assign sdram_ba = sdram_ba_r;
assign sdram_addr = sdram_addr_r;

//-------------------------------------------------------------------------------
	//SDRAM命令参数赋值
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
			sdram_cmd_r <= `CMD_INIT;
			sdram_ba_r <= 2'b11;
			sdram_addr_r <= 12'hfff;
		end
	else
		case (init_state)
				`I_NOP,`I_TRP,`I_TRF1,`I_TRF2,`I_TRF3,`I_TRF4,`I_TRF5,`I_TRF6,`I_TRF7,`I_TRF8,`I_TMRD: begin
						sdram_cmd_r <= `CMD_NOP;
						sdram_ba_r <= 2'b11;
						sdram_addr_r <= 12'hfff;	
					end
				`I_PRE: begin
						sdram_cmd_r <= `CMD_PRGE;
						sdram_ba_r <= 2'b11;
						sdram_addr_r <= 12'hfff;
					end 
				`I_AR1,`I_AR2,`I_AR3,`I_AR4,`I_AR5,`I_AR6,`I_AR7,`I_AR8: begin
						sdram_cmd_r <= `CMD_A_REF;
						sdram_ba_r <= 2'b11;
						sdram_addr_r <= 12'hfff;						
					end 			 	
				`I_MRS: begin	//模式寄存器设置，可根据实际需要进行设置
						sdram_cmd_r <= `CMD_LMR;
						sdram_ba_r <= 2'b00;	//操作模式设置
						sdram_addr_r <= {
                            2'b00,			//操作模式设置
                            1'b0,			//操作模式设置(这里设置为A9=0,即突发读/突发写)
                            2'b00,			//操作模式设置({A8,A7}=00),当前操作为模式寄存器设置
                            3'b011,			// CAS潜伏期设置(这里设置为3，{A6,A5,A4}=011)
                            1'b0,			//突发传输方式(这里设置为顺序，A3=b0)
                            3'b011			//突发长度(这里设置为8，{A2,A1,A0}=011)
								};
					end	
				`I_DONE:
					case (work_state)
							`W_IDLE,`W_TRCD,`W_CL,`W_TRFC,`W_RD,`W_WD,`W_TDAL: begin
									sdram_cmd_r <= `CMD_NOP;
									sdram_ba_r <= 2'b11;
									sdram_addr_r <= 12'hfff;
								end
							`W_ACTIVE: begin
									sdram_cmd_r <= `CMD_ACTIVE;
									sdram_ba_r <= sys_addr[21:20];	//L-Bank地址
									sdram_addr_r <= sys_addr[19:8];	//行地址
								end
							`W_READ: begin
									sdram_cmd_r <= `CMD_READ;
									sdram_ba_r <= sys_addr[21:20];	//L-Bank地址
									sdram_addr_r <= {
													4'b0100,		// A10=1,设置写完成允许预充电
													sys_addr[7:0]	//列地址  
												};
								end
							`W_WRITE: begin
									sdram_cmd_r <= `CMD_WRITE;
									sdram_ba_r <= sys_addr[21:20];	//L-Bank地址
									sdram_addr_r <= {
													4'b0100,		// A10=1,设置写完成允许预充电
													sys_addr[7:0]	//列地址  
												};
								end							
							`W_AR: begin
									sdram_cmd_r <= `CMD_A_REF;
									sdram_ba_r <= 2'b11;
									sdram_addr_r <= 12'hfff;	
								end
							default: begin
									sdram_cmd_r <= `CMD_NOP;
									sdram_ba_r <= 2'b11;
									sdram_addr_r <= 12'hfff;	
								end
						endcase
				default: begin
							sdram_cmd_r <= `CMD_NOP;
							sdram_ba_r <= 2'b11;
							sdram_addr_r <= 12'hfff;	
						end
			endcase
end

endmodule

