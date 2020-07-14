/*
M和S模式的status寄存器是一起的，因为SSTATUS寄存器是MSTATUS寄存器的一个子集
*/
module m_s_status(

input wire clk,
input wire rst,
//控制位输出
output reg sie,
output reg mie,
output reg mprv,
output reg sum,
output reg mxr,
output reg tvm,
output reg tw,
output reg tsr,

//权限输出
output reg [3:0]priv,
output wire [3:0]mod_priv,

input wire csr_write,
input wire [63:0]data_csr,
input wire mrw_mstatus_sel,
input wire srw_sstatus_sel,

//Trap信号
input wire trap_target_m,		//m模式受理trap，当此位为1时候，m模式下受理trap的寄存器将会被影响，s模式的不动
input wire trap_target_s,		//s模式受理trap，当此位为1时，s模式下受理trap的寄存器将会被影响，M模式的不动
//wb信号
//机器控制段
//机器控制段负责WB阶段时csr的自动更新

input wire valid, 			//指令有效信号

input wire m_ret,			//返回信号
input wire s_ret,			//

output wire [63:0]sstatus,
output wire [63:0]mstatus


);
parameter m	=	4'b1000;
parameter s = 	4'b0010;
parameter u = 	4'b0001;

reg spie;
reg mpie;
reg spp;
reg [1:0]mpp;
//status寄存器逻辑
always@(posedge clk)begin
	if(rst)begin
		sie		<=	1'b0;
		mie		<=	1'b0;
		mprv	<=	1'b0;
		sum		<=	1'b0;
		mxr		<=	1'b0;
		tvm		<=	1'b0;
		tw		<=	1'b0;
		tsr		<=	1'b0;
		spie	<=	1'b0;
		mpie	<=	1'b0;
		spp		<=	1'b0;
		mpp		<=	2'b0;
	end
	else if(mrw_mstatus_sel & csr_write)begin
		sie		<=	data_csr[1];
		mie		<=	data_csr[3];
		mprv	<=	data_csr[17];
		sum		<=	data_csr[18];
		mxr		<=	data_csr[19];
		tvm		<=	data_csr[20];
		tw		<=	data_csr[21];
		tsr		<=	data_csr[22];
		spie	<=	data_csr[5];
		mpie	<=	data_csr[7];
		spp		<=	data_csr[8];
		mpp		<=	data_csr[12:11];
	end
	//sstatus寄存器是mstatus寄存器的一个子集，写sstatus寄存器时部分mstatus位不可写
	else if(srw_sstatus_sel & csr_write)begin
		sie		<=	data_csr[1];
		spie	<=	data_csr[5];
		spp		<=	data_csr[8];
		sum		<=	data_csr[18];
		mxr		<=	data_csr[19];
	end
	else if(valid & m_ret)begin
		mie		<=	mpie;
		mpie	<=	1'b0;
		mpp		<=	2'b0;
	end
	else if(valid & s_ret)begin
		sie		<=	spie;
		spie	<=	1'b0;
		spp		<=	1'b0;
	end
	else if(trap_target_m)begin
		mpie	<=	mie;
		mie		<=	1'b0;
		mpp		<=	priv[3]?2'b11:priv[1]?2'b01:priv[0]?2'b00:2'b10;
	end
	else if(trap_target_s)begin
		spie	<=	sie;
		sie		<=	1'b0;
		spp		<=	priv[1]?1'b1:1'b0;
	end
end

//权限更新
always@(posedge clk)begin
	if(rst)begin
		priv	<=	m;
	end
	else if(valid & m_ret)begin
		priv	<=	(mpp==2'b11)? m : (mpp==2'b01)? s : u;
	end
	else if(valid & s_ret)begin
		priv 	<=	(spp==1'b1)? s : u;
	end
end

assign mstatus	= {28'b0,4'b1111,9'b0,tsr,tw,tvm,mxr,sum,mprv,4'b0,mpp,2'b00,spp,mpie,1'b0,spie,1'b0,mie,1'b0,sie,1'b0};
assign sstatus 	= {30'b0,2'b11,12'b0,mxr,sum,1'b0,4'b0,2'b0,2'b0,spp,2'b0,spie,3'b0,sie,1'b0};

assign mod_priv[3]	=	(mpp==2'b11);
assign mod_priv[2]  =   1'b0; 
assign mod_priv[1]	=	(mpp==2'b01);
assign mod_priv[0]	=	(mpp==2'b00);








endmodule
