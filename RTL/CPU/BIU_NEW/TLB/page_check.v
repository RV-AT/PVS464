module page_check(
//csr
input wire [3:0]priv,
input wire mxr,
input wire sum,
//读写控制
input wire read,
input wire write,
input wire execute,

//PTE
input wire PTE_U,
input wire PTE_W,
input wire PTE_R,
input wire PTE_X,

//检查正确
output wire check_ok
);

//权限检查
wire privilege_check_ok;

//读检查
wire read_check;
//写检查
wire write_check;
//执行检查
wire execute_check;

assign privilege_check_ok	=	((priv==4'b0001) & PTE_U) | 		//U模式访问U模式的页面
								((priv==4'b0010) & PTE_U & sum) | 	//S模式在SUM=1访问U模式
								(priv==4'b0010) & !PTE_U | 			
								(priv==4'b1000);
								
assign read_check	=	read & PTE_R | read & PTE_X & mxr;
assign write_check	=	write & PTE_W;
assign execute_check=	execute & PTE_X;

assign check_ok	=	privilege_check_ok & (read_check | write_check | execute_check);

endmodule