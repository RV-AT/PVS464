// Verilog netlist created by TD v4.5.12562
// Wed Apr  8 15:21:33 2020

`timescale 1ns / 1ps
module prv464_top  // ../../RTL/CPU/prv464_top.v(15)
  (
  cacheability_block,
  clk,
  hrdata,
  hready,
  hreset_n,
  hresp,
  m_ext_int,
  m_soft_int,
  m_time_int,
  mtime,
  rst,
  s_ext_int,
  haddr,
  hburst,
  hmastlock,
  hprot,
  hsize,
  htrans,
  hwdata,
  hwrite
  );

  input [31:0] cacheability_block;  // ../../RTL/CPU/prv464_top.v(17)
  input clk;  // ../../RTL/CPU/prv464_top.v(19)
  input [63:0] hrdata;  // ../../RTL/CPU/prv464_top.v(34)
  input hready;  // ../../RTL/CPU/prv464_top.v(31)
  input hreset_n;  // ../../RTL/CPU/prv464_top.v(33)
  input hresp;  // ../../RTL/CPU/prv464_top.v(32)
  input m_ext_int;  // ../../RTL/CPU/prv464_top.v(39)
  input m_soft_int;  // ../../RTL/CPU/prv464_top.v(38)
  input m_time_int;  // ../../RTL/CPU/prv464_top.v(37)
  input [63:0] mtime;  // ../../RTL/CPU/prv464_top.v(42)
  input rst;  // ../../RTL/CPU/prv464_top.v(20)
  input s_ext_int;  // ../../RTL/CPU/prv464_top.v(40)
  output [63:0] haddr;  // ../../RTL/CPU/prv464_top.v(22)
  output [2:0] hburst;  // ../../RTL/CPU/prv464_top.v(25)
  output hmastlock;  // ../../RTL/CPU/prv464_top.v(28)
  output [3:0] hprot;  // ../../RTL/CPU/prv464_top.v(26)
  output [2:0] hsize;  // ../../RTL/CPU/prv464_top.v(24)
  output [1:0] htrans;  // ../../RTL/CPU/prv464_top.v(27)
  output [63:0] hwdata;  // ../../RTL/CPU/prv464_top.v(29)
  output hwrite;  // ../../RTL/CPU/prv464_top.v(23)

  wire [63:0] addr_ex;  // ../../RTL/CPU/prv464_top.v(74)
  wire [63:0] addr_if;  // ../../RTL/CPU/prv464_top.v(65)
  wire [63:0] as1;  // ../../RTL/CPU/prv464_top.v(155)
  wire [63:0] as2;  // ../../RTL/CPU/prv464_top.v(156)
  wire [63:0] csr_data;  // ../../RTL/CPU/prv464_top.v(54)
  wire [11:0] csr_index;  // ../../RTL/CPU/prv464_top.v(180)
  wire [63:0] data_csr;  // ../../RTL/CPU/prv464_top.v(182)
  wire [63:0] data_rd;  // ../../RTL/CPU/prv464_top.v(183)
  wire [63:0] data_read;  // ../../RTL/CPU/prv464_top.v(75)
  wire [63:0] data_write;  // ../../RTL/CPU/prv464_top.v(76)
  wire [63:0] ds1;  // ../../RTL/CPU/prv464_top.v(153)
  wire [63:0] ds2;  // ../../RTL/CPU/prv464_top.v(154)
  wire [11:0] ex_csr_index;  // ../../RTL/CPU/prv464_top.v(147)
  wire [63:0] ex_exc_code;  // ../../RTL/CPU/prv464_top.v(99)
  wire [63:0] ex_ins_pc;  // ../../RTL/CPU/prv464_top.v(100)
  wire [3:0] ex_priv;  // ../../RTL/CPU/prv464_top.v(73)
  wire [4:0] ex_rd_index;  // ../../RTL/CPU/prv464_top.v(150)
  wire [3:0] ex_size;  // ../../RTL/CPU/prv464_top.v(133)
  wire [63:0] flush_pc;  // ../../RTL/CPU/prv464_top.v(61)
  wire [11:0] id_csr_index;  // ../../RTL/CPU/prv464_top.v(55)
  wire [31:0] id_ins;  // ../../RTL/CPU/prv464_top.v(90)
  wire [63:0] id_ins_pc;  // ../../RTL/CPU/prv464_top.v(91)
  wire [4:0] id_rs1_index;  // ../../RTL/CPU/prv464_top.v(57)
  wire [4:0] id_rs2_index;  // ../../RTL/CPU/prv464_top.v(59)
  wire [3:0] if_priv;  // ../../RTL/CPU/prv464_top.v(64)
  wire [63:0] ins_read;  // ../../RTL/CPU/prv464_top.v(67)
  wire [3:0] mod_priv;  // ../../RTL/CPU/prv464_top.v(48)
  wire [63:0] new_pc;  // ../../RTL/CPU/prv464_top.v(184)
  wire [7:0] op_count;  // ../../RTL/CPU/prv464_top.v(157)
  wire [3:0] priv;  // ../../RTL/CPU/prv464_top.v(47)
  wire [63:0] rs1_data;  // ../../RTL/CPU/prv464_top.v(56)
  wire [63:0] rs2_data;  // ../../RTL/CPU/prv464_top.v(58)
  wire [63:0] satp;  // ../../RTL/CPU/prv464_top.v(46)
  wire [3:0] size;  // ../../RTL/CPU/prv464_top.v(78)
  wire [63:0] uncache_data;  // ../../RTL/CPU/prv464_top.v(77)
  wire [63:0] wb_exc_code;  // ../../RTL/CPU/prv464_top.v(185)
  wire [63:0] wb_ins_pc;  // ../../RTL/CPU/prv464_top.v(186)
  wire [4:0] wb_rd_index;  // ../../RTL/CPU/prv464_top.v(181)
  wire amo;  // ../../RTL/CPU/prv464_top.v(138)
  wire amo_lr_sc;  // ../../RTL/CPU/prv464_top.v(111)
  wire and_clr;  // ../../RTL/CPU/prv464_top.v(129)
  wire beq;  // ../../RTL/CPU/prv464_top.v(125)
  wire bge;  // ../../RTL/CPU/prv464_top.v(124)
  wire blt;  // ../../RTL/CPU/prv464_top.v(123)
  wire bne;  // ../../RTL/CPU/prv464_top.v(126)
  wire cache_flush;  // ../../RTL/CPU/prv464_top.v(139)
  wire cache_flush_biu;  // ../../RTL/CPU/prv464_top.v(79)
  wire cache_ready_ex;  // ../../RTL/CPU/prv464_top.v(87)
  wire cache_ready_if;  // ../../RTL/CPU/prv464_top.v(70)
  wire cache_reset;  // ../../RTL/CPU/prv464_top.v(140)
  wire cache_reset_biu;  // ../../RTL/CPU/prv464_top.v(80)
  wire compare;  // ../../RTL/CPU/prv464_top.v(110)
  wire ds1_sel;  // ../../RTL/CPU/prv464_top.v(130)
  wire ex_csr_write;  // ../../RTL/CPU/prv464_top.v(145)
  wire ex_ebreak;  // ../../RTL/CPU/prv464_top.v(171)
  wire ex_ecall;  // ../../RTL/CPU/prv464_top.v(170)
  wire ex_gpr_write;  // ../../RTL/CPU/prv464_top.v(146)
  wire ex_hold;  // ../../RTL/CPU/prv464_top.v(579)
  wire ex_ill_ins;  // ../../RTL/CPU/prv464_top.v(167)
  wire ex_ins_acc_fault;  // ../../RTL/CPU/prv464_top.v(162)
  wire ex_ins_addr_mis;  // ../../RTL/CPU/prv464_top.v(163)
  wire ex_ins_page_fault;  // ../../RTL/CPU/prv464_top.v(164)
  wire ex_int_acc;  // ../../RTL/CPU/prv464_top.v(165)
  wire ex_jmp;  // ../../RTL/CPU/prv464_top.v(161)
  wire ex_m_ret;  // ../../RTL/CPU/prv464_top.v(168)
  wire ex_more_exception;  // ../../RTL/CPU/prv464_top.v(576)
  wire ex_nop;  // ../../RTL/CPU/prv464_top.v(580)
  wire ex_ready;  // ../../RTL/CPU/prv464_top.v(577)
  wire ex_s_ret;  // ../../RTL/CPU/prv464_top.v(169)
  wire ex_system;  // ../../RTL/CPU/prv464_top.v(160)
  wire ex_valid;  // ../../RTL/CPU/prv464_top.v(166)
  wire id_branch;  // ../../RTL/CPU/prv464_top.v(174)
  wire id_hold;  // ../../RTL/CPU/prv464_top.v(177)
  wire id_ill_ins;  // ../../RTL/CPU/prv464_top.v(176)
  wire id_ins_acc_fault;  // ../../RTL/CPU/prv464_top.v(92)
  wire id_ins_addr_mis;  // ../../RTL/CPU/prv464_top.v(93)
  wire id_ins_page_fault;  // ../../RTL/CPU/prv464_top.v(94)
  wire id_int_acc;  // ../../RTL/CPU/prv464_top.v(95)
  wire id_nop;  // ../../RTL/CPU/prv464_top.v(178)
  wire id_system;  // ../../RTL/CPU/prv464_top.v(175)
  wire id_valid;  // ../../RTL/CPU/prv464_top.v(96)
  wire if_hold;  // ../../RTL/CPU/prv464_top.v(263)
  wire if_nop;  // ../../RTL/CPU/prv464_top.v(262)
  wire ins_acc_fault;  // ../../RTL/CPU/prv464_top.v(68)
  wire ins_page_fault;  // ../../RTL/CPU/prv464_top.v(69)
  wire int_req;  // ../../RTL/CPU/prv464_top.v(259)
  wire jmp;  // ../../RTL/CPU/prv464_top.v(127)
  wire load;  // ../../RTL/CPU/prv464_top.v(136)
  wire load_acc_fault;  // ../../RTL/CPU/prv464_top.v(83)
  wire load_page_fault;  // ../../RTL/CPU/prv464_top.v(84)
  wire mem_csr_data_add;  // ../../RTL/CPU/prv464_top.v(116)
  wire mem_csr_data_and;  // ../../RTL/CPU/prv464_top.v(117)
  wire mem_csr_data_ds1;  // ../../RTL/CPU/prv464_top.v(114)
  wire mem_csr_data_ds2;  // ../../RTL/CPU/prv464_top.v(115)
  wire mem_csr_data_max;  // ../../RTL/CPU/prv464_top.v(120)
  wire mem_csr_data_min;  // ../../RTL/CPU/prv464_top.v(121)
  wire mem_csr_data_or;  // ../../RTL/CPU/prv464_top.v(118)
  wire mem_csr_data_xor;  // ../../RTL/CPU/prv464_top.v(119)
  wire mprv;  // ../../RTL/CPU/prv464_top.v(53)
  wire mxr;  // ../../RTL/CPU/prv464_top.v(52)
  wire pc_jmp;  // ../../RTL/CPU/prv464_top.v(522)
  wire pip_flush;  // ../../RTL/CPU/prv464_top.v(265)
  wire rd_data_add;  // ../../RTL/CPU/prv464_top.v(104)
  wire rd_data_and;  // ../../RTL/CPU/prv464_top.v(106)
  wire rd_data_ds1;  // ../../RTL/CPU/prv464_top.v(103)
  wire rd_data_or;  // ../../RTL/CPU/prv464_top.v(107)
  wire rd_data_slt;  // ../../RTL/CPU/prv464_top.v(109)
  wire rd_data_sub;  // ../../RTL/CPU/prv464_top.v(105)
  wire rd_data_xor;  // ../../RTL/CPU/prv464_top.v(108)
  wire rd_ins;  // ../../RTL/CPU/prv464_top.v(66)
  wire read;  // ../../RTL/CPU/prv464_top.v(81)
  wire shift_l;  // ../../RTL/CPU/prv464_top.v(142)
  wire shift_r;  // ../../RTL/CPU/prv464_top.v(141)
  wire store;  // ../../RTL/CPU/prv464_top.v(137)
  wire store_acc_fault;  // ../../RTL/CPU/prv464_top.v(85)
  wire store_page_fault;  // ../../RTL/CPU/prv464_top.v(86)
  wire sum;  // ../../RTL/CPU/prv464_top.v(51)
  wire tsr;  // ../../RTL/CPU/prv464_top.v(50)
  wire tvm;  // ../../RTL/CPU/prv464_top.v(49)
  wire tw;  // ../../RTL/CPU/prv464_top.v(309)
  wire uncache_data_rdy;  // ../../RTL/CPU/prv464_top.v(88)
  wire unpage;  // ../../RTL/CPU/prv464_top.v(72)
  wire unsign;  // ../../RTL/CPU/prv464_top.v(128)
  wire wb_csr_write;  // ../../RTL/CPU/prv464_top.v(520)
  wire wb_ebreak;  // ../../RTL/CPU/prv464_top.v(547)
  wire wb_ecall;  // ../../RTL/CPU/prv464_top.v(546)
  wire wb_gpr_write;  // ../../RTL/CPU/prv464_top.v(521)
  wire wb_ill_ins;  // ../../RTL/CPU/prv464_top.v(543)
  wire wb_ins_acc_fault;  // ../../RTL/CPU/prv464_top.v(532)
  wire wb_ins_addr_mis;  // ../../RTL/CPU/prv464_top.v(533)
  wire wb_ins_page_fault;  // ../../RTL/CPU/prv464_top.v(534)
  wire wb_int_acc;  // ../../RTL/CPU/prv464_top.v(541)
  wire wb_jmp;  // ../../RTL/CPU/prv464_top.v(531)
  wire wb_ld_acc_fault;  // ../../RTL/CPU/prv464_top.v(537)
  wire wb_ld_addr_mis;  // ../../RTL/CPU/prv464_top.v(535)
  wire wb_ld_page_fault;  // ../../RTL/CPU/prv464_top.v(539)
  wire wb_m_ret;  // ../../RTL/CPU/prv464_top.v(544)
  wire wb_s_ret;  // ../../RTL/CPU/prv464_top.v(545)
  wire wb_st_acc_fault;  // ../../RTL/CPU/prv464_top.v(538)
  wire wb_st_addr_mis;  // ../../RTL/CPU/prv464_top.v(536)
  wire wb_st_page_fault;  // ../../RTL/CPU/prv464_top.v(540)
  wire wb_system;  // ../../RTL/CPU/prv464_top.v(530)
  wire wb_valid;  // ../../RTL/CPU/prv464_top.v(542)
  wire write;  // ../../RTL/CPU/prv464_top.v(82)

  biu biu (
    .addr_ex(addr_ex),
    .addr_if(addr_if),
    .cache_flush(cache_flush_biu),
    .cache_reset(cache_reset_biu),
    .cacheability_block(cacheability_block),
    .clk(clk),
    .data_write(data_write),
    .ex_priv(ex_priv),
    .hrdata(hrdata),
    .hready(hready),
    .hresp(hresp),
    .if_priv(if_priv),
    .mxr(mxr),
    .rd_ins(rd_ins),
    .read(read),
    .rst(rst),
    .satp(satp),
    .size(size),
    .sum(sum),
    .unpage(unpage),
    .write(write),
    .cache_ready_ex(cache_ready_ex),
    .cache_ready_if(cache_ready_if),
    .data_read(data_read),
    .data_uncache(uncache_data),
    .haddr(haddr),
    .hburst(hburst),
    .hmastlock(hmastlock),
    .hprot(hprot),
    .hsize(hsize),
    .htrans(htrans),
    .hwdata(hwdata),
    .hwrite(hwrite),
    .ins_acc_fault(ins_acc_fault),
    .ins_page_fault(ins_page_fault),
    .ins_read(ins_read),
    .load_acc_fault(load_acc_fault),
    .load_page_fault(load_page_fault),
    .store_acc_fault(store_acc_fault),
    .store_page_fault(store_page_fault),
    .uncache_data_rdy(uncache_data_rdy));  // ../../RTL/CPU/prv464_top.v(191)
  cu_ru cu_ru (
    .clk(clk),
    .csr_index(csr_index),
    .csr_write(wb_csr_write),
    .data_csr(data_csr),
    .data_rd(data_rd),
    .ebreak(wb_ebreak),
    .ecall(wb_ecall),
    .exc_code(wb_exc_code),
    .gpr_write(wb_gpr_write),
    .id_csr_index(id_csr_index),
    .id_jmp(wb_jmp),
    .id_system(wb_system),
    .ill_ins(wb_ill_ins),
    .ins_acc_fault(wb_ins_acc_fault),
    .ins_addr_mis(wb_ins_addr_mis),
    .ins_page_fault(wb_ins_page_fault),
    .ins_pc(wb_ins_pc),
    .int_acc(wb_int_acc),
    .ld_acc_fault(wb_ld_acc_fault),
    .ld_addr_mis(wb_ld_addr_mis),
    .ld_page_fault(wb_ld_page_fault),
    .m_ext_int(m_ext_int),
    .m_ret(wb_m_ret),
    .m_soft_int(m_soft_int),
    .m_time_int(m_time_int),
    .mtime(mtime),
    .new_pc(new_pc),
    .pc_jmp(pc_jmp),
    .rd_index(wb_rd_index),
    .rs1_index(id_rs1_index),
    .rs2_index(id_rs2_index),
    .rst(rst),
    .s_ext_int(s_ext_int),
    .s_ret(wb_s_ret),
    .st_acc_fault(wb_st_acc_fault),
    .st_addr_mis(wb_st_addr_mis),
    .st_page_fault(wb_st_page_fault),
    .valid(wb_valid),
    .csr_data(csr_data),
    .flush_pc(flush_pc),
    .int_req(int_req),
    .mod_priv(mod_priv),
    .mprv(mprv),
    .mxr(mxr),
    .pip_flush(pip_flush),
    .priv(priv),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data),
    .satp(satp),
    .sum(sum),
    .tsr(tsr),
    .tvm(tvm),
    .tw(tw));  // ../../RTL/CPU/prv464_top.v(584)
  exu exu (
    .amo(amo),
    .amo_lr_sc(amo_lr_sc),
    .and_clr(and_clr),
    .as1(as1),
    .as2(as2),
    .beq(beq),
    .bge(bge),
    .blt(blt),
    .bne(bne),
    .cache_flush(cache_flush),
    .cache_ready_ex(cache_ready_ex),
    .cache_reset(cache_reset),
    .clk(clk),
    .compare(compare),
    .csr_index_id(ex_csr_index),
    .csr_write_id(ex_csr_write),
    .data_read(data_read),
    .ds1(ds1),
    .ds1_sel(ds1_sel),
    .ds2(ds2),
    .ebreak_id(ex_ebreak),
    .ecall_id(ex_ecall),
    .ex_hold(ex_hold),
    .ex_nop(ex_nop),
    .exc_code_id(ex_exc_code),
    .gpr_write_id(ex_gpr_write),
    .id_jmp_id(ex_jmp),
    .id_system_id(ex_system),
    .ill_ins_id(ex_ill_ins),
    .ins_acc_fault_id(ex_ins_acc_fault),
    .ins_addr_mis_id(ex_ins_addr_mis),
    .ins_page_fault_id(ex_ins_page_fault),
    .ins_pc_id(ex_ins_pc),
    .int_acc_id(ex_int_acc),
    .jmp(jmp),
    .load(load),
    .load_acc_fault(load_acc_fault),
    .load_page_fault(load_page_fault),
    .m_ret_id(ex_m_ret),
    .mem_csr_data_add(mem_csr_data_add),
    .mem_csr_data_and(mem_csr_data_and),
    .mem_csr_data_ds1(mem_csr_data_ds1),
    .mem_csr_data_ds2(mem_csr_data_ds2),
    .mem_csr_data_max(mem_csr_data_max),
    .mem_csr_data_min(mem_csr_data_min),
    .mem_csr_data_or(mem_csr_data_or),
    .mem_csr_data_xor(mem_csr_data_xor),
    .mod_priv(mod_priv),
    .mprv(mprv),
    .op_count(op_count),
    .priv(priv),
    .rd_data_add(rd_data_add),
    .rd_data_and(rd_data_and),
    .rd_data_ds1(rd_data_ds1),
    .rd_data_or(rd_data_or),
    .rd_data_slt(rd_data_slt),
    .rd_data_sub(rd_data_sub),
    .rd_data_xor(rd_data_xor),
    .rd_index_id(ex_rd_index),
    .rst(rst),
    .s_ret_id(ex_s_ret),
    .shift_l(shift_l),
    .shift_r(shift_r),
    .size(ex_size),
    .store(store),
    .store_acc_fault(store_acc_fault),
    .store_page_fault(store_page_fault),
    .uncache_data(uncache_data),
    .uncache_data_ready(uncache_data_rdy),
    .unsign(unsign),
    .valid_id(ex_valid),
    .addr_ex(addr_ex),
    .cache_flush_biu(cache_flush_biu),
    .cache_reset_biu(cache_reset_biu),
    .csr_index(csr_index),
    .csr_write(wb_csr_write),
    .data_csr(data_csr),
    .data_rd(data_rd),
    .data_write(data_write),
    .ebreak(wb_ebreak),
    .ecall(wb_ecall),
    .ex_exception(ex_more_exception),
    .ex_priv(ex_priv),
    .ex_ready(ex_ready),
    .exc_code(wb_exc_code),
    .gpr_write(wb_gpr_write),
    .id_jmp(wb_jmp),
    .id_system(wb_system),
    .ill_ins(wb_ill_ins),
    .ins_acc_fault(wb_ins_acc_fault),
    .ins_addr_mis(wb_ins_addr_mis),
    .ins_page_fault(wb_ins_page_fault),
    .ins_pc(wb_ins_pc),
    .int_acc(wb_int_acc),
    .ld_acc_fault(wb_ld_acc_fault),
    .ld_addr_mis(wb_ld_addr_mis),
    .ld_page_fault(wb_ld_page_fault),
    .m_ret(wb_m_ret),
    .new_pc(new_pc),
    .pc_jmp(pc_jmp),
    .rd_index(wb_rd_index),
    .read(read),
    .s_ret(wb_s_ret),
    .size_biu(size),
    .st_acc_fault(wb_st_acc_fault),
    .st_addr_mis(wb_st_addr_mis),
    .st_page_fault(wb_st_page_fault),
    .unpage(unpage),
    .valid(wb_valid),
    .write(write));  // ../../RTL/CPU/prv464_top.v(426)
  ins_dec ins_dec (
    .clk(clk),
    .csr_data(csr_data),
    .id_hold(id_hold),
    .id_nop(id_nop),
    .ins_acc_fault_if(id_ins_acc_fault),
    .ins_addr_mis_if(id_ins_addr_mis),
    .ins_in(id_ins),
    .ins_page_fault_if(id_ins_page_fault),
    .ins_pc(id_ins_pc),
    .int_acc_if(id_int_acc),
    .priv(priv),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data),
    .rst(rst),
    .tsr(tsr),
    .tvm(tvm),
    .tw(tw),
    .valid_if(id_valid),
    .amo(amo),
    .amo_lr_sc(amo_lr_sc),
    .and_clr(and_clr),
    .as1(as1),
    .as2(as2),
    .beq(beq),
    .bge(bge),
    .blt(blt),
    .bne(bne),
    .cache_flush(cache_flush),
    .cache_reset(cache_reset),
    .compare(compare),
    .csr_index(ex_csr_index),
    .csr_write(ex_csr_write),
    .dec_branch(id_branch),
    .dec_csr_index(id_csr_index),
    .dec_ill_ins(id_ill_ins),
    .dec_rs1_index(id_rs1_index),
    .dec_rs2_index(id_rs2_index),
    .dec_system_mem(id_system),
    .ds1(ds1),
    .ds1_sel(ds1_sel),
    .ds2(ds2),
    .ebreak(ex_ebreak),
    .ecall(ex_ecall),
    .exc_code(ex_exc_code),
    .gpr_write(ex_gpr_write),
    .id_jmp(ex_jmp),
    .id_system(ex_system),
    .ill_ins(ex_ill_ins),
    .ins_acc_fault(ex_ins_acc_fault),
    .ins_addr_mis(ex_ins_addr_mis),
    .ins_page_fault(ex_ins_page_fault),
    .ins_pc_id(ex_ins_pc),
    .int_acc(ex_int_acc),
    .jmp(jmp),
    .load(load),
    .m_ret(ex_m_ret),
    .mem_csr_data_add(mem_csr_data_add),
    .mem_csr_data_and(mem_csr_data_and),
    .mem_csr_data_ds1(mem_csr_data_ds1),
    .mem_csr_data_ds2(mem_csr_data_ds2),
    .mem_csr_data_max(mem_csr_data_max),
    .mem_csr_data_min(mem_csr_data_min),
    .mem_csr_data_or(mem_csr_data_or),
    .mem_csr_data_xor(mem_csr_data_xor),
    .op_count(op_count),
    .rd_data_add(rd_data_add),
    .rd_data_and(rd_data_and),
    .rd_data_ds1(rd_data_ds1),
    .rd_data_or(rd_data_or),
    .rd_data_slt(rd_data_slt),
    .rd_data_sub(rd_data_sub),
    .rd_data_xor(rd_data_xor),
    .rd_index(ex_rd_index),
    .s_ret(ex_s_ret),
    .shift_l(shift_l),
    .shift_r(shift_r),
    .size(ex_size),
    .store(store),
    .unsign(unsign),
    .valid(ex_valid));  // ../../RTL/CPU/prv464_top.v(300)
  ins_fetch ins_fetch (
    .cache_ready(cache_ready_if),
    .clk(clk),
    .if_hold(if_hold),
    .ins_acc_fault_biu(ins_acc_fault),
    .ins_in(ins_read),
    .ins_page_fault_biu(ins_page_fault),
    .int_req(int_req),
    .new_pc(flush_pc),
    .nop_if(if_nop),
    .pip_flush(pip_flush),
    .priv(priv),
    .rst(rst),
    .addr(addr_if),
    .if_priv(if_priv),
    .ins_acc_fault(id_ins_acc_fault),
    .ins_addr_mis(id_ins_addr_mis),
    .ins_out(id_ins),
    .ins_page_fault(id_ins_page_fault),
    .ins_pc(id_ins_pc),
    .int_acc(id_int_acc),
    .rd(rd_ins),
    .valid(id_valid));  // ../../RTL/CPU/prv464_top.v(252)
  pip_ctrl pip_ctrl (
    .ex_ebreak(ex_ebreak),
    .ex_ecall(ex_ecall),
    .ex_gpr_write(ex_gpr_write),
    .ex_ill_ins(ex_ill_ins),
    .ex_ins_acc_fault(ex_ins_acc_fault),
    .ex_ins_addr_mis(ex_ins_addr_mis),
    .ex_ins_page_fault(ex_ins_page_fault),
    .ex_int_acc(ex_int_acc),
    .ex_jmp(ex_jmp),
    .ex_m_ret(ex_m_ret),
    .ex_more_exception(ex_more_exception),
    .ex_rd_index(ex_rd_index),
    .ex_ready(ex_ready),
    .ex_s_ret(ex_s_ret),
    .ex_system(ex_system),
    .ex_valid(ex_valid),
    .id_branch(id_branch),
    .id_ill_ins(id_ill_ins),
    .id_ins_acc_fault(id_ins_acc_fault),
    .id_ins_addr_mis(id_ins_addr_mis),
    .id_ins_page_fault(id_ins_page_fault),
    .id_int_acc(id_int_acc),
    .id_rs1_index(id_rs1_index),
    .id_rs2_index(id_rs2_index),
    .id_system_mem(id_system),
    .id_valid(id_valid),
    .wb_ebreak(wb_ebreak),
    .wb_ecall(wb_ecall),
    .wb_gpr_write(wb_gpr_write),
    .wb_id_jmp(wb_jmp),
    .wb_id_system(wb_system),
    .wb_ill_ins(wb_ill_ins),
    .wb_ins_acc_fault(wb_ins_acc_fault),
    .wb_ins_addr_mis(wb_ins_addr_mis),
    .wb_ins_page_fault(wb_ins_page_fault),
    .wb_int_acc(wb_int_acc),
    .wb_ld_acc_fault(wb_ld_acc_fault),
    .wb_ld_addr_mis(wb_ld_addr_mis),
    .wb_ld_page_fault(wb_ld_page_fault),
    .wb_m_ret(wb_m_ret),
    .wb_rd_index(wb_rd_index),
    .wb_s_ret(wb_s_ret),
    .wb_st_acc_fault(wb_st_acc_fault),
    .wb_st_addr_mis(wb_st_addr_mis),
    .wb_st_page_fault(wb_st_page_fault),
    .wb_valid(wb_valid),
    .ex_hold(ex_hold),
    .ex_nop(ex_nop),
    .id_hold(id_hold),
    .id_nop(id_nop),
    .if_hold(if_hold),
    .if_nop(if_nop));  // ../../RTL/CPU/prv464_top.v(665)

endmodule 

module biu  // ../../RTL/CPU/BIU/biu.v(7)
  (
  addr_ex,
  addr_if,
  cache_flush,
  cache_reset,
  cacheability_block,
  clk,
  data_write,
  ex_priv,
  hrdata,
  hready,
  hreset_n,
  hresp,
  if_priv,
  mxr,
  rd_ins,
  read,
  rst,
  satp,
  size,
  sum,
  unpage,
  write,
  cache_ready_ex,
  cache_ready_if,
  data_read,
  data_uncache,
  haddr,
  hburst,
  hmastlock,
  hprot,
  hsize,
  htrans,
  hwdata,
  hwrite,
  ins_acc_fault,
  ins_page_fault,
  ins_read,
  load_acc_fault,
  load_page_fault,
  store_acc_fault,
  store_page_fault,
  uncache_data_rdy
  );

  input [63:0] addr_ex;  // ../../RTL/CPU/BIU/biu.v(44)
  input [63:0] addr_if;  // ../../RTL/CPU/BIU/biu.v(32)
  input cache_flush;  // ../../RTL/CPU/BIU/biu.v(49)
  input cache_reset;  // ../../RTL/CPU/BIU/biu.v(50)
  input [31:0] cacheability_block;  // ../../RTL/CPU/BIU/biu.v(20)
  input clk;  // ../../RTL/CPU/BIU/biu.v(9)
  input [63:0] data_write;  // ../../RTL/CPU/BIU/biu.v(45)
  input [3:0] ex_priv;  // ../../RTL/CPU/BIU/biu.v(43)
  input [63:0] hrdata;  // ../../RTL/CPU/BIU/biu.v(74)
  input hready;  // ../../RTL/CPU/BIU/biu.v(71)
  input hreset_n;  // ../../RTL/CPU/BIU/biu.v(73)
  input hresp;  // ../../RTL/CPU/BIU/biu.v(72)
  input [3:0] if_priv;  // ../../RTL/CPU/BIU/biu.v(31)
  input mxr;  // ../../RTL/CPU/BIU/biu.v(25)
  input rd_ins;  // ../../RTL/CPU/BIU/biu.v(33)
  input read;  // ../../RTL/CPU/BIU/biu.v(51)
  input rst;  // ../../RTL/CPU/BIU/biu.v(10)
  input [63:0] satp;  // ../../RTL/CPU/BIU/biu.v(23)
  input [3:0] size;  // ../../RTL/CPU/BIU/biu.v(48)
  input sum;  // ../../RTL/CPU/BIU/biu.v(24)
  input unpage;  // ../../RTL/CPU/BIU/biu.v(42)
  input write;  // ../../RTL/CPU/BIU/biu.v(52)
  output cache_ready_ex;  // ../../RTL/CPU/BIU/biu.v(58)
  output cache_ready_if;  // ../../RTL/CPU/BIU/biu.v(38)
  output [63:0] data_read;  // ../../RTL/CPU/BIU/biu.v(46)
  output [63:0] data_uncache;  // ../../RTL/CPU/BIU/biu.v(47)
  output [63:0] haddr;  // ../../RTL/CPU/BIU/biu.v(62)
  output [2:0] hburst;  // ../../RTL/CPU/BIU/biu.v(65)
  output hmastlock;  // ../../RTL/CPU/BIU/biu.v(68)
  output [3:0] hprot;  // ../../RTL/CPU/BIU/biu.v(66)
  output [2:0] hsize;  // ../../RTL/CPU/BIU/biu.v(64)
  output [1:0] htrans;  // ../../RTL/CPU/BIU/biu.v(67)
  output [63:0] hwdata;  // ../../RTL/CPU/BIU/biu.v(69)
  output hwrite;  // ../../RTL/CPU/BIU/biu.v(63)
  output ins_acc_fault;  // ../../RTL/CPU/BIU/biu.v(36)
  output ins_page_fault;  // ../../RTL/CPU/BIU/biu.v(37)
  output [63:0] ins_read;  // ../../RTL/CPU/BIU/biu.v(34)
  output load_acc_fault;  // ../../RTL/CPU/BIU/biu.v(54)
  output load_page_fault;  // ../../RTL/CPU/BIU/biu.v(55)
  output store_acc_fault;  // ../../RTL/CPU/BIU/biu.v(56)
  output store_page_fault;  // ../../RTL/CPU/BIU/biu.v(57)
  output uncache_data_rdy;  // ../../RTL/CPU/BIU/biu.v(59)

  wire [8:0] cache_addr;  // ../../RTL/CPU/BIU/biu.v(87)
  wire [8:0] cache_counter;  // ../../RTL/CPU/BIU/biu.v(127)
  wire [63:0] cache_data;  // ../../RTL/CPU/BIU/biu.v(86)
  wire [1:0] ex_data_sel;  // ../../RTL/CPU/BIU/biu.v(81)
  wire [8:0] l1d_addr;  // ../../RTL/CPU/BIU/biu.v(96)
  wire [7:0] l1d_bsel;  // ../../RTL/CPU/BIU/biu.v(85)
  wire [63:0] l1d_out;  // ../../RTL/CPU/BIU/biu.v(92)
  wire [8:0] l1i_addr;  // ../../RTL/CPU/BIU/biu.v(95)
  wire [7:0] l1i_bsel;  // ../../RTL/CPU/BIU/biu.v(84)
  wire [63:0] l1i_in;  // ../../RTL/CPU/BIU/biu.v(91)
  wire [63:0] l1i_out;  // ../../RTL/CPU/BIU/biu.v(90)
  wire [63:0] maddress;  // ../../RTL/CPU/BIU/biu.v(119)
  wire [8:0] n0;
  wire [63:0] n1;
  wire [1:0] opc;  // ../../RTL/CPU/BIU/biu.v(109)
  wire [127:0] paddress;  // ../../RTL/CPU/BIU/biu.v(120)
  wire [3:0] priv;  // ../../RTL/CPU/BIU/biu.v(110)
  wire [63:0] read_data;  // ../../RTL/CPU/BIU/biu.v(123)
  wire [3:0] trans_size;  // ../../RTL/CPU/BIU/biu.v(103)
  wire [63:0] write_data;  // ../../RTL/CPU/BIU/biu.v(125)
  wire bus_error;  // ../../RTL/CPU/BIU/biu.v(117)
  wire cache_addr_sel;  // ../../RTL/CPU/BIU/biu.v(79)
  wire cache_rdy;  // ../../RTL/CPU/BIU/biu.v(106)
  wire cache_write;  // ../../RTL/CPU/BIU/biu.v(115)
  wire cacheable;  // ../../RTL/CPU/BIU/biu.v(113)
  wire l1d_write;  // ../../RTL/CPU/BIU/biu.v(82)
  wire l1i_write;  // ../../RTL/CPU/BIU/biu.v(83)
  wire new_pte_update;  // ../../RTL/CPU/BIU/biu.v(107)
  wire pa_cov;  // ../../RTL/CPU/BIU/biu.v(102)
  wire paddr;  // ../../RTL/CPU/BIU/biu.v(99)
  wire page_fault;  // ../../RTL/CPU/BIU/biu.v(116)
  wire rd;  // ../../RTL/CPU/BIU/biu.v(101)
  wire trans_rdy;  // ../../RTL/CPU/BIU/biu.v(114)
  wire wr;  // ../../RTL/CPU/BIU/biu.v(100)

  bus_unit bus_unit (
    .cache_rdy(cache_rdy),
    .cacheability_block(cacheability_block),
    .clk(clk),
    .hrdata(hrdata),
    .hready(hready),
    .hreset_n(hreset_n),
    .hresp(hresp),
    .maddress(maddress),
    .mxr(mxr),
    .new_pte_update(new_pte_update),
    .opc(opc),
    .pa_cov(pa_cov),
    .paddr(paddr),
    .priv(priv),
    .rd(rd),
    .rst(rst),
    .satp(satp),
    .sum(sum),
    .trans_size(trans_size),
    .wr(wr),
    .write_data(write_data),
    .bus_error(bus_error),
    .cache_counter(cache_counter),
    .cache_write(cache_write),
    .cacheable(cacheable),
    .haddr(haddr),
    .hburst(hburst),
    .hprot(hprot),
    .hsize(hsize),
    .htrans(htrans),
    .hwdata(hwdata),
    .hwrite(hwrite),
    .paddress(paddress),
    .page_fault(page_fault),
    .read_data(read_data),
    .trans_rdy(trans_rdy));  // ../../RTL/CPU/BIU/biu.v(236)
  cache cache (
    .clk(clk),
    .l1d_addr(l1d_addr),
    .l1d_bsel(l1d_bsel),
    .l1d_in(l1i_in),
    .l1d_write(l1d_write),
    .l1i_addr(l1i_addr),
    .l1i_bsel(l1i_bsel),
    .l1i_in(l1i_in),
    .l1i_write(l1i_write),
    .rst(rst),
    .l1d_out(l1d_out),
    .l1i_out(l1i_out));  // ../../RTL/CPU/BIU/biu.v(304)
  cache_ctrl_logic cache_ctrl_logic (
    .addr_ex(addr_ex),
    .addr_if(addr_if),
    .bus_error(bus_error),
    .cache_counter(cache_counter),
    .cache_flush(cache_flush),
    .cache_reset(cache_reset),
    .cache_write(cache_write),
    .cacheable(cacheable),
    .clk(clk),
    .data_write(data_write),
    .ex_priv(ex_priv),
    .if_priv(if_priv),
    .l1d_data(l1d_out),
    .l1i_data(l1i_out),
    .lock(1'bx),
    .mxr(mxr),
    .paddress(paddress),
    .page_fault(page_fault),
    .rd_ins(rd_ins),
    .read(read),
    .read_data(read_data),
    .rst(rst),
    .satp(satp),
    .size(size),
    .sum(sum),
    .trans_rdy(trans_rdy),
    .unpage(unpage),
    .write(write),
    .cache_addr(cache_addr),
    .cache_addr_sel(cache_addr_sel),
    .cache_data(cache_data),
    .cache_rdy(cache_rdy),
    .cache_ready_ex(cache_ready_ex),
    .cache_ready_if(cache_ready_if),
    .data_uncache(data_uncache),
    .ex_data_sel(ex_data_sel),
    .ins_acc_fault(ins_acc_fault),
    .ins_page_fault(ins_page_fault),
    .l1d_bsel(l1d_bsel),
    .l1d_wr(l1d_write),
    .l1i_bsel(l1i_bsel),
    .l1i_wr(l1i_write),
    .load_acc_fault(load_acc_fault),
    .load_page_fault(load_page_fault),
    .maddress(maddress),
    .new_pte_update(new_pte_update),
    .opc(opc),
    .pa_cov(pa_cov),
    .paddr(paddr),
    .priv(priv),
    .rd(rd),
    .store_acc_fault(store_acc_fault),
    .store_page_fault(store_page_fault),
    .trans_size(trans_size),
    .uncache_data_rdy(uncache_data_rdy),
    .wr(wr),
    .write_data(write_data));  // ../../RTL/CPU/BIU/biu.v(144)
  binary_mux_s1_w9 mux0 (
    .i0(addr_if[11:3]),
    .i1(addr_ex[11:3]),
    .sel(ex_data_sel[0]),
    .o(n0));  // ../../RTL/CPU/BIU/biu.v(131)
  binary_mux_s1_w9 mux1 (
    .i0(n0),
    .i1(cache_addr),
    .sel(cache_addr_sel),
    .o(l1i_addr));  // ../../RTL/CPU/BIU/biu.v(131)
  binary_mux_s1_w12 mux2 (
    .i0(addr_ex[11:0]),
    .i1({3'b000,cache_addr}),
    .sel(cache_addr_sel),
    .o({open_n1,open_n2,open_n3,l1d_addr}));  // ../../RTL/CPU/BIU/biu.v(133)
  binary_mux_s1_w64 mux3 (
    .i0(data_write),
    .i1(cache_data),
    .sel(cache_addr_sel),
    .o(l1i_in));  // ../../RTL/CPU/BIU/biu.v(135)
  binary_mux_s1_w64 mux4 (
    .i0(l1d_out),
    .i1(l1i_out),
    .sel(ex_data_sel[0]),
    .o(n1));  // ../../RTL/CPU/BIU/biu.v(139)
  binary_mux_s1_w64 mux5 (
    .i0(n1),
    .i1(cache_data),
    .sel(ex_data_sel[1]),
    .o(data_read));  // ../../RTL/CPU/BIU/biu.v(139)
  buf u1 (ins_read[3], l1i_out[3]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u10 (ins_read[9], l1i_out[9]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u11 (ins_read[10], l1i_out[10]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u12 (ins_read[11], l1i_out[11]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u13 (ins_read[12], l1i_out[12]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u14 (ins_read[13], l1i_out[13]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u15 (ins_read[14], l1i_out[14]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u16 (ins_read[15], l1i_out[15]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u17 (ins_read[16], l1i_out[16]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u18 (ins_read[17], l1i_out[17]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u19 (ins_read[18], l1i_out[18]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u2 (ins_read[2], l1i_out[2]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u20 (ins_read[19], l1i_out[19]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u21 (ins_read[20], l1i_out[20]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u22 (ins_read[21], l1i_out[21]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u23 (ins_read[22], l1i_out[22]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u24 (ins_read[23], l1i_out[23]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u25 (ins_read[24], l1i_out[24]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u26 (ins_read[25], l1i_out[25]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u27 (ins_read[26], l1i_out[26]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u28 (ins_read[27], l1i_out[27]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u29 (ins_read[28], l1i_out[28]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u3 (ins_read[1], l1i_out[1]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u30 (ins_read[29], l1i_out[29]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u31 (ins_read[30], l1i_out[30]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u32 (ins_read[31], l1i_out[31]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u33 (ins_read[32], l1i_out[32]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u34 (ins_read[33], l1i_out[33]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u35 (ins_read[34], l1i_out[34]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u36 (ins_read[35], l1i_out[35]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u37 (ins_read[36], l1i_out[36]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u38 (ins_read[37], l1i_out[37]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u39 (ins_read[38], l1i_out[38]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u4 (ins_read[0], l1i_out[0]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u40 (ins_read[39], l1i_out[39]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u41 (ins_read[40], l1i_out[40]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u42 (ins_read[41], l1i_out[41]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u43 (ins_read[42], l1i_out[42]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u44 (ins_read[43], l1i_out[43]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u45 (ins_read[44], l1i_out[44]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u46 (ins_read[45], l1i_out[45]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u47 (ins_read[46], l1i_out[46]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u48 (ins_read[47], l1i_out[47]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u49 (ins_read[48], l1i_out[48]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u5 (ins_read[4], l1i_out[4]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u50 (ins_read[49], l1i_out[49]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u51 (ins_read[50], l1i_out[50]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u52 (ins_read[51], l1i_out[51]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u53 (ins_read[52], l1i_out[52]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u54 (ins_read[53], l1i_out[53]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u55 (ins_read[54], l1i_out[54]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u56 (ins_read[55], l1i_out[55]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u57 (ins_read[56], l1i_out[56]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u58 (ins_read[57], l1i_out[57]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u59 (ins_read[58], l1i_out[58]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u6 (ins_read[5], l1i_out[5]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u60 (ins_read[59], l1i_out[59]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u61 (ins_read[60], l1i_out[60]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u62 (ins_read[61], l1i_out[61]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u63 (ins_read[62], l1i_out[62]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u64 (ins_read[63], l1i_out[63]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u7 (ins_read[6], l1i_out[6]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u8 (ins_read[7], l1i_out[7]);  // ../../RTL/CPU/BIU/biu.v(141)
  buf u9 (ins_read[8], l1i_out[8]);  // ../../RTL/CPU/BIU/biu.v(141)

endmodule 

module cu_ru  // ../../RTL/CPU/CU&RU/cu_ru.v(7)
  (
  clk,
  csr_index,
  csr_write,
  data_csr,
  data_rd,
  ebreak,
  ecall,
  exc_code,
  gpr_write,
  id_csr_index,
  id_jmp,
  id_system,
  ill_ins,
  ins_acc_fault,
  ins_addr_mis,
  ins_page_fault,
  ins_pc,
  int_acc,
  ld_acc_fault,
  ld_addr_mis,
  ld_page_fault,
  m_ext_int,
  m_ret,
  m_soft_int,
  m_time_int,
  mtime,
  new_pc,
  pc_jmp,
  rd_index,
  rs1_index,
  rs2_index,
  rst,
  s_ext_int,
  s_ret,
  st_acc_fault,
  st_addr_mis,
  st_page_fault,
  valid,
  csr_data,
  flush_pc,
  int_req,
  mod_priv,
  mprv,
  mxr,
  pip_flush,
  priv,
  rs1_data,
  rs2_data,
  satp,
  sum,
  tsr,
  tvm,
  tw
  );

  input clk;  // ../../RTL/CPU/CU&RU/cu_ru.v(8)
  input [11:0] csr_index;  // ../../RTL/CPU/CU&RU/cu_ru.v(53)
  input csr_write;  // ../../RTL/CPU/CU&RU/cu_ru.v(50)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/cu_ru.v(42)
  input [63:0] data_rd;  // ../../RTL/CPU/CU&RU/cu_ru.v(41)
  input ebreak;  // ../../RTL/CPU/CU&RU/cu_ru.v(77)
  input ecall;  // ../../RTL/CPU/CU&RU/cu_ru.v(76)
  input [63:0] exc_code;  // ../../RTL/CPU/CU&RU/cu_ru.v(57)
  input gpr_write;  // ../../RTL/CPU/CU&RU/cu_ru.v(51)
  input [11:0] id_csr_index;  // ../../RTL/CPU/CU&RU/cu_ru.v(30)
  input id_jmp;  // ../../RTL/CPU/CU&RU/cu_ru.v(61)
  input id_system;  // ../../RTL/CPU/CU&RU/cu_ru.v(60)
  input ill_ins;  // ../../RTL/CPU/CU&RU/cu_ru.v(73)
  input ins_acc_fault;  // ../../RTL/CPU/CU&RU/cu_ru.v(62)
  input ins_addr_mis;  // ../../RTL/CPU/CU&RU/cu_ru.v(63)
  input ins_page_fault;  // ../../RTL/CPU/CU&RU/cu_ru.v(64)
  input [63:0] ins_pc;  // ../../RTL/CPU/CU&RU/cu_ru.v(56)
  input int_acc;  // ../../RTL/CPU/CU&RU/cu_ru.v(71)
  input ld_acc_fault;  // ../../RTL/CPU/CU&RU/cu_ru.v(67)
  input ld_addr_mis;  // ../../RTL/CPU/CU&RU/cu_ru.v(65)
  input ld_page_fault;  // ../../RTL/CPU/CU&RU/cu_ru.v(69)
  input m_ext_int;  // ../../RTL/CPU/CU&RU/cu_ru.v(14)
  input m_ret;  // ../../RTL/CPU/CU&RU/cu_ru.v(74)
  input m_soft_int;  // ../../RTL/CPU/CU&RU/cu_ru.v(13)
  input m_time_int;  // ../../RTL/CPU/CU&RU/cu_ru.v(12)
  input [63:0] mtime;  // ../../RTL/CPU/CU&RU/cu_ru.v(17)
  input [63:0] new_pc;  // ../../RTL/CPU/CU&RU/cu_ru.v(43)
  input pc_jmp;  // ../../RTL/CPU/CU&RU/cu_ru.v(52)
  input [4:0] rd_index;  // ../../RTL/CPU/CU&RU/cu_ru.v(54)
  input [4:0] rs1_index;  // ../../RTL/CPU/CU&RU/cu_ru.v(32)
  input [4:0] rs2_index;  // ../../RTL/CPU/CU&RU/cu_ru.v(34)
  input rst;  // ../../RTL/CPU/CU&RU/cu_ru.v(9)
  input s_ext_int;  // ../../RTL/CPU/CU&RU/cu_ru.v(15)
  input s_ret;  // ../../RTL/CPU/CU&RU/cu_ru.v(75)
  input st_acc_fault;  // ../../RTL/CPU/CU&RU/cu_ru.v(68)
  input st_addr_mis;  // ../../RTL/CPU/CU&RU/cu_ru.v(66)
  input st_page_fault;  // ../../RTL/CPU/CU&RU/cu_ru.v(70)
  input valid;  // ../../RTL/CPU/CU&RU/cu_ru.v(72)
  output [63:0] csr_data;  // ../../RTL/CPU/CU&RU/cu_ru.v(31)
  output [63:0] flush_pc;  // ../../RTL/CPU/CU&RU/cu_ru.v(21)
  output int_req;  // ../../RTL/CPU/CU&RU/cu_ru.v(20)
  output [3:0] mod_priv;  // ../../RTL/CPU/CU&RU/cu_ru.v(38)
  output mprv;  // ../../RTL/CPU/CU&RU/cu_ru.v(37)
  output mxr;  // ../../RTL/CPU/CU&RU/cu_ru.v(47)
  output pip_flush;  // ../../RTL/CPU/CU&RU/cu_ru.v(22)
  output [3:0] priv;  // ../../RTL/CPU/CU&RU/cu_ru.v(26)
  output [63:0] rs1_data;  // ../../RTL/CPU/CU&RU/cu_ru.v(33)
  output [63:0] rs2_data;  // ../../RTL/CPU/CU&RU/cu_ru.v(35)
  output [63:0] satp;  // ../../RTL/CPU/CU&RU/cu_ru.v(25)
  output sum;  // ../../RTL/CPU/CU&RU/cu_ru.v(46)
  output tsr;  // ../../RTL/CPU/CU&RU/cu_ru.v(28)
  output tvm;  // ../../RTL/CPU/CU&RU/cu_ru.v(27)
  output tw;  // ../../RTL/CPU/CU&RU/cu_ru.v(29)

  parameter mro_marchid_index = 12'b111100010010;
  parameter mro_mhardid_index = 12'b111100010100;
  parameter mro_mimp_index = 12'b111100010011;
  parameter mro_misa_index = 12'b001100000001;
  parameter mro_mvendorid_index = 12'b111100010001;
  parameter mrw_mcause_index = 12'b001101000010;
  parameter mrw_mcounteren_index = 12'b001100000110;
  parameter mrw_mcounterinhibit_index = 12'b001100100000;
  parameter mrw_mcycle_index = 12'b101100000000;
  parameter mrw_medeleg_index = 12'b001100000010;
  parameter mrw_mepc_index = 12'b001101000001;
  parameter mrw_mhpcounter3_index = 12'b101100000011;
  parameter mrw_mhpcounter4_index = 12'b101100000100;
  parameter mrw_mhpmevent3_index = 12'b001100100011;
  parameter mrw_mideleg_index = 12'b001100000011;
  parameter mrw_mie_index = 12'b001100000100;
  parameter mrw_minstret_index = 12'b101100000010;
  parameter mrw_mip_index = 12'b001101000100;
  parameter mrw_mscratch_index = 12'b001101000000;
  parameter mrw_mstatus_index = 12'b001100000000;
  parameter mrw_mtval_index = 12'b001101000011;
  parameter mrw_mtvec_index = 12'b001100000101;
  parameter mrw_pmpaddr0_index = 12'b001110110000;
  parameter mrw_pmpaddr1_index = 12'b001110110001;
  parameter mrw_pmpcfg0_index = 12'b001110100000;
  parameter srw_satp_index = 12'b000110000000;
  parameter srw_scause_index = 12'b000101000010;
  parameter srw_scounteren_index = 12'b000100000110;
  parameter srw_sepc_index = 12'b000101000001;
  parameter srw_sie_index = 12'b000100000100;
  parameter srw_sip_index = 12'b000101000100;
  parameter srw_sscratch_index = 12'b000101000000;
  parameter srw_sstatus_index = 12'b000100000000;
  parameter srw_stval_index = 12'b000101000011;
  parameter srw_stvec_index = 12'b000100000101;
  parameter uro_cycle_index = 12'b110000000000;
  parameter uro_hpmcounter3_index = 12'b110000000011;
  parameter uro_hpmcounter4_index = 12'b110000000100;
  parameter uro_instret_index = 12'b110000000010;
  parameter uro_time_index = 12'b110000000001;
  wire [63:0] exc_cause;  // ../../RTL/CPU/CU&RU/cu_ru.v(138)
  wire [63:0] int_cause;  // ../../RTL/CPU/CU&RU/cu_ru.v(137)
  wire [63:0] m_sie;  // ../../RTL/CPU/CU&RU/cu_ru.v(157)
  wire [63:0] m_sip;  // ../../RTL/CPU/CU&RU/cu_ru.v(158)
  wire [63:0] marchid;  // ../../RTL/CPU/CU&RU/cu_ru.v(175)
  wire [63:0] mcause;  // ../../RTL/CPU/CU&RU/cu_ru.v(161)
  wire [63:0] mcycle;  // ../../RTL/CPU/CU&RU/cu_ru.v(170)
  wire [63:0] medeleg;  // ../../RTL/CPU/CU&RU/cu_ru.v(156)
  wire [63:0] mepc;  // ../../RTL/CPU/CU&RU/cu_ru.v(163)
  wire [63:0] mhartid;  // ../../RTL/CPU/CU&RU/cu_ru.v(177)
  wire [63:0] mideleg;  // ../../RTL/CPU/CU&RU/cu_ru.v(155)
  wire [63:0] mimpid;  // ../../RTL/CPU/CU&RU/cu_ru.v(176)
  wire [63:0] minstret;  // ../../RTL/CPU/CU&RU/cu_ru.v(171)
  wire [63:0] misa;  // ../../RTL/CPU/CU&RU/cu_ru.v(179)
  wire [63:0] mscratch;  // ../../RTL/CPU/CU&RU/cu_ru.v(172)
  wire [63:0] mstatus;  // ../../RTL/CPU/CU&RU/cu_ru.v(153)
  wire [63:0] mtval;  // ../../RTL/CPU/CU&RU/cu_ru.v(165)
  wire [63:0] mtvec;  // ../../RTL/CPU/CU&RU/cu_ru.v(167)
  wire [63:0] mvendorid;  // ../../RTL/CPU/CU&RU/cu_ru.v(178)
  wire [63:0] n100;
  wire [63:0] n101;
  wire [63:0] n102;
  wire [63:0] n103;
  wire [63:0] n104;
  wire [63:0] n105;
  wire [63:0] n106;
  wire [63:0] n107;
  wire [63:0] n108;
  wire [63:0] n109;
  wire [63:0] n110;
  wire [63:0] n111;
  wire [63:0] n112;
  wire [63:0] n113;
  wire [63:0] n114;
  wire [63:0] n115;
  wire [61:0] n43;
  wire [61:0] n44;
  wire [4:0] n46;
  wire [63:0] n47;
  wire [4:0] n49;
  wire [63:0] n50;
  wire [4:0] n52;
  wire [63:0] n57;
  wire [63:0] n58;
  wire [63:0] n59;
  wire [63:0] n60;
  wire [63:0] n61;
  wire [63:0] n62;
  wire [63:0] n63;
  wire [63:0] n64;
  wire [63:0] n65;
  wire [63:0] n67;
  wire [63:0] n68;
  wire [63:0] n69;
  wire [63:0] n70;
  wire [63:0] n71;
  wire [63:0] n72;
  wire [63:0] n73;
  wire [63:0] n74;
  wire [63:0] n75;
  wire [63:0] n76;
  wire [63:0] n77;
  wire [63:0] n78;
  wire [63:0] n79;
  wire [63:0] n80;
  wire [63:0] n81;
  wire [63:0] n82;
  wire [63:0] n83;
  wire [63:0] n84;
  wire [63:0] n85;
  wire [63:0] n86;
  wire [63:0] n87;
  wire [63:0] n88;
  wire [63:0] n89;
  wire [63:0] n90;
  wire [63:0] n91;
  wire [63:0] n92;
  wire [63:0] n93;
  wire [63:0] n94;
  wire [63:0] n95;
  wire [63:0] n96;
  wire [63:0] n97;
  wire [63:0] n99;
  wire [63:0] s_ip;  // ../../RTL/CPU/CU&RU/cu_ru.v(159)
  wire [63:0] scause;  // ../../RTL/CPU/CU&RU/cu_ru.v(162)
  wire [63:0] sepc;  // ../../RTL/CPU/CU&RU/cu_ru.v(164)
  wire [63:0] sscratch;  // ../../RTL/CPU/CU&RU/cu_ru.v(173)
  wire [63:0] sstatus;  // ../../RTL/CPU/CU&RU/cu_ru.v(154)
  wire [63:0] stval;  // ../../RTL/CPU/CU&RU/cu_ru.v(166)
  wire [63:0] stvec;  // ../../RTL/CPU/CU&RU/cu_ru.v(168)
  wire [63:0] trap_cause;  // ../../RTL/CPU/CU&RU/cu_ru.v(131)
  wire [63:0] tvec;  // ../../RTL/CPU/CU&RU/cu_ru.v(133)
  wire [63:0] vec_pc;  // ../../RTL/CPU/CU&RU/cu_ru.v(135)
  wire exc_target_m;  // ../../RTL/CPU/CU&RU/cu_ru.v(146)
  wire exc_target_s;  // ../../RTL/CPU/CU&RU/cu_ru.v(145)
  wire exception;  // ../../RTL/CPU/CU&RU/cu_ru.v(140)
  wire int_target_m;  // ../../RTL/CPU/CU&RU/cu_ru.v(144)
  wire int_target_s;  // ../../RTL/CPU/CU&RU/cu_ru.v(143)
  wire mcountinhibit;  // ../../RTL/CPU/CU&RU/cu_ru.v(639)
  wire mie;  // ../../RTL/CPU/CU&RU/cu_ru.v(381)
  wire mrw_mcause_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(207)
  wire mrw_mcounterinhibit_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(217)
  wire mrw_mcycle_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(213)
  wire mrw_medeleg_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(200)
  wire mrw_mepc_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(206)
  wire mrw_mideleg_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(201)
  wire mrw_mie_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(202)
  wire mrw_mip_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(209)
  wire mrw_mscratch_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(205)
  wire mrw_mstatus_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(198)
  wire mrw_mtval_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(208)
  wire mrw_mtvec_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(203)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n116;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n2;
  wire n20;
  wire n21;
  wire n22;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire n34;
  wire n35;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n4;
  wire n40;
  wire n41;
  wire n42;
  wire n45;
  wire n48;
  wire n5;
  wire n51;
  wire n53;
  wire n54;
  wire n55;
  wire n56;
  wire n6;
  wire n66;
  wire n7;
  wire n8;
  wire n9;
  wire n98;
  wire next_pc;  // ../../RTL/CPU/CU&RU/cu_ru.v(150)
  wire read_cycle_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(220)
  wire read_instret_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(222)
  wire read_marchid_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(236)
  wire read_mcause_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(248)
  wire read_mcounterinhibit_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(258)
  wire read_mcycle_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(254)
  wire read_medeleg_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(241)
  wire read_mepc_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(247)
  wire read_mhardid_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(238)
  wire read_mideleg_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(242)
  wire read_mie_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(243)
  wire read_mimp_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(237)
  wire read_minstret_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(255)
  wire read_mip_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(250)
  wire read_misa_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(240)
  wire read_mscratch_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(246)
  wire read_mstatus_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(239)
  wire read_mtval_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(249)
  wire read_mtvec_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(244)
  wire read_mvendorid_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(235)
  wire read_satp_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(234)
  wire read_scause_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(231)
  wire read_sepc_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(230)
  wire read_sie_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(226)
  wire read_sip_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(233)
  wire read_sscratch_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(229)
  wire read_sstatus_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(225)
  wire read_stval_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(232)
  wire read_stvec_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(227)
  wire read_time_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(221)
  wire sie;  // ../../RTL/CPU/CU&RU/cu_ru.v(380)
  wire srw_satp_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(193)
  wire srw_scause_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(190)
  wire srw_sepc_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(189)
  wire srw_sie_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(185)
  wire srw_sip_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(192)
  wire srw_sscratch_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(188)
  wire srw_sstatus_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(184)
  wire srw_stval_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(191)
  wire srw_stvec_sel;  // ../../RTL/CPU/CU&RU/cu_ru.v(186)
  wire trap_target_m;  // ../../RTL/CPU/CU&RU/cu_ru.v(148)
  wire trap_target_s;  // ../../RTL/CPU/CU&RU/cu_ru.v(149)

  add_pu62_pu62_o62 add0 (
    .i0({2'b00,tvec[63:4]}),
    .i1(trap_cause[61:0]),
    .o(n43));  // ../../RTL/CPU/CU&RU/cu_ru.v(357)
  csr_satp csr_satp (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(data_csr),
    .rst(rst),
    .srw_satp_sel(srw_satp_sel),
    .satp(satp));  // ../../RTL/CPU/CU&RU/cu_ru.v(613)
  eq_w12 eq0 (
    .i0(csr_index),
    .i1(12'b000100000000),
    .o(n0));  // ../../RTL/CPU/CU&RU/cu_ru.v(264)
  eq_w12 eq1 (
    .i0(csr_index),
    .i1(12'b000100000100),
    .o(n1));  // ../../RTL/CPU/CU&RU/cu_ru.v(265)
  eq_w12 eq10 (
    .i0(csr_index),
    .i1(12'b001100000010),
    .o(n10));  // ../../RTL/CPU/CU&RU/cu_ru.v(280)
  eq_w12 eq11 (
    .i0(csr_index),
    .i1(12'b001100000011),
    .o(n11));  // ../../RTL/CPU/CU&RU/cu_ru.v(281)
  eq_w12 eq12 (
    .i0(csr_index),
    .i1(12'b001100000100),
    .o(n12));  // ../../RTL/CPU/CU&RU/cu_ru.v(282)
  eq_w12 eq13 (
    .i0(csr_index),
    .i1(12'b001100000101),
    .o(n13));  // ../../RTL/CPU/CU&RU/cu_ru.v(283)
  eq_w12 eq14 (
    .i0(csr_index),
    .i1(12'b001101000000),
    .o(n14));  // ../../RTL/CPU/CU&RU/cu_ru.v(285)
  eq_w12 eq15 (
    .i0(csr_index),
    .i1(12'b001101000001),
    .o(n15));  // ../../RTL/CPU/CU&RU/cu_ru.v(286)
  eq_w12 eq16 (
    .i0(csr_index),
    .i1(12'b001101000010),
    .o(n16));  // ../../RTL/CPU/CU&RU/cu_ru.v(287)
  eq_w12 eq17 (
    .i0(csr_index),
    .i1(12'b001101000011),
    .o(n17));  // ../../RTL/CPU/CU&RU/cu_ru.v(288)
  eq_w12 eq18 (
    .i0(csr_index),
    .i1(12'b001101000100),
    .o(n18));  // ../../RTL/CPU/CU&RU/cu_ru.v(289)
  eq_w12 eq19 (
    .i0(csr_index),
    .i1(12'b101100000000),
    .o(n19));  // ../../RTL/CPU/CU&RU/cu_ru.v(293)
  eq_w12 eq2 (
    .i0(csr_index),
    .i1(12'b000100000101),
    .o(n2));  // ../../RTL/CPU/CU&RU/cu_ru.v(266)
  eq_w12 eq20 (
    .i0(csr_index),
    .i1(12'b001100100000),
    .o(n20));  // ../../RTL/CPU/CU&RU/cu_ru.v(297)
  eq_w12 eq21 (
    .i0(id_csr_index),
    .i1(12'b110000000000),
    .o(read_cycle_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(300)
  eq_w12 eq22 (
    .i0(id_csr_index),
    .i1(12'b110000000001),
    .o(read_time_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(301)
  eq_w12 eq23 (
    .i0(id_csr_index),
    .i1(12'b110000000010),
    .o(read_instret_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(302)
  eq_w12 eq24 (
    .i0(id_csr_index),
    .i1(12'b000100000000),
    .o(read_sstatus_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(305)
  eq_w12 eq25 (
    .i0(id_csr_index),
    .i1(12'b000100000100),
    .o(read_sie_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(306)
  eq_w12 eq26 (
    .i0(id_csr_index),
    .i1(12'b000100000101),
    .o(read_stvec_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(307)
  eq_w12 eq27 (
    .i0(id_csr_index),
    .i1(12'b000101000000),
    .o(read_sscratch_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(309)
  eq_w12 eq28 (
    .i0(id_csr_index),
    .i1(12'b000101000001),
    .o(read_sepc_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(310)
  eq_w12 eq29 (
    .i0(id_csr_index),
    .i1(12'b000101000010),
    .o(read_scause_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(311)
  eq_w12 eq3 (
    .i0(csr_index),
    .i1(12'b000101000000),
    .o(n3));  // ../../RTL/CPU/CU&RU/cu_ru.v(268)
  eq_w12 eq30 (
    .i0(id_csr_index),
    .i1(12'b000101000011),
    .o(read_stval_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(312)
  eq_w12 eq31 (
    .i0(id_csr_index),
    .i1(12'b000101000100),
    .o(read_sip_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(313)
  eq_w12 eq32 (
    .i0(id_csr_index),
    .i1(12'b000110000000),
    .o(read_satp_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(314)
  eq_w12 eq33 (
    .i0(id_csr_index),
    .i1(12'b111100010001),
    .o(read_mvendorid_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(315)
  eq_w12 eq34 (
    .i0(id_csr_index),
    .i1(12'b111100010010),
    .o(read_marchid_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(316)
  eq_w12 eq35 (
    .i0(id_csr_index),
    .i1(12'b111100010011),
    .o(read_mimp_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(317)
  eq_w12 eq36 (
    .i0(id_csr_index),
    .i1(12'b111100010100),
    .o(read_mhardid_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(318)
  eq_w12 eq37 (
    .i0(id_csr_index),
    .i1(12'b001100000000),
    .o(read_mstatus_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(319)
  eq_w12 eq38 (
    .i0(id_csr_index),
    .i1(12'b001100000001),
    .o(read_misa_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(320)
  eq_w12 eq39 (
    .i0(id_csr_index),
    .i1(12'b001100000010),
    .o(read_medeleg_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(321)
  eq_w12 eq4 (
    .i0(csr_index),
    .i1(12'b000101000001),
    .o(n4));  // ../../RTL/CPU/CU&RU/cu_ru.v(269)
  eq_w12 eq40 (
    .i0(id_csr_index),
    .i1(12'b001100000011),
    .o(read_mideleg_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(322)
  eq_w12 eq41 (
    .i0(id_csr_index),
    .i1(12'b001100000100),
    .o(read_mie_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(323)
  eq_w12 eq42 (
    .i0(id_csr_index),
    .i1(12'b001100000101),
    .o(read_mtvec_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(324)
  eq_w12 eq43 (
    .i0(id_csr_index),
    .i1(12'b001101000000),
    .o(read_mscratch_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(326)
  eq_w12 eq44 (
    .i0(id_csr_index),
    .i1(12'b001101000001),
    .o(read_mepc_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(327)
  eq_w12 eq45 (
    .i0(id_csr_index),
    .i1(12'b001101000010),
    .o(read_mcause_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(328)
  eq_w12 eq46 (
    .i0(id_csr_index),
    .i1(12'b001101000011),
    .o(read_mtval_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(329)
  eq_w12 eq47 (
    .i0(id_csr_index),
    .i1(12'b001101000100),
    .o(read_mip_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(330)
  eq_w12 eq48 (
    .i0(id_csr_index),
    .i1(12'b101100000000),
    .o(read_mcycle_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(334)
  eq_w12 eq49 (
    .i0(id_csr_index),
    .i1(12'b101100000010),
    .o(read_minstret_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(335)
  eq_w12 eq5 (
    .i0(csr_index),
    .i1(12'b000101000010),
    .o(n5));  // ../../RTL/CPU/CU&RU/cu_ru.v(270)
  eq_w12 eq50 (
    .i0(id_csr_index),
    .i1(12'b001100100000),
    .o(read_mcounterinhibit_sel));  // ../../RTL/CPU/CU&RU/cu_ru.v(338)
  eq_w5 eq51 (
    .i0(rs1_index),
    .i1(5'b00000),
    .o(n45));  // ../../RTL/CPU/CU&RU/cu_ru.v(363)
  eq_w5 eq52 (
    .i0(rs2_index),
    .i1(5'b00000),
    .o(n48));  // ../../RTL/CPU/CU&RU/cu_ru.v(364)
  eq_w12 eq6 (
    .i0(csr_index),
    .i1(12'b000101000011),
    .o(n6));  // ../../RTL/CPU/CU&RU/cu_ru.v(271)
  eq_w12 eq7 (
    .i0(csr_index),
    .i1(12'b000101000100),
    .o(n7));  // ../../RTL/CPU/CU&RU/cu_ru.v(272)
  eq_w12 eq8 (
    .i0(csr_index),
    .i1(12'b000110000000),
    .o(n8));  // ../../RTL/CPU/CU&RU/cu_ru.v(273)
  eq_w12 eq9 (
    .i0(csr_index),
    .i1(12'b001100000000),
    .o(n9));  // ../../RTL/CPU/CU&RU/cu_ru.v(278)
  m_cycle_event m_cycle_event (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(data_csr),
    .mrw_instret_sel(1'bx),
    .mrw_mcountinhibit_sel(mrw_mcounterinhibit_sel),
    .mrw_mcycle_sel(mrw_mcycle_sel),
    .rst(rst),
    .valid(valid),
    .mcountinhibit({open_n0,open_n1,open_n2,open_n3,open_n4,open_n5,open_n6,open_n7,open_n8,open_n9,open_n10,open_n11,open_n12,open_n13,open_n14,open_n15,open_n16,open_n17,open_n18,open_n19,open_n20,open_n21,open_n22,open_n23,open_n24,open_n25,open_n26,open_n27,open_n28,open_n29,open_n30,open_n31,open_n32,open_n33,open_n34,open_n35,open_n36,open_n37,open_n38,open_n39,open_n40,open_n41,open_n42,open_n43,open_n44,open_n45,open_n46,open_n47,open_n48,open_n49,open_n50,open_n51,open_n52,open_n53,open_n54,open_n55,open_n56,open_n57,open_n58,open_n59,open_n60,open_n61,open_n62,mcountinhibit}),
    .mcycle(mcycle),
    .minstret(minstret));  // ../../RTL/CPU/CU&RU/cu_ru.v(624)
  m_s_cause m_s_cause (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(data_csr),
    .mrw_mcause_sel(mrw_mcause_sel),
    .rst(rst),
    .srw_scause_sel(srw_scause_sel),
    .trap_cause(trap_cause),
    .trap_target_m(trap_target_m),
    .trap_target_s(trap_target_s),
    .mcause(mcause),
    .scause(scause));  // ../../RTL/CPU/CU&RU/cu_ru.v(516)
  m_s_epc m_s_epc (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(data_csr),
    .ins_pc(ins_pc),
    .mrw_mepc_sel(mrw_mepc_sel),
    .new_pc(new_pc),
    .next_pc(next_pc),
    .pc_jmp(pc_jmp),
    .rst(rst),
    .srw_sepc_sel(srw_sepc_sel),
    .trap_target_m(trap_target_m),
    .trap_target_s(trap_target_s),
    .mepc(mepc),
    .sepc(sepc));  // ../../RTL/CPU/CU&RU/cu_ru.v(535)
  m_s_ie m_s_ie (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(data_csr),
    .m_ext_int(m_ext_int),
    .mrw_mie_sel(mrw_mie_sel),
    .rst(rst),
    .s_ext_int(s_ext_int),
    .srw_sie_sel(srw_sie_sel),
    .m_s_ie(m_sie));  // ../../RTL/CPU/CU&RU/cu_ru.v(498)
  m_s_ip m_s_ip (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(data_csr),
    .m_ext_int(m_ext_int),
    .m_soft_int(m_soft_int),
    .m_time_int(m_time_int),
    .mrw_mip_sel(mrw_mip_sel),
    .rst(rst),
    .s_ext_int(s_ext_int),
    .srw_sip_sel(srw_sip_sel),
    .m_s_ip(m_sip),
    .s_ip(s_ip));  // ../../RTL/CPU/CU&RU/cu_ru.v(478)
  m_s_scratch m_s_scratch (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(data_csr),
    .mrw_mscratch_sel(mrw_mscratch_sel),
    .rst(rst),
    .srw_sscratch_sel(srw_sscratch_sel),
    .mscratch(mscratch),
    .sscratch(sscratch));  // ../../RTL/CPU/CU&RU/cu_ru.v(643)
  m_s_status m_s_status (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(data_csr),
    .m_ret(m_ret),
    .mrw_mstatus_sel(mrw_mstatus_sel),
    .rst(rst),
    .s_ret(s_ret),
    .srw_sstatus_sel(srw_sstatus_sel),
    .trap_target_m(trap_target_m),
    .trap_target_s(trap_target_s),
    .valid(valid),
    .mie(mie),
    .mod_priv(mod_priv),
    .mprv(mprv),
    .mstatus(mstatus),
    .mxr(mxr),
    .priv(priv),
    .sie(sie),
    .sstatus(sstatus),
    .sum(sum),
    .tsr(tsr),
    .tvm(tvm),
    .tw(tw));  // ../../RTL/CPU/CU&RU/cu_ru.v(375)
  m_s_tval m_s_tval (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(data_csr),
    .ebreak(ebreak),
    .ecall(ecall),
    .exc_code(exc_code),
    .ill_ins(ill_ins),
    .ins_acc_fault(ins_acc_fault),
    .ins_addr_mis(ins_addr_mis),
    .ins_page_fault(ins_page_fault),
    .ins_pc(ins_pc),
    .ld_acc_fault(ld_acc_fault),
    .ld_addr_mis(ld_addr_mis),
    .ld_page_fault(ld_page_fault),
    .m_ret(m_ret),
    .mrw_mtval_sel(mrw_mtval_sel),
    .rst(rst),
    .s_ret(s_ret),
    .srw_stval_sel(srw_stval_sel),
    .st_acc_fault(st_acc_fault),
    .st_addr_mis(st_addr_mis),
    .st_page_fault(st_page_fault),
    .trap_target_m(trap_target_m),
    .trap_target_s(trap_target_s),
    .valid(valid),
    .mtval(mtval),
    .stval(stval));  // ../../RTL/CPU/CU&RU/cu_ru.v(557)
  m_s_tvec m_s_tvec (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(csr_data),
    .mrw_mtvec_sel(mrw_mtvec_sel),
    .rst(rst),
    .srw_stvec_sel(srw_stvec_sel),
    .trap_target_m(trap_target_m),
    .trap_target_s(trap_target_s),
    .mtvec(mtvec),
    .stvec(stvec),
    .tvec({tvec[63:2],open_n127,tvec[0]}));  // ../../RTL/CPU/CU&RU/cu_ru.v(597)
  medeleg_exc_ctrl medeleg_exc_ctrl (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(data_csr),
    .ebreak(ebreak),
    .ecall(ecall),
    .ill_ins(ill_ins),
    .ins_acc_fault(ins_acc_fault),
    .ins_addr_mis(ins_addr_mis),
    .ins_page_fault(ins_page_fault),
    .ld_acc_fault(ld_acc_fault),
    .ld_addr_mis(ld_addr_mis),
    .ld_page_fault(ld_page_fault),
    .mrw_medeleg_sel(mrw_medeleg_sel),
    .priv(priv),
    .rst(rst),
    .st_acc_fault(st_acc_fault),
    .st_addr_mis(st_addr_mis),
    .st_page_fault(st_page_fault),
    .valid(valid),
    .exc_cause(exc_cause),
    .exc_target_m(exc_target_m),
    .exc_target_s(exc_target_s),
    .medeleg(medeleg));  // ../../RTL/CPU/CU&RU/cu_ru.v(442)
  mideleg_int_ctrl mideleg_int_ctrl (
    .clk(clk),
    .csr_write(csr_write),
    .data_csr(data_csr),
    .m_s_ie(m_sie),
    .m_s_ip(m_sip),
    .mie(mie),
    .mrw_mideleg_sel(mrw_mideleg_sel),
    .priv(priv),
    .rst(rst),
    .s_ext_int(s_ext_int),
    .sie(sie),
    .int_cause(int_cause),
    .int_req(int_req),
    .int_target_m(int_target_m),
    .int_target_s(int_target_s),
    .mideleg(mideleg));  // ../../RTL/CPU/CU&RU/cu_ru.v(415)
  mro_csr mro_csr (
    .marchid(marchid),
    .mhartid(mhartid),
    .mimpid(mimpid),
    .misa(misa),
    .mvendorid(mvendorid));  // ../../RTL/CPU/CU&RU/cu_ru.v(657)
  binary_mux_s1_w64 mux0 (
    .i0(int_cause),
    .i1(exc_cause),
    .sel(exception),
    .o(trap_cause));  // ../../RTL/CPU/CU&RU/cu_ru.v(350)
  binary_mux_s1_w62 mux1 (
    .i0({2'b00,tvec[63:4]}),
    .i1(n43),
    .sel(tvec[0]),
    .o(n44));  // ../../RTL/CPU/CU&RU/cu_ru.v(357)
  binary_mux_s1_w64 mux10 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(sstatus),
    .sel(read_sstatus_sel),
    .o(n64));  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  binary_mux_s1_w64 mux11 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(stvec),
    .sel(read_stvec_sel),
    .o(n68));  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  binary_mux_s1_w64 mux12 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(sscratch),
    .sel(read_sscratch_sel),
    .o(n70));  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  binary_mux_s1_w64 mux13 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(sepc),
    .sel(read_sepc_sel),
    .o(n72));  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  binary_mux_s1_w64 mux14 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(scause),
    .sel(read_scause_sel),
    .o(n74));  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  binary_mux_s1_w64 mux15 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(stval),
    .sel(read_stval_sel),
    .o(n76));  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  binary_mux_s1_w64 mux16 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(s_ip),
    .sel(read_sip_sel),
    .o(n78));  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  binary_mux_s1_w64 mux17 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(satp),
    .sel(read_satp_sel),
    .o(n80));  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  binary_mux_s1_w64 mux18 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mvendorid),
    .sel(read_mvendorid_sel),
    .o(n82));  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  binary_mux_s1_w64 mux19 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(marchid),
    .sel(read_marchid_sel),
    .o(n84));  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  binary_mux_s1_w64 mux2 (
    .i0(n47),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(n45),
    .o(rs1_data));  // ../../RTL/CPU/CU&RU/cu_ru.v(363)
  binary_mux_s1_w64 mux20 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mimpid),
    .sel(read_mimp_sel),
    .o(n86));  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  binary_mux_s1_w64 mux21 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mhartid),
    .sel(read_mhardid_sel),
    .o(n88));  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  binary_mux_s1_w64 mux22 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mstatus),
    .sel(read_mstatus_sel),
    .o(n90));  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  binary_mux_s1_w64 mux23 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(misa),
    .sel(read_misa_sel),
    .o(n92));  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  binary_mux_s1_w64 mux24 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(medeleg),
    .sel(read_medeleg_sel),
    .o(n94));  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  binary_mux_s1_w64 mux25 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mideleg),
    .sel(read_mideleg_sel),
    .o(n96));  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  binary_mux_s1_w64 mux26 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mtvec),
    .sel(read_mtvec_sel),
    .o(n100));  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  binary_mux_s1_w64 mux27 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mscratch),
    .sel(read_mscratch_sel),
    .o(n102));  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  binary_mux_s1_w64 mux28 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mepc),
    .sel(read_mepc_sel),
    .o(n104));  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  binary_mux_s1_w64 mux29 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mcause),
    .sel(read_mcause_sel),
    .o(n106));  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  binary_mux_s1_w64 mux3 (
    .i0(n50),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(n48),
    .o(rs2_data));  // ../../RTL/CPU/CU&RU/cu_ru.v(364)
  binary_mux_s1_w64 mux30 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mtval),
    .sel(read_mtval_sel),
    .o(n108));  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  binary_mux_s1_w64 mux31 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(m_sip),
    .sel(read_mip_sel),
    .o(n110));  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  binary_mux_s1_w64 mux32 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mcycle),
    .sel(read_mcycle_sel),
    .o(n112));  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  binary_mux_s1_w64 mux33 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(minstret),
    .sel(read_minstret_sel),
    .o(n114));  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  binary_mux_s1_w62 mux34 (
    .i0(n44),
    .i1({2'b00,tvec[63:4]}),
    .sel(exception),
    .o(vec_pc[63:2]));  // ../../RTL/CPU/CU&RU/cu_ru.v(357)
  binary_mux_s1_w64 mux4 (
    .i0(new_pc),
    .i1(vec_pc),
    .sel(n56),
    .o(n57));  // ../../RTL/CPU/CU&RU/cu_ru.v(667)
  binary_mux_s1_w64 mux5 (
    .i0(n57),
    .i1(sepc),
    .sel(n55),
    .o(n58));  // ../../RTL/CPU/CU&RU/cu_ru.v(667)
  binary_mux_s1_w64 mux6 (
    .i0(n58),
    .i1(mepc),
    .sel(n54),
    .o(flush_pc));  // ../../RTL/CPU/CU&RU/cu_ru.v(667)
  binary_mux_s1_w64 mux7 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mcycle),
    .sel(read_cycle_sel),
    .o(n59));  // ../../RTL/CPU/CU&RU/cu_ru.v(672)
  binary_mux_s1_w64 mux8 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(mtime),
    .sel(read_time_sel),
    .o(n60));  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  binary_mux_s1_w64 mux9 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(minstret),
    .sel(read_instret_sel),
    .o(n62));  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  ne_w5 neq0 (
    .i0(rd_index),
    .i1(5'b00000),
    .o(n51));  // ../../RTL/CPU/CU&RU/cu_ru.v(368)
  ram_w5x64_r5x64_r5x64 #(
    .DATA_DEPTH_LEFT("30"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("63"),
    .DATA_WIDTH_RIGHT("0"))
    ram_gpr (
    .clk1(clk),
    .ra1(n46),
    .ra2(n49),
    .re1(1'b1),
    .re2(1'b1),
    .wa1(n52),
    .wd1(data_rd),
    .we1(n53),
    .rd1(n47),
    .rd2(n50));  // ../../RTL/CPU/CU&RU/cu_ru.v(361)
  add_pu5_mu5_o5 sub0 (
    .i0(rs1_index),
    .i1(5'b00001),
    .o(n46));  // ../../RTL/CPU/CU&RU/cu_ru.v(363)
  add_pu5_mu5_o5 sub1 (
    .i0(rs2_index),
    .i1(5'b00001),
    .o(n49));  // ../../RTL/CPU/CU&RU/cu_ru.v(364)
  add_pu5_mu5_o5 sub2 (
    .i0(rd_index),
    .i1(5'b00001),
    .o(n52));  // ../../RTL/CPU/CU&RU/cu_ru.v(369)
  and u10 (srw_satp_sel, valid, n8);  // ../../RTL/CPU/CU&RU/cu_ru.v(273)
  or u100 (csr_data[52], n113[52], n114[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1000 (n85[32], n83[32], n84[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1001 (n85[33], n83[33], n84[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1002 (n85[34], n83[34], n84[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1003 (n85[35], n83[35], n84[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1004 (n85[36], n83[36], n84[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1005 (n85[37], n83[37], n84[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1006 (n85[38], n83[38], n84[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1007 (n85[39], n83[39], n84[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1008 (n85[40], n83[40], n84[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1009 (n85[41], n83[41], n84[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u101 (csr_data[53], n113[53], n114[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1010 (n85[42], n83[42], n84[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1011 (n85[43], n83[43], n84[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1012 (n85[44], n83[44], n84[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1013 (n85[45], n83[45], n84[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1014 (n85[46], n83[46], n84[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1015 (n85[47], n83[47], n84[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1016 (n85[48], n83[48], n84[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1017 (n85[49], n83[49], n84[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1018 (n85[50], n83[50], n84[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1019 (n85[51], n83[51], n84[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u102 (csr_data[54], n113[54], n114[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1020 (n85[52], n83[52], n84[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1021 (n85[53], n83[53], n84[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1022 (n85[54], n83[54], n84[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1023 (n85[55], n83[55], n84[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1024 (n85[56], n83[56], n84[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1025 (n85[57], n83[57], n84[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1026 (n85[58], n83[58], n84[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1027 (n85[59], n83[59], n84[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1028 (n85[60], n83[60], n84[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1029 (n85[61], n83[61], n84[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u103 (csr_data[55], n113[55], n114[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1030 (n85[62], n83[62], n84[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1031 (n85[63], n83[63], n84[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u1032 (n83[1], n81[1], n82[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1033 (n83[2], n81[2], n82[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1034 (n83[3], n81[3], n82[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1035 (n83[4], n81[4], n82[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1036 (n83[5], n81[5], n82[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1037 (n83[6], n81[6], n82[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1038 (n83[7], n81[7], n82[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1039 (n83[8], n81[8], n82[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u104 (csr_data[56], n113[56], n114[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1040 (n83[9], n81[9], n82[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1041 (n83[10], n81[10], n82[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1042 (n83[11], n81[11], n82[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1043 (n83[12], n81[12], n82[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1044 (n83[13], n81[13], n82[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1045 (n83[14], n81[14], n82[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1046 (n83[15], n81[15], n82[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1047 (n83[16], n81[16], n82[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1048 (n83[17], n81[17], n82[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1049 (n83[18], n81[18], n82[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u105 (csr_data[57], n113[57], n114[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1050 (n83[19], n81[19], n82[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1051 (n83[20], n81[20], n82[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1052 (n83[21], n81[21], n82[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1053 (n83[22], n81[22], n82[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1054 (n83[23], n81[23], n82[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1055 (n83[24], n81[24], n82[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1056 (n83[25], n81[25], n82[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1057 (n83[26], n81[26], n82[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1058 (n83[27], n81[27], n82[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1059 (n83[28], n81[28], n82[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u106 (csr_data[58], n113[58], n114[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1060 (n83[29], n81[29], n82[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1061 (n83[30], n81[30], n82[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1062 (n83[31], n81[31], n82[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1063 (n83[32], n81[32], n82[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1064 (n83[33], n81[33], n82[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1065 (n83[34], n81[34], n82[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1066 (n83[35], n81[35], n82[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1067 (n83[36], n81[36], n82[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1068 (n83[37], n81[37], n82[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1069 (n83[38], n81[38], n82[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u107 (csr_data[59], n113[59], n114[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1070 (n83[39], n81[39], n82[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1071 (n83[40], n81[40], n82[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1072 (n83[41], n81[41], n82[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1073 (n83[42], n81[42], n82[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1074 (n83[43], n81[43], n82[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1075 (n83[44], n81[44], n82[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1076 (n83[45], n81[45], n82[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1077 (n83[46], n81[46], n82[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1078 (n83[47], n81[47], n82[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1079 (n83[48], n81[48], n82[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u108 (csr_data[60], n113[60], n114[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1080 (n83[49], n81[49], n82[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1081 (n83[50], n81[50], n82[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1082 (n83[51], n81[51], n82[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1083 (n83[52], n81[52], n82[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1084 (n83[53], n81[53], n82[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1085 (n83[54], n81[54], n82[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1086 (n83[55], n81[55], n82[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1087 (n83[56], n81[56], n82[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1088 (n83[57], n81[57], n82[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1089 (n83[58], n81[58], n82[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u109 (csr_data[61], n113[61], n114[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1090 (n83[59], n81[59], n82[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1091 (n83[60], n81[60], n82[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1092 (n83[61], n81[61], n82[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1093 (n83[62], n81[62], n82[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1094 (n83[63], n81[63], n82[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u1095 (n81[1], n79[1], n80[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1096 (n81[2], n79[2], n80[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1097 (n81[3], n79[3], n80[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1098 (n81[4], n79[4], n80[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1099 (n81[5], n79[5], n80[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  and u11 (mrw_mstatus_sel, valid, n9);  // ../../RTL/CPU/CU&RU/cu_ru.v(278)
  or u110 (csr_data[62], n113[62], n114[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1100 (n81[6], n79[6], n80[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1101 (n81[7], n79[7], n80[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1102 (n81[8], n79[8], n80[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1103 (n81[9], n79[9], n80[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1104 (n81[10], n79[10], n80[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1105 (n81[11], n79[11], n80[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1106 (n81[12], n79[12], n80[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1107 (n81[13], n79[13], n80[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1108 (n81[14], n79[14], n80[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1109 (n81[15], n79[15], n80[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u111 (csr_data[63], n113[63], n114[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u1110 (n81[16], n79[16], n80[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1111 (n81[17], n79[17], n80[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1112 (n81[18], n79[18], n80[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1113 (n81[19], n79[19], n80[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1114 (n81[20], n79[20], n80[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1115 (n81[21], n79[21], n80[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1116 (n81[22], n79[22], n80[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1117 (n81[23], n79[23], n80[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1118 (n81[24], n79[24], n80[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1119 (n81[25], n79[25], n80[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u112 (n113[1], n111[1], n112[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1120 (n81[26], n79[26], n80[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1121 (n81[27], n79[27], n80[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1122 (n81[28], n79[28], n80[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1123 (n81[29], n79[29], n80[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1124 (n81[30], n79[30], n80[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1125 (n81[31], n79[31], n80[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1126 (n81[32], n79[32], n80[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1127 (n81[33], n79[33], n80[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1128 (n81[34], n79[34], n80[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1129 (n81[35], n79[35], n80[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u113 (n113[2], n111[2], n112[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1130 (n81[36], n79[36], n80[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1131 (n81[37], n79[37], n80[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1132 (n81[38], n79[38], n80[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1133 (n81[39], n79[39], n80[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1134 (n81[40], n79[40], n80[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1135 (n81[41], n79[41], n80[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1136 (n81[42], n79[42], n80[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1137 (n81[43], n79[43], n80[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1138 (n81[44], n79[44], n80[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1139 (n81[45], n79[45], n80[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u114 (n113[3], n111[3], n112[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1140 (n81[46], n79[46], n80[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1141 (n81[47], n79[47], n80[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1142 (n81[48], n79[48], n80[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1143 (n81[49], n79[49], n80[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1144 (n81[50], n79[50], n80[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1145 (n81[51], n79[51], n80[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1146 (n81[52], n79[52], n80[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1147 (n81[53], n79[53], n80[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1148 (n81[54], n79[54], n80[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1149 (n81[55], n79[55], n80[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u115 (n113[4], n111[4], n112[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1150 (n81[56], n79[56], n80[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1151 (n81[57], n79[57], n80[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1152 (n81[58], n79[58], n80[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1153 (n81[59], n79[59], n80[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1154 (n81[60], n79[60], n80[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1155 (n81[61], n79[61], n80[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1156 (n81[62], n79[62], n80[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1157 (n81[63], n79[63], n80[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u1158 (n79[1], n77[1], n78[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1159 (n79[2], n77[2], n78[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u116 (n113[5], n111[5], n112[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1160 (n79[3], n77[3], n78[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1161 (n79[4], n77[4], n78[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1162 (n79[5], n77[5], n78[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1163 (n79[6], n77[6], n78[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1164 (n79[7], n77[7], n78[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1165 (n79[8], n77[8], n78[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1166 (n79[9], n77[9], n78[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1167 (n79[10], n77[10], n78[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1168 (n79[11], n77[11], n78[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1169 (n79[12], n77[12], n78[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u117 (n113[6], n111[6], n112[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1170 (n79[13], n77[13], n78[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1171 (n79[14], n77[14], n78[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1172 (n79[15], n77[15], n78[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1173 (n79[16], n77[16], n78[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1174 (n79[17], n77[17], n78[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1175 (n79[18], n77[18], n78[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1176 (n79[19], n77[19], n78[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1177 (n79[20], n77[20], n78[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1178 (n79[21], n77[21], n78[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1179 (n79[22], n77[22], n78[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u118 (n113[7], n111[7], n112[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1180 (n79[23], n77[23], n78[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1181 (n79[24], n77[24], n78[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1182 (n79[25], n77[25], n78[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1183 (n79[26], n77[26], n78[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1184 (n79[27], n77[27], n78[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1185 (n79[28], n77[28], n78[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1186 (n79[29], n77[29], n78[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1187 (n79[30], n77[30], n78[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1188 (n79[31], n77[31], n78[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1189 (n79[32], n77[32], n78[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u119 (n113[8], n111[8], n112[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1190 (n79[33], n77[33], n78[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1191 (n79[34], n77[34], n78[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1192 (n79[35], n77[35], n78[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1193 (n79[36], n77[36], n78[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1194 (n79[37], n77[37], n78[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1195 (n79[38], n77[38], n78[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1196 (n79[39], n77[39], n78[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1197 (n79[40], n77[40], n78[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1198 (n79[41], n77[41], n78[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1199 (n79[42], n77[42], n78[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  and u12 (mrw_medeleg_sel, valid, n10);  // ../../RTL/CPU/CU&RU/cu_ru.v(280)
  or u120 (n113[9], n111[9], n112[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1200 (n79[43], n77[43], n78[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1201 (n79[44], n77[44], n78[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1202 (n79[45], n77[45], n78[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1203 (n79[46], n77[46], n78[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1204 (n79[47], n77[47], n78[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1205 (n79[48], n77[48], n78[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1206 (n79[49], n77[49], n78[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1207 (n79[50], n77[50], n78[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1208 (n79[51], n77[51], n78[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1209 (n79[52], n77[52], n78[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u121 (n113[10], n111[10], n112[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1210 (n79[53], n77[53], n78[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1211 (n79[54], n77[54], n78[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1212 (n79[55], n77[55], n78[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1213 (n79[56], n77[56], n78[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1214 (n79[57], n77[57], n78[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1215 (n79[58], n77[58], n78[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1216 (n79[59], n77[59], n78[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1217 (n79[60], n77[60], n78[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1218 (n79[61], n77[61], n78[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1219 (n79[62], n77[62], n78[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u122 (n113[11], n111[11], n112[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1220 (n79[63], n77[63], n78[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1221 (n77[1], n75[1], n76[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1222 (n77[2], n75[2], n76[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1223 (n77[3], n75[3], n76[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1224 (n77[4], n75[4], n76[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1225 (n77[5], n75[5], n76[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1226 (n77[6], n75[6], n76[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1227 (n77[7], n75[7], n76[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1228 (n77[8], n75[8], n76[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1229 (n77[9], n75[9], n76[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u123 (n113[12], n111[12], n112[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1230 (n77[10], n75[10], n76[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1231 (n77[11], n75[11], n76[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1232 (n77[12], n75[12], n76[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1233 (n77[13], n75[13], n76[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1234 (n77[14], n75[14], n76[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1235 (n77[15], n75[15], n76[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1236 (n77[16], n75[16], n76[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1237 (n77[17], n75[17], n76[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1238 (n77[18], n75[18], n76[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1239 (n77[19], n75[19], n76[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u124 (n113[13], n111[13], n112[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1240 (n77[20], n75[20], n76[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1241 (n77[21], n75[21], n76[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1242 (n77[22], n75[22], n76[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1243 (n77[23], n75[23], n76[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1244 (n77[24], n75[24], n76[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1245 (n77[25], n75[25], n76[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1246 (n77[26], n75[26], n76[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1247 (n77[27], n75[27], n76[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1248 (n77[28], n75[28], n76[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1249 (n77[29], n75[29], n76[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u125 (n113[14], n111[14], n112[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1250 (n77[30], n75[30], n76[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1251 (n77[31], n75[31], n76[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1252 (n77[32], n75[32], n76[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1253 (n77[33], n75[33], n76[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1254 (n77[34], n75[34], n76[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1255 (n77[35], n75[35], n76[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1256 (n77[36], n75[36], n76[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1257 (n77[37], n75[37], n76[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1258 (n77[38], n75[38], n76[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1259 (n77[39], n75[39], n76[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u126 (n113[15], n111[15], n112[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1260 (n77[40], n75[40], n76[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1261 (n77[41], n75[41], n76[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1262 (n77[42], n75[42], n76[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1263 (n77[43], n75[43], n76[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1264 (n77[44], n75[44], n76[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1265 (n77[45], n75[45], n76[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1266 (n77[46], n75[46], n76[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1267 (n77[47], n75[47], n76[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1268 (n77[48], n75[48], n76[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1269 (n77[49], n75[49], n76[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u127 (n113[16], n111[16], n112[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1270 (n77[50], n75[50], n76[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1271 (n77[51], n75[51], n76[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1272 (n77[52], n75[52], n76[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1273 (n77[53], n75[53], n76[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1274 (n77[54], n75[54], n76[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1275 (n77[55], n75[55], n76[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1276 (n77[56], n75[56], n76[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1277 (n77[57], n75[57], n76[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1278 (n77[58], n75[58], n76[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1279 (n77[59], n75[59], n76[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u128 (n113[17], n111[17], n112[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1280 (n77[60], n75[60], n76[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1281 (n77[61], n75[61], n76[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1282 (n77[62], n75[62], n76[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1283 (n77[63], n75[63], n76[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1284 (n75[1], n73[1], n74[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1285 (n75[2], n73[2], n74[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1286 (n75[3], n73[3], n74[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1287 (n75[4], n73[4], n74[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1288 (n75[5], n73[5], n74[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1289 (n75[6], n73[6], n74[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u129 (n113[18], n111[18], n112[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1290 (n75[7], n73[7], n74[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1291 (n75[8], n73[8], n74[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1292 (n75[9], n73[9], n74[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1293 (n75[10], n73[10], n74[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1294 (n75[11], n73[11], n74[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1295 (n75[12], n73[12], n74[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1296 (n75[13], n73[13], n74[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1297 (n75[14], n73[14], n74[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1298 (n75[15], n73[15], n74[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1299 (n75[16], n73[16], n74[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  and u13 (mrw_mideleg_sel, valid, n11);  // ../../RTL/CPU/CU&RU/cu_ru.v(281)
  or u130 (n113[19], n111[19], n112[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1300 (n75[17], n73[17], n74[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1301 (n75[18], n73[18], n74[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1302 (n75[19], n73[19], n74[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1303 (n75[20], n73[20], n74[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1304 (n75[21], n73[21], n74[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1305 (n75[22], n73[22], n74[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1306 (n75[23], n73[23], n74[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1307 (n75[24], n73[24], n74[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1308 (n75[25], n73[25], n74[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1309 (n75[26], n73[26], n74[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u131 (n113[20], n111[20], n112[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1310 (n75[27], n73[27], n74[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1311 (n75[28], n73[28], n74[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1312 (n75[29], n73[29], n74[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1313 (n75[30], n73[30], n74[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1314 (n75[31], n73[31], n74[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1315 (n75[32], n73[32], n74[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1316 (n75[33], n73[33], n74[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1317 (n75[34], n73[34], n74[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1318 (n75[35], n73[35], n74[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1319 (n75[36], n73[36], n74[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u132 (n113[21], n111[21], n112[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1320 (n75[37], n73[37], n74[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1321 (n75[38], n73[38], n74[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1322 (n75[39], n73[39], n74[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1323 (n75[40], n73[40], n74[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1324 (n75[41], n73[41], n74[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1325 (n75[42], n73[42], n74[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1326 (n75[43], n73[43], n74[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1327 (n75[44], n73[44], n74[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1328 (n75[45], n73[45], n74[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1329 (n75[46], n73[46], n74[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u133 (n113[22], n111[22], n112[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1330 (n75[47], n73[47], n74[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1331 (n75[48], n73[48], n74[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1332 (n75[49], n73[49], n74[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1333 (n75[50], n73[50], n74[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1334 (n75[51], n73[51], n74[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1335 (n75[52], n73[52], n74[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1336 (n75[53], n73[53], n74[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1337 (n75[54], n73[54], n74[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1338 (n75[55], n73[55], n74[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1339 (n75[56], n73[56], n74[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u134 (n113[23], n111[23], n112[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1340 (n75[57], n73[57], n74[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1341 (n75[58], n73[58], n74[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1342 (n75[59], n73[59], n74[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1343 (n75[60], n73[60], n74[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1344 (n75[61], n73[61], n74[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1345 (n75[62], n73[62], n74[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1346 (n75[63], n73[63], n74[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1347 (n73[1], n71[1], n72[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1348 (n73[2], n71[2], n72[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1349 (n73[3], n71[3], n72[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u135 (n113[24], n111[24], n112[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1350 (n73[4], n71[4], n72[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1351 (n73[5], n71[5], n72[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1352 (n73[6], n71[6], n72[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1353 (n73[7], n71[7], n72[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1354 (n73[8], n71[8], n72[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1355 (n73[9], n71[9], n72[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1356 (n73[10], n71[10], n72[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1357 (n73[11], n71[11], n72[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1358 (n73[12], n71[12], n72[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1359 (n73[13], n71[13], n72[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u136 (n113[25], n111[25], n112[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1360 (n73[14], n71[14], n72[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1361 (n73[15], n71[15], n72[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1362 (n73[16], n71[16], n72[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1363 (n73[17], n71[17], n72[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1364 (n73[18], n71[18], n72[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1365 (n73[19], n71[19], n72[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1366 (n73[20], n71[20], n72[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1367 (n73[21], n71[21], n72[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1368 (n73[22], n71[22], n72[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1369 (n73[23], n71[23], n72[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u137 (n113[26], n111[26], n112[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1370 (n73[24], n71[24], n72[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1371 (n73[25], n71[25], n72[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1372 (n73[26], n71[26], n72[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1373 (n73[27], n71[27], n72[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1374 (n73[28], n71[28], n72[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1375 (n73[29], n71[29], n72[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1376 (n73[30], n71[30], n72[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1377 (n73[31], n71[31], n72[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1378 (n73[32], n71[32], n72[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1379 (n73[33], n71[33], n72[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u138 (n113[27], n111[27], n112[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1380 (n73[34], n71[34], n72[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1381 (n73[35], n71[35], n72[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1382 (n73[36], n71[36], n72[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1383 (n73[37], n71[37], n72[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1384 (n73[38], n71[38], n72[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1385 (n73[39], n71[39], n72[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1386 (n73[40], n71[40], n72[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1387 (n73[41], n71[41], n72[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1388 (n73[42], n71[42], n72[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1389 (n73[43], n71[43], n72[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u139 (n113[28], n111[28], n112[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1390 (n73[44], n71[44], n72[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1391 (n73[45], n71[45], n72[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1392 (n73[46], n71[46], n72[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1393 (n73[47], n71[47], n72[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1394 (n73[48], n71[48], n72[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1395 (n73[49], n71[49], n72[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1396 (n73[50], n71[50], n72[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1397 (n73[51], n71[51], n72[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1398 (n73[52], n71[52], n72[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1399 (n73[53], n71[53], n72[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  and u14 (mrw_mie_sel, valid, n12);  // ../../RTL/CPU/CU&RU/cu_ru.v(282)
  or u140 (n113[29], n111[29], n112[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1400 (n73[54], n71[54], n72[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1401 (n73[55], n71[55], n72[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1402 (n73[56], n71[56], n72[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1403 (n73[57], n71[57], n72[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1404 (n73[58], n71[58], n72[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1405 (n73[59], n71[59], n72[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1406 (n73[60], n71[60], n72[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1407 (n73[61], n71[61], n72[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1408 (n73[62], n71[62], n72[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1409 (n73[63], n71[63], n72[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u141 (n113[30], n111[30], n112[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1410 (n71[1], n69[1], n70[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1411 (n71[2], n69[2], n70[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1412 (n71[3], n69[3], n70[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1413 (n71[4], n69[4], n70[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1414 (n71[5], n69[5], n70[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1415 (n71[6], n69[6], n70[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1416 (n71[7], n69[7], n70[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1417 (n71[8], n69[8], n70[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1418 (n71[9], n69[9], n70[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1419 (n71[10], n69[10], n70[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u142 (n113[31], n111[31], n112[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1420 (n71[11], n69[11], n70[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1421 (n71[12], n69[12], n70[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1422 (n71[13], n69[13], n70[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1423 (n71[14], n69[14], n70[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1424 (n71[15], n69[15], n70[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1425 (n71[16], n69[16], n70[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1426 (n71[17], n69[17], n70[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1427 (n71[18], n69[18], n70[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1428 (n71[19], n69[19], n70[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1429 (n71[20], n69[20], n70[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u143 (n113[32], n111[32], n112[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1430 (n71[21], n69[21], n70[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1431 (n71[22], n69[22], n70[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1432 (n71[23], n69[23], n70[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1433 (n71[24], n69[24], n70[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1434 (n71[25], n69[25], n70[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1435 (n71[26], n69[26], n70[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1436 (n71[27], n69[27], n70[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1437 (n71[28], n69[28], n70[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1438 (n71[29], n69[29], n70[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1439 (n71[30], n69[30], n70[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u144 (n113[33], n111[33], n112[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1440 (n71[31], n69[31], n70[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1441 (n71[32], n69[32], n70[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1442 (n71[33], n69[33], n70[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1443 (n71[34], n69[34], n70[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1444 (n71[35], n69[35], n70[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1445 (n71[36], n69[36], n70[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1446 (n71[37], n69[37], n70[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1447 (n71[38], n69[38], n70[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1448 (n71[39], n69[39], n70[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1449 (n71[40], n69[40], n70[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u145 (n113[34], n111[34], n112[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1450 (n71[41], n69[41], n70[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1451 (n71[42], n69[42], n70[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1452 (n71[43], n69[43], n70[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1453 (n71[44], n69[44], n70[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1454 (n71[45], n69[45], n70[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1455 (n71[46], n69[46], n70[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1456 (n71[47], n69[47], n70[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1457 (n71[48], n69[48], n70[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1458 (n71[49], n69[49], n70[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1459 (n71[50], n69[50], n70[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u146 (n113[35], n111[35], n112[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1460 (n71[51], n69[51], n70[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1461 (n71[52], n69[52], n70[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1462 (n71[53], n69[53], n70[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1463 (n71[54], n69[54], n70[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1464 (n71[55], n69[55], n70[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1465 (n71[56], n69[56], n70[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1466 (n71[57], n69[57], n70[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1467 (n71[58], n69[58], n70[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1468 (n71[59], n69[59], n70[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1469 (n71[60], n69[60], n70[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u147 (n113[36], n111[36], n112[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1470 (n71[61], n69[61], n70[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1471 (n71[62], n69[62], n70[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1472 (n71[63], n69[63], n70[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1473 (n69[1], n65[1], n68[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1474 (n69[2], n65[2], n68[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1475 (n69[3], n65[3], n68[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1476 (n69[4], n65[4], n68[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1477 (n69[5], n65[5], n68[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1478 (n69[6], n65[6], n68[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1479 (n69[7], n65[7], n68[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u148 (n113[37], n111[37], n112[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1480 (n69[8], n65[8], n68[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1481 (n69[9], n65[9], n68[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1482 (n69[10], n65[10], n68[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1483 (n69[11], n65[11], n68[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1484 (n69[12], n65[12], n68[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1485 (n69[13], n65[13], n68[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1486 (n69[14], n65[14], n68[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1487 (n69[15], n65[15], n68[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1488 (n69[16], n65[16], n68[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1489 (n69[17], n65[17], n68[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u149 (n113[38], n111[38], n112[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1490 (n69[18], n65[18], n68[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1491 (n69[19], n65[19], n68[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1492 (n69[20], n65[20], n68[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1493 (n69[21], n65[21], n68[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1494 (n69[22], n65[22], n68[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1495 (n69[23], n65[23], n68[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1496 (n69[24], n65[24], n68[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1497 (n69[25], n65[25], n68[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1498 (n69[26], n65[26], n68[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1499 (n69[27], n65[27], n68[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  and u15 (mrw_mtvec_sel, valid, n13);  // ../../RTL/CPU/CU&RU/cu_ru.v(283)
  or u150 (n113[39], n111[39], n112[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1500 (n69[28], n65[28], n68[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1501 (n69[29], n65[29], n68[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1502 (n69[30], n65[30], n68[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1503 (n69[31], n65[31], n68[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1504 (n69[32], n65[32], n68[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1505 (n69[33], n65[33], n68[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1506 (n69[34], n65[34], n68[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1507 (n69[35], n65[35], n68[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1508 (n69[36], n65[36], n68[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1509 (n69[37], n65[37], n68[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u151 (n113[40], n111[40], n112[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1510 (n69[38], n65[38], n68[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1511 (n69[39], n65[39], n68[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1512 (n69[40], n65[40], n68[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1513 (n69[41], n65[41], n68[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1514 (n69[42], n65[42], n68[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1515 (n69[43], n65[43], n68[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1516 (n69[44], n65[44], n68[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1517 (n69[45], n65[45], n68[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1518 (n69[46], n65[46], n68[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1519 (n69[47], n65[47], n68[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u152 (n113[41], n111[41], n112[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1520 (n69[48], n65[48], n68[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1521 (n69[49], n65[49], n68[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1522 (n69[50], n65[50], n68[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1523 (n69[51], n65[51], n68[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1524 (n69[52], n65[52], n68[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1525 (n69[53], n65[53], n68[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1526 (n69[54], n65[54], n68[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1527 (n69[55], n65[55], n68[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1528 (n69[56], n65[56], n68[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1529 (n69[57], n65[57], n68[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u153 (n113[42], n111[42], n112[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1530 (n69[58], n65[58], n68[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1531 (n69[59], n65[59], n68[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1532 (n69[60], n65[60], n68[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1533 (n69[61], n65[61], n68[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1534 (n69[62], n65[62], n68[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1535 (n69[63], n65[63], n68[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1536 (n65[1], n63[1], n64[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1537 (n65[2], n63[2], n64[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1538 (n65[3], n63[3], n64[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1539 (n65[4], n63[4], n64[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u154 (n113[43], n111[43], n112[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u1540 (n65[5], n63[5], n64[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1541 (n65[6], n63[6], n64[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1542 (n65[7], n63[7], n64[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1543 (n65[8], n63[8], n64[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1544 (n65[9], n63[9], n64[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1545 (n65[10], n63[10], n64[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1546 (n65[11], n63[11], n64[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1547 (n65[12], n63[12], n64[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1548 (n65[13], n63[13], n64[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1549 (n65[14], n63[14], n64[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  AL_MUX u155 (
    .i0(1'b0),
    .i1(n51),
    .sel(gpr_write),
    .o(n53));  // ../../RTL/CPU/CU&RU/cu_ru.v(371)
  or u1550 (n65[15], n63[15], n64[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1551 (n65[16], n63[16], n64[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1552 (n65[17], n63[17], n64[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1553 (n65[18], n63[18], n64[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1554 (n65[19], n63[19], n64[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1555 (n65[20], n63[20], n64[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1556 (n65[21], n63[21], n64[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1557 (n65[22], n63[22], n64[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1558 (n65[23], n63[23], n64[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1559 (n65[24], n63[24], n64[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  and u156 (n54, valid, m_ret);  // ../../RTL/CPU/CU&RU/cu_ru.v(667)
  or u1560 (n65[25], n63[25], n64[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1561 (n65[26], n63[26], n64[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1562 (n65[27], n63[27], n64[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1563 (n65[28], n63[28], n64[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1564 (n65[29], n63[29], n64[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1565 (n65[30], n63[30], n64[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1566 (n65[31], n63[31], n64[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1567 (n65[32], n63[32], n64[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1568 (n65[33], n63[33], n64[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1569 (n65[34], n63[34], n64[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  and u157 (n55, valid, s_ret);  // ../../RTL/CPU/CU&RU/cu_ru.v(667)
  or u1570 (n65[35], n63[35], n64[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1571 (n65[36], n63[36], n64[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1572 (n65[37], n63[37], n64[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1573 (n65[38], n63[38], n64[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1574 (n65[39], n63[39], n64[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1575 (n65[40], n63[40], n64[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1576 (n65[41], n63[41], n64[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1577 (n65[42], n63[42], n64[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1578 (n65[43], n63[43], n64[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1579 (n65[44], n63[44], n64[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u158 (n56, trap_target_m, trap_target_s);  // ../../RTL/CPU/CU&RU/cu_ru.v(667)
  or u1580 (n65[45], n63[45], n64[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1581 (n65[46], n63[46], n64[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1582 (n65[47], n63[47], n64[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1583 (n65[48], n63[48], n64[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1584 (n65[49], n63[49], n64[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1585 (n65[50], n63[50], n64[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1586 (n65[51], n63[51], n64[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1587 (n65[52], n63[52], n64[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1588 (n65[53], n63[53], n64[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1589 (n65[54], n63[54], n64[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u159 (csr_data[0], n115[0], n116);  // ../../RTL/CPU/CU&RU/cu_ru.v(706)
  or u1590 (n65[55], n63[55], n64[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1591 (n65[56], n63[56], n64[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1592 (n65[57], n63[57], n64[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1593 (n65[58], n63[58], n64[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1594 (n65[59], n63[59], n64[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1595 (n65[60], n63[60], n64[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1596 (n65[61], n63[61], n64[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1597 (n65[62], n63[62], n64[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1598 (n65[63], n63[63], n64[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1599 (n63[1], n61[1], n62[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  and u16 (mrw_mscratch_sel, valid, n14);  // ../../RTL/CPU/CU&RU/cu_ru.v(285)
  or u160 (pip_flush, n56, pc_jmp);  // ../../RTL/CPU/CU&RU/cu_ru.v(668)
  or u1600 (n63[2], n61[2], n62[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1601 (n63[3], n61[3], n62[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1602 (n63[4], n61[4], n62[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1603 (n63[5], n61[5], n62[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1604 (n63[6], n61[6], n62[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1605 (n63[7], n61[7], n62[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1606 (n63[8], n61[8], n62[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1607 (n63[9], n61[9], n62[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1608 (n63[10], n61[10], n62[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1609 (n63[11], n61[11], n62[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  buf u161 (vec_pc[0], tvec[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(357)
  or u1610 (n63[12], n61[12], n62[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1611 (n63[13], n61[13], n62[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1612 (n63[14], n61[14], n62[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1613 (n63[15], n61[15], n62[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1614 (n63[16], n61[16], n62[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1615 (n63[17], n61[17], n62[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1616 (n63[18], n61[18], n62[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1617 (n63[19], n61[19], n62[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1618 (n63[20], n61[20], n62[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1619 (n63[21], n61[21], n62[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u162 (n61[0], n59[0], n60[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1620 (n63[22], n61[22], n62[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1621 (n63[23], n61[23], n62[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1622 (n63[24], n61[24], n62[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1623 (n63[25], n61[25], n62[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1624 (n63[26], n61[26], n62[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1625 (n63[27], n61[27], n62[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1626 (n63[28], n61[28], n62[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1627 (n63[29], n61[29], n62[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1628 (n63[30], n61[30], n62[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1629 (n63[31], n61[31], n62[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u163 (n63[0], n61[0], n62[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1630 (n63[32], n61[32], n62[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1631 (n63[33], n61[33], n62[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1632 (n63[34], n61[34], n62[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1633 (n63[35], n61[35], n62[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1634 (n63[36], n61[36], n62[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1635 (n63[37], n61[37], n62[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1636 (n63[38], n61[38], n62[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1637 (n63[39], n61[39], n62[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1638 (n63[40], n61[40], n62[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1639 (n63[41], n61[41], n62[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  AL_MUX u164 (
    .i0(1'b0),
    .i1(sie),
    .sel(read_sie_sel),
    .o(n66));  // ../../RTL/CPU/CU&RU/cu_ru.v(677)
  or u1640 (n63[42], n61[42], n62[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1641 (n63[43], n61[43], n62[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1642 (n63[44], n61[44], n62[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1643 (n63[45], n61[45], n62[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1644 (n63[46], n61[46], n62[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1645 (n63[47], n61[47], n62[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1646 (n63[48], n61[48], n62[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1647 (n63[49], n61[49], n62[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1648 (n63[50], n61[50], n62[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1649 (n63[51], n61[51], n62[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u165 (n65[0], n63[0], n64[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(676)
  or u1650 (n63[52], n61[52], n62[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1651 (n63[53], n61[53], n62[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1652 (n63[54], n61[54], n62[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1653 (n63[55], n61[55], n62[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1654 (n63[56], n61[56], n62[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1655 (n63[57], n61[57], n62[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1656 (n63[58], n61[58], n62[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1657 (n63[59], n61[59], n62[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1658 (n63[60], n61[60], n62[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1659 (n63[61], n61[61], n62[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u166 (n67[0], n65[0], n66);  // ../../RTL/CPU/CU&RU/cu_ru.v(677)
  or u1660 (n63[62], n61[62], n62[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1661 (n63[63], n61[63], n62[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(674)
  or u1662 (n61[1], n59[1], n60[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1663 (n61[2], n59[2], n60[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1664 (n61[3], n59[3], n60[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1665 (n61[4], n59[4], n60[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1666 (n61[5], n59[5], n60[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1667 (n61[6], n59[6], n60[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1668 (n61[7], n59[7], n60[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1669 (n61[8], n59[8], n60[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u167 (n69[0], n67[0], n68[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(678)
  or u1670 (n61[9], n59[9], n60[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1671 (n61[10], n59[10], n60[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1672 (n61[11], n59[11], n60[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1673 (n61[12], n59[12], n60[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1674 (n61[13], n59[13], n60[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1675 (n61[14], n59[14], n60[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1676 (n61[15], n59[15], n60[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1677 (n61[16], n59[16], n60[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1678 (n61[17], n59[17], n60[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1679 (n61[18], n59[18], n60[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u168 (n71[0], n69[0], n70[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(680)
  or u1680 (n61[19], n59[19], n60[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1681 (n61[20], n59[20], n60[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1682 (n61[21], n59[21], n60[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1683 (n61[22], n59[22], n60[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1684 (n61[23], n59[23], n60[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1685 (n61[24], n59[24], n60[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1686 (n61[25], n59[25], n60[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1687 (n61[26], n59[26], n60[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1688 (n61[27], n59[27], n60[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1689 (n61[28], n59[28], n60[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u169 (n73[0], n71[0], n72[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(681)
  or u1690 (n61[29], n59[29], n60[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1691 (n61[30], n59[30], n60[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1692 (n61[31], n59[31], n60[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1693 (n61[32], n59[32], n60[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1694 (n61[33], n59[33], n60[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1695 (n61[34], n59[34], n60[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1696 (n61[35], n59[35], n60[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1697 (n61[36], n59[36], n60[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1698 (n61[37], n59[37], n60[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1699 (n61[38], n59[38], n60[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  and u17 (mrw_mepc_sel, valid, n15);  // ../../RTL/CPU/CU&RU/cu_ru.v(286)
  or u170 (n75[0], n73[0], n74[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(682)
  or u1700 (n61[39], n59[39], n60[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1701 (n61[40], n59[40], n60[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1702 (n61[41], n59[41], n60[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1703 (n61[42], n59[42], n60[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1704 (n61[43], n59[43], n60[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1705 (n61[44], n59[44], n60[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1706 (n61[45], n59[45], n60[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1707 (n61[46], n59[46], n60[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1708 (n61[47], n59[47], n60[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1709 (n61[48], n59[48], n60[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u171 (n77[0], n75[0], n76[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(683)
  or u1710 (n61[49], n59[49], n60[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1711 (n61[50], n59[50], n60[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1712 (n61[51], n59[51], n60[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1713 (n61[52], n59[52], n60[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1714 (n61[53], n59[53], n60[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1715 (n61[54], n59[54], n60[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1716 (n61[55], n59[55], n60[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1717 (n61[56], n59[56], n60[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1718 (n61[57], n59[57], n60[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1719 (n61[58], n59[58], n60[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u172 (n79[0], n77[0], n78[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(684)
  or u1720 (n61[59], n59[59], n60[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1721 (n61[60], n59[60], n60[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1722 (n61[61], n59[61], n60[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1723 (n61[62], n59[62], n60[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  or u1724 (n61[63], n59[63], n60[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(673)
  buf u1725 (vec_pc[1], tvec[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(357)
  or u173 (n81[0], n79[0], n80[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(685)
  or u174 (n83[0], n81[0], n82[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(686)
  or u175 (n85[0], n83[0], n84[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u176 (n87[0], n85[0], n86[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u177 (n89[0], n87[0], n88[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u178 (n91[0], n89[0], n90[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u179 (n93[0], n91[0], n92[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  and u18 (mrw_mcause_sel, valid, n16);  // ../../RTL/CPU/CU&RU/cu_ru.v(287)
  or u180 (n95[0], n93[0], n94[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  AL_MUX u181 (
    .i0(1'b0),
    .i1(mie),
    .sel(read_mie_sel),
    .o(n98));  // ../../RTL/CPU/CU&RU/cu_ru.v(694)
  or u182 (n97[0], n95[0], n96[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u183 (n99[0], n97[0], n98);  // ../../RTL/CPU/CU&RU/cu_ru.v(694)
  or u184 (n101[0], n99[0], n100[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u185 (n103[0], n101[0], n102[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u186 (n105[0], n103[0], n104[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u187 (n107[0], n105[0], n106[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u188 (n109[0], n107[0], n108[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u189 (n111[0], n109[0], n110[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  and u19 (mrw_mtval_sel, valid, n17);  // ../../RTL/CPU/CU&RU/cu_ru.v(288)
  or u190 (n113[0], n111[0], n112[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  AL_MUX u191 (
    .i0(1'b0),
    .i1(mcountinhibit),
    .sel(read_mcounterinhibit_sel),
    .o(n116));  // ../../RTL/CPU/CU&RU/cu_ru.v(706)
  or u192 (n115[0], n113[0], n114[0]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u193 (n113[44], n111[44], n112[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u194 (n113[45], n111[45], n112[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u195 (n113[46], n111[46], n112[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u196 (n113[47], n111[47], n112[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u197 (n113[48], n111[48], n112[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u198 (n113[49], n111[49], n112[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u199 (n113[50], n111[50], n112[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  and u2 (srw_sstatus_sel, valid, n0);  // ../../RTL/CPU/CU&RU/cu_ru.v(264)
  and u20 (mrw_mip_sel, valid, n18);  // ../../RTL/CPU/CU&RU/cu_ru.v(289)
  or u200 (n113[51], n111[51], n112[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u201 (n113[52], n111[52], n112[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u202 (n113[53], n111[53], n112[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u203 (n113[54], n111[54], n112[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u204 (n113[55], n111[55], n112[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u205 (n113[56], n111[56], n112[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u206 (n113[57], n111[57], n112[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u207 (n113[58], n111[58], n112[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u208 (n113[59], n111[59], n112[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u209 (n113[60], n111[60], n112[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  and u21 (mrw_mcycle_sel, valid, n19);  // ../../RTL/CPU/CU&RU/cu_ru.v(293)
  or u210 (n113[61], n111[61], n112[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u211 (n113[62], n111[62], n112[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u212 (n113[63], n111[63], n112[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(703)
  or u213 (n111[1], n109[1], n110[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u214 (n111[2], n109[2], n110[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u215 (n111[3], n109[3], n110[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u216 (n111[4], n109[4], n110[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u217 (n111[5], n109[5], n110[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u218 (n111[6], n109[6], n110[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u219 (n111[7], n109[7], n110[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  and u22 (mrw_mcounterinhibit_sel, valid, n20);  // ../../RTL/CPU/CU&RU/cu_ru.v(297)
  or u220 (n111[8], n109[8], n110[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u221 (n111[9], n109[9], n110[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u222 (n111[10], n109[10], n110[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u223 (n111[11], n109[11], n110[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u224 (n111[12], n109[12], n110[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u225 (n111[13], n109[13], n110[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u226 (n111[14], n109[14], n110[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u227 (n111[15], n109[15], n110[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u228 (n111[16], n109[16], n110[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u229 (n111[17], n109[17], n110[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u23 (n21, ins_acc_fault, ins_addr_mis);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u230 (n111[18], n109[18], n110[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u231 (n111[19], n109[19], n110[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u232 (n111[20], n109[20], n110[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u233 (n111[21], n109[21], n110[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u234 (n111[22], n109[22], n110[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u235 (n111[23], n109[23], n110[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u236 (n111[24], n109[24], n110[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u237 (n111[25], n109[25], n110[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u238 (n111[26], n109[26], n110[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u239 (n111[27], n109[27], n110[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u24 (n22, n21, ins_page_fault);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u240 (n111[28], n109[28], n110[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u241 (n111[29], n109[29], n110[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u242 (n111[30], n109[30], n110[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u243 (n111[31], n109[31], n110[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u244 (n111[32], n109[32], n110[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u245 (n111[33], n109[33], n110[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u246 (n111[34], n109[34], n110[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u247 (n111[35], n109[35], n110[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u248 (n111[36], n109[36], n110[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u249 (n111[37], n109[37], n110[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u25 (n23, n22, ill_ins);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u250 (n111[38], n109[38], n110[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u251 (n111[39], n109[39], n110[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u252 (n111[40], n109[40], n110[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u253 (n111[41], n109[41], n110[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u254 (n111[42], n109[42], n110[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u255 (n111[43], n109[43], n110[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u256 (n111[44], n109[44], n110[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u257 (n111[45], n109[45], n110[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u258 (n111[46], n109[46], n110[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u259 (n111[47], n109[47], n110[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u26 (n24, n23, ld_acc_fault);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u260 (n111[48], n109[48], n110[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u261 (n111[49], n109[49], n110[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u262 (n111[50], n109[50], n110[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u263 (n111[51], n109[51], n110[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u264 (n111[52], n109[52], n110[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u265 (n111[53], n109[53], n110[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u266 (n111[54], n109[54], n110[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u267 (n111[55], n109[55], n110[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u268 (n111[56], n109[56], n110[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u269 (n111[57], n109[57], n110[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u27 (n25, n24, ld_page_fault);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u270 (n111[58], n109[58], n110[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u271 (n111[59], n109[59], n110[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u272 (n111[60], n109[60], n110[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u273 (n111[61], n109[61], n110[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u274 (n111[62], n109[62], n110[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u275 (n111[63], n109[63], n110[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(701)
  or u276 (n109[1], n107[1], n108[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u277 (n109[2], n107[2], n108[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u278 (n109[3], n107[3], n108[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u279 (n109[4], n107[4], n108[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u28 (n26, n25, st_acc_fault);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u280 (n109[5], n107[5], n108[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u281 (n109[6], n107[6], n108[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u282 (n109[7], n107[7], n108[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u283 (n109[8], n107[8], n108[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u284 (n109[9], n107[9], n108[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u285 (n109[10], n107[10], n108[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u286 (n109[11], n107[11], n108[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u287 (n109[12], n107[12], n108[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u288 (n109[13], n107[13], n108[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u289 (n109[14], n107[14], n108[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u29 (n27, n26, st_page_fault);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u290 (n109[15], n107[15], n108[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u291 (n109[16], n107[16], n108[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u292 (n109[17], n107[17], n108[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u293 (n109[18], n107[18], n108[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u294 (n109[19], n107[19], n108[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u295 (n109[20], n107[20], n108[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u296 (n109[21], n107[21], n108[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u297 (n109[22], n107[22], n108[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u298 (n109[23], n107[23], n108[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u299 (n109[24], n107[24], n108[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  and u3 (srw_sie_sel, valid, n1);  // ../../RTL/CPU/CU&RU/cu_ru.v(265)
  or u30 (n28, n27, ld_addr_mis);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u300 (n109[25], n107[25], n108[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u301 (n109[26], n107[26], n108[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u302 (n109[27], n107[27], n108[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u303 (n109[28], n107[28], n108[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u304 (n109[29], n107[29], n108[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u305 (n109[30], n107[30], n108[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u306 (n109[31], n107[31], n108[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u307 (n109[32], n107[32], n108[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u308 (n109[33], n107[33], n108[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u309 (n109[34], n107[34], n108[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u31 (n29, n28, st_addr_mis);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u310 (n109[35], n107[35], n108[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u311 (n109[36], n107[36], n108[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u312 (n109[37], n107[37], n108[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u313 (n109[38], n107[38], n108[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u314 (n109[39], n107[39], n108[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u315 (n109[40], n107[40], n108[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u316 (n109[41], n107[41], n108[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u317 (n109[42], n107[42], n108[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u318 (n109[43], n107[43], n108[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u319 (n109[44], n107[44], n108[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u32 (n30, n29, ecall);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u320 (n109[45], n107[45], n108[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u321 (n109[46], n107[46], n108[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u322 (n109[47], n107[47], n108[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u323 (n109[48], n107[48], n108[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u324 (n109[49], n107[49], n108[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u325 (n109[50], n107[50], n108[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u326 (n109[51], n107[51], n108[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u327 (n109[52], n107[52], n108[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u328 (n109[53], n107[53], n108[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u329 (n109[54], n107[54], n108[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u33 (n31, n30, ebreak);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u330 (n109[55], n107[55], n108[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u331 (n109[56], n107[56], n108[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u332 (n109[57], n107[57], n108[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u333 (n109[58], n107[58], n108[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u334 (n109[59], n107[59], n108[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u335 (n109[60], n107[60], n108[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u336 (n109[61], n107[61], n108[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u337 (n109[62], n107[62], n108[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u338 (n109[63], n107[63], n108[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(700)
  or u339 (n107[1], n105[1], n106[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  and u34 (exception, valid, n31);  // ../../RTL/CPU/CU&RU/cu_ru.v(341)
  or u340 (n107[2], n105[2], n106[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u341 (n107[3], n105[3], n106[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u342 (n107[4], n105[4], n106[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u343 (n107[5], n105[5], n106[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u344 (n107[6], n105[6], n106[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u345 (n107[7], n105[7], n106[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u346 (n107[8], n105[8], n106[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u347 (n107[9], n105[9], n106[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u348 (n107[10], n105[10], n106[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u349 (n107[11], n105[11], n106[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  not u35 (n32, exception);  // ../../RTL/CPU/CU&RU/cu_ru.v(344)
  or u350 (n107[12], n105[12], n106[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u351 (n107[13], n105[13], n106[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u352 (n107[14], n105[14], n106[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u353 (n107[15], n105[15], n106[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u354 (n107[16], n105[16], n106[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u355 (n107[17], n105[17], n106[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u356 (n107[18], n105[18], n106[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u357 (n107[19], n105[19], n106[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u358 (n107[20], n105[20], n106[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u359 (n107[21], n105[21], n106[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  and u36 (n33, n32, valid);  // ../../RTL/CPU/CU&RU/cu_ru.v(344)
  or u360 (n107[22], n105[22], n106[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u361 (n107[23], n105[23], n106[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u362 (n107[24], n105[24], n106[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u363 (n107[25], n105[25], n106[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u364 (n107[26], n105[26], n106[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u365 (n107[27], n105[27], n106[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u366 (n107[28], n105[28], n106[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u367 (n107[29], n105[29], n106[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u368 (n107[30], n105[30], n106[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u369 (n107[31], n105[31], n106[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  and u37 (n34, n33, int_target_m);  // ../../RTL/CPU/CU&RU/cu_ru.v(344)
  or u370 (n107[32], n105[32], n106[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u371 (n107[33], n105[33], n106[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u372 (n107[34], n105[34], n106[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u373 (n107[35], n105[35], n106[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u374 (n107[36], n105[36], n106[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u375 (n107[37], n105[37], n106[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u376 (n107[38], n105[38], n106[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u377 (n107[39], n105[39], n106[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u378 (n107[40], n105[40], n106[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u379 (n107[41], n105[41], n106[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  and u38 (n35, n34, int_req);  // ../../RTL/CPU/CU&RU/cu_ru.v(344)
  or u380 (n107[42], n105[42], n106[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u381 (n107[43], n105[43], n106[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u382 (n107[44], n105[44], n106[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u383 (n107[45], n105[45], n106[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u384 (n107[46], n105[46], n106[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u385 (n107[47], n105[47], n106[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u386 (n107[48], n105[48], n106[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u387 (n107[49], n105[49], n106[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u388 (n107[50], n105[50], n106[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u389 (n107[51], n105[51], n106[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  and u39 (n36, n35, int_acc);  // ../../RTL/CPU/CU&RU/cu_ru.v(344)
  or u390 (n107[52], n105[52], n106[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u391 (n107[53], n105[53], n106[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u392 (n107[54], n105[54], n106[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u393 (n107[55], n105[55], n106[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u394 (n107[56], n105[56], n106[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u395 (n107[57], n105[57], n106[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u396 (n107[58], n105[58], n106[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u397 (n107[59], n105[59], n106[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u398 (n107[60], n105[60], n106[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u399 (n107[61], n105[61], n106[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  and u4 (srw_stvec_sel, valid, n2);  // ../../RTL/CPU/CU&RU/cu_ru.v(266)
  and u40 (n37, valid, exc_target_m);  // ../../RTL/CPU/CU&RU/cu_ru.v(344)
  or u400 (n107[62], n105[62], n106[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u401 (n107[63], n105[63], n106[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(699)
  or u402 (n105[1], n103[1], n104[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u403 (n105[2], n103[2], n104[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u404 (n105[3], n103[3], n104[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u405 (n105[4], n103[4], n104[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u406 (n105[5], n103[5], n104[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u407 (n105[6], n103[6], n104[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u408 (n105[7], n103[7], n104[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u409 (n105[8], n103[8], n104[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u41 (trap_target_m, n36, n37);  // ../../RTL/CPU/CU&RU/cu_ru.v(344)
  or u410 (n105[9], n103[9], n104[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u411 (n105[10], n103[10], n104[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u412 (n105[11], n103[11], n104[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u413 (n105[12], n103[12], n104[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u414 (n105[13], n103[13], n104[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u415 (n105[14], n103[14], n104[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u416 (n105[15], n103[15], n104[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u417 (n105[16], n103[16], n104[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u418 (n105[17], n103[17], n104[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u419 (n105[18], n103[18], n104[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  and u42 (n38, n33, int_target_s);  // ../../RTL/CPU/CU&RU/cu_ru.v(345)
  or u420 (n105[19], n103[19], n104[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u421 (n105[20], n103[20], n104[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u422 (n105[21], n103[21], n104[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u423 (n105[22], n103[22], n104[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u424 (n105[23], n103[23], n104[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u425 (n105[24], n103[24], n104[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u426 (n105[25], n103[25], n104[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u427 (n105[26], n103[26], n104[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u428 (n105[27], n103[27], n104[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u429 (n105[28], n103[28], n104[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  and u43 (n39, n38, int_req);  // ../../RTL/CPU/CU&RU/cu_ru.v(345)
  or u430 (n105[29], n103[29], n104[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u431 (n105[30], n103[30], n104[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u432 (n105[31], n103[31], n104[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u433 (n105[32], n103[32], n104[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u434 (n105[33], n103[33], n104[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u435 (n105[34], n103[34], n104[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u436 (n105[35], n103[35], n104[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u437 (n105[36], n103[36], n104[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u438 (n105[37], n103[37], n104[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u439 (n105[38], n103[38], n104[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  and u44 (n40, n39, int_acc);  // ../../RTL/CPU/CU&RU/cu_ru.v(345)
  or u440 (n105[39], n103[39], n104[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u441 (n105[40], n103[40], n104[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u442 (n105[41], n103[41], n104[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u443 (n105[42], n103[42], n104[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u444 (n105[43], n103[43], n104[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u445 (n105[44], n103[44], n104[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u446 (n105[45], n103[45], n104[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u447 (n105[46], n103[46], n104[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u448 (n105[47], n103[47], n104[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u449 (n105[48], n103[48], n104[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  and u45 (n41, valid, exc_target_s);  // ../../RTL/CPU/CU&RU/cu_ru.v(345)
  or u450 (n105[49], n103[49], n104[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u451 (n105[50], n103[50], n104[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u452 (n105[51], n103[51], n104[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u453 (n105[52], n103[52], n104[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u454 (n105[53], n103[53], n104[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u455 (n105[54], n103[54], n104[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u456 (n105[55], n103[55], n104[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u457 (n105[56], n103[56], n104[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u458 (n105[57], n103[57], n104[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u459 (n105[58], n103[58], n104[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u46 (trap_target_s, n40, n41);  // ../../RTL/CPU/CU&RU/cu_ru.v(345)
  or u460 (n105[59], n103[59], n104[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u461 (n105[60], n103[60], n104[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u462 (n105[61], n103[61], n104[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u463 (n105[62], n103[62], n104[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u464 (n105[63], n103[63], n104[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(698)
  or u465 (n103[1], n101[1], n102[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u466 (n103[2], n101[2], n102[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u467 (n103[3], n101[3], n102[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u468 (n103[4], n101[4], n102[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u469 (n103[5], n101[5], n102[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u47 (n42, ebreak, int_target_m);  // ../../RTL/CPU/CU&RU/cu_ru.v(349)
  or u470 (n103[6], n101[6], n102[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u471 (n103[7], n101[7], n102[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u472 (n103[8], n101[8], n102[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u473 (n103[9], n101[9], n102[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u474 (n103[10], n101[10], n102[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u475 (n103[11], n101[11], n102[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u476 (n103[12], n101[12], n102[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u477 (n103[13], n101[13], n102[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u478 (n103[14], n101[14], n102[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u479 (n103[15], n101[15], n102[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u48 (next_pc, n42, int_target_s);  // ../../RTL/CPU/CU&RU/cu_ru.v(349)
  or u480 (n103[16], n101[16], n102[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u481 (n103[17], n101[17], n102[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u482 (n103[18], n101[18], n102[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u483 (n103[19], n101[19], n102[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u484 (n103[20], n101[20], n102[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u485 (n103[21], n101[21], n102[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u486 (n103[22], n101[22], n102[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u487 (n103[23], n101[23], n102[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u488 (n103[24], n101[24], n102[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u489 (n103[25], n101[25], n102[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u49 (csr_data[1], n113[1], n114[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u490 (n103[26], n101[26], n102[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u491 (n103[27], n101[27], n102[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u492 (n103[28], n101[28], n102[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u493 (n103[29], n101[29], n102[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u494 (n103[30], n101[30], n102[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u495 (n103[31], n101[31], n102[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u496 (n103[32], n101[32], n102[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u497 (n103[33], n101[33], n102[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u498 (n103[34], n101[34], n102[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u499 (n103[35], n101[35], n102[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  and u5 (srw_sscratch_sel, valid, n3);  // ../../RTL/CPU/CU&RU/cu_ru.v(268)
  or u50 (csr_data[2], n113[2], n114[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u500 (n103[36], n101[36], n102[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u501 (n103[37], n101[37], n102[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u502 (n103[38], n101[38], n102[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u503 (n103[39], n101[39], n102[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u504 (n103[40], n101[40], n102[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u505 (n103[41], n101[41], n102[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u506 (n103[42], n101[42], n102[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u507 (n103[43], n101[43], n102[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u508 (n103[44], n101[44], n102[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u509 (n103[45], n101[45], n102[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u51 (csr_data[3], n113[3], n114[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u510 (n103[46], n101[46], n102[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u511 (n103[47], n101[47], n102[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u512 (n103[48], n101[48], n102[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u513 (n103[49], n101[49], n102[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u514 (n103[50], n101[50], n102[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u515 (n103[51], n101[51], n102[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u516 (n103[52], n101[52], n102[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u517 (n103[53], n101[53], n102[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u518 (n103[54], n101[54], n102[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u519 (n103[55], n101[55], n102[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u52 (csr_data[4], n113[4], n114[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u520 (n103[56], n101[56], n102[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u521 (n103[57], n101[57], n102[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u522 (n103[58], n101[58], n102[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u523 (n103[59], n101[59], n102[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u524 (n103[60], n101[60], n102[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u525 (n103[61], n101[61], n102[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u526 (n103[62], n101[62], n102[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u527 (n103[63], n101[63], n102[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(697)
  or u528 (n101[1], n97[1], n100[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u529 (n101[2], n97[2], n100[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u53 (csr_data[5], n113[5], n114[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u530 (n101[3], n97[3], n100[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u531 (n101[4], n97[4], n100[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u532 (n101[5], n97[5], n100[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u533 (n101[6], n97[6], n100[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u534 (n101[7], n97[7], n100[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u535 (n101[8], n97[8], n100[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u536 (n101[9], n97[9], n100[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u537 (n101[10], n97[10], n100[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u538 (n101[11], n97[11], n100[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u539 (n101[12], n97[12], n100[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u54 (csr_data[6], n113[6], n114[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u540 (n101[13], n97[13], n100[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u541 (n101[14], n97[14], n100[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u542 (n101[15], n97[15], n100[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u543 (n101[16], n97[16], n100[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u544 (n101[17], n97[17], n100[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u545 (n101[18], n97[18], n100[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u546 (n101[19], n97[19], n100[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u547 (n101[20], n97[20], n100[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u548 (n101[21], n97[21], n100[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u549 (n101[22], n97[22], n100[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u55 (csr_data[7], n113[7], n114[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u550 (n101[23], n97[23], n100[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u551 (n101[24], n97[24], n100[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u552 (n101[25], n97[25], n100[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u553 (n101[26], n97[26], n100[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u554 (n101[27], n97[27], n100[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u555 (n101[28], n97[28], n100[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u556 (n101[29], n97[29], n100[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u557 (n101[30], n97[30], n100[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u558 (n101[31], n97[31], n100[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u559 (n101[32], n97[32], n100[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u56 (csr_data[8], n113[8], n114[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u560 (n101[33], n97[33], n100[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u561 (n101[34], n97[34], n100[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u562 (n101[35], n97[35], n100[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u563 (n101[36], n97[36], n100[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u564 (n101[37], n97[37], n100[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u565 (n101[38], n97[38], n100[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u566 (n101[39], n97[39], n100[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u567 (n101[40], n97[40], n100[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u568 (n101[41], n97[41], n100[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u569 (n101[42], n97[42], n100[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u57 (csr_data[9], n113[9], n114[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u570 (n101[43], n97[43], n100[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u571 (n101[44], n97[44], n100[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u572 (n101[45], n97[45], n100[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u573 (n101[46], n97[46], n100[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u574 (n101[47], n97[47], n100[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u575 (n101[48], n97[48], n100[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u576 (n101[49], n97[49], n100[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u577 (n101[50], n97[50], n100[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u578 (n101[51], n97[51], n100[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u579 (n101[52], n97[52], n100[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u58 (csr_data[10], n113[10], n114[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u580 (n101[53], n97[53], n100[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u581 (n101[54], n97[54], n100[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u582 (n101[55], n97[55], n100[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u583 (n101[56], n97[56], n100[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u584 (n101[57], n97[57], n100[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u585 (n101[58], n97[58], n100[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u586 (n101[59], n97[59], n100[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u587 (n101[60], n97[60], n100[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u588 (n101[61], n97[61], n100[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u589 (n101[62], n97[62], n100[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u59 (csr_data[11], n113[11], n114[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u590 (n101[63], n97[63], n100[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(695)
  or u591 (n97[1], n95[1], n96[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u592 (n97[2], n95[2], n96[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u593 (n97[3], n95[3], n96[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u594 (n97[4], n95[4], n96[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u595 (n97[5], n95[5], n96[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u596 (n97[6], n95[6], n96[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u597 (n97[7], n95[7], n96[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u598 (n97[8], n95[8], n96[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u599 (n97[9], n95[9], n96[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  and u6 (srw_sepc_sel, valid, n4);  // ../../RTL/CPU/CU&RU/cu_ru.v(269)
  or u60 (csr_data[12], n113[12], n114[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u600 (n97[10], n95[10], n96[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u601 (n97[11], n95[11], n96[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u602 (n97[12], n95[12], n96[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u603 (n97[13], n95[13], n96[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u604 (n97[14], n95[14], n96[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u605 (n97[15], n95[15], n96[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u606 (n97[16], n95[16], n96[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u607 (n97[17], n95[17], n96[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u608 (n97[18], n95[18], n96[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u609 (n97[19], n95[19], n96[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u61 (csr_data[13], n113[13], n114[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u610 (n97[20], n95[20], n96[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u611 (n97[21], n95[21], n96[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u612 (n97[22], n95[22], n96[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u613 (n97[23], n95[23], n96[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u614 (n97[24], n95[24], n96[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u615 (n97[25], n95[25], n96[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u616 (n97[26], n95[26], n96[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u617 (n97[27], n95[27], n96[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u618 (n97[28], n95[28], n96[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u619 (n97[29], n95[29], n96[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u62 (csr_data[14], n113[14], n114[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u620 (n97[30], n95[30], n96[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u621 (n97[31], n95[31], n96[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u622 (n97[32], n95[32], n96[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u623 (n97[33], n95[33], n96[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u624 (n97[34], n95[34], n96[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u625 (n97[35], n95[35], n96[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u626 (n97[36], n95[36], n96[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u627 (n97[37], n95[37], n96[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u628 (n97[38], n95[38], n96[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u629 (n97[39], n95[39], n96[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u63 (csr_data[15], n113[15], n114[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u630 (n97[40], n95[40], n96[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u631 (n97[41], n95[41], n96[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u632 (n97[42], n95[42], n96[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u633 (n97[43], n95[43], n96[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u634 (n97[44], n95[44], n96[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u635 (n97[45], n95[45], n96[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u636 (n97[46], n95[46], n96[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u637 (n97[47], n95[47], n96[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u638 (n97[48], n95[48], n96[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u639 (n97[49], n95[49], n96[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u64 (csr_data[16], n113[16], n114[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u640 (n97[50], n95[50], n96[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u641 (n97[51], n95[51], n96[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u642 (n97[52], n95[52], n96[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u643 (n97[53], n95[53], n96[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u644 (n97[54], n95[54], n96[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u645 (n97[55], n95[55], n96[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u646 (n97[56], n95[56], n96[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u647 (n97[57], n95[57], n96[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u648 (n97[58], n95[58], n96[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u649 (n97[59], n95[59], n96[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u65 (csr_data[17], n113[17], n114[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u650 (n97[60], n95[60], n96[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u651 (n97[61], n95[61], n96[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u652 (n97[62], n95[62], n96[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u653 (n97[63], n95[63], n96[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(693)
  or u654 (n95[1], n93[1], n94[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u655 (n95[2], n93[2], n94[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u656 (n95[3], n93[3], n94[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u657 (n95[4], n93[4], n94[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u658 (n95[5], n93[5], n94[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u659 (n95[6], n93[6], n94[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u66 (csr_data[18], n113[18], n114[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u660 (n95[7], n93[7], n94[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u661 (n95[8], n93[8], n94[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u662 (n95[9], n93[9], n94[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u663 (n95[10], n93[10], n94[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u664 (n95[11], n93[11], n94[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u665 (n95[12], n93[12], n94[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u666 (n95[13], n93[13], n94[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u667 (n95[14], n93[14], n94[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u668 (n95[15], n93[15], n94[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u669 (n95[16], n93[16], n94[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u67 (csr_data[19], n113[19], n114[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u670 (n95[17], n93[17], n94[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u671 (n95[18], n93[18], n94[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u672 (n95[19], n93[19], n94[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u673 (n95[20], n93[20], n94[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u674 (n95[21], n93[21], n94[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u675 (n95[22], n93[22], n94[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u676 (n95[23], n93[23], n94[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u677 (n95[24], n93[24], n94[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u678 (n95[25], n93[25], n94[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u679 (n95[26], n93[26], n94[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u68 (csr_data[20], n113[20], n114[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u680 (n95[27], n93[27], n94[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u681 (n95[28], n93[28], n94[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u682 (n95[29], n93[29], n94[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u683 (n95[30], n93[30], n94[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u684 (n95[31], n93[31], n94[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u685 (n95[32], n93[32], n94[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u686 (n95[33], n93[33], n94[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u687 (n95[34], n93[34], n94[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u688 (n95[35], n93[35], n94[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u689 (n95[36], n93[36], n94[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u69 (csr_data[21], n113[21], n114[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u690 (n95[37], n93[37], n94[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u691 (n95[38], n93[38], n94[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u692 (n95[39], n93[39], n94[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u693 (n95[40], n93[40], n94[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u694 (n95[41], n93[41], n94[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u695 (n95[42], n93[42], n94[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u696 (n95[43], n93[43], n94[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u697 (n95[44], n93[44], n94[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u698 (n95[45], n93[45], n94[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u699 (n95[46], n93[46], n94[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  and u7 (srw_scause_sel, valid, n5);  // ../../RTL/CPU/CU&RU/cu_ru.v(270)
  or u70 (csr_data[22], n113[22], n114[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u700 (n95[47], n93[47], n94[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u701 (n95[48], n93[48], n94[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u702 (n95[49], n93[49], n94[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u703 (n95[50], n93[50], n94[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u704 (n95[51], n93[51], n94[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u705 (n95[52], n93[52], n94[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u706 (n95[53], n93[53], n94[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u707 (n95[54], n93[54], n94[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u708 (n95[55], n93[55], n94[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u709 (n95[56], n93[56], n94[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u71 (csr_data[23], n113[23], n114[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u710 (n95[57], n93[57], n94[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u711 (n95[58], n93[58], n94[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u712 (n95[59], n93[59], n94[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u713 (n95[60], n93[60], n94[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u714 (n95[61], n93[61], n94[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u715 (n95[62], n93[62], n94[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u716 (n95[63], n93[63], n94[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(692)
  or u717 (n93[1], n91[1], n92[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u718 (n93[2], n91[2], n92[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u719 (n93[3], n91[3], n92[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u72 (csr_data[24], n113[24], n114[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u720 (n93[4], n91[4], n92[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u721 (n93[5], n91[5], n92[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u722 (n93[6], n91[6], n92[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u723 (n93[7], n91[7], n92[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u724 (n93[8], n91[8], n92[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u725 (n93[9], n91[9], n92[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u726 (n93[10], n91[10], n92[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u727 (n93[11], n91[11], n92[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u728 (n93[12], n91[12], n92[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u729 (n93[13], n91[13], n92[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u73 (csr_data[25], n113[25], n114[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u730 (n93[14], n91[14], n92[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u731 (n93[15], n91[15], n92[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u732 (n93[16], n91[16], n92[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u733 (n93[17], n91[17], n92[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u734 (n93[18], n91[18], n92[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u735 (n93[19], n91[19], n92[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u736 (n93[20], n91[20], n92[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u737 (n93[21], n91[21], n92[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u738 (n93[22], n91[22], n92[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u739 (n93[23], n91[23], n92[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u74 (csr_data[26], n113[26], n114[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u740 (n93[24], n91[24], n92[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u741 (n93[25], n91[25], n92[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u742 (n93[26], n91[26], n92[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u743 (n93[27], n91[27], n92[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u744 (n93[28], n91[28], n92[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u745 (n93[29], n91[29], n92[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u746 (n93[30], n91[30], n92[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u747 (n93[31], n91[31], n92[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u748 (n93[32], n91[32], n92[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u749 (n93[33], n91[33], n92[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u75 (csr_data[27], n113[27], n114[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u750 (n93[34], n91[34], n92[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u751 (n93[35], n91[35], n92[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u752 (n93[36], n91[36], n92[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u753 (n93[37], n91[37], n92[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u754 (n93[38], n91[38], n92[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u755 (n93[39], n91[39], n92[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u756 (n93[40], n91[40], n92[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u757 (n93[41], n91[41], n92[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u758 (n93[42], n91[42], n92[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u759 (n93[43], n91[43], n92[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u76 (csr_data[28], n113[28], n114[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u760 (n93[44], n91[44], n92[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u761 (n93[45], n91[45], n92[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u762 (n93[46], n91[46], n92[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u763 (n93[47], n91[47], n92[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u764 (n93[48], n91[48], n92[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u765 (n93[49], n91[49], n92[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u766 (n93[50], n91[50], n92[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u767 (n93[51], n91[51], n92[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u768 (n93[52], n91[52], n92[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u769 (n93[53], n91[53], n92[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u77 (csr_data[29], n113[29], n114[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u770 (n93[54], n91[54], n92[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u771 (n93[55], n91[55], n92[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u772 (n93[56], n91[56], n92[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u773 (n93[57], n91[57], n92[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u774 (n93[58], n91[58], n92[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u775 (n93[59], n91[59], n92[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u776 (n93[60], n91[60], n92[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u777 (n93[61], n91[61], n92[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u778 (n93[62], n91[62], n92[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u779 (n93[63], n91[63], n92[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(691)
  or u78 (csr_data[30], n113[30], n114[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u780 (n91[1], n89[1], n90[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u781 (n91[2], n89[2], n90[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u782 (n91[3], n89[3], n90[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u783 (n91[4], n89[4], n90[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u784 (n91[5], n89[5], n90[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u785 (n91[6], n89[6], n90[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u786 (n91[7], n89[7], n90[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u787 (n91[8], n89[8], n90[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u788 (n91[9], n89[9], n90[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u789 (n91[10], n89[10], n90[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u79 (csr_data[31], n113[31], n114[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u790 (n91[11], n89[11], n90[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u791 (n91[12], n89[12], n90[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u792 (n91[13], n89[13], n90[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u793 (n91[14], n89[14], n90[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u794 (n91[15], n89[15], n90[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u795 (n91[16], n89[16], n90[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u796 (n91[17], n89[17], n90[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u797 (n91[18], n89[18], n90[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u798 (n91[19], n89[19], n90[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u799 (n91[20], n89[20], n90[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  and u8 (srw_stval_sel, valid, n6);  // ../../RTL/CPU/CU&RU/cu_ru.v(271)
  or u80 (csr_data[32], n113[32], n114[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u800 (n91[21], n89[21], n90[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u801 (n91[22], n89[22], n90[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u802 (n91[23], n89[23], n90[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u803 (n91[24], n89[24], n90[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u804 (n91[25], n89[25], n90[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u805 (n91[26], n89[26], n90[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u806 (n91[27], n89[27], n90[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u807 (n91[28], n89[28], n90[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u808 (n91[29], n89[29], n90[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u809 (n91[30], n89[30], n90[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u81 (csr_data[33], n113[33], n114[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u810 (n91[31], n89[31], n90[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u811 (n91[32], n89[32], n90[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u812 (n91[33], n89[33], n90[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u813 (n91[34], n89[34], n90[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u814 (n91[35], n89[35], n90[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u815 (n91[36], n89[36], n90[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u816 (n91[37], n89[37], n90[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u817 (n91[38], n89[38], n90[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u818 (n91[39], n89[39], n90[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u819 (n91[40], n89[40], n90[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u82 (csr_data[34], n113[34], n114[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u820 (n91[41], n89[41], n90[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u821 (n91[42], n89[42], n90[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u822 (n91[43], n89[43], n90[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u823 (n91[44], n89[44], n90[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u824 (n91[45], n89[45], n90[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u825 (n91[46], n89[46], n90[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u826 (n91[47], n89[47], n90[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u827 (n91[48], n89[48], n90[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u828 (n91[49], n89[49], n90[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u829 (n91[50], n89[50], n90[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u83 (csr_data[35], n113[35], n114[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u830 (n91[51], n89[51], n90[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u831 (n91[52], n89[52], n90[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u832 (n91[53], n89[53], n90[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u833 (n91[54], n89[54], n90[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u834 (n91[55], n89[55], n90[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u835 (n91[56], n89[56], n90[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u836 (n91[57], n89[57], n90[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u837 (n91[58], n89[58], n90[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u838 (n91[59], n89[59], n90[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u839 (n91[60], n89[60], n90[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u84 (csr_data[36], n113[36], n114[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u840 (n91[61], n89[61], n90[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u841 (n91[62], n89[62], n90[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u842 (n91[63], n89[63], n90[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(690)
  or u843 (n89[1], n87[1], n88[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u844 (n89[2], n87[2], n88[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u845 (n89[3], n87[3], n88[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u846 (n89[4], n87[4], n88[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u847 (n89[5], n87[5], n88[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u848 (n89[6], n87[6], n88[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u849 (n89[7], n87[7], n88[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u85 (csr_data[37], n113[37], n114[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u850 (n89[8], n87[8], n88[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u851 (n89[9], n87[9], n88[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u852 (n89[10], n87[10], n88[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u853 (n89[11], n87[11], n88[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u854 (n89[12], n87[12], n88[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u855 (n89[13], n87[13], n88[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u856 (n89[14], n87[14], n88[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u857 (n89[15], n87[15], n88[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u858 (n89[16], n87[16], n88[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u859 (n89[17], n87[17], n88[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u86 (csr_data[38], n113[38], n114[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u860 (n89[18], n87[18], n88[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u861 (n89[19], n87[19], n88[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u862 (n89[20], n87[20], n88[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u863 (n89[21], n87[21], n88[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u864 (n89[22], n87[22], n88[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u865 (n89[23], n87[23], n88[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u866 (n89[24], n87[24], n88[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u867 (n89[25], n87[25], n88[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u868 (n89[26], n87[26], n88[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u869 (n89[27], n87[27], n88[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u87 (csr_data[39], n113[39], n114[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u870 (n89[28], n87[28], n88[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u871 (n89[29], n87[29], n88[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u872 (n89[30], n87[30], n88[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u873 (n89[31], n87[31], n88[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u874 (n89[32], n87[32], n88[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u875 (n89[33], n87[33], n88[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u876 (n89[34], n87[34], n88[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u877 (n89[35], n87[35], n88[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u878 (n89[36], n87[36], n88[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u879 (n89[37], n87[37], n88[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u88 (csr_data[40], n113[40], n114[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u880 (n89[38], n87[38], n88[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u881 (n89[39], n87[39], n88[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u882 (n89[40], n87[40], n88[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u883 (n89[41], n87[41], n88[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u884 (n89[42], n87[42], n88[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u885 (n89[43], n87[43], n88[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u886 (n89[44], n87[44], n88[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u887 (n89[45], n87[45], n88[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u888 (n89[46], n87[46], n88[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u889 (n89[47], n87[47], n88[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u89 (csr_data[41], n113[41], n114[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u890 (n89[48], n87[48], n88[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u891 (n89[49], n87[49], n88[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u892 (n89[50], n87[50], n88[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u893 (n89[51], n87[51], n88[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u894 (n89[52], n87[52], n88[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u895 (n89[53], n87[53], n88[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u896 (n89[54], n87[54], n88[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u897 (n89[55], n87[55], n88[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u898 (n89[56], n87[56], n88[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u899 (n89[57], n87[57], n88[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  and u9 (srw_sip_sel, valid, n7);  // ../../RTL/CPU/CU&RU/cu_ru.v(272)
  or u90 (csr_data[42], n113[42], n114[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u900 (n89[58], n87[58], n88[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u901 (n89[59], n87[59], n88[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u902 (n89[60], n87[60], n88[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u903 (n89[61], n87[61], n88[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u904 (n89[62], n87[62], n88[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u905 (n89[63], n87[63], n88[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(689)
  or u906 (n87[1], n85[1], n86[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u907 (n87[2], n85[2], n86[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u908 (n87[3], n85[3], n86[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u909 (n87[4], n85[4], n86[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u91 (csr_data[43], n113[43], n114[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u910 (n87[5], n85[5], n86[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u911 (n87[6], n85[6], n86[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u912 (n87[7], n85[7], n86[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u913 (n87[8], n85[8], n86[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u914 (n87[9], n85[9], n86[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u915 (n87[10], n85[10], n86[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u916 (n87[11], n85[11], n86[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u917 (n87[12], n85[12], n86[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u918 (n87[13], n85[13], n86[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u919 (n87[14], n85[14], n86[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u92 (csr_data[44], n113[44], n114[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u920 (n87[15], n85[15], n86[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u921 (n87[16], n85[16], n86[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u922 (n87[17], n85[17], n86[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u923 (n87[18], n85[18], n86[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u924 (n87[19], n85[19], n86[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u925 (n87[20], n85[20], n86[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u926 (n87[21], n85[21], n86[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u927 (n87[22], n85[22], n86[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u928 (n87[23], n85[23], n86[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u929 (n87[24], n85[24], n86[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u93 (csr_data[45], n113[45], n114[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u930 (n87[25], n85[25], n86[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u931 (n87[26], n85[26], n86[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u932 (n87[27], n85[27], n86[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u933 (n87[28], n85[28], n86[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u934 (n87[29], n85[29], n86[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u935 (n87[30], n85[30], n86[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u936 (n87[31], n85[31], n86[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u937 (n87[32], n85[32], n86[32]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u938 (n87[33], n85[33], n86[33]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u939 (n87[34], n85[34], n86[34]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u94 (csr_data[46], n113[46], n114[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u940 (n87[35], n85[35], n86[35]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u941 (n87[36], n85[36], n86[36]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u942 (n87[37], n85[37], n86[37]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u943 (n87[38], n85[38], n86[38]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u944 (n87[39], n85[39], n86[39]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u945 (n87[40], n85[40], n86[40]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u946 (n87[41], n85[41], n86[41]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u947 (n87[42], n85[42], n86[42]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u948 (n87[43], n85[43], n86[43]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u949 (n87[44], n85[44], n86[44]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u95 (csr_data[47], n113[47], n114[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u950 (n87[45], n85[45], n86[45]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u951 (n87[46], n85[46], n86[46]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u952 (n87[47], n85[47], n86[47]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u953 (n87[48], n85[48], n86[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u954 (n87[49], n85[49], n86[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u955 (n87[50], n85[50], n86[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u956 (n87[51], n85[51], n86[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u957 (n87[52], n85[52], n86[52]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u958 (n87[53], n85[53], n86[53]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u959 (n87[54], n85[54], n86[54]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u96 (csr_data[48], n113[48], n114[48]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u960 (n87[55], n85[55], n86[55]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u961 (n87[56], n85[56], n86[56]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u962 (n87[57], n85[57], n86[57]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u963 (n87[58], n85[58], n86[58]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u964 (n87[59], n85[59], n86[59]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u965 (n87[60], n85[60], n86[60]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u966 (n87[61], n85[61], n86[61]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u967 (n87[62], n85[62], n86[62]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u968 (n87[63], n85[63], n86[63]);  // ../../RTL/CPU/CU&RU/cu_ru.v(688)
  or u969 (n85[1], n83[1], n84[1]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u97 (csr_data[49], n113[49], n114[49]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u970 (n85[2], n83[2], n84[2]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u971 (n85[3], n83[3], n84[3]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u972 (n85[4], n83[4], n84[4]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u973 (n85[5], n83[5], n84[5]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u974 (n85[6], n83[6], n84[6]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u975 (n85[7], n83[7], n84[7]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u976 (n85[8], n83[8], n84[8]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u977 (n85[9], n83[9], n84[9]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u978 (n85[10], n83[10], n84[10]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u979 (n85[11], n83[11], n84[11]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u98 (csr_data[50], n113[50], n114[50]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u980 (n85[12], n83[12], n84[12]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u981 (n85[13], n83[13], n84[13]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u982 (n85[14], n83[14], n84[14]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u983 (n85[15], n83[15], n84[15]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u984 (n85[16], n83[16], n84[16]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u985 (n85[17], n83[17], n84[17]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u986 (n85[18], n83[18], n84[18]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u987 (n85[19], n83[19], n84[19]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u988 (n85[20], n83[20], n84[20]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u989 (n85[21], n83[21], n84[21]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u99 (csr_data[51], n113[51], n114[51]);  // ../../RTL/CPU/CU&RU/cu_ru.v(704)
  or u990 (n85[22], n83[22], n84[22]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u991 (n85[23], n83[23], n84[23]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u992 (n85[24], n83[24], n84[24]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u993 (n85[25], n83[25], n84[25]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u994 (n85[26], n83[26], n84[26]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u995 (n85[27], n83[27], n84[27]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u996 (n85[28], n83[28], n84[28]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u997 (n85[29], n83[29], n84[29]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u998 (n85[30], n83[30], n84[30]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)
  or u999 (n85[31], n83[31], n84[31]);  // ../../RTL/CPU/CU&RU/cu_ru.v(687)

endmodule 

module exu  // ../../RTL/CPU/EX/exu.v(5)
  (
  amo,
  amo_lr_sc,
  and_clr,
  as1,
  as2,
  beq,
  bge,
  blt,
  bne,
  cache_flush,
  cache_ready_ex,
  cache_reset,
  clk,
  compare,
  csr_index_id,
  csr_write_id,
  data_read,
  ds1,
  ds1_sel,
  ds2,
  ebreak_id,
  ecall_id,
  ex_hold,
  ex_nop,
  exc_code_id,
  gpr_write_id,
  id_jmp_id,
  id_system_id,
  ill_ins_id,
  ins_acc_fault_id,
  ins_addr_mis_id,
  ins_page_fault_id,
  ins_pc_id,
  int_acc_id,
  jmp,
  load,
  load_acc_fault,
  load_page_fault,
  m_ret_id,
  mem_csr_data_add,
  mem_csr_data_and,
  mem_csr_data_ds1,
  mem_csr_data_ds2,
  mem_csr_data_max,
  mem_csr_data_min,
  mem_csr_data_or,
  mem_csr_data_xor,
  mod_priv,
  mprv,
  op_count,
  priv,
  rd_data_add,
  rd_data_and,
  rd_data_ds1,
  rd_data_or,
  rd_data_slt,
  rd_data_sub,
  rd_data_xor,
  rd_index_id,
  rs1_index_id,
  rs2_index_id,
  rst,
  s_ret_id,
  shift_l,
  shift_r,
  size,
  store,
  store_acc_fault,
  store_page_fault,
  uncache_data,
  uncache_data_ready,
  unsign,
  valid_id,
  addr_ex,
  cache_flush_biu,
  cache_reset_biu,
  csr_index,
  csr_write,
  data_csr,
  data_rd,
  data_write,
  ebreak,
  ecall,
  ex_exception,
  ex_priv,
  ex_ready,
  exc_code,
  gpr_write,
  id_jmp,
  id_system,
  ill_ins,
  ins_acc_fault,
  ins_addr_mis,
  ins_page_fault,
  ins_pc,
  int_acc,
  ld_acc_fault,
  ld_addr_mis,
  ld_page_fault,
  m_ret,
  new_pc,
  pc_jmp,
  rd_index,
  read,
  s_ret,
  size_biu,
  st_acc_fault,
  st_addr_mis,
  st_page_fault,
  trans_csr_index,
  trans_rd_index,
  unpage,
  valid,
  write
  );

  input amo;  // ../../RTL/CPU/EX/exu.v(57)
  input amo_lr_sc;  // ../../RTL/CPU/EX/exu.v(30)
  input and_clr;  // ../../RTL/CPU/EX/exu.v(48)
  input [63:0] as1;  // ../../RTL/CPU/EX/exu.v(74)
  input [63:0] as2;  // ../../RTL/CPU/EX/exu.v(75)
  input beq;  // ../../RTL/CPU/EX/exu.v(44)
  input bge;  // ../../RTL/CPU/EX/exu.v(43)
  input blt;  // ../../RTL/CPU/EX/exu.v(42)
  input bne;  // ../../RTL/CPU/EX/exu.v(45)
  input cache_flush;  // ../../RTL/CPU/EX/exu.v(58)
  input cache_ready_ex;  // ../../RTL/CPU/EX/exu.v(146)
  input cache_reset;  // ../../RTL/CPU/EX/exu.v(59)
  input clk;  // ../../RTL/CPU/EX/exu.v(6)
  input compare;  // ../../RTL/CPU/EX/exu.v(29)
  input [11:0] csr_index_id;  // ../../RTL/CPU/EX/exu.v(66)
  input csr_write_id;  // ../../RTL/CPU/EX/exu.v(64)
  input [63:0] data_read;  // ../../RTL/CPU/EX/exu.v(134)
  input [63:0] ds1;  // ../../RTL/CPU/EX/exu.v(72)
  input ds1_sel;  // ../../RTL/CPU/EX/exu.v(49)
  input [63:0] ds2;  // ../../RTL/CPU/EX/exu.v(73)
  input ebreak_id;  // ../../RTL/CPU/EX/exu.v(90)
  input ecall_id;  // ../../RTL/CPU/EX/exu.v(89)
  input ex_hold;  // ../../RTL/CPU/EX/exu.v(158)
  input ex_nop;  // ../../RTL/CPU/EX/exu.v(159)
  input [63:0] exc_code_id;  // ../../RTL/CPU/EX/exu.v(16)
  input gpr_write_id;  // ../../RTL/CPU/EX/exu.v(65)
  input id_jmp_id;  // ../../RTL/CPU/EX/exu.v(80)
  input id_system_id;  // ../../RTL/CPU/EX/exu.v(79)
  input ill_ins_id;  // ../../RTL/CPU/EX/exu.v(86)
  input ins_acc_fault_id;  // ../../RTL/CPU/EX/exu.v(81)
  input ins_addr_mis_id;  // ../../RTL/CPU/EX/exu.v(82)
  input ins_page_fault_id;  // ../../RTL/CPU/EX/exu.v(83)
  input [63:0] ins_pc_id;  // ../../RTL/CPU/EX/exu.v(18)
  input int_acc_id;  // ../../RTL/CPU/EX/exu.v(84)
  input jmp;  // ../../RTL/CPU/EX/exu.v(46)
  input load;  // ../../RTL/CPU/EX/exu.v(55)
  input load_acc_fault;  // ../../RTL/CPU/EX/exu.v(142)
  input load_page_fault;  // ../../RTL/CPU/EX/exu.v(143)
  input m_ret_id;  // ../../RTL/CPU/EX/exu.v(87)
  input mem_csr_data_add;  // ../../RTL/CPU/EX/exu.v(35)
  input mem_csr_data_and;  // ../../RTL/CPU/EX/exu.v(36)
  input mem_csr_data_ds1;  // ../../RTL/CPU/EX/exu.v(33)
  input mem_csr_data_ds2;  // ../../RTL/CPU/EX/exu.v(34)
  input mem_csr_data_max;  // ../../RTL/CPU/EX/exu.v(39)
  input mem_csr_data_min;  // ../../RTL/CPU/EX/exu.v(40)
  input mem_csr_data_or;  // ../../RTL/CPU/EX/exu.v(37)
  input mem_csr_data_xor;  // ../../RTL/CPU/EX/exu.v(38)
  input [3:0] mod_priv;  // ../../RTL/CPU/EX/exu.v(12)
  input mprv;  // ../../RTL/CPU/EX/exu.v(11)
  input [7:0] op_count;  // ../../RTL/CPU/EX/exu.v(76)
  input [3:0] priv;  // ../../RTL/CPU/EX/exu.v(9)
  input rd_data_add;  // ../../RTL/CPU/EX/exu.v(23)
  input rd_data_and;  // ../../RTL/CPU/EX/exu.v(25)
  input rd_data_ds1;  // ../../RTL/CPU/EX/exu.v(22)
  input rd_data_or;  // ../../RTL/CPU/EX/exu.v(26)
  input rd_data_slt;  // ../../RTL/CPU/EX/exu.v(28)
  input rd_data_sub;  // ../../RTL/CPU/EX/exu.v(24)
  input rd_data_xor;  // ../../RTL/CPU/EX/exu.v(27)
  input [4:0] rd_index_id;  // ../../RTL/CPU/EX/exu.v(69)
  input [4:0] rs1_index_id;  // ../../RTL/CPU/EX/exu.v(67)
  input [4:0] rs2_index_id;  // ../../RTL/CPU/EX/exu.v(68)
  input rst;  // ../../RTL/CPU/EX/exu.v(7)
  input s_ret_id;  // ../../RTL/CPU/EX/exu.v(88)
  input shift_l;  // ../../RTL/CPU/EX/exu.v(61)
  input shift_r;  // ../../RTL/CPU/EX/exu.v(60)
  input [3:0] size;  // ../../RTL/CPU/EX/exu.v(52)
  input store;  // ../../RTL/CPU/EX/exu.v(56)
  input store_acc_fault;  // ../../RTL/CPU/EX/exu.v(144)
  input store_page_fault;  // ../../RTL/CPU/EX/exu.v(145)
  input [63:0] uncache_data;  // ../../RTL/CPU/EX/exu.v(135)
  input uncache_data_ready;  // ../../RTL/CPU/EX/exu.v(147)
  input unsign;  // ../../RTL/CPU/EX/exu.v(47)
  input valid_id;  // ../../RTL/CPU/EX/exu.v(85)
  output [63:0] addr_ex;  // ../../RTL/CPU/EX/exu.v(132)
  output cache_flush_biu;  // ../../RTL/CPU/EX/exu.v(137)
  output cache_reset_biu;  // ../../RTL/CPU/EX/exu.v(138)
  output [11:0] csr_index;  // ../../RTL/CPU/EX/exu.v(102)
  output csr_write;  // ../../RTL/CPU/EX/exu.v(99)
  output [63:0] data_csr;  // ../../RTL/CPU/EX/exu.v(96)
  output [63:0] data_rd;  // ../../RTL/CPU/EX/exu.v(95)
  output [63:0] data_write;  // ../../RTL/CPU/EX/exu.v(133)
  output ebreak;  // ../../RTL/CPU/EX/exu.v(126)
  output ecall;  // ../../RTL/CPU/EX/exu.v(125)
  output ex_exception;  // ../../RTL/CPU/EX/exu.v(155)
  output [3:0] ex_priv;  // ../../RTL/CPU/EX/exu.v(131)
  output ex_ready;  // ../../RTL/CPU/EX/exu.v(156)
  output [63:0] exc_code;  // ../../RTL/CPU/EX/exu.v(106)
  output gpr_write;  // ../../RTL/CPU/EX/exu.v(100)
  output id_jmp;  // ../../RTL/CPU/EX/exu.v(110)
  output id_system;  // ../../RTL/CPU/EX/exu.v(109)
  output ill_ins;  // ../../RTL/CPU/EX/exu.v(122)
  output ins_acc_fault;  // ../../RTL/CPU/EX/exu.v(111)
  output ins_addr_mis;  // ../../RTL/CPU/EX/exu.v(112)
  output ins_page_fault;  // ../../RTL/CPU/EX/exu.v(113)
  output [63:0] ins_pc;  // ../../RTL/CPU/EX/exu.v(105)
  output int_acc;  // ../../RTL/CPU/EX/exu.v(120)
  output ld_acc_fault;  // ../../RTL/CPU/EX/exu.v(116)
  output ld_addr_mis;  // ../../RTL/CPU/EX/exu.v(114)
  output ld_page_fault;  // ../../RTL/CPU/EX/exu.v(118)
  output m_ret;  // ../../RTL/CPU/EX/exu.v(123)
  output [63:0] new_pc;  // ../../RTL/CPU/EX/exu.v(97)
  output pc_jmp;  // ../../RTL/CPU/EX/exu.v(101)
  output [4:0] rd_index;  // ../../RTL/CPU/EX/exu.v(103)
  output read;  // ../../RTL/CPU/EX/exu.v(139)
  output s_ret;  // ../../RTL/CPU/EX/exu.v(124)
  output [3:0] size_biu;  // ../../RTL/CPU/EX/exu.v(136)
  output st_acc_fault;  // ../../RTL/CPU/EX/exu.v(117)
  output st_addr_mis;  // ../../RTL/CPU/EX/exu.v(115)
  output st_page_fault;  // ../../RTL/CPU/EX/exu.v(119)
  output [11:0] trans_csr_index;  // ../../RTL/CPU/EX/exu.v(153)
  output [4:0] trans_rd_index;  // ../../RTL/CPU/EX/exu.v(152)
  output unpage;  // ../../RTL/CPU/EX/exu.v(130)
  output valid;  // ../../RTL/CPU/EX/exu.v(121)
  output write;  // ../../RTL/CPU/EX/exu.v(140)

  parameter p_amo_ex1 = 4'b1010;
  parameter p_amo_mem0 = 4'b1000;
  parameter p_amo_mem01 = 4'b1001;
  parameter p_amo_mem1 = 4'b1011;
  parameter p_fence = 4'b1100;
  parameter p_load = 4'b0010;
  parameter p_load1 = 4'b0011;
  parameter p_shift = 4'b0001;
  parameter p_stb = 4'b0000;
  parameter p_store = 4'b0100;
  wire [63:0] alu_data_mem_csr;  // ../../RTL/CPU/EX/exu.v(193)
  wire [63:0] alu_data_rd;  // ../../RTL/CPU/EX/exu.v(192)
  wire [63:0] au_addr_pc;  // ../../RTL/CPU/EX/exu.v(195)
  wire [63:0] data_lsu_cache;  // ../../RTL/CPU/EX/exu.v(197)
  wire [63:0] data_lsu_uncache;  // ../../RTL/CPU/EX/exu.v(198)
  wire [3:0] main_state;  // ../../RTL/CPU/EX/exu.v(184)
  wire [3:0] n22;
  wire [3:0] n23;
  wire [3:0] n24;
  wire [3:0] n25;
  wire [3:0] n26;
  wire [1:0] n27;
  wire [2:0] n29;
  wire [2:0] n30;
  wire [1:0] n32;
  wire [3:0] n33;
  wire [3:0] n34;
  wire [3:0] n36;
  wire [3:0] n37;
  wire [3:0] n38;
  wire [3:0] n39;
  wire [3:0] n40;
  wire [3:0] n41;
  wire [3:0] n42;
  wire [3:0] n43;
  wire [3:0] n44;
  wire [3:0] n45;
  wire [3:0] n46;
  wire [3:0] n47;
  wire [7:0] n50;
  wire [7:0] n51;
  wire [7:0] n52;
  wire [7:0] n53;
  wire [31:0] n54;
  wire [64:0] n55;
  wire [32:0] n56;
  wire [63:0] n57;
  wire [63:0] n58;
  wire [63:0] n61;
  wire [63:0] n62;
  wire [63:0] n63;
  wire [63:0] n64;
  wire [63:0] n65;
  wire [63:0] n66;
  wire [63:0] n67;
  wire [63:0] n68;
  wire [63:0] n69;
  wire [63:0] n70;
  wire [63:0] n71;
  wire [63:0] n72;
  wire [63:0] n73;
  wire [63:0] n74;
  wire [63:0] n75;
  wire [11:0] n79;
  wire [4:0] n80;
  wire [11:0] n84;
  wire [4:0] n85;
  wire [7:0] shift_count;  // ../../RTL/CPU/EX/exu.v(185)
  wire amo_ready;  // ../../RTL/CPU/EX/exu.v(208)
  wire c_amo_mem0;  // ../../RTL/CPU/EX/exu.v(178)
  wire c_amo_mem01;  // ../../RTL/CPU/EX/exu.v(179)
  wire c_amo_mem1;  // ../../RTL/CPU/EX/exu.v(181)
  wire c_fence;  // ../../RTL/CPU/EX/exu.v(182)
  wire c_load;  // ../../RTL/CPU/EX/exu.v(175)
  wire c_load_1;  // ../../RTL/CPU/EX/exu.v(176)
  wire c_shift;  // ../../RTL/CPU/EX/exu.v(174)
  wire c_stb;  // ../../RTL/CPU/EX/exu.v(173)
  wire c_store;  // ../../RTL/CPU/EX/exu.v(177)
  wire exception_id;  // ../../RTL/CPU/EX/exu.v(199)
  wire fence_ready;  // ../../RTL/CPU/EX/exu.v(207)
  wire load_addr_mis;  // ../../RTL/CPU/EX/exu.v(202)
  wire load_ready;  // ../../RTL/CPU/EX/exu.v(205)
  wire n0;
  wire n1;
  wire n10;
  wire n100;
  wire n101;
  wire n102;
  wire n103;
  wire n104;
  wire n105;
  wire n106;
  wire n107;
  wire n108;
  wire n109;
  wire n11;
  wire n110;
  wire n111;
  wire n112;
  wire n113;
  wire n114;
  wire n115;
  wire n116;
  wire n117;
  wire n118;
  wire n119;
  wire n12;
  wire n120;
  wire n121;
  wire n122;
  wire n123;
  wire n124;
  wire n125;
  wire n126;
  wire n127;
  wire n128;
  wire n129;
  wire n13;
  wire n130;
  wire n131;
  wire n132;
  wire n133;
  wire n134;
  wire n135;
  wire n136;
  wire n137;
  wire n138;
  wire n139;
  wire n14;
  wire n140;
  wire n141;
  wire n142;
  wire n143;
  wire n144;
  wire n145;
  wire n146;
  wire n147;
  wire n148;
  wire n149;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n2;
  wire n20;
  wire n21;
  wire n28;
  wire n3;
  wire n31;
  wire n35;
  wire n4;
  wire n48;
  wire n49;
  wire n5;
  wire n59;
  wire n6;
  wire n60;
  wire n7;
  wire n76;
  wire n77;
  wire n78;
  wire n8;
  wire n81;
  wire n82;
  wire n83;
  wire n86;
  wire n87;
  wire n88;
  wire n89;
  wire n9;
  wire n90;
  wire n91;
  wire n92;
  wire n93;
  wire n94;
  wire n95;
  wire n96;
  wire n97;
  wire n98;
  wire n99;
  wire shift_multi_ready;  // ../../RTL/CPU/EX/exu.v(209)
  wire shift_ready;  // ../../RTL/CPU/EX/exu.v(188)
  wire store_addr_mis;  // ../../RTL/CPU/EX/exu.v(203)
  wire store_ready;  // ../../RTL/CPU/EX/exu.v(206)

  alu_au alu_au (
    .amo_lr_sc(amo_lr_sc),
    .and_clr(and_clr),
    .as1(as1),
    .as2(as2),
    .beq(beq),
    .bge(bge),
    .blt(blt),
    .bne(bne),
    .compare(compare),
    .ds1(ds1),
    .ds2(ds2),
    .jmp(jmp),
    .mem_csr_data_add(mem_csr_data_add),
    .mem_csr_data_and(mem_csr_data_and),
    .mem_csr_data_ds1(mem_csr_data_ds1),
    .mem_csr_data_ds2(mem_csr_data_ds2),
    .mem_csr_data_max(mem_csr_data_max),
    .mem_csr_data_min(mem_csr_data_min),
    .mem_csr_data_or(mem_csr_data_or),
    .mem_csr_data_xor(mem_csr_data_xor),
    .rd_data_add(rd_data_add),
    .rd_data_and(rd_data_and),
    .rd_data_ds1(rd_data_ds1),
    .rd_data_or(rd_data_or),
    .rd_data_slt(rd_data_slt),
    .rd_data_sub(rd_data_sub),
    .rd_data_xor(rd_data_xor),
    .size(size),
    .unsign(unsign),
    .alu_data_mem_csr(alu_data_mem_csr),
    .alu_data_rd(alu_data_rd),
    .au_addr_pc(au_addr_pc));  // ../../RTL/CPU/EX/exu.v(456)
  AL_DFF csr_write_reg (
    .clk(clk),
    .d(n81),
    .reset(1'b0),
    .set(1'b0),
    .q(csr_write));  // ../../RTL/CPU/EX/exu.v(383)
  AL_DFF ebreak_reg (
    .clk(clk),
    .d(n131),
    .reset(1'b0),
    .set(1'b0),
    .q(ebreak));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF ecall_reg (
    .clk(clk),
    .d(n130),
    .reset(1'b0),
    .set(1'b0),
    .q(ecall));  // ../../RTL/CPU/EX/exu.v(448)
  eq_w3 eq0 (
    .i0(au_addr_pc[2:0]),
    .i1(3'b111),
    .o(n1));  // ../../RTL/CPU/EX/exu.v(211)
  eq_w4 eq1 (
    .i0(main_state),
    .i1(4'b0001),
    .o(c_shift));  // ../../RTL/CPU/EX/exu.v(215)
  eq_w4 eq10 (
    .i0(main_state),
    .i1(4'b1011),
    .o(c_amo_mem1));  // ../../RTL/CPU/EX/exu.v(264)
  eq_w4 eq11 (
    .i0(main_state),
    .i1(4'b0011),
    .o(c_load_1));  // ../../RTL/CPU/EX/exu.v(272)
  eq_w4 eq12 (
    .i0(mod_priv),
    .i1(4'b0011),
    .o(n148));  // ../../RTL/CPU/EX/exu.v(506)
  eq_w8 eq2 (
    .i0(shift_count),
    .i1(8'b00000001),
    .o(n9));  // ../../RTL/CPU/EX/exu.v(215)
  eq_w4 eq3 (
    .i0(main_state),
    .i1(4'b0000),
    .o(c_stb));  // ../../RTL/CPU/EX/exu.v(235)
  eq_w4 eq4 (
    .i0(main_state),
    .i1(4'b0010),
    .o(c_load));  // ../../RTL/CPU/EX/exu.v(243)
  eq_w4 eq5 (
    .i0(main_state),
    .i1(4'b0100),
    .o(c_store));  // ../../RTL/CPU/EX/exu.v(246)
  eq_w4 eq6 (
    .i0(main_state),
    .i1(4'b1000),
    .o(c_amo_mem0));  // ../../RTL/CPU/EX/exu.v(252)
  eq_w4 eq7 (
    .i0(main_state),
    .i1(4'b1100),
    .o(c_fence));  // ../../RTL/CPU/EX/exu.v(255)
  eq_w4 eq8 (
    .i0(main_state),
    .i1(4'b1010),
    .o(n35));  // ../../RTL/CPU/EX/exu.v(258)
  eq_w4 eq9 (
    .i0(main_state),
    .i1(4'b1001),
    .o(c_amo_mem01));  // ../../RTL/CPU/EX/exu.v(261)
  AL_DFF gpr_write_reg (
    .clk(clk),
    .d(n82),
    .reset(1'b0),
    .set(1'b0),
    .q(gpr_write));  // ../../RTL/CPU/EX/exu.v(383)
  AL_DFF id_jmp_reg (
    .clk(clk),
    .d(n115),
    .reset(1'b0),
    .set(1'b0),
    .q(id_jmp));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF id_system_reg (
    .clk(clk),
    .d(n114),
    .reset(1'b0),
    .set(1'b0),
    .q(id_system));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF ill_ins_reg (
    .clk(clk),
    .d(n127),
    .reset(1'b0),
    .set(1'b0),
    .q(ill_ins));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF ins_acc_fault_reg (
    .clk(clk),
    .d(n116),
    .reset(1'b0),
    .set(1'b0),
    .q(ins_acc_fault));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF ins_addr_mis_reg (
    .clk(clk),
    .d(n117),
    .reset(1'b0),
    .set(1'b0),
    .q(ins_addr_mis));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF ins_page_fault_reg (
    .clk(clk),
    .d(n118),
    .reset(1'b0),
    .set(1'b0),
    .q(ins_page_fault));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF int_acc_reg (
    .clk(clk),
    .d(n125),
    .reset(1'b0),
    .set(1'b0),
    .q(int_acc));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF ld_acc_fault_reg (
    .clk(clk),
    .d(n121),
    .reset(1'b0),
    .set(1'b0),
    .q(ld_acc_fault));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF ld_addr_mis_reg (
    .clk(clk),
    .d(n119),
    .reset(1'b0),
    .set(1'b0),
    .q(ld_addr_mis));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF ld_page_fault_reg (
    .clk(clk),
    .d(n123),
    .reset(1'b0),
    .set(1'b0),
    .q(ld_page_fault));  // ../../RTL/CPU/EX/exu.v(448)
  lsu lsu (
    .addr({1'b0,au_addr_pc[1:0]}),
    .data_in(alu_data_mem_csr),
    .data_read(data_read),
    .size(size),
    .uncache_data(uncache_data),
    .unsign(unsign),
    .data_lsu_cache(data_lsu_cache),
    .data_lsu_uncache(data_lsu_uncache),
    .data_write(data_write));  // ../../RTL/CPU/EX/exu.v(522)
  AL_DFF m_ret_reg (
    .clk(clk),
    .d(n128),
    .reset(1'b0),
    .set(1'b0),
    .q(m_ret));  // ../../RTL/CPU/EX/exu.v(448)
  binary_mux_s1_w4 mux0 (
    .i0(main_state),
    .i1(4'b1100),
    .sel(n21),
    .o(n22));  // ../../RTL/CPU/EX/exu.v(240)
  binary_mux_s1_w4 mux1 (
    .i0(n22),
    .i1(4'b1000),
    .sel(amo),
    .o(n23));  // ../../RTL/CPU/EX/exu.v(240)
  binary_mux_s1_w4 mux10 (
    .i0({n29[2],1'b0,n29[2],n29[2]}),
    .i1(4'b0000),
    .sel(ex_exception),
    .o(n36));  // ../../RTL/CPU/EX/exu.v(265)
  binary_mux_s1_w4 mux11 (
    .i0(main_state),
    .i1(n36),
    .sel(c_amo_mem1),
    .o(n37));  // ../../RTL/CPU/EX/exu.v(266)
  binary_mux_s1_w4 mux12 (
    .i0(n37),
    .i1(4'b1010),
    .sel(c_amo_mem01),
    .o(n38));  // ../../RTL/CPU/EX/exu.v(266)
  binary_mux_s1_w4 mux13 (
    .i0(n38),
    .i1(4'b1011),
    .sel(n35),
    .o(n39));  // ../../RTL/CPU/EX/exu.v(266)
  binary_mux_s1_w4 mux14 (
    .i0(n39),
    .i1(n34),
    .sel(c_fence),
    .o(n40));  // ../../RTL/CPU/EX/exu.v(266)
  binary_mux_s1_w4 mux15 (
    .i0(n40),
    .i1(n33),
    .sel(c_amo_mem0),
    .o(n41));  // ../../RTL/CPU/EX/exu.v(266)
  binary_mux_s1_w4 mux16 (
    .i0(n41),
    .i1({3'b000,n31}),
    .sel(c_shift),
    .o(n42));  // ../../RTL/CPU/EX/exu.v(266)
  binary_mux_s1_w4 mux17 (
    .i0(n42),
    .i1({1'b0,n30}),
    .sel(c_store),
    .o(n43));  // ../../RTL/CPU/EX/exu.v(266)
  binary_mux_s1_w4 mux18 (
    .i0(n43),
    .i1({2'b00,n27}),
    .sel(c_load),
    .o(n44));  // ../../RTL/CPU/EX/exu.v(266)
  binary_mux_s1_w4 mux19 (
    .i0(n44),
    .i1(n26),
    .sel(n19),
    .o(n45));  // ../../RTL/CPU/EX/exu.v(266)
  binary_mux_s1_w4 mux2 (
    .i0(n23),
    .i1(4'b0001),
    .sel(n20),
    .o(n24));  // ../../RTL/CPU/EX/exu.v(240)
  binary_mux_s1_w4 mux20 (
    .i0(n45),
    .i1(main_state),
    .sel(ex_nop),
    .o(n46));  // ../../RTL/CPU/EX/exu.v(266)
  binary_mux_s1_w4 mux21 (
    .i0(n46),
    .i1(4'b0000),
    .sel(rst),
    .o(n47));  // ../../RTL/CPU/EX/exu.v(266)
  binary_mux_s1_w8 mux22 (
    .i0(shift_count),
    .i1(n50),
    .sel(c_shift),
    .o(n51));  // ../../RTL/CPU/EX/exu.v(289)
  binary_mux_s1_w8 mux23 (
    .i0(n51),
    .i1(op_count),
    .sel(n49),
    .o(n52));  // ../../RTL/CPU/EX/exu.v(289)
  binary_mux_s1_w8 mux24 (
    .i0(n52),
    .i1(8'b00000000),
    .sel(rst),
    .o(n53));  // ../../RTL/CPU/EX/exu.v(289)
  binary_mux_s1_w32 mux25 (
    .i0(data_rd[62:31]),
    .i1(data_rd[63:32]),
    .sel(size[2]),
    .o(n54));  // ../../RTL/CPU/EX/exu.v(303)
  binary_mux_s1_w65 mux26 (
    .i0({data_rd[63:32],1'b0,data_rd[63:32]}),
    .i1({data_rd[62:31],data_rd[63:32],1'b0}),
    .sel(size[2]),
    .o(n55));  // ../../RTL/CPU/EX/exu.v(310)
  binary_mux_s1_w64 mux27 (
    .i0(data_rd),
    .i1({n56,data_rd[31:1]}),
    .sel(shift_r),
    .o(n57));  // ../../RTL/CPU/EX/exu.v(312)
  binary_mux_s1_w64 mux28 (
    .i0(n57),
    .i1({n54,data_rd[30:0],1'b0}),
    .sel(shift_l),
    .o(n58));  // ../../RTL/CPU/EX/exu.v(312)
  binary_mux_s1_w64 mux29 (
    .i0(data_rd),
    .i1(data_lsu_cache),
    .sel(n60),
    .o(n61));  // ../../RTL/CPU/EX/exu.v(326)
  binary_mux_s1_w4 mux3 (
    .i0(n24),
    .i1(4'b0100),
    .sel(store),
    .o(n25));  // ../../RTL/CPU/EX/exu.v(240)
  binary_mux_s1_w64 mux30 (
    .i0(n61),
    .i1(data_lsu_uncache),
    .sel(n59),
    .o(n62));  // ../../RTL/CPU/EX/exu.v(326)
  binary_mux_s1_w64 mux31 (
    .i0(n62),
    .i1(alu_data_rd),
    .sel(c_stb),
    .o(n63));  // ../../RTL/CPU/EX/exu.v(326)
  binary_mux_s1_w64 mux32 (
    .i0(n63),
    .i1(n58),
    .sel(c_shift),
    .o(n64));  // ../../RTL/CPU/EX/exu.v(326)
  binary_mux_s1_w64 mux33 (
    .i0(n64),
    .i1(data_rd),
    .sel(ex_hold),
    .o(n65));  // ../../RTL/CPU/EX/exu.v(326)
  binary_mux_s1_w64 mux34 (
    .i0(n65),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n66));  // ../../RTL/CPU/EX/exu.v(326)
  binary_mux_s1_w64 mux35 (
    .i0(alu_data_mem_csr),
    .i1(data_csr),
    .sel(ex_hold),
    .o(n67));  // ../../RTL/CPU/EX/exu.v(341)
  binary_mux_s1_w64 mux36 (
    .i0(au_addr_pc),
    .i1(new_pc),
    .sel(ex_hold),
    .o(n68));  // ../../RTL/CPU/EX/exu.v(341)
  binary_mux_s1_w64 mux37 (
    .i0(n67),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n69));  // ../../RTL/CPU/EX/exu.v(341)
  binary_mux_s1_w64 mux38 (
    .i0(n68),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n70));  // ../../RTL/CPU/EX/exu.v(341)
  binary_mux_s1_w64 mux39 (
    .i0(exc_code_id),
    .i1(au_addr_pc),
    .sel(ex_exception),
    .o(n71));  // ../../RTL/CPU/EX/exu.v(356)
  binary_mux_s1_w4 mux4 (
    .i0(n25),
    .i1(4'b0010),
    .sel(load),
    .o(n26));  // ../../RTL/CPU/EX/exu.v(240)
  binary_mux_s1_w64 mux40 (
    .i0(ins_pc_id),
    .i1(ins_pc),
    .sel(ex_hold),
    .o(n72));  // ../../RTL/CPU/EX/exu.v(357)
  binary_mux_s1_w64 mux41 (
    .i0(n71),
    .i1(exc_code),
    .sel(ex_hold),
    .o(n73));  // ../../RTL/CPU/EX/exu.v(357)
  binary_mux_s1_w64 mux42 (
    .i0(n72),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n74));  // ../../RTL/CPU/EX/exu.v(357)
  binary_mux_s1_w64 mux43 (
    .i0(n73),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n75));  // ../../RTL/CPU/EX/exu.v(357)
  binary_mux_s1_w12 mux44 (
    .i0(csr_index_id),
    .i1(csr_index),
    .sel(ex_hold),
    .o(n79));  // ../../RTL/CPU/EX/exu.v(382)
  binary_mux_s1_w5 mux45 (
    .i0(rd_index_id),
    .i1(rd_index),
    .sel(ex_hold),
    .o(n80));  // ../../RTL/CPU/EX/exu.v(382)
  binary_mux_s1_w12 mux46 (
    .i0(n79),
    .i1(12'b000000000000),
    .sel(rst),
    .o(n84));  // ../../RTL/CPU/EX/exu.v(382)
  binary_mux_s1_w5 mux47 (
    .i0(n80),
    .i1(5'b00000),
    .sel(rst),
    .o(n85));  // ../../RTL/CPU/EX/exu.v(382)
  binary_mux_s1_w33 mux48 (
    .i0({data_rd[63],n55[64:33]}),
    .i1(n55[32:0]),
    .sel(unsign),
    .o(n56));  // ../../RTL/CPU/EX/exu.v(311)
  binary_mux_s1_w4 mux49 (
    .i0(priv),
    .i1(mod_priv),
    .sel(unpage),
    .o(ex_priv));  // ../../RTL/CPU/EX/exu.v(507)
  binary_mux_s1_w2 mux5 (
    .i0({1'b1,cache_ready_ex}),
    .i1(2'b00),
    .sel(uncache_data_ready),
    .o(n27));  // ../../RTL/CPU/EX/exu.v(244)
  binary_mux_s1_w3 mux6 (
    .i0({n29[2],2'b00}),
    .i1(3'b000),
    .sel(ex_exception),
    .o(n30));  // ../../RTL/CPU/EX/exu.v(247)
  binary_mux_s1_w2 mux7 (
    .i0({1'b0,cache_ready_ex}),
    .i1(2'b10),
    .sel(uncache_data_ready),
    .o(n32));  // ../../RTL/CPU/EX/exu.v(253)
  binary_mux_s1_w4 mux8 (
    .i0({2'b10,n32}),
    .i1(4'b0000),
    .sel(ex_exception),
    .o(n33));  // ../../RTL/CPU/EX/exu.v(253)
  binary_mux_s1_w4 mux9 (
    .i0({n29[2],n29[2],2'b00}),
    .i1(4'b0000),
    .sel(ex_exception),
    .o(n34));  // ../../RTL/CPU/EX/exu.v(256)
  ne_w2 neq0 (
    .i0(au_addr_pc[1:0]),
    .i1(2'b00),
    .o(n3));  // ../../RTL/CPU/EX/exu.v(211)
  ne_w3 neq1 (
    .i0(au_addr_pc[2:0]),
    .i1(3'b000),
    .o(n6));  // ../../RTL/CPU/EX/exu.v(211)
  AL_DFF pc_jmp_reg (
    .clk(clk),
    .d(n83),
    .reset(1'b0),
    .set(1'b0),
    .q(pc_jmp));  // ../../RTL/CPU/EX/exu.v(383)
  reg_ar_as_w8 reg0 (
    .clk(clk),
    .d(n53),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(shift_count));  // ../../RTL/CPU/EX/exu.v(290)
  reg_ar_as_w64 reg1 (
    .clk(clk),
    .d(n66),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(data_rd));  // ../../RTL/CPU/EX/exu.v(327)
  reg_ar_as_w64 reg2 (
    .clk(clk),
    .d(n69),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(data_csr));  // ../../RTL/CPU/EX/exu.v(342)
  reg_ar_as_w64 reg3 (
    .clk(clk),
    .d(n70),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(new_pc));  // ../../RTL/CPU/EX/exu.v(342)
  reg_ar_as_w64 reg4 (
    .clk(clk),
    .d(n74),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(ins_pc));  // ../../RTL/CPU/EX/exu.v(358)
  reg_ar_as_w64 reg5 (
    .clk(clk),
    .d(n75),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(exc_code));  // ../../RTL/CPU/EX/exu.v(358)
  reg_ar_as_w12 reg6 (
    .clk(clk),
    .d(n84),
    .reset(12'b000000000000),
    .set(12'b000000000000),
    .q(csr_index));  // ../../RTL/CPU/EX/exu.v(383)
  reg_ar_as_w5 reg7 (
    .clk(clk),
    .d(n85),
    .reset(5'b00000),
    .set(5'b00000),
    .q(rd_index));  // ../../RTL/CPU/EX/exu.v(383)
  reg_ar_as_w4 reg8 (
    .clk(clk),
    .d(n47),
    .reset(4'b0000),
    .set(4'b0000),
    .q(main_state));  // ../../RTL/CPU/EX/exu.v(268)
  AL_DFF s_ret_reg (
    .clk(clk),
    .d(n129),
    .reset(1'b0),
    .set(1'b0),
    .q(s_ret));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF st_acc_fault_reg (
    .clk(clk),
    .d(n122),
    .reset(1'b0),
    .set(1'b0),
    .q(st_acc_fault));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF st_addr_mis_reg (
    .clk(clk),
    .d(n120),
    .reset(1'b0),
    .set(1'b0),
    .q(st_addr_mis));  // ../../RTL/CPU/EX/exu.v(448)
  AL_DFF st_page_fault_reg (
    .clk(clk),
    .d(n124),
    .reset(1'b0),
    .set(1'b0),
    .q(st_page_fault));  // ../../RTL/CPU/EX/exu.v(448)
  add_pu8_mu8_o8 sub0 (
    .i0(shift_count),
    .i1(8'b00000001),
    .o(n50));  // ../../RTL/CPU/EX/exu.v(288)
  and u10 (load_addr_mis, n0, n8);  // ../../RTL/CPU/EX/exu.v(211)
  or u100 (n60, c_load_1, c_amo_mem01);  // ../../RTL/CPU/EX/exu.v(324)
  AL_MUX u101 (
    .i0(csr_write_id),
    .i1(csr_write),
    .sel(ex_hold),
    .o(n76));  // ../../RTL/CPU/EX/exu.v(382)
  AL_MUX u102 (
    .i0(gpr_write_id),
    .i1(gpr_write),
    .sel(ex_hold),
    .o(n77));  // ../../RTL/CPU/EX/exu.v(382)
  AL_MUX u103 (
    .i0(jmp),
    .i1(pc_jmp),
    .sel(ex_hold),
    .o(n78));  // ../../RTL/CPU/EX/exu.v(382)
  AL_MUX u104 (
    .i0(n76),
    .i1(1'b0),
    .sel(rst),
    .o(n81));  // ../../RTL/CPU/EX/exu.v(382)
  AL_MUX u105 (
    .i0(n77),
    .i1(1'b0),
    .sel(rst),
    .o(n82));  // ../../RTL/CPU/EX/exu.v(382)
  AL_MUX u106 (
    .i0(n78),
    .i1(1'b0),
    .sel(rst),
    .o(n83));  // ../../RTL/CPU/EX/exu.v(382)
  or u107 (n86, rst, ex_nop);  // ../../RTL/CPU/EX/exu.v(388)
  and u108 (n87, c_amo_mem0, load_addr_mis);  // ../../RTL/CPU/EX/exu.v(435)
  or u109 (n88, n87, store_addr_mis);  // ../../RTL/CPU/EX/exu.v(435)
  buf u11 (addr_ex[26], au_addr_pc[26]);  // ../../RTL/CPU/EX/exu.v(508)
  and u110 (n89, c_amo_mem0, load_acc_fault);  // ../../RTL/CPU/EX/exu.v(437)
  or u111 (n90, n89, store_acc_fault);  // ../../RTL/CPU/EX/exu.v(437)
  and u112 (n91, c_amo_mem0, load_page_fault);  // ../../RTL/CPU/EX/exu.v(439)
  or u113 (n92, n91, store_page_fault);  // ../../RTL/CPU/EX/exu.v(439)
  or u114 (n93, ex_ready, ex_exception);  // ../../RTL/CPU/EX/exu.v(441)
  or u115 (n94, n93, exception_id);  // ../../RTL/CPU/EX/exu.v(441)
  and u116 (n95, valid_id, n94);  // ../../RTL/CPU/EX/exu.v(441)
  AL_MUX u117 (
    .i0(id_system_id),
    .i1(id_system),
    .sel(ex_hold),
    .o(n96));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u118 (
    .i0(id_jmp_id),
    .i1(id_jmp),
    .sel(ex_hold),
    .o(n97));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u119 (
    .i0(ins_acc_fault_id),
    .i1(ins_acc_fault),
    .sel(ex_hold),
    .o(n98));  // ../../RTL/CPU/EX/exu.v(447)
  buf u12 (addr_ex[25], au_addr_pc[25]);  // ../../RTL/CPU/EX/exu.v(508)
  AL_MUX u120 (
    .i0(ins_addr_mis_id),
    .i1(ins_addr_mis),
    .sel(ex_hold),
    .o(n99));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u121 (
    .i0(ins_page_fault_id),
    .i1(ins_page_fault),
    .sel(ex_hold),
    .o(n100));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u122 (
    .i0(load_addr_mis),
    .i1(ins_addr_mis),
    .sel(ex_hold),
    .o(n101));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u123 (
    .i0(n88),
    .i1(st_addr_mis),
    .sel(ex_hold),
    .o(n102));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u124 (
    .i0(load_acc_fault),
    .i1(ld_acc_fault),
    .sel(ex_hold),
    .o(n103));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u125 (
    .i0(n90),
    .i1(st_acc_fault),
    .sel(ex_hold),
    .o(n104));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u126 (
    .i0(load_page_fault),
    .i1(ld_page_fault),
    .sel(ex_hold),
    .o(n105));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u127 (
    .i0(n92),
    .i1(st_page_fault),
    .sel(ex_hold),
    .o(n106));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u128 (
    .i0(int_acc_id),
    .i1(int_acc),
    .sel(ex_hold),
    .o(n107));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u129 (
    .i0(n95),
    .i1(valid),
    .sel(ex_hold),
    .o(n108));  // ../../RTL/CPU/EX/exu.v(447)
  buf u13 (addr_ex[24], au_addr_pc[24]);  // ../../RTL/CPU/EX/exu.v(508)
  AL_MUX u130 (
    .i0(ill_ins_id),
    .i1(ill_ins),
    .sel(ex_hold),
    .o(n109));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u131 (
    .i0(m_ret_id),
    .i1(m_ret),
    .sel(ex_hold),
    .o(n110));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u132 (
    .i0(s_ret_id),
    .i1(s_ret),
    .sel(ex_hold),
    .o(n111));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u133 (
    .i0(ecall_id),
    .i1(ecall),
    .sel(ex_hold),
    .o(n112));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u134 (
    .i0(ebreak_id),
    .i1(ebreak),
    .sel(ex_hold),
    .o(n113));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u135 (
    .i0(n96),
    .i1(1'b0),
    .sel(n86),
    .o(n114));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u136 (
    .i0(n97),
    .i1(1'b0),
    .sel(n86),
    .o(n115));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u137 (
    .i0(n98),
    .i1(1'b0),
    .sel(n86),
    .o(n116));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u138 (
    .i0(n99),
    .i1(1'b0),
    .sel(n86),
    .o(n117));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u139 (
    .i0(n100),
    .i1(1'b0),
    .sel(n86),
    .o(n118));  // ../../RTL/CPU/EX/exu.v(447)
  buf u14 (addr_ex[23], au_addr_pc[23]);  // ../../RTL/CPU/EX/exu.v(508)
  AL_MUX u140 (
    .i0(n101),
    .i1(1'b0),
    .sel(n86),
    .o(n119));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u141 (
    .i0(n102),
    .i1(1'b0),
    .sel(n86),
    .o(n120));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u142 (
    .i0(n103),
    .i1(1'b0),
    .sel(n86),
    .o(n121));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u143 (
    .i0(n104),
    .i1(1'b0),
    .sel(n86),
    .o(n122));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u144 (
    .i0(n105),
    .i1(1'b0),
    .sel(n86),
    .o(n123));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u145 (
    .i0(n106),
    .i1(1'b0),
    .sel(n86),
    .o(n124));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u146 (
    .i0(n107),
    .i1(1'b0),
    .sel(n86),
    .o(n125));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u147 (
    .i0(n108),
    .i1(1'b0),
    .sel(n86),
    .o(n126));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u148 (
    .i0(n109),
    .i1(1'b0),
    .sel(n86),
    .o(n127));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u149 (
    .i0(n110),
    .i1(1'b0),
    .sel(n86),
    .o(n128));  // ../../RTL/CPU/EX/exu.v(447)
  buf u15 (addr_ex[22], au_addr_pc[22]);  // ../../RTL/CPU/EX/exu.v(508)
  AL_MUX u150 (
    .i0(n111),
    .i1(1'b0),
    .sel(n86),
    .o(n129));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u151 (
    .i0(n112),
    .i1(1'b0),
    .sel(n86),
    .o(n130));  // ../../RTL/CPU/EX/exu.v(447)
  AL_MUX u152 (
    .i0(n113),
    .i1(1'b0),
    .sel(n86),
    .o(n131));  // ../../RTL/CPU/EX/exu.v(447)
  or u153 (n132, load, store);  // ../../RTL/CPU/EX/exu.v(451)
  or u154 (n133, n132, amo);  // ../../RTL/CPU/EX/exu.v(451)
  or u155 (n134, n133, cache_flush);  // ../../RTL/CPU/EX/exu.v(451)
  or u156 (n135, n134, cache_reset);  // ../../RTL/CPU/EX/exu.v(451)
  or u157 (n136, n135, shift_l);  // ../../RTL/CPU/EX/exu.v(451)
  or u158 (n137, n136, shift_r);  // ../../RTL/CPU/EX/exu.v(451)
  not u159 (n138, n137);  // ../../RTL/CPU/EX/exu.v(451)
  buf u16 (addr_ex[21], au_addr_pc[21]);  // ../../RTL/CPU/EX/exu.v(508)
  and u160 (n139, load, load_ready);  // ../../RTL/CPU/EX/exu.v(452)
  or u161 (n140, n138, n139);  // ../../RTL/CPU/EX/exu.v(452)
  and u162 (n141, store, store_ready);  // ../../RTL/CPU/EX/exu.v(452)
  or u163 (n142, n140, n141);  // ../../RTL/CPU/EX/exu.v(452)
  and u164 (n143, amo, amo_ready);  // ../../RTL/CPU/EX/exu.v(452)
  or u165 (n144, n142, n143);  // ../../RTL/CPU/EX/exu.v(452)
  buf u166 (addr_ex[1], au_addr_pc[1]);  // ../../RTL/CPU/EX/exu.v(508)
  and u167 (n145, n21, fence_ready);  // ../../RTL/CPU/EX/exu.v(453)
  or u168 (n146, n144, n145);  // ../../RTL/CPU/EX/exu.v(453)
  buf u169 (size_biu[3], size[3]);  // ../../RTL/CPU/EX/exu.v(511)
  buf u17 (addr_ex[20], au_addr_pc[20]);  // ../../RTL/CPU/EX/exu.v(508)
  and u170 (n147, n20, shift_multi_ready);  // ../../RTL/CPU/EX/exu.v(453)
  or u171 (ex_ready, n146, n147);  // ../../RTL/CPU/EX/exu.v(453)
  and u172 (unpage, mprv, n148);  // ../../RTL/CPU/EX/exu.v(506)
  buf u173 (addr_ex[0], au_addr_pc[0]);  // ../../RTL/CPU/EX/exu.v(508)
  and u174 (cache_flush_biu, cache_flush, c_fence);  // ../../RTL/CPU/EX/exu.v(512)
  and u175 (cache_reset_biu, cache_reset, c_fence);  // ../../RTL/CPU/EX/exu.v(513)
  buf u176 (size_biu[2], size[2]);  // ../../RTL/CPU/EX/exu.v(511)
  and u177 (read, load, n59);  // ../../RTL/CPU/EX/exu.v(514)
  or u178 (n149, c_amo_mem1, c_store);  // ../../RTL/CPU/EX/exu.v(515)
  and u179 (write, store, n149);  // ../../RTL/CPU/EX/exu.v(515)
  buf u18 (addr_ex[19], au_addr_pc[19]);  // ../../RTL/CPU/EX/exu.v(508)
  and u19 (store_addr_mis, store, n8);  // ../../RTL/CPU/EX/exu.v(212)
  buf u2 (addr_ex[30], au_addr_pc[30]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u20 (addr_ex[28], au_addr_pc[28]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u21 (size_biu[0], size[0]);  // ../../RTL/CPU/EX/exu.v(511)
  buf u22 (addr_ex[18], au_addr_pc[18]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u23 (size_biu[1], size[1]);  // ../../RTL/CPU/EX/exu.v(511)
  and u24 (shift_ready, c_shift, n9);  // ../../RTL/CPU/EX/exu.v(215)
  and u25 (n10, c_load, uncache_data_ready);  // ../../RTL/CPU/EX/exu.v(217)
  or u26 (load_ready, n10, c_load_1);  // ../../RTL/CPU/EX/exu.v(217)
  and u27 (store_ready, c_store, cache_ready_ex);  // ../../RTL/CPU/EX/exu.v(218)
  and u28 (fence_ready, c_fence, cache_ready_ex);  // ../../RTL/CPU/EX/exu.v(219)
  and u29 (amo_ready, c_amo_mem1, cache_ready_ex);  // ../../RTL/CPU/EX/exu.v(220)
  buf u3 (addr_ex[29], au_addr_pc[29]);  // ../../RTL/CPU/EX/exu.v(508)
  and u30 (shift_multi_ready, c_shift, shift_ready);  // ../../RTL/CPU/EX/exu.v(221)
  or u31 (n11, ins_acc_fault_id, ins_addr_mis_id);  // ../../RTL/CPU/EX/exu.v(223)
  or u32 (n12, n11, ins_page_fault_id);  // ../../RTL/CPU/EX/exu.v(223)
  or u33 (exception_id, n12, ill_ins_id);  // ../../RTL/CPU/EX/exu.v(223)
  or u34 (n13, load_acc_fault, load_page_fault);  // ../../RTL/CPU/EX/exu.v(224)
  or u35 (n14, n13, store_acc_fault);  // ../../RTL/CPU/EX/exu.v(224)
  or u36 (n15, n14, store_page_fault);  // ../../RTL/CPU/EX/exu.v(224)
  or u37 (n16, n15, load_addr_mis);  // ../../RTL/CPU/EX/exu.v(224)
  or u38 (ex_exception, n16, store_addr_mis);  // ../../RTL/CPU/EX/exu.v(224)
  not u39 (n17, exception_id);  // ../../RTL/CPU/EX/exu.v(235)
  or u4 (n0, amo, load);  // ../../RTL/CPU/EX/exu.v(211)
  and u40 (n18, valid_id, n17);  // ../../RTL/CPU/EX/exu.v(235)
  and u41 (n19, n18, c_stb);  // ../../RTL/CPU/EX/exu.v(235)
  or u42 (n20, shift_l, shift_r);  // ../../RTL/CPU/EX/exu.v(238)
  or u43 (n21, cache_flush, cache_reset);  // ../../RTL/CPU/EX/exu.v(240)
  or u44 (n28, cache_ready_ex, uncache_data_ready);  // ../../RTL/CPU/EX/exu.v(247)
  buf u45 (addr_ex[17], au_addr_pc[17]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u46 (addr_ex[16], au_addr_pc[16]);  // ../../RTL/CPU/EX/exu.v(508)
  not u47 (n31, shift_ready);  // ../../RTL/CPU/EX/exu.v(250)
  buf u48 (addr_ex[15], au_addr_pc[15]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u49 (addr_ex[14], au_addr_pc[14]);  // ../../RTL/CPU/EX/exu.v(508)
  and u5 (n2, size[1], n1);  // ../../RTL/CPU/EX/exu.v(211)
  buf u50 (addr_ex[13], au_addr_pc[13]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u51 (addr_ex[27], au_addr_pc[27]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u52 (addr_ex[12], au_addr_pc[12]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u53 (addr_ex[11], au_addr_pc[11]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u54 (addr_ex[10], au_addr_pc[10]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u55 (addr_ex[9], au_addr_pc[9]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u56 (addr_ex[8], au_addr_pc[8]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u57 (addr_ex[7], au_addr_pc[7]);  // ../../RTL/CPU/EX/exu.v(508)
  not u58 (n29[2], n28);  // ../../RTL/CPU/EX/exu.v(247)
  buf u59 (addr_ex[6], au_addr_pc[6]);  // ../../RTL/CPU/EX/exu.v(508)
  and u6 (n4, size[2], n3);  // ../../RTL/CPU/EX/exu.v(211)
  buf u60 (addr_ex[5], au_addr_pc[5]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u61 (addr_ex[4], au_addr_pc[4]);  // ../../RTL/CPU/EX/exu.v(508)
  and u62 (n48, c_stb, valid_id);  // ../../RTL/CPU/EX/exu.v(284)
  buf u63 (addr_ex[3], au_addr_pc[3]);  // ../../RTL/CPU/EX/exu.v(508)
  and u64 (n49, n48, n20);  // ../../RTL/CPU/EX/exu.v(284)
  buf u65 (addr_ex[2], au_addr_pc[2]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u66 (addr_ex[31], au_addr_pc[31]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u67 (addr_ex[32], au_addr_pc[32]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u68 (addr_ex[33], au_addr_pc[33]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u69 (addr_ex[34], au_addr_pc[34]);  // ../../RTL/CPU/EX/exu.v(508)
  or u7 (n5, n2, n4);  // ../../RTL/CPU/EX/exu.v(211)
  buf u70 (addr_ex[35], au_addr_pc[35]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u71 (addr_ex[36], au_addr_pc[36]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u72 (addr_ex[37], au_addr_pc[37]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u73 (addr_ex[38], au_addr_pc[38]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u74 (addr_ex[39], au_addr_pc[39]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u75 (addr_ex[40], au_addr_pc[40]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u76 (addr_ex[41], au_addr_pc[41]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u77 (addr_ex[42], au_addr_pc[42]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u78 (addr_ex[43], au_addr_pc[43]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u79 (addr_ex[44], au_addr_pc[44]);  // ../../RTL/CPU/EX/exu.v(508)
  and u8 (n7, size[3], n6);  // ../../RTL/CPU/EX/exu.v(211)
  buf u80 (addr_ex[45], au_addr_pc[45]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u81 (addr_ex[46], au_addr_pc[46]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u82 (addr_ex[47], au_addr_pc[47]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u83 (addr_ex[48], au_addr_pc[48]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u84 (addr_ex[49], au_addr_pc[49]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u85 (addr_ex[50], au_addr_pc[50]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u86 (addr_ex[51], au_addr_pc[51]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u87 (addr_ex[52], au_addr_pc[52]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u88 (addr_ex[53], au_addr_pc[53]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u89 (addr_ex[54], au_addr_pc[54]);  // ../../RTL/CPU/EX/exu.v(508)
  or u9 (n8, n5, n7);  // ../../RTL/CPU/EX/exu.v(211)
  buf u90 (addr_ex[55], au_addr_pc[55]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u91 (addr_ex[56], au_addr_pc[56]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u92 (addr_ex[57], au_addr_pc[57]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u93 (addr_ex[58], au_addr_pc[58]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u94 (addr_ex[59], au_addr_pc[59]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u95 (addr_ex[60], au_addr_pc[60]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u96 (addr_ex[61], au_addr_pc[61]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u97 (addr_ex[62], au_addr_pc[62]);  // ../../RTL/CPU/EX/exu.v(508)
  buf u98 (addr_ex[63], au_addr_pc[63]);  // ../../RTL/CPU/EX/exu.v(508)
  or u99 (n59, c_load, c_amo_mem0);  // ../../RTL/CPU/EX/exu.v(321)
  AL_DFF valid_reg (
    .clk(clk),
    .d(n126),
    .reset(1'b0),
    .set(1'b0),
    .q(valid));  // ../../RTL/CPU/EX/exu.v(448)

endmodule 

module ins_dec  // ../../RTL/CPU/ID/ins_dec.v(4)
  (
  clk,
  csr_data,
  id_hold,
  id_nop,
  ins_acc_fault_if,
  ins_addr_mis_if,
  ins_in,
  ins_page_fault_if,
  ins_pc,
  int_acc_if,
  priv,
  rs1_data,
  rs2_data,
  rst,
  tsr,
  tvm,
  tw,
  valid_if,
  amo,
  amo_lr_sc,
  and_clr,
  as1,
  as2,
  beq,
  bge,
  blt,
  bne,
  cache_flush,
  cache_reset,
  compare,
  csr_index,
  csr_write,
  dec_branch,
  dec_csr_index,
  dec_gpr_write,
  dec_ill_ins,
  dec_rd_index,
  dec_rs1_index,
  dec_rs2_index,
  dec_system_mem,
  ds1,
  ds1_sel,
  ds2,
  ebreak,
  ecall,
  exc_code,
  gpr_write,
  id_jmp,
  id_system,
  ill_ins,
  ins_acc_fault,
  ins_addr_mis,
  ins_page_fault,
  ins_pc_id,
  int_acc,
  jmp,
  load,
  m_ret,
  mem_csr_data_add,
  mem_csr_data_and,
  mem_csr_data_ds1,
  mem_csr_data_ds2,
  mem_csr_data_max,
  mem_csr_data_min,
  mem_csr_data_or,
  mem_csr_data_xor,
  op_count,
  rd_data_add,
  rd_data_and,
  rd_data_ds1,
  rd_data_or,
  rd_data_slt,
  rd_data_sub,
  rd_data_xor,
  rd_index,
  rs1_index,
  rs2_index,
  s_ret,
  shift_l,
  shift_r,
  size,
  store,
  unsign,
  valid
  );

  input clk;  // ../../RTL/CPU/ID/ins_dec.v(6)
  input [63:0] csr_data;  // ../../RTL/CPU/ID/ins_dec.v(14)
  input id_hold;  // ../../RTL/CPU/ID/ins_dec.v(124)
  input id_nop;  // ../../RTL/CPU/ID/ins_dec.v(125)
  input ins_acc_fault_if;  // ../../RTL/CPU/ID/ins_dec.v(25)
  input ins_addr_mis_if;  // ../../RTL/CPU/ID/ins_dec.v(26)
  input [31:0] ins_in;  // ../../RTL/CPU/ID/ins_dec.v(21)
  input ins_page_fault_if;  // ../../RTL/CPU/ID/ins_dec.v(27)
  input [63:0] ins_pc;  // ../../RTL/CPU/ID/ins_dec.v(23)
  input int_acc_if;  // ../../RTL/CPU/ID/ins_dec.v(28)
  input [3:0] priv;  // ../../RTL/CPU/ID/ins_dec.v(10)
  input [63:0] rs1_data;  // ../../RTL/CPU/ID/ins_dec.v(16)
  input [63:0] rs2_data;  // ../../RTL/CPU/ID/ins_dec.v(17)
  input rst;  // ../../RTL/CPU/ID/ins_dec.v(7)
  input tsr;  // ../../RTL/CPU/ID/ins_dec.v(12)
  input tvm;  // ../../RTL/CPU/ID/ins_dec.v(11)
  input tw;  // ../../RTL/CPU/ID/ins_dec.v(13)
  input valid_if;  // ../../RTL/CPU/ID/ins_dec.v(29)
  output amo;  // ../../RTL/CPU/ID/ins_dec.v(75)
  output amo_lr_sc;  // ../../RTL/CPU/ID/ins_dec.v(48)
  output and_clr;  // ../../RTL/CPU/ID/ins_dec.v(66)
  output [63:0] as1;  // ../../RTL/CPU/ID/ins_dec.v(92)
  output [63:0] as2;  // ../../RTL/CPU/ID/ins_dec.v(93)
  output beq;  // ../../RTL/CPU/ID/ins_dec.v(62)
  output bge;  // ../../RTL/CPU/ID/ins_dec.v(61)
  output blt;  // ../../RTL/CPU/ID/ins_dec.v(60)
  output bne;  // ../../RTL/CPU/ID/ins_dec.v(63)
  output cache_flush;  // ../../RTL/CPU/ID/ins_dec.v(76)
  output cache_reset;  // ../../RTL/CPU/ID/ins_dec.v(77)
  output compare;  // ../../RTL/CPU/ID/ins_dec.v(47)
  output [11:0] csr_index;  // ../../RTL/CPU/ID/ins_dec.v(84)
  output csr_write;  // ../../RTL/CPU/ID/ins_dec.v(82)
  output dec_branch;  // ../../RTL/CPU/ID/ins_dec.v(121)
  output [11:0] dec_csr_index;  // ../../RTL/CPU/ID/ins_dec.v(117)
  output dec_gpr_write;  // ../../RTL/CPU/ID/ins_dec.v(119)
  output dec_ill_ins;  // ../../RTL/CPU/ID/ins_dec.v(120)
  output [4:0] dec_rd_index;  // ../../RTL/CPU/ID/ins_dec.v(116)
  output [4:0] dec_rs1_index;  // ../../RTL/CPU/ID/ins_dec.v(114)
  output [4:0] dec_rs2_index;  // ../../RTL/CPU/ID/ins_dec.v(115)
  output dec_system_mem;  // ../../RTL/CPU/ID/ins_dec.v(122)
  output [63:0] ds1;  // ../../RTL/CPU/ID/ins_dec.v(90)
  output ds1_sel;  // ../../RTL/CPU/ID/ins_dec.v(67)
  output [63:0] ds2;  // ../../RTL/CPU/ID/ins_dec.v(91)
  output ebreak;  // ../../RTL/CPU/ID/ins_dec.v(108)
  output ecall;  // ../../RTL/CPU/ID/ins_dec.v(107)
  output [63:0] exc_code;  // ../../RTL/CPU/ID/ins_dec.v(34)
  output gpr_write;  // ../../RTL/CPU/ID/ins_dec.v(83)
  output id_jmp;  // ../../RTL/CPU/ID/ins_dec.v(98)
  output id_system;  // ../../RTL/CPU/ID/ins_dec.v(97)
  output ill_ins;  // ../../RTL/CPU/ID/ins_dec.v(104)
  output ins_acc_fault;  // ../../RTL/CPU/ID/ins_dec.v(99)
  output ins_addr_mis;  // ../../RTL/CPU/ID/ins_dec.v(100)
  output ins_page_fault;  // ../../RTL/CPU/ID/ins_dec.v(101)
  output [63:0] ins_pc_id;  // ../../RTL/CPU/ID/ins_dec.v(36)
  output int_acc;  // ../../RTL/CPU/ID/ins_dec.v(102)
  output jmp;  // ../../RTL/CPU/ID/ins_dec.v(64)
  output load;  // ../../RTL/CPU/ID/ins_dec.v(73)
  output m_ret;  // ../../RTL/CPU/ID/ins_dec.v(105)
  output mem_csr_data_add;  // ../../RTL/CPU/ID/ins_dec.v(53)
  output mem_csr_data_and;  // ../../RTL/CPU/ID/ins_dec.v(54)
  output mem_csr_data_ds1;  // ../../RTL/CPU/ID/ins_dec.v(51)
  output mem_csr_data_ds2;  // ../../RTL/CPU/ID/ins_dec.v(52)
  output mem_csr_data_max;  // ../../RTL/CPU/ID/ins_dec.v(57)
  output mem_csr_data_min;  // ../../RTL/CPU/ID/ins_dec.v(58)
  output mem_csr_data_or;  // ../../RTL/CPU/ID/ins_dec.v(55)
  output mem_csr_data_xor;  // ../../RTL/CPU/ID/ins_dec.v(56)
  output [7:0] op_count;  // ../../RTL/CPU/ID/ins_dec.v(94)
  output rd_data_add;  // ../../RTL/CPU/ID/ins_dec.v(41)
  output rd_data_and;  // ../../RTL/CPU/ID/ins_dec.v(43)
  output rd_data_ds1;  // ../../RTL/CPU/ID/ins_dec.v(40)
  output rd_data_or;  // ../../RTL/CPU/ID/ins_dec.v(44)
  output rd_data_slt;  // ../../RTL/CPU/ID/ins_dec.v(46)
  output rd_data_sub;  // ../../RTL/CPU/ID/ins_dec.v(42)
  output rd_data_xor;  // ../../RTL/CPU/ID/ins_dec.v(45)
  output [4:0] rd_index;  // ../../RTL/CPU/ID/ins_dec.v(87)
  output [4:0] rs1_index;  // ../../RTL/CPU/ID/ins_dec.v(85)
  output [4:0] rs2_index;  // ../../RTL/CPU/ID/ins_dec.v(86)
  output s_ret;  // ../../RTL/CPU/ID/ins_dec.v(106)
  output shift_l;  // ../../RTL/CPU/ID/ins_dec.v(79)
  output shift_r;  // ../../RTL/CPU/ID/ins_dec.v(78)
  output [3:0] size;  // ../../RTL/CPU/ID/ins_dec.v(70)
  output store;  // ../../RTL/CPU/ID/ins_dec.v(74)
  output unsign;  // ../../RTL/CPU/ID/ins_dec.v(65)
  output valid;  // ../../RTL/CPU/ID/ins_dec.v(103)

  parameter amo_encode = 7'b0101111;
  parameter auipc_encode = 7'b0010111;
  parameter branch_encode = 7'b1100011;
  parameter dbyte_size = 4'b0010;
  parameter imm_32_encode = 7'b0011011;
  parameter imm_encode = 7'b0010011;
  parameter jal_encode = 7'b1101111;
  parameter jalr_encode = 7'b1100111;
  parameter load_encode = 7'b0000011;
  parameter lui_encode = 7'b0110111;
  parameter m_32_encode = 7'b0111011;
  parameter mach = 4'b1000;
  parameter mem_encode = 7'b0001111;
  parameter obyte_size = 4'b1000;
  parameter qbyte_size = 4'b0100;
  parameter reg_32_encode = 7'b0111011;
  parameter reg_encode = 7'b0110011;
  parameter sbyte_size = 4'b0001;
  parameter store_encode = 7'b0100011;
  parameter supe = 4'b0010;
  parameter system_encode = 7'b0001111;
  parameter user = 4'b0001;
  wire [63:0] imm12_b;  // ../../RTL/CPU/ID/ins_dec.v(229)
  wire [63:0] imm12_i;  // ../../RTL/CPU/ID/ins_dec.v(228)
  wire [63:0] imm12_s;  // ../../RTL/CPU/ID/ins_dec.v(230)
  wire [63:0] imm20;  // ../../RTL/CPU/ID/ins_dec.v(226)
  wire [63:0] imm20_jal;  // ../../RTL/CPU/ID/ins_dec.v(227)
  wire [63:0] imm5_csr;  // ../../RTL/CPU/ID/ins_dec.v(232)
  wire [3:0] n223;
  wire [3:0] n224;
  wire [11:0] n249;
  wire [4:0] n250;
  wire [4:0] n251;
  wire [4:0] n252;
  wire [11:0] n262;
  wire [4:0] n263;
  wire [4:0] n264;
  wire [4:0] n265;
  wire [63:0] n270;
  wire [63:0] n271;
  wire [63:0] n272;
  wire [63:0] n280;
  wire [63:0] n281;
  wire [63:0] n282;
  wire [63:0] n283;
  wire [63:0] n284;
  wire [63:0] n286;
  wire [63:0] n287;
  wire [63:0] n288;
  wire [63:0] n289;
  wire [63:0] n290;
  wire [63:0] n291;
  wire [63:0] n292;
  wire [63:0] n293;
  wire [63:0] n294;
  wire [63:0] n295;
  wire [7:0] n296;
  wire [63:0] n297;
  wire [63:0] n298;
  wire [63:0] n299;
  wire [63:0] n300;
  wire [7:0] n301;
  wire [31:0] n342;
  wire [63:0] n343;
  wire [63:0] n344;
  wire [63:0] n345;
  wire [63:0] n346;
  wire [7:0] n58;
  wire [7:0] op_count_decode;  // ../../RTL/CPU/ID/ins_dec.v(239)
  wire dbyte;  // ../../RTL/CPU/ID/ins_dec.v(235)
  wire dec_csr_acc_fault;  // ../../RTL/CPU/ID/ins_dec.v(334)
  wire dec_ins_dec_fault;  // ../../RTL/CPU/ID/ins_dec.v(336)
  wire dec_ins_unpermit;  // ../../RTL/CPU/ID/ins_dec.v(335)
  wire ds1_mem_iden;  // ../../RTL/CPU/ID/ins_dec.v(339)
  wire funct12_0;  // ../../RTL/CPU/ID/ins_dec.v(223)
  wire funct12_1;  // ../../RTL/CPU/ID/ins_dec.v(224)
  wire funct3_0;  // ../../RTL/CPU/ID/ins_dec.v(172)
  wire funct3_1;  // ../../RTL/CPU/ID/ins_dec.v(173)
  wire funct3_2;  // ../../RTL/CPU/ID/ins_dec.v(174)
  wire funct3_3;  // ../../RTL/CPU/ID/ins_dec.v(175)
  wire funct3_4;  // ../../RTL/CPU/ID/ins_dec.v(176)
  wire funct3_5;  // ../../RTL/CPU/ID/ins_dec.v(177)
  wire funct3_6;  // ../../RTL/CPU/ID/ins_dec.v(178)
  wire funct3_7;  // ../../RTL/CPU/ID/ins_dec.v(179)
  wire funct5_0;  // ../../RTL/CPU/ID/ins_dec.v(181)
  wire funct5_1;  // ../../RTL/CPU/ID/ins_dec.v(182)
  wire funct5_12;  // ../../RTL/CPU/ID/ins_dec.v(193)
  wire funct5_16;  // ../../RTL/CPU/ID/ins_dec.v(197)
  wire funct5_2;  // ../../RTL/CPU/ID/ins_dec.v(183)
  wire funct5_20;  // ../../RTL/CPU/ID/ins_dec.v(201)
  wire funct5_24;  // ../../RTL/CPU/ID/ins_dec.v(205)
  wire funct5_28;  // ../../RTL/CPU/ID/ins_dec.v(209)
  wire funct5_3;  // ../../RTL/CPU/ID/ins_dec.v(184)
  wire funct5_4;  // ../../RTL/CPU/ID/ins_dec.v(185)
  wire funct5_8;  // ../../RTL/CPU/ID/ins_dec.v(189)
  wire funct6_0;  // ../../RTL/CPU/ID/ins_dec.v(214)
  wire funct6_16;  // ../../RTL/CPU/ID/ins_dec.v(215)
  wire funct7_0;  // ../../RTL/CPU/ID/ins_dec.v(220)
  wire funct7_24;  // ../../RTL/CPU/ID/ins_dec.v(218)
  wire funct7_32;  // ../../RTL/CPU/ID/ins_dec.v(217)
  wire funct7_8;  // ../../RTL/CPU/ID/ins_dec.v(219)
  wire funct7_9;  // ../../RTL/CPU/ID/ins_dec.v(410)
  wire ins_add;  // ../../RTL/CPU/ID/ins_dec.v(272)
  wire ins_addi;  // ../../RTL/CPU/ID/ins_dec.v(262)
  wire ins_addiw;  // ../../RTL/CPU/ID/ins_dec.v(295)
  wire ins_addw;  // ../../RTL/CPU/ID/ins_dec.v(299)
  wire ins_amoaddd;  // ../../RTL/CPU/ID/ins_dec.v(320)
  wire ins_amoaddw;  // ../../RTL/CPU/ID/ins_dec.v(308)
  wire ins_amoandd;  // ../../RTL/CPU/ID/ins_dec.v(322)
  wire ins_amoandw;  // ../../RTL/CPU/ID/ins_dec.v(310)
  wire ins_amomaxd;  // ../../RTL/CPU/ID/ins_dec.v(325)
  wire ins_amomaxud;  // ../../RTL/CPU/ID/ins_dec.v(327)
  wire ins_amomaxuw;  // ../../RTL/CPU/ID/ins_dec.v(315)
  wire ins_amomaxw;  // ../../RTL/CPU/ID/ins_dec.v(313)
  wire ins_amomind;  // ../../RTL/CPU/ID/ins_dec.v(324)
  wire ins_amominud;  // ../../RTL/CPU/ID/ins_dec.v(326)
  wire ins_amominuw;  // ../../RTL/CPU/ID/ins_dec.v(314)
  wire ins_amominw;  // ../../RTL/CPU/ID/ins_dec.v(312)
  wire ins_amoord;  // ../../RTL/CPU/ID/ins_dec.v(323)
  wire ins_amoorw;  // ../../RTL/CPU/ID/ins_dec.v(311)
  wire ins_amoswapd;  // ../../RTL/CPU/ID/ins_dec.v(319)
  wire ins_amoswapw;  // ../../RTL/CPU/ID/ins_dec.v(307)
  wire ins_amoxord;  // ../../RTL/CPU/ID/ins_dec.v(321)
  wire ins_amoxorw;  // ../../RTL/CPU/ID/ins_dec.v(309)
  wire ins_and;  // ../../RTL/CPU/ID/ins_dec.v(281)
  wire ins_andi;  // ../../RTL/CPU/ID/ins_dec.v(268)
  wire ins_auipc;  // ../../RTL/CPU/ID/ins_dec.v(243)
  wire ins_beq;  // ../../RTL/CPU/ID/ins_dec.v(246)
  wire ins_bge;  // ../../RTL/CPU/ID/ins_dec.v(249)
  wire ins_bgeu;  // ../../RTL/CPU/ID/ins_dec.v(251)
  wire ins_blt;  // ../../RTL/CPU/ID/ins_dec.v(248)
  wire ins_bltu;  // ../../RTL/CPU/ID/ins_dec.v(250)
  wire ins_bne;  // ../../RTL/CPU/ID/ins_dec.v(247)
  wire ins_csrrc;  // ../../RTL/CPU/ID/ins_dec.v(287)
  wire ins_csrrci;  // ../../RTL/CPU/ID/ins_dec.v(290)
  wire ins_csrrs;  // ../../RTL/CPU/ID/ins_dec.v(286)
  wire ins_csrrsi;  // ../../RTL/CPU/ID/ins_dec.v(289)
  wire ins_csrrw;  // ../../RTL/CPU/ID/ins_dec.v(285)
  wire ins_csrrwi;  // ../../RTL/CPU/ID/ins_dec.v(288)
  wire ins_ebreak;  // ../../RTL/CPU/ID/ins_dec.v(284)
  wire ins_ecall;  // ../../RTL/CPU/ID/ins_dec.v(283)
  wire ins_fence;  // ../../RTL/CPU/ID/ins_dec.v(282)
  wire ins_jal;  // ../../RTL/CPU/ID/ins_dec.v(244)
  wire ins_jalr;  // ../../RTL/CPU/ID/ins_dec.v(245)
  wire ins_lb;  // ../../RTL/CPU/ID/ins_dec.v(252)
  wire ins_lbu;  // ../../RTL/CPU/ID/ins_dec.v(253)
  wire ins_ld;  // ../../RTL/CPU/ID/ins_dec.v(293)
  wire ins_lh;  // ../../RTL/CPU/ID/ins_dec.v(254)
  wire ins_lhu;  // ../../RTL/CPU/ID/ins_dec.v(255)
  wire ins_lrd;  // ../../RTL/CPU/ID/ins_dec.v(317)
  wire ins_lrw;  // ../../RTL/CPU/ID/ins_dec.v(305)
  wire ins_lui;  // ../../RTL/CPU/ID/ins_dec.v(242)
  wire ins_lw;  // ../../RTL/CPU/ID/ins_dec.v(256)
  wire ins_lwu;  // ../../RTL/CPU/ID/ins_dec.v(292)
  wire ins_mret;  // ../../RTL/CPU/ID/ins_dec.v(329)
  wire ins_or;  // ../../RTL/CPU/ID/ins_dec.v(280)
  wire ins_ori;  // ../../RTL/CPU/ID/ins_dec.v(267)
  wire ins_sb;  // ../../RTL/CPU/ID/ins_dec.v(258)
  wire ins_scd;  // ../../RTL/CPU/ID/ins_dec.v(318)
  wire ins_scw;  // ../../RTL/CPU/ID/ins_dec.v(306)
  wire ins_sfencevma;  // ../../RTL/CPU/ID/ins_dec.v(331)
  wire ins_sh;  // ../../RTL/CPU/ID/ins_dec.v(259)
  wire ins_sll;  // ../../RTL/CPU/ID/ins_dec.v(274)
  wire ins_slli;  // ../../RTL/CPU/ID/ins_dec.v(269)
  wire ins_slliw;  // ../../RTL/CPU/ID/ins_dec.v(296)
  wire ins_sllw;  // ../../RTL/CPU/ID/ins_dec.v(301)
  wire ins_slt;  // ../../RTL/CPU/ID/ins_dec.v(275)
  wire ins_slti;  // ../../RTL/CPU/ID/ins_dec.v(264)
  wire ins_sltiu;  // ../../RTL/CPU/ID/ins_dec.v(265)
  wire ins_sltu;  // ../../RTL/CPU/ID/ins_dec.v(276)
  wire ins_sra;  // ../../RTL/CPU/ID/ins_dec.v(279)
  wire ins_srai;  // ../../RTL/CPU/ID/ins_dec.v(271)
  wire ins_sraiw;  // ../../RTL/CPU/ID/ins_dec.v(298)
  wire ins_sraw;  // ../../RTL/CPU/ID/ins_dec.v(303)
  wire ins_sret;  // ../../RTL/CPU/ID/ins_dec.v(330)
  wire ins_srl;  // ../../RTL/CPU/ID/ins_dec.v(278)
  wire ins_srli;  // ../../RTL/CPU/ID/ins_dec.v(270)
  wire ins_srliw;  // ../../RTL/CPU/ID/ins_dec.v(297)
  wire ins_srlw;  // ../../RTL/CPU/ID/ins_dec.v(302)
  wire ins_sub;  // ../../RTL/CPU/ID/ins_dec.v(273)
  wire ins_subw;  // ../../RTL/CPU/ID/ins_dec.v(300)
  wire ins_sw;  // ../../RTL/CPU/ID/ins_dec.v(260)
  wire ins_wfi;  // ../../RTL/CPU/ID/ins_dec.v(505)
  wire ins_xor;  // ../../RTL/CPU/ID/ins_dec.v(277)
  wire ins_xori;  // ../../RTL/CPU/ID/ins_dec.v(266)
  wire n0;
  wire n1;
  wire n10;
  wire n100;
  wire n101;
  wire n102;
  wire n103;
  wire n104;
  wire n105;
  wire n106;
  wire n107;
  wire n108;
  wire n109;
  wire n11;
  wire n110;
  wire n111;
  wire n112;
  wire n113;
  wire n114;
  wire n115;
  wire n116;
  wire n117;
  wire n118;
  wire n119;
  wire n12;
  wire n120;
  wire n121;
  wire n122;
  wire n123;
  wire n124;
  wire n125;
  wire n126;
  wire n127;
  wire n128;
  wire n129;
  wire n13;
  wire n130;
  wire n131;
  wire n132;
  wire n133;
  wire n134;
  wire n135;
  wire n136;
  wire n137;
  wire n138;
  wire n139;
  wire n14;
  wire n140;
  wire n141;
  wire n142;
  wire n143;
  wire n144;
  wire n145;
  wire n146;
  wire n147;
  wire n148;
  wire n149;
  wire n15;
  wire n150;
  wire n151;
  wire n152;
  wire n153;
  wire n154;
  wire n155;
  wire n156;
  wire n157;
  wire n158;
  wire n159;
  wire n16;
  wire n160;
  wire n161;
  wire n162;
  wire n163;
  wire n164;
  wire n165;
  wire n166;
  wire n167;
  wire n168;
  wire n169;
  wire n17;
  wire n170;
  wire n171;
  wire n172;
  wire n173;
  wire n174;
  wire n175;
  wire n176;
  wire n177;
  wire n178;
  wire n179;
  wire n18;
  wire n180;
  wire n181;
  wire n182;
  wire n183;
  wire n184;
  wire n185;
  wire n186;
  wire n187;
  wire n188;
  wire n189;
  wire n19;
  wire n190;
  wire n191;
  wire n192;
  wire n193;
  wire n194;
  wire n195;
  wire n196;
  wire n197;
  wire n198;
  wire n199;
  wire n2;
  wire n20;
  wire n200;
  wire n201;
  wire n202;
  wire n203;
  wire n204;
  wire n205;
  wire n206;
  wire n207;
  wire n208;
  wire n209;
  wire n21;
  wire n210;
  wire n211;
  wire n212;
  wire n213;
  wire n214;
  wire n215;
  wire n216;
  wire n217;
  wire n218;
  wire n219;
  wire n22;
  wire n220;
  wire n221;
  wire n222;
  wire n225;
  wire n226;
  wire n227;
  wire n228;
  wire n229;
  wire n23;
  wire n230;
  wire n231;
  wire n232;
  wire n233;
  wire n234;
  wire n235;
  wire n236;
  wire n237;
  wire n238;
  wire n239;
  wire n24;
  wire n240;
  wire n241;
  wire n242;
  wire n243;
  wire n244;
  wire n245;
  wire n246;
  wire n247;
  wire n248;
  wire n25;
  wire n253;
  wire n254;
  wire n255;
  wire n256;
  wire n257;
  wire n258;
  wire n259;
  wire n26;
  wire n260;
  wire n261;
  wire n266;
  wire n267;
  wire n268;
  wire n269;
  wire n27;
  wire n273;
  wire n274;
  wire n275;
  wire n276;
  wire n277;
  wire n278;
  wire n279;
  wire n28;
  wire n285;
  wire n29;
  wire n3;
  wire n30;
  wire n302;
  wire n303;
  wire n304;
  wire n305;
  wire n306;
  wire n307;
  wire n308;
  wire n309;
  wire n31;
  wire n310;
  wire n311;
  wire n312;
  wire n313;
  wire n314;
  wire n315;
  wire n316;
  wire n317;
  wire n318;
  wire n319;
  wire n32;
  wire n320;
  wire n321;
  wire n322;
  wire n323;
  wire n324;
  wire n325;
  wire n326;
  wire n327;
  wire n328;
  wire n329;
  wire n33;
  wire n330;
  wire n331;
  wire n332;
  wire n333;
  wire n334;
  wire n335;
  wire n336;
  wire n337;
  wire n338;
  wire n339;
  wire n34;
  wire n340;
  wire n341;
  wire n35;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n4;
  wire n40;
  wire n41;
  wire n42;
  wire n43;
  wire n44;
  wire n45;
  wire n46;
  wire n47;
  wire n48;
  wire n49;
  wire n5;
  wire n50;
  wire n51;
  wire n52;
  wire n53;
  wire n54;
  wire n55;
  wire n56;
  wire n57;
  wire n59;
  wire n6;
  wire n60;
  wire n61;
  wire n62;
  wire n63;
  wire n64;
  wire n65;
  wire n66;
  wire n67;
  wire n68;
  wire n69;
  wire n7;
  wire n70;
  wire n71;
  wire n72;
  wire n73;
  wire n74;
  wire n75;
  wire n76;
  wire n77;
  wire n78;
  wire n79;
  wire n8;
  wire n80;
  wire n81;
  wire n82;
  wire n83;
  wire n84;
  wire n85;
  wire n86;
  wire n87;
  wire n88;
  wire n89;
  wire n9;
  wire n90;
  wire n91;
  wire n92;
  wire n93;
  wire n94;
  wire n95;
  wire n96;
  wire n97;
  wire n98;
  wire n99;
  wire obyte;  // ../../RTL/CPU/ID/ins_dec.v(237)
  wire op_32_imm;  // ../../RTL/CPU/ID/ins_dec.v(158)
  wire op_32_reg;  // ../../RTL/CPU/ID/ins_dec.v(167)
  wire op_amo;  // ../../RTL/CPU/ID/ins_dec.v(168)
  wire op_auipc;  // ../../RTL/CPU/ID/ins_dec.v(160)
  wire op_branch;  // ../../RTL/CPU/ID/ins_dec.v(163)
  wire op_imm;  // ../../RTL/CPU/ID/ins_dec.v(157)
  wire op_jal;  // ../../RTL/CPU/ID/ins_dec.v(161)
  wire op_jalr;  // ../../RTL/CPU/ID/ins_dec.v(162)
  wire op_load;  // ../../RTL/CPU/ID/ins_dec.v(165)
  wire op_lui;  // ../../RTL/CPU/ID/ins_dec.v(159)
  wire op_reg;  // ../../RTL/CPU/ID/ins_dec.v(166)
  wire op_store;  // ../../RTL/CPU/ID/ins_dec.v(164)
  wire op_system;  // ../../RTL/CPU/ID/ins_dec.v(156)
  wire qbyte;  // ../../RTL/CPU/ID/ins_dec.v(236)
  wire sbyte;  // ../../RTL/CPU/ID/ins_dec.v(234)

  assign dec_system_mem = op_system;
  AL_DFF amo_lr_sc_reg (
    .clk(clk),
    .d(n183),
    .reset(1'b0),
    .set(1'b0),
    .q(amo_lr_sc));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF amo_reg (
    .clk(clk),
    .d(n255),
    .reset(1'b0),
    .set(1'b0),
    .q(amo));  // ../../RTL/CPU/ID/ins_dec.v(739)
  AL_DFF and_clr_reg (
    .clk(clk),
    .d(n221),
    .reset(1'b0),
    .set(1'b0),
    .q(and_clr));  // ../../RTL/CPU/ID/ins_dec.v(674)
  AL_DFF beq_reg (
    .clk(clk),
    .d(n217),
    .reset(1'b0),
    .set(1'b0),
    .q(beq));  // ../../RTL/CPU/ID/ins_dec.v(674)
  AL_DFF bge_reg (
    .clk(clk),
    .d(n216),
    .reset(1'b0),
    .set(1'b0),
    .q(bge));  // ../../RTL/CPU/ID/ins_dec.v(674)
  AL_DFF blt_reg (
    .clk(clk),
    .d(n215),
    .reset(1'b0),
    .set(1'b0),
    .q(blt));  // ../../RTL/CPU/ID/ins_dec.v(674)
  AL_DFF bne_reg (
    .clk(clk),
    .d(n218),
    .reset(1'b0),
    .set(1'b0),
    .q(bne));  // ../../RTL/CPU/ID/ins_dec.v(674)
  AL_DFF cache_flush_reg (
    .clk(clk),
    .d(n256),
    .reset(1'b0),
    .set(1'b0),
    .q(cache_flush));  // ../../RTL/CPU/ID/ins_dec.v(739)
  AL_DFF cache_reset_reg (
    .clk(clk),
    .d(n257),
    .reset(1'b0),
    .set(1'b0),
    .q(cache_reset));  // ../../RTL/CPU/ID/ins_dec.v(739)
  AL_DFF compare_reg (
    .clk(clk),
    .d(n182),
    .reset(1'b0),
    .set(1'b0),
    .q(compare));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF csr_write_reg (
    .clk(clk),
    .d(n260),
    .reset(1'b0),
    .set(1'b0),
    .q(csr_write));  // ../../RTL/CPU/ID/ins_dec.v(739)
  AL_DFF ds1_sel_reg (
    .clk(clk),
    .d(n222),
    .reset(1'b0),
    .set(1'b0),
    .q(ds1_sel));  // ../../RTL/CPU/ID/ins_dec.v(674)
  AL_DFF ebreak_reg (
    .clk(clk),
    .d(n341),
    .reset(1'b0),
    .set(1'b0),
    .q(ebreak));  // ../../RTL/CPU/ID/ins_dec.v(830)
  AL_DFF ecall_reg (
    .clk(clk),
    .d(n340),
    .reset(1'b0),
    .set(1'b0),
    .q(ecall));  // ../../RTL/CPU/ID/ins_dec.v(830)
  eq_w7 eq0 (
    .i0(ins_in[6:0]),
    .i1(7'b0001111),
    .o(op_system));  // ../../RTL/CPU/ID/ins_dec.v(346)
  eq_w7 eq1 (
    .i0(ins_in[6:0]),
    .i1(7'b0010011),
    .o(op_imm));  // ../../RTL/CPU/ID/ins_dec.v(347)
  eq_w7 eq10 (
    .i0(ins_in[6:0]),
    .i1(7'b0110011),
    .o(op_reg));  // ../../RTL/CPU/ID/ins_dec.v(356)
  eq_w7 eq11 (
    .i0(ins_in[6:0]),
    .i1(7'b0111011),
    .o(op_32_reg));  // ../../RTL/CPU/ID/ins_dec.v(357)
  eq_w7 eq12 (
    .i0(ins_in[6:0]),
    .i1(7'b0101111),
    .o(op_amo));  // ../../RTL/CPU/ID/ins_dec.v(358)
  eq_w3 eq13 (
    .i0(ins_in[14:12]),
    .i1(3'b000),
    .o(funct3_0));  // ../../RTL/CPU/ID/ins_dec.v(363)
  eq_w3 eq14 (
    .i0(ins_in[14:12]),
    .i1(3'b001),
    .o(funct3_1));  // ../../RTL/CPU/ID/ins_dec.v(364)
  eq_w3 eq15 (
    .i0(ins_in[14:12]),
    .i1(3'b010),
    .o(funct3_2));  // ../../RTL/CPU/ID/ins_dec.v(365)
  eq_w3 eq16 (
    .i0(ins_in[14:12]),
    .i1(3'b011),
    .o(funct3_3));  // ../../RTL/CPU/ID/ins_dec.v(366)
  eq_w3 eq17 (
    .i0(ins_in[14:12]),
    .i1(3'b100),
    .o(funct3_4));  // ../../RTL/CPU/ID/ins_dec.v(367)
  eq_w3 eq18 (
    .i0(ins_in[14:12]),
    .i1(3'b101),
    .o(funct3_5));  // ../../RTL/CPU/ID/ins_dec.v(368)
  eq_w3 eq19 (
    .i0(ins_in[14:12]),
    .i1(3'b110),
    .o(funct3_6));  // ../../RTL/CPU/ID/ins_dec.v(369)
  eq_w7 eq2 (
    .i0(ins_in[6:0]),
    .i1(7'b0011011),
    .o(op_32_imm));  // ../../RTL/CPU/ID/ins_dec.v(348)
  eq_w3 eq20 (
    .i0(ins_in[14:12]),
    .i1(3'b111),
    .o(funct3_7));  // ../../RTL/CPU/ID/ins_dec.v(370)
  eq_w5 eq21 (
    .i0(ins_in[31:27]),
    .i1(5'b00000),
    .o(funct5_0));  // ../../RTL/CPU/ID/ins_dec.v(372)
  eq_w5 eq22 (
    .i0(ins_in[31:27]),
    .i1(5'b00001),
    .o(funct5_1));  // ../../RTL/CPU/ID/ins_dec.v(373)
  eq_w5 eq23 (
    .i0(ins_in[31:27]),
    .i1(5'b00010),
    .o(funct5_2));  // ../../RTL/CPU/ID/ins_dec.v(374)
  eq_w5 eq24 (
    .i0(ins_in[31:27]),
    .i1(5'b00011),
    .o(funct5_3));  // ../../RTL/CPU/ID/ins_dec.v(375)
  eq_w5 eq25 (
    .i0(ins_in[31:27]),
    .i1(5'b00100),
    .o(funct5_4));  // ../../RTL/CPU/ID/ins_dec.v(376)
  eq_w5 eq26 (
    .i0(ins_in[31:27]),
    .i1(5'b01000),
    .o(funct5_8));  // ../../RTL/CPU/ID/ins_dec.v(380)
  eq_w5 eq27 (
    .i0(ins_in[31:27]),
    .i1(5'b01100),
    .o(funct5_12));  // ../../RTL/CPU/ID/ins_dec.v(384)
  eq_w5 eq28 (
    .i0(ins_in[31:27]),
    .i1(5'b10000),
    .o(funct5_16));  // ../../RTL/CPU/ID/ins_dec.v(388)
  eq_w5 eq29 (
    .i0(ins_in[31:27]),
    .i1(5'b10100),
    .o(funct5_20));  // ../../RTL/CPU/ID/ins_dec.v(392)
  eq_w7 eq3 (
    .i0(ins_in[6:0]),
    .i1(7'b0110111),
    .o(op_lui));  // ../../RTL/CPU/ID/ins_dec.v(349)
  eq_w5 eq30 (
    .i0(ins_in[31:27]),
    .i1(5'b11000),
    .o(funct5_24));  // ../../RTL/CPU/ID/ins_dec.v(396)
  eq_w5 eq31 (
    .i0(ins_in[31:27]),
    .i1(5'b11100),
    .o(funct5_28));  // ../../RTL/CPU/ID/ins_dec.v(400)
  eq_w6 eq32 (
    .i0(ins_in[31:26]),
    .i1(6'b000000),
    .o(funct6_0));  // ../../RTL/CPU/ID/ins_dec.v(405)
  eq_w6 eq33 (
    .i0(ins_in[31:26]),
    .i1(6'b010000),
    .o(funct6_16));  // ../../RTL/CPU/ID/ins_dec.v(406)
  eq_w7 eq34 (
    .i0(ins_in[31:25]),
    .i1(7'b0000000),
    .o(funct7_0));  // ../../RTL/CPU/ID/ins_dec.v(408)
  eq_w7 eq35 (
    .i0(ins_in[31:25]),
    .i1(7'b0001000),
    .o(funct7_8));  // ../../RTL/CPU/ID/ins_dec.v(409)
  eq_w7 eq36 (
    .i0(ins_in[31:25]),
    .i1(7'b0001001),
    .o(funct7_9));  // ../../RTL/CPU/ID/ins_dec.v(410)
  eq_w7 eq37 (
    .i0(ins_in[31:25]),
    .i1(7'b0011000),
    .o(funct7_24));  // ../../RTL/CPU/ID/ins_dec.v(411)
  eq_w7 eq38 (
    .i0(ins_in[31:25]),
    .i1(7'b0101111),
    .o(funct7_32));  // ../../RTL/CPU/ID/ins_dec.v(412)
  eq_w12 eq39 (
    .i0(ins_in[31:20]),
    .i1(12'b000000000000),
    .o(funct12_0));  // ../../RTL/CPU/ID/ins_dec.v(415)
  eq_w7 eq4 (
    .i0(ins_in[6:0]),
    .i1(7'b0010111),
    .o(op_auipc));  // ../../RTL/CPU/ID/ins_dec.v(350)
  eq_w12 eq40 (
    .i0(ins_in[31:20]),
    .i1(12'b000000000001),
    .o(funct12_1));  // ../../RTL/CPU/ID/ins_dec.v(416)
  eq_w5 eq41 (
    .i0(dec_rs2_index),
    .i1(5'b00010),
    .o(n44));  // ../../RTL/CPU/ID/ins_dec.v(502)
  eq_w4 eq42 (
    .i0(priv),
    .i1(4'b1000),
    .o(n76));  // ../../RTL/CPU/ID/ins_dec.v(550)
  eq_w4 eq43 (
    .i0(priv),
    .i1(4'b0010),
    .o(n77));  // ../../RTL/CPU/ID/ins_dec.v(550)
  eq_w4 eq44 (
    .i0(priv),
    .i1(4'b0001),
    .o(n79));  // ../../RTL/CPU/ID/ins_dec.v(550)
  eq_w2 eq45 (
    .i0(dec_csr_index[9:8]),
    .i1(2'b00),
    .o(n80));  // ../../RTL/CPU/ID/ins_dec.v(550)
  eq_w12 eq46 (
    .i0(dec_csr_index),
    .i1(12'b000110000000),
    .o(n85));  // ../../RTL/CPU/ID/ins_dec.v(552)
  eq_w7 eq5 (
    .i0(ins_in[6:0]),
    .i1(7'b1101111),
    .o(op_jal));  // ../../RTL/CPU/ID/ins_dec.v(351)
  eq_w7 eq6 (
    .i0(ins_in[6:0]),
    .i1(7'b1100111),
    .o(op_jalr));  // ../../RTL/CPU/ID/ins_dec.v(352)
  eq_w7 eq7 (
    .i0(ins_in[6:0]),
    .i1(7'b1100011),
    .o(op_branch));  // ../../RTL/CPU/ID/ins_dec.v(353)
  eq_w7 eq8 (
    .i0(ins_in[6:0]),
    .i1(7'b0000011),
    .o(op_load));  // ../../RTL/CPU/ID/ins_dec.v(354)
  eq_w7 eq9 (
    .i0(ins_in[6:0]),
    .i1(7'b0100011),
    .o(op_store));  // ../../RTL/CPU/ID/ins_dec.v(355)
  AL_DFF gpr_write_reg (
    .clk(clk),
    .d(n261),
    .reset(1'b0),
    .set(1'b0),
    .q(gpr_write));  // ../../RTL/CPU/ID/ins_dec.v(739)
  AL_DFF id_jmp_reg (
    .clk(clk),
    .d(n331),
    .reset(1'b0),
    .set(1'b0),
    .q(id_jmp));  // ../../RTL/CPU/ID/ins_dec.v(830)
  AL_DFF id_system_reg (
    .clk(clk),
    .d(n330),
    .reset(1'b0),
    .set(1'b0),
    .q(id_system));  // ../../RTL/CPU/ID/ins_dec.v(830)
  AL_DFF ill_ins_reg (
    .clk(clk),
    .d(n337),
    .reset(1'b0),
    .set(1'b0),
    .q(ill_ins));  // ../../RTL/CPU/ID/ins_dec.v(830)
  AL_DFF ins_acc_fault_reg (
    .clk(clk),
    .d(n332),
    .reset(1'b0),
    .set(1'b0),
    .q(ins_acc_fault));  // ../../RTL/CPU/ID/ins_dec.v(830)
  AL_DFF ins_addr_mis_reg (
    .clk(clk),
    .d(n333),
    .reset(1'b0),
    .set(1'b0),
    .q(ins_addr_mis));  // ../../RTL/CPU/ID/ins_dec.v(830)
  AL_DFF ins_page_fault_reg (
    .clk(clk),
    .d(n334),
    .reset(1'b0),
    .set(1'b0),
    .q(ins_page_fault));  // ../../RTL/CPU/ID/ins_dec.v(830)
  AL_DFF int_acc_reg (
    .clk(clk),
    .d(n335),
    .reset(1'b0),
    .set(1'b0),
    .q(int_acc));  // ../../RTL/CPU/ID/ins_dec.v(830)
  AL_DFF jmp_reg (
    .clk(clk),
    .d(n219),
    .reset(1'b0),
    .set(1'b0),
    .q(jmp));  // ../../RTL/CPU/ID/ins_dec.v(674)
  AL_DFF load_reg (
    .clk(clk),
    .d(n253),
    .reset(1'b0),
    .set(1'b0),
    .q(load));  // ../../RTL/CPU/ID/ins_dec.v(739)
  AL_DFF m_ret_reg (
    .clk(clk),
    .d(n338),
    .reset(1'b0),
    .set(1'b0),
    .q(m_ret));  // ../../RTL/CPU/ID/ins_dec.v(830)
  AL_DFF mem_csr_data_add_reg (
    .clk(clk),
    .d(n186),
    .reset(1'b0),
    .set(1'b0),
    .q(mem_csr_data_add));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF mem_csr_data_and_reg (
    .clk(clk),
    .d(n187),
    .reset(1'b0),
    .set(1'b0),
    .q(mem_csr_data_and));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF mem_csr_data_ds1_reg (
    .clk(clk),
    .d(n184),
    .reset(1'b0),
    .set(1'b0),
    .q(mem_csr_data_ds1));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF mem_csr_data_ds2_reg (
    .clk(clk),
    .d(n185),
    .reset(1'b0),
    .set(1'b0),
    .q(mem_csr_data_ds2));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF mem_csr_data_max_reg (
    .clk(clk),
    .d(n190),
    .reset(1'b0),
    .set(1'b0),
    .q(mem_csr_data_max));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF mem_csr_data_min_reg (
    .clk(clk),
    .d(n191),
    .reset(1'b0),
    .set(1'b0),
    .q(mem_csr_data_min));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF mem_csr_data_or_reg (
    .clk(clk),
    .d(n188),
    .reset(1'b0),
    .set(1'b0),
    .q(mem_csr_data_or));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF mem_csr_data_xor_reg (
    .clk(clk),
    .d(n189),
    .reset(1'b0),
    .set(1'b0),
    .q(mem_csr_data_xor));  // ../../RTL/CPU/ID/ins_dec.v(636)
  binary_mux_s1_w8 mux0 (
    .i0(rs2_data[7:0]),
    .i1({2'b00,ins_in[20:15]}),
    .sel(n57),
    .o(n58));  // ../../RTL/CPU/ID/ins_dec.v(524)
  binary_mux_s1_w8 mux1 (
    .i0(n58),
    .i1({3'b000,dec_rs2_index}),
    .sel(n55),
    .o(op_count_decode));  // ../../RTL/CPU/ID/ins_dec.v(524)
  binary_mux_s1_w12 mux10 (
    .i0(n249),
    .i1(12'b000000000000),
    .sel(n107),
    .o(n262));  // ../../RTL/CPU/ID/ins_dec.v(738)
  binary_mux_s1_w5 mux11 (
    .i0(n250),
    .i1(5'b00000),
    .sel(n107),
    .o(n263));  // ../../RTL/CPU/ID/ins_dec.v(738)
  binary_mux_s1_w5 mux12 (
    .i0(n251),
    .i1(5'b00000),
    .sel(n107),
    .o(n264));  // ../../RTL/CPU/ID/ins_dec.v(738)
  binary_mux_s1_w5 mux13 (
    .i0(n252),
    .i1(rd_index),
    .sel(n107),
    .o(n265));  // ../../RTL/CPU/ID/ins_dec.v(738)
  binary_mux_s1_w64 mux14 (
    .i0(ins_pc),
    .i1(csr_data),
    .sel(op_system),
    .o(n270));  // ../../RTL/CPU/ID/ins_dec.v(762)
  binary_mux_s1_w64 mux15 (
    .i0(n270),
    .i1(rs1_data),
    .sel(n269),
    .o(n271));  // ../../RTL/CPU/ID/ins_dec.v(762)
  binary_mux_s1_w64 mux16 (
    .i0(n271),
    .i1(imm20),
    .sel(ins_lui),
    .o(n272));  // ../../RTL/CPU/ID/ins_dec.v(762)
  binary_mux_s1_w64 mux17 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000100),
    .i1(imm20),
    .sel(ins_auipc),
    .o(n280));  // ../../RTL/CPU/ID/ins_dec.v(767)
  binary_mux_s1_w64 mux18 (
    .i0(n280),
    .i1(rs1_data),
    .sel(n279),
    .o(n281));  // ../../RTL/CPU/ID/ins_dec.v(767)
  binary_mux_s1_w64 mux19 (
    .i0(n281),
    .i1(imm5_csr),
    .sel(n277),
    .o(n282));  // ../../RTL/CPU/ID/ins_dec.v(767)
  binary_mux_s1_w5 mux2 (
    .i0(ins_in[19:15]),
    .i1(5'b00000),
    .sel(n61),
    .o(dec_rs1_index));  // ../../RTL/CPU/ID/ins_dec.v(529)
  binary_mux_s1_w64 mux20 (
    .i0(n282),
    .i1(imm12_i),
    .sel(n275),
    .o(n283));  // ../../RTL/CPU/ID/ins_dec.v(767)
  binary_mux_s1_w64 mux21 (
    .i0(n283),
    .i1(rs2_data),
    .sel(n274),
    .o(n284));  // ../../RTL/CPU/ID/ins_dec.v(767)
  binary_mux_s1_w64 mux22 (
    .i0(rs1_data),
    .i1(ins_pc),
    .sel(n285),
    .o(n286));  // ../../RTL/CPU/ID/ins_dec.v(769)
  binary_mux_s1_w64 mux23 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(imm12_i),
    .sel(op_load),
    .o(n287));  // ../../RTL/CPU/ID/ins_dec.v(774)
  binary_mux_s1_w64 mux24 (
    .i0(n287),
    .i1(imm12_s),
    .sel(op_store),
    .o(n288));  // ../../RTL/CPU/ID/ins_dec.v(774)
  binary_mux_s1_w64 mux25 (
    .i0(n288),
    .i1(imm20_jal),
    .sel(ins_jal),
    .o(n289));  // ../../RTL/CPU/ID/ins_dec.v(774)
  binary_mux_s1_w64 mux26 (
    .i0(n289),
    .i1(imm12_i),
    .sel(ins_jalr),
    .o(n290));  // ../../RTL/CPU/ID/ins_dec.v(774)
  binary_mux_s1_w64 mux27 (
    .i0(n290),
    .i1(imm12_b),
    .sel(op_branch),
    .o(n291));  // ../../RTL/CPU/ID/ins_dec.v(774)
  binary_mux_s1_w64 mux28 (
    .i0(n272),
    .i1(ds1),
    .sel(id_hold),
    .o(n292));  // ../../RTL/CPU/ID/ins_dec.v(776)
  binary_mux_s1_w64 mux29 (
    .i0(n284),
    .i1(ds2),
    .sel(id_hold),
    .o(n293));  // ../../RTL/CPU/ID/ins_dec.v(776)
  binary_mux_s1_w5 mux3 (
    .i0(5'b00000),
    .i1(ins_in[24:20]),
    .sel(n65),
    .o(dec_rs2_index));  // ../../RTL/CPU/ID/ins_dec.v(530)
  binary_mux_s1_w64 mux30 (
    .i0(n286),
    .i1(as1),
    .sel(id_hold),
    .o(n294));  // ../../RTL/CPU/ID/ins_dec.v(776)
  binary_mux_s1_w64 mux31 (
    .i0(n291),
    .i1(as2),
    .sel(id_hold),
    .o(n295));  // ../../RTL/CPU/ID/ins_dec.v(776)
  binary_mux_s1_w8 mux32 (
    .i0(op_count_decode),
    .i1(op_count),
    .sel(id_hold),
    .o(n296));  // ../../RTL/CPU/ID/ins_dec.v(776)
  binary_mux_s1_w64 mux33 (
    .i0(n292),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(n107),
    .o(n297));  // ../../RTL/CPU/ID/ins_dec.v(776)
  binary_mux_s1_w64 mux34 (
    .i0(n293),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(n107),
    .o(n298));  // ../../RTL/CPU/ID/ins_dec.v(776)
  binary_mux_s1_w64 mux35 (
    .i0(n294),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(n107),
    .o(n299));  // ../../RTL/CPU/ID/ins_dec.v(776)
  binary_mux_s1_w64 mux36 (
    .i0(n295),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(n107),
    .o(n300));  // ../../RTL/CPU/ID/ins_dec.v(776)
  binary_mux_s1_w8 mux37 (
    .i0(n296),
    .i1(8'b00000000),
    .sel(n107),
    .o(n301));  // ../../RTL/CPU/ID/ins_dec.v(776)
  binary_mux_s1_w32 mux38 (
    .i0(32'b00000000000000000000000000000000),
    .i1(ins_in),
    .sel(dec_ill_ins),
    .o(n342));  // ../../RTL/CPU/ID/ins_dec.v(845)
  binary_mux_s1_w64 mux39 (
    .i0({32'b00000000000000000000000000000000,n342}),
    .i1(exc_code),
    .sel(id_hold),
    .o(n343));  // ../../RTL/CPU/ID/ins_dec.v(847)
  binary_mux_s1_w4 mux4 (
    .i0({obyte,qbyte,dbyte,sbyte}),
    .i1(size),
    .sel(id_hold),
    .o(n223));  // ../../RTL/CPU/ID/ins_dec.v(688)
  binary_mux_s1_w64 mux40 (
    .i0(ins_pc),
    .i1(ins_pc_id),
    .sel(id_hold),
    .o(n344));  // ../../RTL/CPU/ID/ins_dec.v(847)
  binary_mux_s1_w64 mux41 (
    .i0(n343),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(n107),
    .o(n345));  // ../../RTL/CPU/ID/ins_dec.v(847)
  binary_mux_s1_w64 mux42 (
    .i0(n344),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(n107),
    .o(n346));  // ../../RTL/CPU/ID/ins_dec.v(847)
  binary_mux_s1_w4 mux5 (
    .i0(n223),
    .i1(4'b0100),
    .sel(n107),
    .o(n224));  // ../../RTL/CPU/ID/ins_dec.v(688)
  binary_mux_s1_w12 mux6 (
    .i0(dec_csr_index),
    .i1(csr_index),
    .sel(id_hold),
    .o(n249));  // ../../RTL/CPU/ID/ins_dec.v(738)
  binary_mux_s1_w5 mux7 (
    .i0(dec_rs1_index),
    .i1(rs1_index),
    .sel(id_hold),
    .o(n250));  // ../../RTL/CPU/ID/ins_dec.v(738)
  binary_mux_s1_w5 mux8 (
    .i0(dec_rs2_index),
    .i1(rs2_index),
    .sel(id_hold),
    .o(n251));  // ../../RTL/CPU/ID/ins_dec.v(738)
  binary_mux_s1_w5 mux9 (
    .i0(dec_rd_index),
    .i1(rd_index),
    .sel(id_hold),
    .o(n252));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_DFF rd_data_add_reg (
    .clk(clk),
    .d(n176),
    .reset(1'b0),
    .set(1'b0),
    .q(rd_data_add));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF rd_data_and_reg (
    .clk(clk),
    .d(n178),
    .reset(1'b0),
    .set(1'b0),
    .q(rd_data_and));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF rd_data_ds1_reg (
    .clk(clk),
    .d(n175),
    .reset(1'b0),
    .set(1'b0),
    .q(rd_data_ds1));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF rd_data_or_reg (
    .clk(clk),
    .d(n179),
    .reset(1'b0),
    .set(1'b0),
    .q(rd_data_or));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF rd_data_slt_reg (
    .clk(clk),
    .d(n181),
    .reset(1'b0),
    .set(1'b0),
    .q(rd_data_slt));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF rd_data_sub_reg (
    .clk(clk),
    .d(n177),
    .reset(1'b0),
    .set(1'b0),
    .q(rd_data_sub));  // ../../RTL/CPU/ID/ins_dec.v(636)
  AL_DFF rd_data_xor_reg (
    .clk(clk),
    .d(n180),
    .reset(1'b0),
    .set(1'b0),
    .q(rd_data_xor));  // ../../RTL/CPU/ID/ins_dec.v(636)
  reg_ar_as_w4 reg0 (
    .clk(clk),
    .d(n224),
    .reset(4'b0000),
    .set(4'b0000),
    .q(size));  // ../../RTL/CPU/ID/ins_dec.v(689)
  reg_ar_as_w12 reg1 (
    .clk(clk),
    .d(n262),
    .reset(12'b000000000000),
    .set(12'b000000000000),
    .q(csr_index));  // ../../RTL/CPU/ID/ins_dec.v(739)
  reg_ar_as_w64 reg10 (
    .clk(clk),
    .d(n345),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(exc_code));  // ../../RTL/CPU/ID/ins_dec.v(848)
  reg_ar_as_w64 reg11 (
    .clk(clk),
    .d(n346),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(ins_pc_id));  // ../../RTL/CPU/ID/ins_dec.v(848)
  reg_ar_as_w5 reg2 (
    .clk(clk),
    .d(n263),
    .reset(5'b00000),
    .set(5'b00000),
    .q(rs1_index));  // ../../RTL/CPU/ID/ins_dec.v(739)
  reg_ar_as_w5 reg3 (
    .clk(clk),
    .d(n264),
    .reset(5'b00000),
    .set(5'b00000),
    .q(rs2_index));  // ../../RTL/CPU/ID/ins_dec.v(739)
  reg_ar_as_w5 reg4 (
    .clk(clk),
    .d(n265),
    .reset(5'b00000),
    .set(5'b00000),
    .q(rd_index));  // ../../RTL/CPU/ID/ins_dec.v(739)
  reg_ar_as_w64 reg5 (
    .clk(clk),
    .d(n297),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(ds1));  // ../../RTL/CPU/ID/ins_dec.v(777)
  reg_ar_as_w64 reg6 (
    .clk(clk),
    .d(n298),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(ds2));  // ../../RTL/CPU/ID/ins_dec.v(777)
  reg_ar_as_w64 reg7 (
    .clk(clk),
    .d(n299),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(as1));  // ../../RTL/CPU/ID/ins_dec.v(777)
  reg_ar_as_w64 reg8 (
    .clk(clk),
    .d(n300),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(as2));  // ../../RTL/CPU/ID/ins_dec.v(777)
  reg_ar_as_w8 reg9 (
    .clk(clk),
    .d(n301),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(op_count));  // ../../RTL/CPU/ID/ins_dec.v(777)
  AL_DFF s_ret_reg (
    .clk(clk),
    .d(n339),
    .reset(1'b0),
    .set(1'b0),
    .q(s_ret));  // ../../RTL/CPU/ID/ins_dec.v(830)
  AL_DFF shift_l_reg (
    .clk(clk),
    .d(n259),
    .reset(1'b0),
    .set(1'b0),
    .q(shift_l));  // ../../RTL/CPU/ID/ins_dec.v(739)
  AL_DFF shift_r_reg (
    .clk(clk),
    .d(n258),
    .reset(1'b0),
    .set(1'b0),
    .q(shift_r));  // ../../RTL/CPU/ID/ins_dec.v(739)
  AL_DFF store_reg (
    .clk(clk),
    .d(n254),
    .reset(1'b0),
    .set(1'b0),
    .q(store));  // ../../RTL/CPU/ID/ins_dec.v(739)
  or u10 (n6, n5, ins_amoandd);  // ../../RTL/CPU/ID/ins_dec.v(341)
  and u100 (n34, op_reg, funct3_7);  // ../../RTL/CPU/ID/ins_dec.v(454)
  and u101 (ins_and, n34, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(454)
  or u102 (n35, funct3_0, funct3_1);  // ../../RTL/CPU/ID/ins_dec.v(455)
  and u103 (ins_fence, op_system, n35);  // ../../RTL/CPU/ID/ins_dec.v(455)
  and u104 (n36, op_system, funct3_0);  // ../../RTL/CPU/ID/ins_dec.v(456)
  and u105 (ins_ecall, n36, funct12_0);  // ../../RTL/CPU/ID/ins_dec.v(456)
  buf u106 (imm5_csr[38], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u107 (ins_ebreak, n36, funct12_1);  // ../../RTL/CPU/ID/ins_dec.v(457)
  and u108 (ins_csrrw, op_system, funct3_1);  // ../../RTL/CPU/ID/ins_dec.v(458)
  and u109 (ins_csrrs, op_system, funct3_2);  // ../../RTL/CPU/ID/ins_dec.v(459)
  or u11 (n7, n6, ins_amoorw);  // ../../RTL/CPU/ID/ins_dec.v(341)
  and u110 (ins_csrrc, op_system, funct3_3);  // ../../RTL/CPU/ID/ins_dec.v(460)
  and u111 (ins_csrrwi, op_system, funct3_5);  // ../../RTL/CPU/ID/ins_dec.v(461)
  and u112 (ins_csrrsi, op_system, funct3_6);  // ../../RTL/CPU/ID/ins_dec.v(462)
  and u113 (ins_csrrci, op_system, funct3_7);  // ../../RTL/CPU/ID/ins_dec.v(463)
  and u114 (ins_lwu, op_load, funct3_6);  // ../../RTL/CPU/ID/ins_dec.v(465)
  and u115 (ins_ld, op_load, funct3_3);  // ../../RTL/CPU/ID/ins_dec.v(466)
  buf u116 (imm5_csr[43], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u117 (ins_addiw, op_32_imm, funct3_0);  // ../../RTL/CPU/ID/ins_dec.v(468)
  and u118 (n37, op_32_imm, funct3_1);  // ../../RTL/CPU/ID/ins_dec.v(469)
  and u119 (ins_slliw, n37, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(469)
  or u12 (n8, n7, ins_amoord);  // ../../RTL/CPU/ID/ins_dec.v(341)
  and u120 (n38, op_32_imm, funct3_5);  // ../../RTL/CPU/ID/ins_dec.v(470)
  and u121 (ins_srliw, n38, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(470)
  buf u122 (imm5_csr[37], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u123 (ins_sraiw, n38, funct7_32);  // ../../RTL/CPU/ID/ins_dec.v(471)
  and u124 (n39, op_32_reg, funct3_0);  // ../../RTL/CPU/ID/ins_dec.v(472)
  and u125 (ins_addw, n39, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(472)
  buf u126 (imm5_csr[36], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u127 (ins_subw, n39, funct7_32);  // ../../RTL/CPU/ID/ins_dec.v(473)
  and u128 (n40, op_32_reg, funct3_1);  // ../../RTL/CPU/ID/ins_dec.v(474)
  and u129 (ins_sllw, n40, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(474)
  or u13 (n9, n8, ins_amominw);  // ../../RTL/CPU/ID/ins_dec.v(341)
  and u130 (n41, op_32_reg, funct3_5);  // ../../RTL/CPU/ID/ins_dec.v(475)
  and u131 (ins_srlw, n41, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(475)
  buf u132 (imm5_csr[35], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u133 (ins_sraw, n41, funct7_32);  // ../../RTL/CPU/ID/ins_dec.v(476)
  and u134 (n42, op_amo, funct3_2);  // ../../RTL/CPU/ID/ins_dec.v(478)
  and u135 (ins_lrw, n42, funct5_2);  // ../../RTL/CPU/ID/ins_dec.v(478)
  buf u136 (imm5_csr[34], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u137 (ins_scw, n42, funct5_3);  // ../../RTL/CPU/ID/ins_dec.v(479)
  buf u138 (imm5_csr[33], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u139 (ins_amoswapw, n42, funct5_1);  // ../../RTL/CPU/ID/ins_dec.v(480)
  or u14 (n10, n9, ins_amomind);  // ../../RTL/CPU/ID/ins_dec.v(341)
  buf u140 (imm5_csr[32], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u141 (ins_amoaddw, n42, funct5_0);  // ../../RTL/CPU/ID/ins_dec.v(481)
  buf u142 (imm5_csr[31], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u143 (ins_amoxorw, n42, funct5_4);  // ../../RTL/CPU/ID/ins_dec.v(482)
  buf u144 (imm5_csr[30], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u145 (ins_amoandw, n42, funct5_12);  // ../../RTL/CPU/ID/ins_dec.v(483)
  buf u146 (imm5_csr[29], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u147 (ins_amoorw, n42, funct5_8);  // ../../RTL/CPU/ID/ins_dec.v(484)
  buf u148 (imm5_csr[28], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u149 (ins_amominw, n42, funct5_16);  // ../../RTL/CPU/ID/ins_dec.v(485)
  or u15 (n11, n10, ins_amomaxw);  // ../../RTL/CPU/ID/ins_dec.v(342)
  buf u150 (imm5_csr[27], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u151 (ins_amomaxw, n42, funct5_20);  // ../../RTL/CPU/ID/ins_dec.v(486)
  buf u152 (imm5_csr[26], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u153 (ins_amominuw, n42, funct5_24);  // ../../RTL/CPU/ID/ins_dec.v(487)
  buf u154 (imm5_csr[25], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u155 (ins_amomaxuw, n42, funct5_28);  // ../../RTL/CPU/ID/ins_dec.v(488)
  and u156 (n43, op_amo, funct3_3);  // ../../RTL/CPU/ID/ins_dec.v(490)
  and u157 (ins_lrd, n43, funct5_2);  // ../../RTL/CPU/ID/ins_dec.v(490)
  buf u158 (imm5_csr[24], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u159 (ins_scd, n43, funct5_3);  // ../../RTL/CPU/ID/ins_dec.v(491)
  or u16 (n12, n11, ins_amomaxd);  // ../../RTL/CPU/ID/ins_dec.v(342)
  buf u160 (imm5_csr[23], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u161 (ins_amoswapd, n43, funct5_1);  // ../../RTL/CPU/ID/ins_dec.v(492)
  buf u162 (imm5_csr[22], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u163 (ins_amoaddd, n43, funct5_0);  // ../../RTL/CPU/ID/ins_dec.v(493)
  buf u164 (imm5_csr[21], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u165 (ins_amoxord, n43, funct5_4);  // ../../RTL/CPU/ID/ins_dec.v(494)
  buf u166 (imm5_csr[20], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u167 (ins_amoandd, n43, funct5_12);  // ../../RTL/CPU/ID/ins_dec.v(495)
  buf u168 (imm5_csr[19], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u169 (ins_amoord, n43, funct5_8);  // ../../RTL/CPU/ID/ins_dec.v(496)
  or u17 (n13, ins_amomaxd, ins_amomaxud);  // ../../RTL/CPU/ID/ins_dec.v(342)
  buf u170 (imm5_csr[18], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u171 (ins_amomind, n43, funct5_16);  // ../../RTL/CPU/ID/ins_dec.v(497)
  buf u172 (imm5_csr[17], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u173 (ins_amomaxd, n43, funct5_20);  // ../../RTL/CPU/ID/ins_dec.v(498)
  buf u174 (imm5_csr[16], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u175 (ins_amominud, n43, funct5_24);  // ../../RTL/CPU/ID/ins_dec.v(499)
  buf u176 (imm5_csr[15], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u177 (ins_amomaxud, n43, funct5_28);  // ../../RTL/CPU/ID/ins_dec.v(500)
  and u178 (n45, op_system, n44);  // ../../RTL/CPU/ID/ins_dec.v(502)
  and u179 (ins_mret, n45, funct7_24);  // ../../RTL/CPU/ID/ins_dec.v(502)
  or u18 (n14, n13, ins_amomind);  // ../../RTL/CPU/ID/ins_dec.v(342)
  buf u180 (imm5_csr[14], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u181 (imm5_csr[13], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u182 (ins_sret, n45, funct7_8);  // ../../RTL/CPU/ID/ins_dec.v(503)
  and u183 (ins_sfencevma, op_system, funct7_9);  // ../../RTL/CPU/ID/ins_dec.v(504)
  and u184 (ins_wfi, op_system, funct7_8);  // ../../RTL/CPU/ID/ins_dec.v(505)
  buf u185 (imm20[0], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u186 (imm20_jal[0], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u187 (imm12_i[0], ins_in[20]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u188 (imm12_b[0], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u189 (imm12_s[0], ins_in[7]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  or u19 (n15, n14, ins_amominud);  // ../../RTL/CPU/ID/ins_dec.v(342)
  or u190 (n46, ins_lb, ins_lbu);  // ../../RTL/CPU/ID/ins_dec.v(517)
  or u191 (sbyte, n46, ins_sb);  // ../../RTL/CPU/ID/ins_dec.v(517)
  or u192 (n47, ins_lh, ins_lhu);  // ../../RTL/CPU/ID/ins_dec.v(518)
  or u193 (dbyte, n47, ins_sh);  // ../../RTL/CPU/ID/ins_dec.v(518)
  or u194 (n48, ins_lw, ins_lwu);  // ../../RTL/CPU/ID/ins_dec.v(519)
  or u195 (n49, n48, ins_sw);  // ../../RTL/CPU/ID/ins_dec.v(519)
  or u196 (n50, n49, op_32_imm);  // ../../RTL/CPU/ID/ins_dec.v(519)
  or u197 (n51, n50, op_32_reg);  // ../../RTL/CPU/ID/ins_dec.v(519)
  buf u198 (imm5_csr[12], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  or u199 (qbyte, n51, n42);  // ../../RTL/CPU/ID/ins_dec.v(519)
  buf u2 (imm12_s[3], ins_in[10]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  or u20 (n16, n15, ins_lb);  // ../../RTL/CPU/ID/ins_dec.v(343)
  or u200 (n52, sbyte, dbyte);  // ../../RTL/CPU/ID/ins_dec.v(520)
  or u201 (n53, n52, qbyte);  // ../../RTL/CPU/ID/ins_dec.v(520)
  not u202 (obyte, n53);  // ../../RTL/CPU/ID/ins_dec.v(520)
  or u203 (n54, ins_slliw, ins_srliw);  // ../../RTL/CPU/ID/ins_dec.v(522)
  or u204 (n55, n54, ins_sraiw);  // ../../RTL/CPU/ID/ins_dec.v(522)
  or u205 (n56, ins_slli, ins_srli);  // ../../RTL/CPU/ID/ins_dec.v(523)
  or u206 (n57, n56, ins_srai);  // ../../RTL/CPU/ID/ins_dec.v(523)
  or u207 (n59, op_jal, op_jalr);  // ../../RTL/CPU/ID/ins_dec.v(529)
  or u208 (n60, n59, op_lui);  // ../../RTL/CPU/ID/ins_dec.v(529)
  or u209 (n61, n60, op_auipc);  // ../../RTL/CPU/ID/ins_dec.v(529)
  or u21 (n17, n16, ins_lbu);  // ../../RTL/CPU/ID/ins_dec.v(343)
  or u210 (n62, op_reg, op_32_reg);  // ../../RTL/CPU/ID/ins_dec.v(530)
  or u211 (n63, n62, op_branch);  // ../../RTL/CPU/ID/ins_dec.v(530)
  or u212 (n64, n63, op_store);  // ../../RTL/CPU/ID/ins_dec.v(530)
  or u213 (n65, n64, op_amo);  // ../../RTL/CPU/ID/ins_dec.v(530)
  buf u214 (imm5_csr[0], ins_in[7]);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u215 (dec_rd_index[0], ins_in[7]);  // ../../RTL/CPU/ID/ins_dec.v(531)
  buf u216 (dec_csr_index[0], ins_in[20]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  or u217 (n66, op_branch, ins_jalr);  // ../../RTL/CPU/ID/ins_dec.v(538)
  or u218 (dec_branch, n66, ins_jal);  // ../../RTL/CPU/ID/ins_dec.v(538)
  or u219 (n67, op_branch, op_store);  // ../../RTL/CPU/ID/ins_dec.v(545)
  or u22 (n18, n17, ins_lh);  // ../../RTL/CPU/ID/ins_dec.v(343)
  or u220 (n68, n67, ins_fence);  // ../../RTL/CPU/ID/ins_dec.v(545)
  or u221 (n69, n68, ins_mret);  // ../../RTL/CPU/ID/ins_dec.v(545)
  or u222 (n70, n69, ins_sret);  // ../../RTL/CPU/ID/ins_dec.v(545)
  not u223 (dec_gpr_write, n70);  // ../../RTL/CPU/ID/ins_dec.v(545)
  or u224 (n71, ins_csrrc, ins_csrrci);  // ../../RTL/CPU/ID/ins_dec.v(550)
  or u225 (n72, n71, ins_csrrs);  // ../../RTL/CPU/ID/ins_dec.v(550)
  or u226 (n73, n72, ins_csrrsi);  // ../../RTL/CPU/ID/ins_dec.v(550)
  or u227 (n74, n73, ins_csrrw);  // ../../RTL/CPU/ID/ins_dec.v(550)
  or u228 (n75, n74, ins_csrrwi);  // ../../RTL/CPU/ID/ins_dec.v(550)
  or u229 (n78, n76, n77);  // ../../RTL/CPU/ID/ins_dec.v(550)
  or u23 (n19, n18, ins_lhu);  // ../../RTL/CPU/ID/ins_dec.v(343)
  and u230 (n81, n79, n80);  // ../../RTL/CPU/ID/ins_dec.v(550)
  or u231 (n82, n78, n81);  // ../../RTL/CPU/ID/ins_dec.v(550)
  AL_MUX u232 (
    .i0(1'b0),
    .i1(n82),
    .sel(n75),
    .o(dec_csr_acc_fault));  // ../../RTL/CPU/ID/ins_dec.v(550)
  and u233 (n83, tsr, ins_sret);  // ../../RTL/CPU/ID/ins_dec.v(552)
  buf u234 (imm5_csr[11], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u235 (imm5_csr[10], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u236 (imm5_csr[9], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u237 (imm5_csr[8], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u238 (imm5_csr[7], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u239 (imm5_csr[6], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  or u24 (n20, n19, ins_lw);  // ../../RTL/CPU/ID/ins_dec.v(343)
  and u240 (n84, n75, n77);  // ../../RTL/CPU/ID/ins_dec.v(552)
  and u241 (n86, n84, n85);  // ../../RTL/CPU/ID/ins_dec.v(552)
  or u242 (n87, ins_sfencevma, n86);  // ../../RTL/CPU/ID/ins_dec.v(552)
  and u243 (n88, tvm, n87);  // ../../RTL/CPU/ID/ins_dec.v(552)
  or u244 (n89, n83, n88);  // ../../RTL/CPU/ID/ins_dec.v(552)
  and u245 (n90, tw, ins_wfi);  // ../../RTL/CPU/ID/ins_dec.v(553)
  or u246 (n91, n89, n90);  // ../../RTL/CPU/ID/ins_dec.v(553)
  buf u247 (imm5_csr[5], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u248 (n92, n77, ins_mret);  // ../../RTL/CPU/ID/ins_dec.v(554)
  or u249 (dec_ins_unpermit, n91, n92);  // ../../RTL/CPU/ID/ins_dec.v(554)
  or u25 (n21, n20, ins_lwu);  // ../../RTL/CPU/ID/ins_dec.v(343)
  or u250 (n93, op_system, op_imm);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u251 (n94, n93, op_32_imm);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u252 (n95, n94, op_lui);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u253 (n96, n95, op_auipc);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u254 (n97, n96, op_jal);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u255 (n98, n97, op_jalr);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u256 (n99, n98, op_branch);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u257 (n100, n99, op_store);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u258 (n101, n100, op_load);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u259 (n102, n101, op_reg);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u26 (n22, n21, ins_ld);  // ../../RTL/CPU/ID/ins_dec.v(343)
  or u260 (n103, n102, op_32_reg);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u261 (n104, n103, op_amo);  // ../../RTL/CPU/ID/ins_dec.v(556)
  not u262 (dec_ins_dec_fault, n104);  // ../../RTL/CPU/ID/ins_dec.v(556)
  or u263 (n105, dec_ins_unpermit, dec_csr_acc_fault);  // ../../RTL/CPU/ID/ins_dec.v(557)
  or u264 (dec_ill_ins, n105, dec_ins_dec_fault);  // ../../RTL/CPU/ID/ins_dec.v(557)
  not u265 (n106, valid_if);  // ../../RTL/CPU/ID/ins_dec.v(561)
  or u266 (n107, rst, n106);  // ../../RTL/CPU/ID/ins_dec.v(561)
  or u267 (n108, ins_lui, ins_slli);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u268 (n109, n108, ins_slliw);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u269 (n110, n109, ins_srli);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u27 (n23, n22, ins_lrw);  // ../../RTL/CPU/ID/ins_dec.v(343)
  or u270 (n111, n110, ins_srliw);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u271 (n112, n111, ins_srai);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u272 (n113, n112, ins_sraiw);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u273 (n114, n113, ins_sll);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u274 (n115, n114, ins_sllw);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u275 (n116, n115, ins_srl);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u276 (n117, n116, ins_srlw);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u277 (n118, n117, ins_sra);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u278 (n119, n118, ins_sraw);  // ../../RTL/CPU/ID/ins_dec.v(613)
  or u279 (n120, n119, ins_csrrc);  // ../../RTL/CPU/ID/ins_dec.v(614)
  or u28 (n24, n23, ins_lrd);  // ../../RTL/CPU/ID/ins_dec.v(343)
  or u280 (n121, n120, ins_csrrci);  // ../../RTL/CPU/ID/ins_dec.v(614)
  or u281 (n122, n121, ins_csrrs);  // ../../RTL/CPU/ID/ins_dec.v(614)
  or u282 (n123, n122, ins_csrrsi);  // ../../RTL/CPU/ID/ins_dec.v(614)
  or u283 (n124, n123, ins_csrrw);  // ../../RTL/CPU/ID/ins_dec.v(614)
  or u284 (n125, n124, ins_csrrwi);  // ../../RTL/CPU/ID/ins_dec.v(614)
  or u285 (n126, n125, ds1_mem_iden);  // ../../RTL/CPU/ID/ins_dec.v(614)
  or u286 (n127, ins_auipc, ins_jal);  // ../../RTL/CPU/ID/ins_dec.v(617)
  or u287 (n128, n127, ins_jalr);  // ../../RTL/CPU/ID/ins_dec.v(617)
  or u288 (n129, n128, ins_addi);  // ../../RTL/CPU/ID/ins_dec.v(617)
  or u289 (n130, n129, ins_addiw);  // ../../RTL/CPU/ID/ins_dec.v(617)
  or u29 (ds1_mem_iden, n12, n24);  // ../../RTL/CPU/ID/ins_dec.v(343)
  or u290 (n131, n130, ins_add);  // ../../RTL/CPU/ID/ins_dec.v(617)
  or u291 (n132, n131, ins_addw);  // ../../RTL/CPU/ID/ins_dec.v(617)
  or u292 (n133, ins_sub, ins_subw);  // ../../RTL/CPU/ID/ins_dec.v(618)
  or u293 (n134, ins_andi, ins_and);  // ../../RTL/CPU/ID/ins_dec.v(619)
  or u294 (n135, ins_ori, ins_or);  // ../../RTL/CPU/ID/ins_dec.v(620)
  or u295 (n136, ins_xori, ins_xor);  // ../../RTL/CPU/ID/ins_dec.v(621)
  or u296 (n137, ins_slti, ins_sltiu);  // ../../RTL/CPU/ID/ins_dec.v(622)
  or u297 (n138, n137, ins_slt);  // ../../RTL/CPU/ID/ins_dec.v(622)
  or u298 (n139, n138, ins_sltu);  // ../../RTL/CPU/ID/ins_dec.v(622)
  or u299 (n140, ins_scw, ins_scd);  // ../../RTL/CPU/ID/ins_dec.v(624)
  buf u3 (imm12_s[2], ins_in[9]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u30 (imm5_csr[42], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  or u300 (n141, ins_csrrw, ins_csrrwi);  // ../../RTL/CPU/ID/ins_dec.v(628)
  or u301 (n142, n141, ins_scw);  // ../../RTL/CPU/ID/ins_dec.v(628)
  or u302 (n143, n142, ins_scd);  // ../../RTL/CPU/ID/ins_dec.v(628)
  or u303 (n144, n143, ins_amoswapd);  // ../../RTL/CPU/ID/ins_dec.v(628)
  or u304 (n145, n144, ins_amoswapw);  // ../../RTL/CPU/ID/ins_dec.v(628)
  or u305 (n146, ins_amoaddd, ins_addw);  // ../../RTL/CPU/ID/ins_dec.v(629)
  buf u306 (imm5_csr[4], ins_in[11]);  // ../../RTL/CPU/ID/ins_dec.v(513)
  or u307 (n147, n71, ins_amoandd);  // ../../RTL/CPU/ID/ins_dec.v(630)
  or u308 (n148, n147, ins_amoandw);  // ../../RTL/CPU/ID/ins_dec.v(630)
  or u309 (n149, ins_csrrs, ins_csrrsi);  // ../../RTL/CPU/ID/ins_dec.v(631)
  buf u31 (imm12_s[1], ins_in[8]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  or u310 (n150, n149, ins_amoord);  // ../../RTL/CPU/ID/ins_dec.v(631)
  or u311 (n151, n150, ins_amoorw);  // ../../RTL/CPU/ID/ins_dec.v(631)
  or u312 (n152, ins_amoxord, ins_amoxorw);  // ../../RTL/CPU/ID/ins_dec.v(632)
  or u313 (n153, ins_amomaxw, ins_amomaxuw);  // ../../RTL/CPU/ID/ins_dec.v(633)
  or u314 (n154, n153, ins_amomaxd);  // ../../RTL/CPU/ID/ins_dec.v(633)
  or u315 (n155, n154, ins_amomaxud);  // ../../RTL/CPU/ID/ins_dec.v(633)
  or u316 (n156, ins_amominw, ins_amominuw);  // ../../RTL/CPU/ID/ins_dec.v(634)
  or u317 (n157, n156, ins_amomind);  // ../../RTL/CPU/ID/ins_dec.v(634)
  or u318 (n158, n157, ins_amominud);  // ../../RTL/CPU/ID/ins_dec.v(634)
  AL_MUX u319 (
    .i0(n126),
    .i1(rd_data_ds1),
    .sel(id_hold),
    .o(n159));  // ../../RTL/CPU/ID/ins_dec.v(635)
  buf u32 (imm5_csr[63], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u320 (
    .i0(n132),
    .i1(rd_data_add),
    .sel(id_hold),
    .o(n160));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u321 (
    .i0(n133),
    .i1(rd_data_sub),
    .sel(id_hold),
    .o(n161));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u322 (
    .i0(n134),
    .i1(rd_data_and),
    .sel(id_hold),
    .o(n162));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u323 (
    .i0(n135),
    .i1(rd_data_or),
    .sel(id_hold),
    .o(n163));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u324 (
    .i0(n136),
    .i1(rd_data_xor),
    .sel(id_hold),
    .o(n164));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u325 (
    .i0(n139),
    .i1(rd_data_slt),
    .sel(id_hold),
    .o(n165));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u326 (
    .i0(op_branch),
    .i1(compare),
    .sel(id_hold),
    .o(n166));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u327 (
    .i0(n140),
    .i1(amo_lr_sc),
    .sel(id_hold),
    .o(n167));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u328 (
    .i0(n145),
    .i1(mem_csr_data_ds2),
    .sel(id_hold),
    .o(n168));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u329 (
    .i0(n146),
    .i1(mem_csr_data_add),
    .sel(id_hold),
    .o(n169));  // ../../RTL/CPU/ID/ins_dec.v(635)
  buf u33 (imm5_csr[62], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u330 (
    .i0(n148),
    .i1(mem_csr_data_and),
    .sel(id_hold),
    .o(n170));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u331 (
    .i0(n151),
    .i1(mem_csr_data_or),
    .sel(id_hold),
    .o(n171));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u332 (
    .i0(n152),
    .i1(mem_csr_data_xor),
    .sel(id_hold),
    .o(n172));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u333 (
    .i0(n155),
    .i1(mem_csr_data_max),
    .sel(id_hold),
    .o(n173));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u334 (
    .i0(n158),
    .i1(mem_csr_data_min),
    .sel(id_hold),
    .o(n174));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u335 (
    .i0(n159),
    .i1(1'b0),
    .sel(n107),
    .o(n175));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u336 (
    .i0(n160),
    .i1(1'b0),
    .sel(n107),
    .o(n176));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u337 (
    .i0(n161),
    .i1(1'b0),
    .sel(n107),
    .o(n177));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u338 (
    .i0(n162),
    .i1(1'b0),
    .sel(n107),
    .o(n178));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u339 (
    .i0(n163),
    .i1(1'b0),
    .sel(n107),
    .o(n179));  // ../../RTL/CPU/ID/ins_dec.v(635)
  buf u34 (imm5_csr[61], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u340 (
    .i0(n164),
    .i1(1'b0),
    .sel(n107),
    .o(n180));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u341 (
    .i0(n165),
    .i1(1'b0),
    .sel(n107),
    .o(n181));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u342 (
    .i0(n166),
    .i1(1'b0),
    .sel(n107),
    .o(n182));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u343 (
    .i0(n167),
    .i1(1'b0),
    .sel(n107),
    .o(n183));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u344 (
    .i0(mem_csr_data_ds1),
    .i1(1'b0),
    .sel(n107),
    .o(n184));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u345 (
    .i0(n168),
    .i1(1'b0),
    .sel(n107),
    .o(n185));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u346 (
    .i0(n169),
    .i1(1'b0),
    .sel(n107),
    .o(n186));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u347 (
    .i0(n170),
    .i1(1'b0),
    .sel(n107),
    .o(n187));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u348 (
    .i0(n171),
    .i1(1'b0),
    .sel(n107),
    .o(n188));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u349 (
    .i0(n172),
    .i1(1'b0),
    .sel(n107),
    .o(n189));  // ../../RTL/CPU/ID/ins_dec.v(635)
  buf u35 (imm5_csr[60], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u350 (
    .i0(n173),
    .i1(1'b0),
    .sel(n107),
    .o(n190));  // ../../RTL/CPU/ID/ins_dec.v(635)
  AL_MUX u351 (
    .i0(n174),
    .i1(1'b0),
    .sel(n107),
    .o(n191));  // ../../RTL/CPU/ID/ins_dec.v(635)
  buf u352 (imm5_csr[3], ins_in[10]);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u353 (imm5_csr[2], ins_in[9]);  // ../../RTL/CPU/ID/ins_dec.v(513)
  or u354 (n192, ins_blt, ins_bltu);  // ../../RTL/CPU/ID/ins_dec.v(663)
  or u355 (n193, ins_bge, ins_bgeu);  // ../../RTL/CPU/ID/ins_dec.v(664)
  or u356 (n194, ins_jal, ins_jalr);  // ../../RTL/CPU/ID/ins_dec.v(667)
  or u357 (n195, ins_bltu, ins_bgeu);  // ../../RTL/CPU/ID/ins_dec.v(668)
  or u358 (n196, n195, ins_lbu);  // ../../RTL/CPU/ID/ins_dec.v(668)
  or u359 (n197, n196, ins_lhu);  // ../../RTL/CPU/ID/ins_dec.v(668)
  buf u36 (imm5_csr[59], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  or u360 (n198, n197, ins_lwu);  // ../../RTL/CPU/ID/ins_dec.v(668)
  or u361 (n199, n198, ins_srai);  // ../../RTL/CPU/ID/ins_dec.v(668)
  or u362 (n200, n199, ins_sraiw);  // ../../RTL/CPU/ID/ins_dec.v(668)
  or u363 (n201, n200, ins_sraw);  // ../../RTL/CPU/ID/ins_dec.v(669)
  or u364 (n202, n201, ins_sra);  // ../../RTL/CPU/ID/ins_dec.v(669)
  or u365 (n203, n202, ins_amomaxuw);  // ../../RTL/CPU/ID/ins_dec.v(669)
  or u366 (n204, n203, ins_amomaxud);  // ../../RTL/CPU/ID/ins_dec.v(669)
  or u367 (n205, n204, ins_amominud);  // ../../RTL/CPU/ID/ins_dec.v(669)
  or u368 (n206, n205, ins_amominuw);  // ../../RTL/CPU/ID/ins_dec.v(669)
  buf u369 (imm5_csr[1], ins_in[8]);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u37 (imm5_csr[58], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u370 (
    .i0(n192),
    .i1(blt),
    .sel(id_hold),
    .o(n207));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u371 (
    .i0(n193),
    .i1(bge),
    .sel(id_hold),
    .o(n208));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u372 (
    .i0(ins_beq),
    .i1(beq),
    .sel(id_hold),
    .o(n209));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u373 (
    .i0(ins_bne),
    .i1(bne),
    .sel(id_hold),
    .o(n210));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u374 (
    .i0(n194),
    .i1(jmp),
    .sel(id_hold),
    .o(n211));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u375 (
    .i0(n206),
    .i1(unsign),
    .sel(id_hold),
    .o(n212));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u376 (
    .i0(n71),
    .i1(and_clr),
    .sel(id_hold),
    .o(n213));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u377 (
    .i0(ds1_mem_iden),
    .i1(ds1_sel),
    .sel(id_hold),
    .o(n214));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u378 (
    .i0(n207),
    .i1(1'b0),
    .sel(n107),
    .o(n215));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u379 (
    .i0(n208),
    .i1(1'b0),
    .sel(n107),
    .o(n216));  // ../../RTL/CPU/ID/ins_dec.v(673)
  buf u38 (imm5_csr[57], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u380 (
    .i0(n209),
    .i1(1'b0),
    .sel(n107),
    .o(n217));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u381 (
    .i0(n210),
    .i1(1'b0),
    .sel(n107),
    .o(n218));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u382 (
    .i0(n211),
    .i1(1'b0),
    .sel(n107),
    .o(n219));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u383 (
    .i0(n212),
    .i1(1'b0),
    .sel(n107),
    .o(n220));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u384 (
    .i0(n213),
    .i1(1'b0),
    .sel(n107),
    .o(n221));  // ../../RTL/CPU/ID/ins_dec.v(673)
  AL_MUX u385 (
    .i0(n214),
    .i1(1'b0),
    .sel(n107),
    .o(n222));  // ../../RTL/CPU/ID/ins_dec.v(673)
  buf u386 (dec_rd_index[4], ins_in[11]);  // ../../RTL/CPU/ID/ins_dec.v(531)
  buf u387 (dec_rd_index[3], ins_in[10]);  // ../../RTL/CPU/ID/ins_dec.v(531)
  buf u388 (dec_rd_index[2], ins_in[9]);  // ../../RTL/CPU/ID/ins_dec.v(531)
  buf u389 (dec_rd_index[1], ins_in[8]);  // ../../RTL/CPU/ID/ins_dec.v(531)
  buf u39 (imm5_csr[56], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  or u390 (n225, ins_sfencevma, ins_fence);  // ../../RTL/CPU/ID/ins_dec.v(729)
  or u391 (n226, ins_srli, ins_srliw);  // ../../RTL/CPU/ID/ins_dec.v(730)
  or u392 (n227, n226, ins_srai);  // ../../RTL/CPU/ID/ins_dec.v(730)
  or u393 (n228, n227, ins_sraiw);  // ../../RTL/CPU/ID/ins_dec.v(730)
  or u394 (n229, n228, ins_srl);  // ../../RTL/CPU/ID/ins_dec.v(730)
  or u395 (n230, n229, ins_srlw);  // ../../RTL/CPU/ID/ins_dec.v(730)
  or u396 (n231, n230, ins_sra);  // ../../RTL/CPU/ID/ins_dec.v(730)
  or u397 (n232, n231, ins_sraw);  // ../../RTL/CPU/ID/ins_dec.v(730)
  or u398 (n233, ins_slli, ins_slliw);  // ../../RTL/CPU/ID/ins_dec.v(731)
  or u399 (n234, n233, ins_sll);  // ../../RTL/CPU/ID/ins_dec.v(731)
  or u4 (n0, ins_amoswapd, ins_amoswapw);  // ../../RTL/CPU/ID/ins_dec.v(340)
  buf u40 (imm5_csr[55], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  or u400 (n235, n234, ins_sllw);  // ../../RTL/CPU/ID/ins_dec.v(731)
  buf u401 (dec_csr_index[11], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  or u402 (n236, n141, ins_csrrci);  // ../../RTL/CPU/ID/ins_dec.v(732)
  or u403 (n237, n236, ins_csrrc);  // ../../RTL/CPU/ID/ins_dec.v(732)
  or u404 (n238, n237, ins_csrrs);  // ../../RTL/CPU/ID/ins_dec.v(732)
  or u405 (n239, n238, ins_csrrsi);  // ../../RTL/CPU/ID/ins_dec.v(732)
  AL_MUX u406 (
    .i0(op_load),
    .i1(load),
    .sel(id_hold),
    .o(n240));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u407 (
    .i0(op_store),
    .i1(store),
    .sel(id_hold),
    .o(n241));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u408 (
    .i0(op_amo),
    .i1(amo),
    .sel(id_hold),
    .o(n242));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u409 (
    .i0(ins_fence),
    .i1(cache_flush),
    .sel(id_hold),
    .o(n243));  // ../../RTL/CPU/ID/ins_dec.v(738)
  buf u41 (imm5_csr[54], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u410 (
    .i0(n225),
    .i1(cache_reset),
    .sel(id_hold),
    .o(n244));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u411 (
    .i0(n232),
    .i1(shift_r),
    .sel(id_hold),
    .o(n245));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u412 (
    .i0(n235),
    .i1(shift_l),
    .sel(id_hold),
    .o(n246));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u413 (
    .i0(n239),
    .i1(csr_write),
    .sel(id_hold),
    .o(n247));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u414 (
    .i0(dec_gpr_write),
    .i1(gpr_write),
    .sel(id_hold),
    .o(n248));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u415 (
    .i0(n240),
    .i1(1'b0),
    .sel(n107),
    .o(n253));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u416 (
    .i0(n241),
    .i1(1'b0),
    .sel(n107),
    .o(n254));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u417 (
    .i0(n242),
    .i1(1'b0),
    .sel(n107),
    .o(n255));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u418 (
    .i0(n243),
    .i1(1'b0),
    .sel(n107),
    .o(n256));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u419 (
    .i0(n244),
    .i1(1'b0),
    .sel(n107),
    .o(n257));  // ../../RTL/CPU/ID/ins_dec.v(738)
  buf u42 (imm5_csr[53], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u420 (
    .i0(n245),
    .i1(1'b0),
    .sel(n107),
    .o(n258));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u421 (
    .i0(n246),
    .i1(1'b0),
    .sel(n107),
    .o(n259));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u422 (
    .i0(n247),
    .i1(1'b0),
    .sel(n107),
    .o(n260));  // ../../RTL/CPU/ID/ins_dec.v(738)
  AL_MUX u423 (
    .i0(n248),
    .i1(1'b0),
    .sel(n107),
    .o(n261));  // ../../RTL/CPU/ID/ins_dec.v(738)
  buf u424 (dec_csr_index[10], ins_in[30]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  buf u425 (dec_csr_index[9], ins_in[29]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  or u426 (n266, op_branch, op_reg);  // ../../RTL/CPU/ID/ins_dec.v(760)
  or u427 (n267, n266, op_32_reg);  // ../../RTL/CPU/ID/ins_dec.v(760)
  or u428 (n268, n267, op_imm);  // ../../RTL/CPU/ID/ins_dec.v(760)
  or u429 (n269, n268, op_32_imm);  // ../../RTL/CPU/ID/ins_dec.v(760)
  buf u43 (imm5_csr[52], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u430 (dec_csr_index[8], ins_in[28]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  buf u431 (dec_csr_index[7], ins_in[27]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  or u432 (n273, n267, op_store);  // ../../RTL/CPU/ID/ins_dec.v(763)
  or u433 (n274, n273, op_amo);  // ../../RTL/CPU/ID/ins_dec.v(763)
  or u434 (n275, op_32_imm, op_imm);  // ../../RTL/CPU/ID/ins_dec.v(764)
  or u435 (n276, ins_csrrwi, ins_csrrci);  // ../../RTL/CPU/ID/ins_dec.v(765)
  or u436 (n277, n276, ins_csrrsi);  // ../../RTL/CPU/ID/ins_dec.v(765)
  or u437 (n278, ins_csrrw, ins_csrrc);  // ../../RTL/CPU/ID/ins_dec.v(766)
  or u438 (n279, n278, ins_csrrs);  // ../../RTL/CPU/ID/ins_dec.v(766)
  or u439 (n285, op_branch, ins_jal);  // ../../RTL/CPU/ID/ins_dec.v(769)
  buf u44 (imm5_csr[51], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u440 (dec_csr_index[6], ins_in[26]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  buf u441 (dec_csr_index[5], ins_in[25]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  buf u442 (dec_csr_index[4], ins_in[24]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  or u443 (n302, n285, ins_jalr);  // ../../RTL/CPU/ID/ins_dec.v(817)
  not u444 (n303, dec_ill_ins);  // ../../RTL/CPU/ID/ins_dec.v(824)
  and u445 (n304, n303, ins_mret);  // ../../RTL/CPU/ID/ins_dec.v(824)
  buf u446 (dec_csr_index[3], ins_in[23]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  and u447 (n305, n303, ins_sret);  // ../../RTL/CPU/ID/ins_dec.v(825)
  AL_MUX u448 (
    .i0(op_system),
    .i1(id_system),
    .sel(id_hold),
    .o(n306));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u449 (
    .i0(n302),
    .i1(id_jmp),
    .sel(id_hold),
    .o(n307));  // ../../RTL/CPU/ID/ins_dec.v(828)
  buf u45 (imm5_csr[50], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u450 (
    .i0(ins_acc_fault_if),
    .i1(ins_acc_fault),
    .sel(id_hold),
    .o(n308));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u451 (
    .i0(ins_addr_mis_if),
    .i1(ins_addr_mis),
    .sel(id_hold),
    .o(n309));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u452 (
    .i0(ins_page_fault_if),
    .i1(ins_page_fault),
    .sel(id_hold),
    .o(n310));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u453 (
    .i0(int_acc_if),
    .i1(int_acc),
    .sel(id_hold),
    .o(n311));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u454 (
    .i0(valid_if),
    .i1(valid),
    .sel(id_hold),
    .o(n312));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u455 (
    .i0(dec_ill_ins),
    .i1(ill_ins),
    .sel(id_hold),
    .o(n313));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u456 (
    .i0(n304),
    .i1(m_ret),
    .sel(id_hold),
    .o(n314));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u457 (
    .i0(n305),
    .i1(s_ret),
    .sel(id_hold),
    .o(n315));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u458 (
    .i0(ins_ecall),
    .i1(ecall),
    .sel(id_hold),
    .o(n316));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u459 (
    .i0(ins_ebreak),
    .i1(ebreak),
    .sel(id_hold),
    .o(n317));  // ../../RTL/CPU/ID/ins_dec.v(828)
  buf u46 (imm5_csr[49], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u460 (
    .i0(n312),
    .i1(1'b0),
    .sel(id_nop),
    .o(n318));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u461 (
    .i0(n306),
    .i1(id_system),
    .sel(id_nop),
    .o(n319));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u462 (
    .i0(n307),
    .i1(id_jmp),
    .sel(id_nop),
    .o(n320));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u463 (
    .i0(n308),
    .i1(ins_acc_fault),
    .sel(id_nop),
    .o(n321));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u464 (
    .i0(n309),
    .i1(ins_addr_mis),
    .sel(id_nop),
    .o(n322));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u465 (
    .i0(n310),
    .i1(ins_page_fault),
    .sel(id_nop),
    .o(n323));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u466 (
    .i0(n311),
    .i1(int_acc),
    .sel(id_nop),
    .o(n324));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u467 (
    .i0(n313),
    .i1(ill_ins),
    .sel(id_nop),
    .o(n325));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u468 (
    .i0(n314),
    .i1(m_ret),
    .sel(id_nop),
    .o(n326));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u469 (
    .i0(n315),
    .i1(s_ret),
    .sel(id_nop),
    .o(n327));  // ../../RTL/CPU/ID/ins_dec.v(828)
  buf u47 (imm5_csr[48], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u470 (
    .i0(n316),
    .i1(ecall),
    .sel(id_nop),
    .o(n328));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u471 (
    .i0(n317),
    .i1(ebreak),
    .sel(id_nop),
    .o(n329));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u472 (
    .i0(n319),
    .i1(1'b0),
    .sel(n107),
    .o(n330));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u473 (
    .i0(n320),
    .i1(1'b0),
    .sel(n107),
    .o(n331));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u474 (
    .i0(n321),
    .i1(1'b0),
    .sel(n107),
    .o(n332));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u475 (
    .i0(n322),
    .i1(1'b0),
    .sel(n107),
    .o(n333));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u476 (
    .i0(n323),
    .i1(1'b0),
    .sel(n107),
    .o(n334));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u477 (
    .i0(n324),
    .i1(1'b0),
    .sel(n107),
    .o(n335));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u478 (
    .i0(n318),
    .i1(1'b0),
    .sel(n107),
    .o(n336));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u479 (
    .i0(n325),
    .i1(1'b0),
    .sel(n107),
    .o(n337));  // ../../RTL/CPU/ID/ins_dec.v(828)
  buf u48 (imm5_csr[47], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  AL_MUX u480 (
    .i0(n326),
    .i1(1'b0),
    .sel(n107),
    .o(n338));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u481 (
    .i0(n327),
    .i1(1'b0),
    .sel(n107),
    .o(n339));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u482 (
    .i0(n328),
    .i1(1'b0),
    .sel(n107),
    .o(n340));  // ../../RTL/CPU/ID/ins_dec.v(828)
  AL_MUX u483 (
    .i0(n329),
    .i1(1'b0),
    .sel(n107),
    .o(n341));  // ../../RTL/CPU/ID/ins_dec.v(828)
  buf u484 (dec_csr_index[2], ins_in[22]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  buf u485 (dec_csr_index[1], ins_in[21]);  // ../../RTL/CPU/ID/ins_dec.v(532)
  buf u486 (imm12_s[4], ins_in[11]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u487 (imm12_s[5], ins_in[25]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u488 (imm12_s[6], ins_in[26]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u489 (imm12_s[7], ins_in[27]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u49 (imm5_csr[46], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u490 (imm12_s[8], ins_in[28]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u491 (imm12_s[9], ins_in[29]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u492 (imm12_s[10], ins_in[30]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u493 (imm12_s[11], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u494 (imm12_s[12], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u495 (imm12_s[13], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u496 (imm12_s[14], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u497 (imm12_s[15], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u498 (imm12_s[16], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u499 (imm12_s[17], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  or u5 (n1, n0, ins_amoaddw);  // ../../RTL/CPU/ID/ins_dec.v(340)
  buf u50 (imm5_csr[45], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u500 (imm12_s[18], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u501 (imm12_s[19], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u502 (imm12_s[20], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u503 (imm12_s[21], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u504 (imm12_s[22], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u505 (imm12_s[23], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u506 (imm12_s[24], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u507 (imm12_s[25], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u508 (imm12_s[26], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u509 (imm12_s[27], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u51 (imm5_csr[44], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  buf u510 (imm12_s[28], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u511 (imm12_s[29], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u512 (imm12_s[30], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u513 (imm12_s[31], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u514 (imm12_s[32], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u515 (imm12_s[33], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u516 (imm12_s[34], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u517 (imm12_s[35], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u518 (imm12_s[36], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u519 (imm12_s[37], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u52 (ins_lui, op_lui);  // ../../RTL/CPU/ID/ins_dec.v(418)
  buf u520 (imm12_s[38], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u521 (imm12_s[39], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u522 (imm12_s[40], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u523 (imm12_s[41], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u524 (imm12_s[42], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u525 (imm12_s[43], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u526 (imm12_s[44], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u527 (imm12_s[45], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u528 (imm12_s[46], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u529 (imm12_s[47], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u53 (ins_auipc, op_auipc);  // ../../RTL/CPU/ID/ins_dec.v(419)
  buf u530 (imm12_s[48], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u531 (imm12_s[49], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u532 (imm12_s[50], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u533 (imm12_s[51], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u534 (imm12_s[52], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u535 (imm12_s[53], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u536 (imm12_s[54], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u537 (imm12_s[55], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u538 (imm12_s[56], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u539 (imm12_s[57], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u54 (ins_jal, op_jal);  // ../../RTL/CPU/ID/ins_dec.v(420)
  buf u540 (imm12_s[58], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u541 (imm12_s[59], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u542 (imm12_s[60], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u543 (imm12_s[61], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u544 (imm12_s[62], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u545 (imm12_s[63], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(511)
  buf u546 (imm12_b[1], ins_in[7]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u547 (imm12_b[2], ins_in[8]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u548 (imm12_b[3], ins_in[9]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u549 (imm12_b[4], ins_in[10]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u55 (ins_jalr, op_jalr);  // ../../RTL/CPU/ID/ins_dec.v(421)
  buf u550 (imm12_b[5], ins_in[11]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u551 (imm12_b[6], ins_in[25]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u552 (imm12_b[7], ins_in[26]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u553 (imm12_b[8], ins_in[27]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u554 (imm12_b[9], ins_in[28]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u555 (imm12_b[10], ins_in[29]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u556 (imm12_b[11], ins_in[30]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u557 (imm12_b[12], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u558 (imm12_b[13], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u559 (imm12_b[14], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  and u56 (ins_beq, op_branch, funct3_0);  // ../../RTL/CPU/ID/ins_dec.v(422)
  buf u560 (imm12_b[15], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u561 (imm12_b[16], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u562 (imm12_b[17], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u563 (imm12_b[18], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u564 (imm12_b[19], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u565 (imm12_b[20], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u566 (imm12_b[21], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u567 (imm12_b[22], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u568 (imm12_b[23], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u569 (imm12_b[24], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  and u57 (ins_bne, op_branch, funct3_1);  // ../../RTL/CPU/ID/ins_dec.v(423)
  buf u570 (imm12_b[25], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u571 (imm12_b[26], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u572 (imm12_b[27], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u573 (imm12_b[28], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u574 (imm12_b[29], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u575 (imm12_b[30], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u576 (imm12_b[31], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u577 (imm12_b[32], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u578 (imm12_b[33], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u579 (imm12_b[34], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  and u58 (ins_blt, op_branch, funct3_4);  // ../../RTL/CPU/ID/ins_dec.v(424)
  buf u580 (imm12_b[35], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u581 (imm12_b[36], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u582 (imm12_b[37], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u583 (imm12_b[38], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u584 (imm12_b[39], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u585 (imm12_b[40], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u586 (imm12_b[41], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u587 (imm12_b[42], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u588 (imm12_b[43], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u589 (imm12_b[44], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  and u59 (ins_bge, op_branch, funct3_5);  // ../../RTL/CPU/ID/ins_dec.v(425)
  buf u590 (imm12_b[45], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u591 (imm12_b[46], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u592 (imm12_b[47], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u593 (imm12_b[48], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u594 (imm12_b[49], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u595 (imm12_b[50], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u596 (imm12_b[51], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u597 (imm12_b[52], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u598 (imm12_b[53], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u599 (imm12_b[54], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  or u6 (n2, n1, ins_amoaddd);  // ../../RTL/CPU/ID/ins_dec.v(340)
  and u60 (ins_bltu, op_branch, funct3_6);  // ../../RTL/CPU/ID/ins_dec.v(426)
  buf u600 (imm12_b[55], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u601 (imm12_b[56], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u602 (imm12_b[57], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u603 (imm12_b[58], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u604 (imm12_b[59], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u605 (imm12_b[60], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u606 (imm12_b[61], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u607 (imm12_b[62], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u608 (imm12_b[63], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(510)
  buf u609 (imm12_i[1], ins_in[21]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  and u61 (ins_bgeu, op_branch, funct3_7);  // ../../RTL/CPU/ID/ins_dec.v(427)
  buf u610 (imm12_i[2], ins_in[22]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u611 (imm12_i[3], ins_in[23]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u612 (imm12_i[4], ins_in[24]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u613 (imm12_i[5], ins_in[25]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u614 (imm12_i[6], ins_in[26]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u615 (imm12_i[7], ins_in[27]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u616 (imm12_i[8], ins_in[28]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u617 (imm12_i[9], ins_in[29]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u618 (imm12_i[10], ins_in[30]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u619 (imm12_i[11], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  and u62 (ins_lb, op_load, funct3_0);  // ../../RTL/CPU/ID/ins_dec.v(428)
  buf u620 (imm12_i[12], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u621 (imm12_i[13], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u622 (imm12_i[14], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u623 (imm12_i[15], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u624 (imm12_i[16], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u625 (imm12_i[17], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u626 (imm12_i[18], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u627 (imm12_i[19], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u628 (imm12_i[20], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u629 (imm12_i[21], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  and u63 (ins_lh, op_load, funct3_1);  // ../../RTL/CPU/ID/ins_dec.v(429)
  buf u630 (imm12_i[22], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u631 (imm12_i[23], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u632 (imm12_i[24], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u633 (imm12_i[25], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u634 (imm12_i[26], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u635 (imm12_i[27], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u636 (imm12_i[28], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u637 (imm12_i[29], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u638 (imm12_i[30], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u639 (imm12_i[31], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  and u64 (ins_lw, op_load, funct3_2);  // ../../RTL/CPU/ID/ins_dec.v(430)
  buf u640 (imm12_i[32], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u641 (imm12_i[33], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u642 (imm12_i[34], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u643 (imm12_i[35], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u644 (imm12_i[36], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u645 (imm12_i[37], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u646 (imm12_i[38], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u647 (imm12_i[39], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u648 (imm12_i[40], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u649 (imm12_i[41], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  and u65 (ins_lbu, op_load, funct3_4);  // ../../RTL/CPU/ID/ins_dec.v(431)
  buf u650 (imm12_i[42], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u651 (imm12_i[43], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u652 (imm12_i[44], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u653 (imm12_i[45], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u654 (imm12_i[46], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u655 (imm12_i[47], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u656 (imm12_i[48], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u657 (imm12_i[49], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u658 (imm12_i[50], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u659 (imm12_i[51], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  and u66 (ins_lhu, op_load, funct3_5);  // ../../RTL/CPU/ID/ins_dec.v(432)
  buf u660 (imm12_i[52], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u661 (imm12_i[53], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u662 (imm12_i[54], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u663 (imm12_i[55], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u664 (imm12_i[56], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u665 (imm12_i[57], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u666 (imm12_i[58], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u667 (imm12_i[59], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u668 (imm12_i[60], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u669 (imm12_i[61], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(509)
  and u67 (ins_sb, op_store, funct3_0);  // ../../RTL/CPU/ID/ins_dec.v(433)
  buf u670 (imm12_i[62], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u671 (imm12_i[63], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(509)
  buf u672 (imm20_jal[1], ins_in[12]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u673 (imm20_jal[2], ins_in[13]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u674 (imm20_jal[3], ins_in[14]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u675 (imm20_jal[4], ins_in[15]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u676 (imm20_jal[5], ins_in[16]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u677 (imm20_jal[6], ins_in[17]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u678 (imm20_jal[7], ins_in[18]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u679 (imm20_jal[8], ins_in[19]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  and u68 (ins_sh, op_store, funct3_1);  // ../../RTL/CPU/ID/ins_dec.v(434)
  buf u680 (imm20_jal[9], ins_in[20]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u681 (imm20_jal[10], ins_in[21]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u682 (imm20_jal[11], ins_in[22]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u683 (imm20_jal[12], ins_in[23]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u684 (imm20_jal[13], ins_in[24]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u685 (imm20_jal[14], ins_in[25]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u686 (imm20_jal[15], ins_in[26]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u687 (imm20_jal[16], ins_in[27]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u688 (imm20_jal[17], ins_in[28]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u689 (imm20_jal[18], ins_in[29]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  and u69 (ins_sw, op_store, funct3_2);  // ../../RTL/CPU/ID/ins_dec.v(435)
  buf u690 (imm20_jal[19], ins_in[30]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u691 (imm20_jal[20], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u692 (imm20_jal[21], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u693 (imm20_jal[22], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u694 (imm20_jal[23], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u695 (imm20_jal[24], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u696 (imm20_jal[25], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u697 (imm20_jal[26], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u698 (imm20_jal[27], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u699 (imm20_jal[28], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  or u7 (n3, n2, ins_amoxorw);  // ../../RTL/CPU/ID/ins_dec.v(340)
  and u70 (ins_addi, op_imm, funct3_0);  // ../../RTL/CPU/ID/ins_dec.v(436)
  buf u700 (imm20_jal[29], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u701 (imm20_jal[30], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u702 (imm20_jal[31], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u703 (imm20_jal[32], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u704 (imm20_jal[33], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u705 (imm20_jal[34], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u706 (imm20_jal[35], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u707 (imm20_jal[36], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u708 (imm20_jal[37], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u709 (imm20_jal[38], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  and u71 (ins_slti, op_imm, funct3_2);  // ../../RTL/CPU/ID/ins_dec.v(437)
  buf u710 (imm20_jal[39], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u711 (imm20_jal[40], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u712 (imm20_jal[41], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u713 (imm20_jal[42], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u714 (imm20_jal[43], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u715 (imm20_jal[44], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u716 (imm20_jal[45], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u717 (imm20_jal[46], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u718 (imm20_jal[47], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u719 (imm20_jal[48], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  and u72 (ins_sltiu, op_imm, funct3_3);  // ../../RTL/CPU/ID/ins_dec.v(438)
  buf u720 (imm20_jal[49], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u721 (imm20_jal[50], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u722 (imm20_jal[51], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u723 (imm20_jal[52], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u724 (imm20_jal[53], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u725 (imm20_jal[54], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u726 (imm20_jal[55], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u727 (imm20_jal[56], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u728 (imm20_jal[57], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u729 (imm20_jal[58], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  and u73 (ins_xori, op_imm, funct3_4);  // ../../RTL/CPU/ID/ins_dec.v(439)
  buf u730 (imm20_jal[59], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u731 (imm20_jal[60], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u732 (imm20_jal[61], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u733 (imm20_jal[62], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u734 (imm20_jal[63], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(508)
  buf u735 (imm20[1], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u736 (imm20[2], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u737 (imm20[3], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u738 (imm20[4], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u739 (imm20[5], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  and u74 (ins_ori, op_imm, funct3_6);  // ../../RTL/CPU/ID/ins_dec.v(440)
  buf u740 (imm20[6], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u741 (imm20[7], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u742 (imm20[8], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u743 (imm20[9], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u744 (imm20[10], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u745 (imm20[11], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u746 (imm20[12], ins_in[12]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u747 (imm20[13], ins_in[13]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u748 (imm20[14], ins_in[14]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u749 (imm20[15], ins_in[15]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  and u75 (ins_andi, op_imm, funct3_7);  // ../../RTL/CPU/ID/ins_dec.v(441)
  buf u750 (imm20[16], ins_in[16]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u751 (imm20[17], ins_in[17]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u752 (imm20[18], ins_in[18]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u753 (imm20[19], ins_in[19]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u754 (imm20[20], ins_in[20]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u755 (imm20[21], ins_in[21]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u756 (imm20[22], ins_in[22]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u757 (imm20[23], ins_in[23]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u758 (imm20[24], ins_in[24]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u759 (imm20[25], ins_in[25]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  and u76 (n25, op_imm, funct3_1);  // ../../RTL/CPU/ID/ins_dec.v(442)
  buf u760 (imm20[26], ins_in[26]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u761 (imm20[27], ins_in[27]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u762 (imm20[28], ins_in[28]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u763 (imm20[29], ins_in[29]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u764 (imm20[30], ins_in[30]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u765 (imm20[31], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u766 (imm20[32], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u767 (imm20[33], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u768 (imm20[34], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u769 (imm20[35], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  and u77 (ins_slli, n25, funct6_0);  // ../../RTL/CPU/ID/ins_dec.v(442)
  buf u770 (imm20[36], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u771 (imm20[37], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u772 (imm20[38], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u773 (imm20[39], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u774 (imm20[40], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u775 (imm20[41], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u776 (imm20[42], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u777 (imm20[43], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u778 (imm20[44], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u779 (imm20[45], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  and u78 (n26, op_imm, funct3_5);  // ../../RTL/CPU/ID/ins_dec.v(443)
  buf u780 (imm20[46], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u781 (imm20[47], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u782 (imm20[48], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u783 (imm20[49], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u784 (imm20[50], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u785 (imm20[51], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u786 (imm20[52], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u787 (imm20[53], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u788 (imm20[54], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u789 (imm20[55], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  and u79 (ins_srli, n26, funct6_0);  // ../../RTL/CPU/ID/ins_dec.v(443)
  buf u790 (imm20[56], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u791 (imm20[57], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u792 (imm20[58], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u793 (imm20[59], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u794 (imm20[60], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u795 (imm20[61], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u796 (imm20[62], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  buf u797 (imm20[63], ins_in[31]);  // ../../RTL/CPU/ID/ins_dec.v(507)
  or u8 (n4, n3, ins_amoxord);  // ../../RTL/CPU/ID/ins_dec.v(340)
  buf u80 (imm5_csr[41], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u81 (ins_srai, n26, funct6_16);  // ../../RTL/CPU/ID/ins_dec.v(444)
  and u82 (n27, op_reg, funct3_0);  // ../../RTL/CPU/ID/ins_dec.v(445)
  and u83 (ins_add, n27, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(445)
  buf u84 (imm5_csr[40], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u85 (ins_sub, n27, funct7_32);  // ../../RTL/CPU/ID/ins_dec.v(446)
  and u86 (n28, op_reg, funct3_1);  // ../../RTL/CPU/ID/ins_dec.v(447)
  and u87 (ins_sll, n28, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(447)
  and u88 (n29, op_reg, funct3_2);  // ../../RTL/CPU/ID/ins_dec.v(448)
  and u89 (ins_slt, n29, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(448)
  or u9 (n5, n4, ins_amoandw);  // ../../RTL/CPU/ID/ins_dec.v(341)
  and u90 (n30, op_reg, funct3_3);  // ../../RTL/CPU/ID/ins_dec.v(449)
  and u91 (ins_sltu, n30, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(449)
  and u92 (n31, op_reg, funct3_4);  // ../../RTL/CPU/ID/ins_dec.v(450)
  and u93 (ins_xor, n31, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(450)
  and u94 (n32, op_reg, funct3_5);  // ../../RTL/CPU/ID/ins_dec.v(451)
  and u95 (ins_srl, n32, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(451)
  buf u96 (imm5_csr[39], 1'b0);  // ../../RTL/CPU/ID/ins_dec.v(513)
  and u97 (ins_sra, n32, funct7_32);  // ../../RTL/CPU/ID/ins_dec.v(452)
  and u98 (n33, op_reg, funct3_6);  // ../../RTL/CPU/ID/ins_dec.v(453)
  and u99 (ins_or, n33, funct7_0);  // ../../RTL/CPU/ID/ins_dec.v(453)
  AL_DFF unsign_reg (
    .clk(clk),
    .d(n220),
    .reset(1'b0),
    .set(1'b0),
    .q(unsign));  // ../../RTL/CPU/ID/ins_dec.v(674)
  AL_DFF valid_reg (
    .clk(clk),
    .d(n336),
    .reset(1'b0),
    .set(1'b0),
    .q(valid));  // ../../RTL/CPU/ID/ins_dec.v(830)

endmodule 

module ins_fetch  // ../../RTL/CPU/IF/ins_fetch.v(7)
  (
  cache_ready,
  clk,
  if_hold,
  ins_acc_fault_biu,
  ins_in,
  ins_page_fault_biu,
  int_req,
  new_pc,
  nop_if,
  pip_flush,
  priv,
  rst,
  addr,
  if_priv,
  ins_acc_fault,
  ins_addr_mis,
  ins_out,
  ins_page_fault,
  ins_pc,
  int_acc,
  rd,
  valid
  );

  input cache_ready;  // ../../RTL/CPU/IF/ins_fetch.v(30)
  input clk;  // ../../RTL/CPU/IF/ins_fetch.v(9)
  input if_hold;  // ../../RTL/CPU/IF/ins_fetch.v(18)
  input ins_acc_fault_biu;  // ../../RTL/CPU/IF/ins_fetch.v(28)
  input [63:0] ins_in;  // ../../RTL/CPU/IF/ins_fetch.v(27)
  input ins_page_fault_biu;  // ../../RTL/CPU/IF/ins_fetch.v(29)
  input int_req;  // ../../RTL/CPU/IF/ins_fetch.v(14)
  input [63:0] new_pc;  // ../../RTL/CPU/IF/ins_fetch.v(21)
  input nop_if;  // ../../RTL/CPU/IF/ins_fetch.v(17)
  input pip_flush;  // ../../RTL/CPU/IF/ins_fetch.v(20)
  input [3:0] priv;  // ../../RTL/CPU/IF/ins_fetch.v(11)
  input rst;  // ../../RTL/CPU/IF/ins_fetch.v(10)
  output [63:0] addr;  // ../../RTL/CPU/IF/ins_fetch.v(23)
  output [3:0] if_priv;  // ../../RTL/CPU/IF/ins_fetch.v(26)
  output ins_acc_fault;  // ../../RTL/CPU/IF/ins_fetch.v(43)
  output ins_addr_mis;  // ../../RTL/CPU/IF/ins_fetch.v(44)
  output [31:0] ins_out;  // ../../RTL/CPU/IF/ins_fetch.v(38)
  output ins_page_fault;  // ../../RTL/CPU/IF/ins_fetch.v(45)
  output [63:0] ins_pc;  // ../../RTL/CPU/IF/ins_fetch.v(40)
  output int_acc;  // ../../RTL/CPU/IF/ins_fetch.v(46)
  output rd;  // ../../RTL/CPU/IF/ins_fetch.v(25)
  output valid;  // ../../RTL/CPU/IF/ins_fetch.v(47)

  parameter pc_rst = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  wire [31:0] ins_hold;  // ../../RTL/CPU/IF/ins_fetch.v(55)
  wire [31:0] ins_shift;  // ../../RTL/CPU/IF/ins_fetch.v(59)
  wire [61:0] n1;
  wire [31:0] n10;
  wire [31:0] n11;
  wire [61:0] n2;
  wire [61:0] n3;
  wire [63:0] n4;
  wire [63:0] n5;
  wire [63:0] n6;
  wire [63:0] n7;
  wire [63:0] pc;  // ../../RTL/CPU/IF/ins_fetch.v(56)
  wire addr_mis;  // ../../RTL/CPU/IF/ins_fetch.v(57)
  wire hold;  // ../../RTL/CPU/IF/ins_fetch.v(53)
  wire n0;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n20;
  wire n21;
  wire n22;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n30;
  wire n31;
  wire n8;
  wire n9;

  add_pu62_pu62_o62 add0 (
    .i0(pc[63:2]),
    .i1(62'b00000000000000000000000000000000000000000000000000000000000001),
    .o(n1));  // ../../RTL/CPU/IF/ins_fetch.v(81)
  AL_DFF hold_reg (
    .clk(clk),
    .d(n14),
    .reset(1'b0),
    .set(1'b0),
    .q(hold));  // ../../RTL/CPU/IF/ins_fetch.v(115)
  AL_DFF ins_acc_fault_reg (
    .clk(clk),
    .d(n19),
    .reset(1'b0),
    .set(1'b0),
    .q(ins_acc_fault));  // ../../RTL/CPU/IF/ins_fetch.v(137)
  AL_DFF ins_addr_mis_reg (
    .clk(clk),
    .d(n21),
    .reset(1'b0),
    .set(1'b0),
    .q(ins_addr_mis));  // ../../RTL/CPU/IF/ins_fetch.v(137)
  AL_DFF ins_page_fault_reg (
    .clk(clk),
    .d(n20),
    .reset(1'b0),
    .set(1'b0),
    .q(ins_page_fault));  // ../../RTL/CPU/IF/ins_fetch.v(137)
  AL_DFF int_acc_reg (
    .clk(clk),
    .d(n22),
    .reset(1'b0),
    .set(1'b0),
    .q(int_acc));  // ../../RTL/CPU/IF/ins_fetch.v(137)
  binary_mux_s1_w32 mux0 (
    .i0(ins_in[31:0]),
    .i1(ins_in[63:32]),
    .sel(ins_pc[2]),
    .o(ins_shift));  // ../../RTL/CPU/IF/ins_fetch.v(64)
  binary_mux_s1_w62 mux1 (
    .i0(pc[63:2]),
    .i1(n1),
    .sel(cache_ready),
    .o(n2));  // ../../RTL/CPU/IF/ins_fetch.v(81)
  binary_mux_s1_w64 mux2 (
    .i0({n3,pc[1:0]}),
    .i1(new_pc),
    .sel(pip_flush),
    .o(n4));  // ../../RTL/CPU/IF/ins_fetch.v(82)
  binary_mux_s1_w64 mux3 (
    .i0(n4),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n5));  // ../../RTL/CPU/IF/ins_fetch.v(82)
  binary_mux_s1_w64 mux4 (
    .i0(pc),
    .i1(ins_pc),
    .sel(if_hold),
    .o(n6));  // ../../RTL/CPU/IF/ins_fetch.v(94)
  binary_mux_s1_w64 mux5 (
    .i0(n6),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n7));  // ../../RTL/CPU/IF/ins_fetch.v(94)
  binary_mux_s1_w32 mux6 (
    .i0(ins_hold),
    .i1(ins_shift),
    .sel(n9),
    .o(n10));  // ../../RTL/CPU/IF/ins_fetch.v(103)
  binary_mux_s1_w32 mux7 (
    .i0(n10),
    .i1(32'b00000000000000000000000000000000),
    .sel(rst),
    .o(n11));  // ../../RTL/CPU/IF/ins_fetch.v(103)
  binary_mux_s1_w62 mux8 (
    .i0(n2),
    .i1(pc[63:2]),
    .sel(n0),
    .o(n3));  // ../../RTL/CPU/IF/ins_fetch.v(82)
  binary_mux_s1_w32 mux9 (
    .i0(ins_shift),
    .i1(ins_hold),
    .sel(hold),
    .o(ins_out));  // ../../RTL/CPU/IF/ins_fetch.v(156)
  ne_w2 neq0 (
    .i0(pc[1:0]),
    .i1(2'b00),
    .o(addr_mis));  // ../../RTL/CPU/IF/ins_fetch.v(62)
  reg_ar_as_w64 reg0 (
    .clk(clk),
    .d(n7),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(ins_pc));  // ../../RTL/CPU/IF/ins_fetch.v(95)
  reg_ar_as_w32 reg1 (
    .clk(clk),
    .d(n11),
    .reset(32'b00000000000000000000000000000000),
    .set(32'b00000000000000000000000000000000),
    .q(ins_hold));  // ../../RTL/CPU/IF/ins_fetch.v(104)
  reg_ar_as_w64 reg2 (
    .clk(clk),
    .d(n5),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(pc));  // ../../RTL/CPU/IF/ins_fetch.v(83)
  buf u10 (addr[11], pc[11]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u11 (addr[12], pc[12]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u12 (addr[13], pc[13]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u13 (addr[14], pc[14]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u14 (addr[15], pc[15]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u15 (addr[16], pc[16]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u16 (addr[17], pc[17]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u17 (addr[18], pc[18]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u18 (addr[19], pc[19]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u19 (addr[20], pc[20]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u2 (addr[5], pc[5]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u20 (addr[21], pc[21]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u21 (addr[22], pc[22]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u22 (addr[23], pc[23]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u23 (addr[24], pc[24]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u24 (addr[25], pc[25]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u25 (addr[26], pc[26]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u26 (addr[27], pc[27]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u27 (addr[28], pc[28]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u28 (addr[29], pc[29]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u29 (addr[30], pc[30]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u3 (addr[4], pc[4]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u30 (addr[31], pc[31]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u31 (addr[32], pc[32]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u32 (addr[33], pc[33]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u33 (addr[34], pc[34]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u34 (addr[35], pc[35]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u35 (addr[36], pc[36]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u36 (addr[37], pc[37]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u37 (addr[38], pc[38]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u38 (addr[39], pc[39]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u39 (addr[40], pc[40]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  or u4 (n0, nop_if, if_hold);  // ../../RTL/CPU/IF/ins_fetch.v(77)
  buf u40 (addr[41], pc[41]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u41 (addr[42], pc[42]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u42 (addr[43], pc[43]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u43 (addr[44], pc[44]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u44 (addr[45], pc[45]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u45 (addr[46], pc[46]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u46 (addr[47], pc[47]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u47 (addr[48], pc[48]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u48 (addr[49], pc[49]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u49 (addr[50], pc[50]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u5 (addr[6], pc[6]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u50 (addr[51], pc[51]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u51 (addr[52], pc[52]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u52 (addr[53], pc[53]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u53 (addr[54], pc[54]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u54 (addr[55], pc[55]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u55 (addr[56], pc[56]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u56 (addr[57], pc[57]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u57 (addr[58], pc[58]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u58 (addr[59], pc[59]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u59 (addr[60], pc[60]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u6 (addr[7], pc[7]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u60 (addr[61], pc[61]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u61 (addr[62], pc[62]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u62 (addr[63], pc[63]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u63 (if_priv[1], priv[1]);  // ../../RTL/CPU/IF/ins_fetch.v(157)
  buf u64 (if_priv[2], priv[2]);  // ../../RTL/CPU/IF/ins_fetch.v(157)
  buf u65 (if_priv[3], priv[3]);  // ../../RTL/CPU/IF/ins_fetch.v(157)
  not u66 (n8, hold);  // ../../RTL/CPU/IF/ins_fetch.v(101)
  and u67 (n9, if_hold, n8);  // ../../RTL/CPU/IF/ins_fetch.v(101)
  buf u68 (addr[1], pc[1]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u69 (addr[3], pc[3]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u7 (addr[8], pc[8]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u70 (addr[2], pc[2]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  AL_MUX u71 (
    .i0(hold),
    .i1(if_hold),
    .sel(hold),
    .o(n12));  // ../../RTL/CPU/IF/ins_fetch.v(114)
  AL_MUX u72 (
    .i0(if_hold),
    .i1(n12),
    .sel(hold),
    .o(n13));  // ../../RTL/CPU/IF/ins_fetch.v(114)
  AL_MUX u73 (
    .i0(n13),
    .i1(1'b0),
    .sel(rst),
    .o(n14));  // ../../RTL/CPU/IF/ins_fetch.v(114)
  AL_MUX u74 (
    .i0(ins_acc_fault_biu),
    .i1(ins_acc_fault),
    .sel(if_hold),
    .o(n15));  // ../../RTL/CPU/IF/ins_fetch.v(136)
  AL_MUX u75 (
    .i0(ins_page_fault_biu),
    .i1(ins_page_fault),
    .sel(if_hold),
    .o(n16));  // ../../RTL/CPU/IF/ins_fetch.v(136)
  AL_MUX u76 (
    .i0(addr_mis),
    .i1(ins_addr_mis),
    .sel(if_hold),
    .o(n17));  // ../../RTL/CPU/IF/ins_fetch.v(136)
  AL_MUX u77 (
    .i0(int_req),
    .i1(int_acc),
    .sel(if_hold),
    .o(n18));  // ../../RTL/CPU/IF/ins_fetch.v(136)
  AL_MUX u78 (
    .i0(n15),
    .i1(1'b0),
    .sel(rst),
    .o(n19));  // ../../RTL/CPU/IF/ins_fetch.v(136)
  AL_MUX u79 (
    .i0(n16),
    .i1(1'b0),
    .sel(rst),
    .o(n20));  // ../../RTL/CPU/IF/ins_fetch.v(136)
  buf u8 (addr[9], pc[9]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  AL_MUX u80 (
    .i0(n17),
    .i1(1'b0),
    .sel(rst),
    .o(n21));  // ../../RTL/CPU/IF/ins_fetch.v(136)
  AL_MUX u81 (
    .i0(n18),
    .i1(1'b0),
    .sel(rst),
    .o(n22));  // ../../RTL/CPU/IF/ins_fetch.v(136)
  or u82 (n23, rst, ins_acc_fault);  // ../../RTL/CPU/IF/ins_fetch.v(142)
  or u83 (n24, n23, ins_page_fault);  // ../../RTL/CPU/IF/ins_fetch.v(142)
  or u84 (n25, n24, ins_addr_mis);  // ../../RTL/CPU/IF/ins_fetch.v(142)
  not u85 (n26, nop_if);  // ../../RTL/CPU/IF/ins_fetch.v(145)
  and u86 (n27, cache_ready, n26);  // ../../RTL/CPU/IF/ins_fetch.v(145)
  AL_MUX u87 (
    .i0(1'b0),
    .i1(valid),
    .sel(if_hold),
    .o(n28));  // ../../RTL/CPU/IF/ins_fetch.v(153)
  AL_MUX u88 (
    .i0(n28),
    .i1(1'b1),
    .sel(n27),
    .o(n29));  // ../../RTL/CPU/IF/ins_fetch.v(153)
  AL_MUX u89 (
    .i0(n29),
    .i1(1'b0),
    .sel(n25),
    .o(n30));  // ../../RTL/CPU/IF/ins_fetch.v(153)
  buf u9 (addr[10], pc[10]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  buf u90 (if_priv[0], priv[0]);  // ../../RTL/CPU/IF/ins_fetch.v(157)
  buf u91 (addr[0], pc[0]);  // ../../RTL/CPU/IF/ins_fetch.v(158)
  not u92 (n31, if_hold);  // ../../RTL/CPU/IF/ins_fetch.v(159)
  and u93 (rd, n26, n31);  // ../../RTL/CPU/IF/ins_fetch.v(159)
  AL_DFF valid_reg (
    .clk(clk),
    .d(n30),
    .reset(1'b0),
    .set(1'b0),
    .q(valid));  // ../../RTL/CPU/IF/ins_fetch.v(154)

endmodule 

module pip_ctrl  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(5)
  (
  ex_ebreak,
  ex_ecall,
  ex_gpr_write,
  ex_ill_ins,
  ex_ins_acc_fault,
  ex_ins_addr_mis,
  ex_ins_page_fault,
  ex_int_acc,
  ex_jmp,
  ex_m_ret,
  ex_more_exception,
  ex_rd_index,
  ex_ready,
  ex_s_ret,
  ex_system,
  ex_valid,
  id_branch,
  id_ill_ins,
  id_ins_acc_fault,
  id_ins_addr_mis,
  id_ins_page_fault,
  id_int_acc,
  id_rs1_index,
  id_rs2_index,
  id_system_mem,
  id_valid,
  wb_ebreak,
  wb_ecall,
  wb_gpr_write,
  wb_id_jmp,
  wb_id_system,
  wb_ill_ins,
  wb_ins_acc_fault,
  wb_ins_addr_mis,
  wb_ins_page_fault,
  wb_int_acc,
  wb_ld_acc_fault,
  wb_ld_addr_mis,
  wb_ld_page_fault,
  wb_m_ret,
  wb_rd_index,
  wb_s_ret,
  wb_st_acc_fault,
  wb_st_addr_mis,
  wb_st_page_fault,
  wb_valid,
  ex_hold,
  ex_nop,
  id_hold,
  id_nop,
  if_hold,
  if_nop
  );

  input ex_ebreak;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(38)
  input ex_ecall;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(37)
  input ex_gpr_write;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(25)
  input ex_ill_ins;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(34)
  input ex_ins_acc_fault;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(29)
  input ex_ins_addr_mis;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(30)
  input ex_ins_page_fault;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(31)
  input ex_int_acc;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(32)
  input ex_jmp;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(28)
  input ex_m_ret;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(35)
  input ex_more_exception;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(41)
  input [4:0] ex_rd_index;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(24)
  input ex_ready;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(40)
  input ex_s_ret;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(36)
  input ex_system;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(27)
  input ex_valid;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(33)
  input id_branch;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(14)
  input id_ill_ins;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(12)
  input id_ins_acc_fault;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(15)
  input id_ins_addr_mis;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(16)
  input id_ins_page_fault;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(17)
  input id_int_acc;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(18)
  input [4:0] id_rs1_index;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(9)
  input [4:0] id_rs2_index;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(10)
  input id_system_mem;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(13)
  input id_valid;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(19)
  input wb_ebreak;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(65)
  input wb_ecall;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(64)
  input wb_gpr_write;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(46)
  input wb_id_jmp;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(49)
  input wb_id_system;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(48)
  input wb_ill_ins;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(61)
  input wb_ins_acc_fault;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(50)
  input wb_ins_addr_mis;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(51)
  input wb_ins_page_fault;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(52)
  input wb_int_acc;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(59)
  input wb_ld_acc_fault;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(55)
  input wb_ld_addr_mis;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(53)
  input wb_ld_page_fault;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(57)
  input wb_m_ret;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(62)
  input [4:0] wb_rd_index;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(45)
  input wb_s_ret;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(63)
  input wb_st_acc_fault;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(56)
  input wb_st_addr_mis;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(54)
  input wb_st_page_fault;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(58)
  input wb_valid;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(60)
  output ex_hold;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(73)
  output ex_nop;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(72)
  output id_hold;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(71)
  output id_nop;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(70)
  output if_hold;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(69)
  output if_nop;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(68)

  wire ex_exception;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(80)
  wire id_ex_war;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(83)
  wire id_exception;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(79)
  wire id_wb_war;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(84)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n2;
  wire n20;
  wire n21;
  wire n22;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire n34;
  wire n35;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n4;
  wire n40;
  wire n41;
  wire n42;
  wire n43;
  wire n44;
  wire n45;
  wire n46;
  wire n47;
  wire n48;
  wire n49;
  wire n5;
  wire n50;
  wire n51;
  wire n52;
  wire n53;
  wire n54;
  wire n55;
  wire n56;
  wire n57;
  wire n58;
  wire n59;
  wire n6;
  wire n60;
  wire n7;
  wire n8;
  wire n9;
  wire wb_exception;  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(81)

  eq_w5 eq0 (
    .i0(id_rs1_index),
    .i1(ex_rd_index),
    .o(n36));  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(96)
  eq_w5 eq1 (
    .i0(id_rs2_index),
    .i1(ex_rd_index),
    .o(n42));  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(97)
  eq_w5 eq2 (
    .i0(id_rs1_index),
    .i1(wb_rd_index),
    .o(n46));  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(100)
  eq_w5 eq3 (
    .i0(id_rs2_index),
    .i1(wb_rd_index),
    .o(n50));  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(101)
  ne_w5 neq0 (
    .i0(id_rs1_index),
    .i1(5'b00000),
    .o(n33));  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(96)
  ne_w5 neq1 (
    .i0(id_rs2_index),
    .i1(5'b00000),
    .o(n39));  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(97)
  or u1 (n0, id_ill_ins, id_system_mem);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(86)
  or u10 (n8, n7, ex_ins_acc_fault);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(88)
  or u11 (n9, n8, ex_ins_addr_mis);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(88)
  or u12 (n10, n9, ex_ins_page_fault);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(88)
  or u13 (n11, n10, ex_int_acc);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(89)
  or u14 (n12, n11, ex_ill_ins);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(89)
  or u15 (n13, n12, ex_m_ret);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(89)
  or u16 (n14, n13, ex_s_ret);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(89)
  or u17 (n15, n14, ex_ecall);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(89)
  or u18 (n16, n15, ex_ebreak);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(89)
  and u19 (ex_exception, ex_valid, n16);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(89)
  or u2 (n1, n0, id_branch);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(86)
  or u20 (n17, wb_id_system, wb_id_jmp);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(90)
  or u21 (n18, n17, wb_ins_acc_fault);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(90)
  or u22 (n19, n18, wb_ins_addr_mis);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(90)
  or u23 (n20, n19, wb_ins_page_fault);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(90)
  or u24 (n21, n20, wb_ld_addr_mis);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(90)
  or u25 (n22, n21, wb_st_addr_mis);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(91)
  or u26 (n23, n22, wb_ld_acc_fault);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(91)
  or u27 (n24, n23, wb_st_acc_fault);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(91)
  or u28 (n25, n24, wb_ld_page_fault);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(91)
  or u29 (n26, n25, wb_st_page_fault);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(91)
  or u3 (n2, n1, id_ins_acc_fault);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(86)
  or u30 (n27, n26, wb_int_acc);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(91)
  or u31 (n28, n27, wb_ill_ins);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(91)
  or u32 (n29, n28, wb_m_ret);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(92)
  or u33 (n30, n29, wb_s_ret);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(92)
  or u34 (n31, n30, wb_ecall);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(92)
  or u35 (n32, n31, wb_ebreak);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(92)
  and u36 (wb_exception, wb_valid, n32);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(92)
  and u37 (n34, id_valid, n33);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(96)
  and u38 (n35, n34, ex_valid);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(96)
  and u39 (n37, n35, n36);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(96)
  or u4 (n3, n2, id_ins_addr_mis);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(86)
  and u40 (n38, n37, ex_gpr_write);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(96)
  and u41 (n40, id_valid, n39);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(97)
  and u42 (n41, n40, ex_valid);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(97)
  and u43 (n43, n41, n42);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(97)
  and u44 (n44, n43, ex_gpr_write);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(97)
  or u45 (id_ex_war, n38, n44);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(97)
  and u46 (n45, n34, wb_valid);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(100)
  and u47 (n47, n45, n46);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(100)
  and u48 (n48, n47, wb_gpr_write);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(100)
  and u49 (n49, n40, wb_valid);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(101)
  or u5 (n4, n3, id_ins_page_fault);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(86)
  and u50 (n51, n49, n50);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(101)
  and u51 (n52, n51, wb_gpr_write);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(101)
  or u52 (id_wb_war, n48, n52);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(101)
  or u53 (n53, id_exception, ex_exception);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(105)
  or u54 (if_nop, n53, wb_exception);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(105)
  not u55 (n54, if_nop);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(109)
  or u56 (n55, id_ex_war, id_wb_war);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(109)
  not u57 (n56, ex_ready);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(109)
  or u58 (n57, n55, n56);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(109)
  and u59 (if_hold, n54, n57);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(109)
  or u6 (n5, n4, id_int_acc);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(86)
  or u60 (n58, ex_exception, wb_exception);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(112)
  or u61 (n59, n58, id_ex_war);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(112)
  or u62 (id_nop, n59, id_wb_war);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(112)
  not u63 (n60, id_nop);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(114)
  and u64 (id_hold, n60, n56);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(114)
  buf u65 (ex_nop, wb_exception);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(116)
  and u7 (id_exception, id_valid, n5);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(86)
  or u8 (n6, ex_more_exception, ex_system);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(88)
  or u9 (n7, n6, ex_jmp);  // ../../RTL/CPU/PIP_CTRL/pip_ctrl.v(88)

endmodule 

module bus_unit  // ../../RTL/CPU/BIU/bus_unit.v(1)
  (
  cache_rdy,
  cacheability_block,
  clk,
  hrdata,
  hready,
  hreset_n,
  hresp,
  maddress,
  mxr,
  new_pte_update,
  opc,
  pa_cov,
  paddr,
  priv,
  rd,
  rst,
  satp,
  sum,
  trans_size,
  wr,
  write_data,
  bus_error,
  cache_counter,
  cache_write,
  cacheable,
  haddr,
  hburst,
  hmastlock,
  hprot,
  hsize,
  htrans,
  hwdata,
  hwrite,
  paddress,
  page_fault,
  read_data,
  trans_rdy
  );

  input cache_rdy;  // ../../RTL/CPU/BIU/bus_unit.v(27)
  input [31:0] cacheability_block;  // ../../RTL/CPU/BIU/bus_unit.v(7)
  input clk;  // ../../RTL/CPU/BIU/bus_unit.v(3)
  input [63:0] hrdata;  // ../../RTL/CPU/BIU/bus_unit.v(65)
  input hready;  // ../../RTL/CPU/BIU/bus_unit.v(62)
  input hreset_n;  // ../../RTL/CPU/BIU/bus_unit.v(64)
  input hresp;  // ../../RTL/CPU/BIU/bus_unit.v(63)
  input [63:0] maddress;  // ../../RTL/CPU/BIU/bus_unit.v(41)
  input mxr;  // ../../RTL/CPU/BIU/bus_unit.v(11)
  input new_pte_update;  // ../../RTL/CPU/BIU/bus_unit.v(28)
  input [1:0] opc;  // ../../RTL/CPU/BIU/bus_unit.v(31)
  input pa_cov;  // ../../RTL/CPU/BIU/bus_unit.v(23)
  input paddr;  // ../../RTL/CPU/BIU/bus_unit.v(20)
  input [3:0] priv;  // ../../RTL/CPU/BIU/bus_unit.v(32)
  input rd;  // ../../RTL/CPU/BIU/bus_unit.v(22)
  input rst;  // ../../RTL/CPU/BIU/bus_unit.v(4)
  input [63:0] satp;  // ../../RTL/CPU/BIU/bus_unit.v(9)
  input sum;  // ../../RTL/CPU/BIU/bus_unit.v(10)
  input [3:0] trans_size;  // ../../RTL/CPU/BIU/bus_unit.v(24)
  input wr;  // ../../RTL/CPU/BIU/bus_unit.v(21)
  input [63:0] write_data;  // ../../RTL/CPU/BIU/bus_unit.v(47)
  output bus_error;  // ../../RTL/CPU/BIU/bus_unit.v(39)
  output [8:0] cache_counter;  // ../../RTL/CPU/BIU/bus_unit.v(49)
  output cache_write;  // ../../RTL/CPU/BIU/bus_unit.v(37)
  output cacheable;  // ../../RTL/CPU/BIU/bus_unit.v(35)
  output [63:0] haddr;  // ../../RTL/CPU/BIU/bus_unit.v(53)
  output [2:0] hburst;  // ../../RTL/CPU/BIU/bus_unit.v(56)
  output hmastlock;  // ../../RTL/CPU/BIU/bus_unit.v(59)
  output [3:0] hprot;  // ../../RTL/CPU/BIU/bus_unit.v(57)
  output [2:0] hsize;  // ../../RTL/CPU/BIU/bus_unit.v(55)
  output [1:0] htrans;  // ../../RTL/CPU/BIU/bus_unit.v(58)
  output [63:0] hwdata;  // ../../RTL/CPU/BIU/bus_unit.v(60)
  output hwrite;  // ../../RTL/CPU/BIU/bus_unit.v(54)
  output [127:0] paddress;  // ../../RTL/CPU/BIU/bus_unit.v(42)
  output page_fault;  // ../../RTL/CPU/BIU/bus_unit.v(38)
  output [63:0] read_data;  // ../../RTL/CPU/BIU/bus_unit.v(45)
  output trans_rdy;  // ../../RTL/CPU/BIU/bus_unit.v(36)

  parameter Byte = 3'b000;
  parameter Dword = 3'b011;
  parameter Hword = 3'b001;
  parameter INCR = 3'b001;
  parameter Single = 3'b000;
  parameter Word = 3'b010;
  parameter acc_fault = 5'b11111;
  parameter idle = 2'b00;
  parameter nseq = 2'b10;
  parameter pacov = 5'b00001;
  parameter rd0 = 5'b00100;
  parameter rd1 = 5'b00101;
  parameter rd_b0 = 5'b01001;
  parameter rd_b1 = 5'b01010;
  parameter rd_b2 = 5'b01011;
  parameter seq = 2'b11;
  parameter stb = 5'b00000;
  parameter sync0 = 5'b00110;
  parameter sync1 = 5'b00111;
  parameter sync2 = 5'b01000;
  parameter wr0 = 5'b00010;
  parameter wr1 = 5'b00011;
  wire [8:0] addr_counter;  // ../../RTL/CPU/BIU/bus_unit.v(117)
  wire [8:0] last_addr;  // ../../RTL/CPU/BIU/bus_unit.v(118)
  wire [63:0] mmu_haddr;  // ../../RTL/CPU/BIU/bus_unit.v(99)
  wire [2:0] mmu_hburst;  // ../../RTL/CPU/BIU/bus_unit.v(102)
  wire [3:0] mmu_hsize;  // ../../RTL/CPU/BIU/bus_unit.v(101)
  wire [1:0] mmu_htrans;  // ../../RTL/CPU/BIU/bus_unit.v(104)
  wire [63:0] mmu_hwdata;  // ../../RTL/CPU/BIU/bus_unit.v(106)
  wire [4:0] n17;
  wire [4:0] n19;
  wire [4:0] n21;
  wire [3:0] n23;
  wire [4:0] n24;
  wire [4:0] n26;
  wire [4:0] n27;
  wire [4:0] n28;
  wire [4:0] n29;
  wire [4:0] n30;
  wire [4:0] n31;
  wire [4:0] n32;
  wire [4:0] n33;
  wire [4:0] n34;
  wire [4:0] n35;
  wire [4:0] n36;
  wire [8:0] n39;
  wire [2:0] n4;
  wire [8:0] n40;
  wire [8:0] n41;
  wire [8:0] n42;
  wire [8:0] n43;
  wire [60:0] n49;
  wire [3:0] n5;
  wire [1:0] n54;
  wire [1:0] n55;
  wire [1:0] n59;
  wire [3:0] n6;
  wire [4:0] statu;  // ../../RTL/CPU/BIU/bus_unit.v(115)
  wire mmu_acc_fault;  // ../../RTL/CPU/BIU/bus_unit.v(110)
  wire mmu_hwrite;  // ../../RTL/CPU/BIU/bus_unit.v(100)
  wire mmu_page_fault;  // ../../RTL/CPU/BIU/bus_unit.v(111)
  wire mmu_read_data;  // ../../RTL/CPU/BIU/bus_unit.v(113)
  wire mmu_trans_rdy;  // ../../RTL/CPU/BIU/bus_unit.v(109)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n18;
  wire n2;
  wire n20;
  wire n22;
  wire n25;
  wire n3;
  wire n37;
  wire n38;
  wire n44;
  wire n45;
  wire n46;
  wire n47;
  wire n48;
  wire n50;
  wire n51;
  wire n52;
  wire n53;
  wire n56;
  wire n57;
  wire n58;
  wire n60;
  wire n7;
  wire n8;
  wire n9;

  add_pu9_pu9_o9 add0 (
    .i0(addr_counter),
    .i1(9'b000000001),
    .o(n39));  // ../../RTL/CPU/BIU/bus_unit.v(175)
  add_pu61_pu61_o61 add1 (
    .i0({52'b0000000000000000000000000000000000000000000000000000,addr_counter}),
    .i1(maddress[63:3]),
    .o(n49));  // ../../RTL/CPU/BIU/bus_unit.v(189)
  eq_w5 eq0 (
    .i0(statu),
    .i1(5'b00000),
    .o(n0));  // ../../RTL/CPU/BIU/bus_unit.v(126)
  eq_w5 eq1 (
    .i0(statu),
    .i1(5'b00001),
    .o(n7));  // ../../RTL/CPU/BIU/bus_unit.v(130)
  eq_w5 eq10 (
    .i0(statu),
    .i1(5'b11111),
    .o(n25));  // ../../RTL/CPU/BIU/bus_unit.v(160)
  eq_w5 eq11 (
    .i0(statu),
    .i1(5'b01000),
    .o(n45));  // ../../RTL/CPU/BIU/bus_unit.v(181)
  eq_w5 eq2 (
    .i0(statu),
    .i1(5'b01001),
    .o(n11));  // ../../RTL/CPU/BIU/bus_unit.v(134)
  eq_w5 eq3 (
    .i0(statu),
    .i1(5'b00010),
    .o(n12));  // ../../RTL/CPU/BIU/bus_unit.v(137)
  eq_w5 eq4 (
    .i0(statu),
    .i1(5'b00100),
    .o(n13));  // ../../RTL/CPU/BIU/bus_unit.v(140)
  eq_w5 eq5 (
    .i0(statu),
    .i1(5'b01010),
    .o(n14));  // ../../RTL/CPU/BIU/bus_unit.v(145)
  eq_w9 eq6 (
    .i0(addr_counter),
    .i1(9'b111111111),
    .o(n15));  // ../../RTL/CPU/BIU/bus_unit.v(146)
  eq_w5 eq7 (
    .i0(statu),
    .i1(5'b00011),
    .o(n18));  // ../../RTL/CPU/BIU/bus_unit.v(148)
  eq_w5 eq8 (
    .i0(statu),
    .i1(5'b00101),
    .o(n20));  // ../../RTL/CPU/BIU/bus_unit.v(151)
  eq_w5 eq9 (
    .i0(statu),
    .i1(5'b01011),
    .o(n22));  // ../../RTL/CPU/BIU/bus_unit.v(156)
  mmu mmu (
    .cacheability_block(cacheability_block),
    .clk(clk),
    .hrdata(hrdata),
    .hready(hready),
    .hreset_n(hreset_n),
    .hresp(hresp),
    .maddress(maddress),
    .mxr(mxr),
    .opc(opc),
    .pa_cov(pa_cov),
    .priv(priv),
    .rst(rst),
    .satp(satp),
    .sum(sum),
    .bus_error(mmu_acc_fault),
    .cacheable(cacheable),
    .haddr(mmu_haddr),
    .hburst(mmu_hburst),
    .hsize(mmu_hsize),
    .htrans(mmu_htrans),
    .hwdata(mmu_hwdata),
    .hwrite(mmu_hwrite),
    .paddress(paddress),
    .pagefault(mmu_page_fault),
    .read_data({open_n5,open_n6,open_n7,open_n8,open_n9,open_n10,open_n11,open_n12,open_n13,open_n14,open_n15,open_n16,open_n17,open_n18,open_n19,open_n20,open_n21,open_n22,open_n23,open_n24,open_n25,open_n26,open_n27,open_n28,open_n29,open_n30,open_n31,open_n32,open_n33,open_n34,open_n35,open_n36,open_n37,open_n38,open_n39,open_n40,open_n41,open_n42,open_n43,open_n44,open_n45,open_n46,open_n47,open_n48,open_n49,open_n50,open_n51,open_n52,open_n53,open_n54,open_n55,open_n56,open_n57,open_n58,open_n59,open_n60,open_n61,open_n62,open_n63,open_n64,open_n65,open_n66,open_n67,mmu_read_data}),
    .trans_rdy(mmu_trans_rdy));  // ../../RTL/CPU/BIU/bus_unit.v(211)
  binary_mux_s1_w3 mux0 (
    .i0({1'b0,n3,1'b0}),
    .i1(3'b100),
    .sel(n2),
    .o(n4));  // ../../RTL/CPU/BIU/bus_unit.v(127)
  binary_mux_s1_w4 mux1 (
    .i0({1'b0,n4}),
    .i1(4'b1001),
    .sel(n1),
    .o(n5));  // ../../RTL/CPU/BIU/bus_unit.v(127)
  binary_mux_s1_w5 mux10 (
    .i0(n28),
    .i1(n19),
    .sel(n18),
    .o(n29));  // ../../RTL/CPU/BIU/bus_unit.v(162)
  binary_mux_s1_w5 mux11 (
    .i0(n29),
    .i1(n17),
    .sel(n14),
    .o(n30));  // ../../RTL/CPU/BIU/bus_unit.v(162)
  binary_mux_s1_w5 mux12 (
    .i0(n30),
    .i1(5'b00101),
    .sel(n13),
    .o(n31));  // ../../RTL/CPU/BIU/bus_unit.v(162)
  binary_mux_s1_w5 mux13 (
    .i0(n31),
    .i1(5'b00011),
    .sel(n12),
    .o(n32));  // ../../RTL/CPU/BIU/bus_unit.v(162)
  binary_mux_s1_w5 mux14 (
    .i0(n32),
    .i1(5'b01010),
    .sel(n11),
    .o(n33));  // ../../RTL/CPU/BIU/bus_unit.v(162)
  binary_mux_s1_w5 mux15 (
    .i0(n33),
    .i1({4'b0000,n10}),
    .sel(n7),
    .o(n34));  // ../../RTL/CPU/BIU/bus_unit.v(162)
  binary_mux_s1_w5 mux16 (
    .i0(n34),
    .i1({1'b0,n6}),
    .sel(n0),
    .o(n35));  // ../../RTL/CPU/BIU/bus_unit.v(162)
  binary_mux_s1_w5 mux17 (
    .i0(n35),
    .i1(5'b00000),
    .sel(rst),
    .o(n36));  // ../../RTL/CPU/BIU/bus_unit.v(162)
  binary_mux_s1_w9 mux18 (
    .i0(addr_counter),
    .i1(n39),
    .sel(hready),
    .o(n40));  // ../../RTL/CPU/BIU/bus_unit.v(175)
  binary_mux_s1_w9 mux19 (
    .i0(addr_counter),
    .i1(n40),
    .sel(n38),
    .o(n41));  // ../../RTL/CPU/BIU/bus_unit.v(176)
  binary_mux_s1_w4 mux2 (
    .i0(n5),
    .i1(4'b0001),
    .sel(pa_cov),
    .o(n6));  // ../../RTL/CPU/BIU/bus_unit.v(127)
  binary_mux_s1_w9 mux20 (
    .i0(n41),
    .i1(9'b111111111),
    .sel(n15),
    .o(n42));  // ../../RTL/CPU/BIU/bus_unit.v(176)
  binary_mux_s1_w9 mux21 (
    .i0(n42),
    .i1(9'b000000000),
    .sel(n37),
    .o(n43));  // ../../RTL/CPU/BIU/bus_unit.v(176)
  binary_mux_s1_w64 mux22 (
    .i0({n49,maddress[2:0]}),
    .i1(mmu_haddr),
    .sel(n7),
    .o(haddr));  // ../../RTL/CPU/BIU/bus_unit.v(189)
  binary_mux_s1_w2 mux23 (
    .i0({1'b1,n53}),
    .i1(2'b01),
    .sel(n51),
    .o(n54));  // ../../RTL/CPU/BIU/bus_unit.v(191)
  binary_mux_s1_w2 mux24 (
    .i0(n54),
    .i1(2'b00),
    .sel(n50),
    .o(n55));  // ../../RTL/CPU/BIU/bus_unit.v(191)
  binary_mux_s1_w4 mux25 (
    .i0({2'b00,n55}),
    .i1(mmu_hsize),
    .sel(n7),
    .o({open_n68,hsize}));  // ../../RTL/CPU/BIU/bus_unit.v(191)
  binary_mux_s1_w3 mux26 (
    .i0({2'b00,n57}),
    .i1(mmu_hburst),
    .sel(n7),
    .o(hburst));  // ../../RTL/CPU/BIU/bus_unit.v(193)
  binary_mux_s1_w2 mux27 (
    .i0({n14,n14}),
    .i1(2'b10),
    .sel(n58),
    .o(n59));  // ../../RTL/CPU/BIU/bus_unit.v(195)
  binary_mux_s1_w2 mux28 (
    .i0(n59),
    .i1(mmu_htrans),
    .sel(n7),
    .o(htrans));  // ../../RTL/CPU/BIU/bus_unit.v(195)
  binary_mux_s1_w64 mux29 (
    .i0(write_data),
    .i1(mmu_hwdata),
    .sel(n7),
    .o(hwdata));  // ../../RTL/CPU/BIU/bus_unit.v(197)
  binary_mux_s1_w5 mux3 (
    .i0({4'b0101,n16}),
    .i1(5'b11111),
    .sel(hresp),
    .o(n17));  // ../../RTL/CPU/BIU/bus_unit.v(146)
  binary_mux_s1_w64 mux30 (
    .i0(hrdata),
    .i1({63'b000000000000000000000000000000000000000000000000000000000000000,mmu_read_data}),
    .sel(n7),
    .o(read_data));  // ../../RTL/CPU/BIU/bus_unit.v(201)
  binary_mux_s1_w9 mux31 (
    .i0(last_addr),
    .i1(addr_counter),
    .sel(n22),
    .o(cache_counter));  // ../../RTL/CPU/BIU/bus_unit.v(207)
  binary_mux_s1_w5 mux4 (
    .i0({3'b000,n23[0],n23[0]}),
    .i1(5'b11111),
    .sel(hresp),
    .o(n19));  // ../../RTL/CPU/BIU/bus_unit.v(149)
  binary_mux_s1_w5 mux5 (
    .i0({2'b00,n23[0],1'b0,n23[0]}),
    .i1(5'b11111),
    .sel(hresp),
    .o(n21));  // ../../RTL/CPU/BIU/bus_unit.v(152)
  binary_mux_s1_w5 mux6 (
    .i0({1'b0,n23[0],1'b0,n23[0],n23[0]}),
    .i1(5'b11111),
    .sel(hresp),
    .o(n24));  // ../../RTL/CPU/BIU/bus_unit.v(157)
  binary_mux_s1_w5 mux7 (
    .i0(statu),
    .i1(5'b00000),
    .sel(n25),
    .o(n26));  // ../../RTL/CPU/BIU/bus_unit.v(162)
  binary_mux_s1_w5 mux8 (
    .i0(n26),
    .i1(n24),
    .sel(n22),
    .o(n27));  // ../../RTL/CPU/BIU/bus_unit.v(162)
  binary_mux_s1_w5 mux9 (
    .i0(n27),
    .i1(n21),
    .sel(n20),
    .o(n28));  // ../../RTL/CPU/BIU/bus_unit.v(162)
  reg_ar_as_w9 reg0 (
    .clk(clk),
    .d(n43),
    .reset(9'b000000000),
    .set(9'b000000000),
    .q(addr_counter));  // ../../RTL/CPU/BIU/bus_unit.v(177)
  reg_ar_as_w5 reg1 (
    .clk(clk),
    .d(n36),
    .reset(5'b00000),
    .set(5'b00000),
    .q(statu));  // ../../RTL/CPU/BIU/bus_unit.v(163)
  add_pu9_mu9_o9 sub0 (
    .i0(addr_counter),
    .i1(9'b000000001),
    .o(last_addr));  // ../../RTL/CPU/BIU/bus_unit.v(203)
  or u10 (n37, rst, n0);  // ../../RTL/CPU/BIU/bus_unit.v(167)
  or u11 (n38, n11, n14);  // ../../RTL/CPU/BIU/bus_unit.v(174)
  or u12 (n44, n20, n18);  // ../../RTL/CPU/BIU/bus_unit.v(181)
  or u13 (n46, n44, n45);  // ../../RTL/CPU/BIU/bus_unit.v(181)
  or u14 (n47, n46, n22);  // ../../RTL/CPU/BIU/bus_unit.v(181)
  AL_MUX u15 (
    .i0(1'b0),
    .i1(hready),
    .sel(n47),
    .o(n48));  // ../../RTL/CPU/BIU/bus_unit.v(181)
  AL_MUX u16 (
    .i0(n48),
    .i1(mmu_trans_rdy),
    .sel(n7),
    .o(trans_rdy));  // ../../RTL/CPU/BIU/bus_unit.v(181)
  AL_MUX u17 (
    .i0(n25),
    .i1(mmu_acc_fault),
    .sel(n7),
    .o(bus_error));  // ../../RTL/CPU/BIU/bus_unit.v(184)
  AL_MUX u18 (
    .i0(1'b0),
    .i1(mmu_page_fault),
    .sel(n7),
    .o(page_fault));  // ../../RTL/CPU/BIU/bus_unit.v(185)
  AL_MUX u19 (
    .i0(n12),
    .i1(mmu_hwrite),
    .sel(n7),
    .o(hwrite));  // ../../RTL/CPU/BIU/bus_unit.v(190)
  not u2 (n23[0], hready);  // ../../RTL/CPU/BIU/bus_unit.v(157)
  and u20 (n50, n12, trans_size[0]);  // ../../RTL/CPU/BIU/bus_unit.v(191)
  and u21 (n51, n12, trans_size[1]);  // ../../RTL/CPU/BIU/bus_unit.v(191)
  and u22 (n52, n12, trans_size[2]);  // ../../RTL/CPU/BIU/bus_unit.v(191)
  not u23 (n53, n52);  // ../../RTL/CPU/BIU/bus_unit.v(191)
  or u24 (n56, n12, n13);  // ../../RTL/CPU/BIU/bus_unit.v(193)
  AL_MUX u25 (
    .i0(n38),
    .i1(1'b0),
    .sel(n56),
    .o(n57));  // ../../RTL/CPU/BIU/bus_unit.v(193)
  or u26 (n58, n56, n11);  // ../../RTL/CPU/BIU/bus_unit.v(195)
  buf u27 (hmastlock, 1'b0);  // ../../RTL/CPU/BIU/bus_unit.v(196)
  buf u28 (hprot[3], 1'b0);  // ../../RTL/CPU/BIU/bus_unit.v(194)
  buf u29 (hprot[2], 1'b0);  // ../../RTL/CPU/BIU/bus_unit.v(194)
  and u3 (n1, rd, cache_rdy);  // ../../RTL/CPU/BIU/bus_unit.v(127)
  buf u30 (hprot[1], 1'b1);  // ../../RTL/CPU/BIU/bus_unit.v(194)
  buf u31 (hprot[0], 1'b1);  // ../../RTL/CPU/BIU/bus_unit.v(194)
  or u32 (n60, n14, n22);  // ../../RTL/CPU/BIU/bus_unit.v(209)
  AL_MUX u33 (
    .i0(1'b0),
    .i1(hready),
    .sel(n60),
    .o(cache_write));  // ../../RTL/CPU/BIU/bus_unit.v(209)
  and u4 (n2, rd, paddr);  // ../../RTL/CPU/BIU/bus_unit.v(127)
  or u5 (n3, wr, new_pte_update);  // ../../RTL/CPU/BIU/bus_unit.v(127)
  or u6 (n8, mmu_acc_fault, mmu_page_fault);  // ../../RTL/CPU/BIU/bus_unit.v(131)
  or u7 (n9, n8, mmu_trans_rdy);  // ../../RTL/CPU/BIU/bus_unit.v(131)
  not u8 (n10, n9);  // ../../RTL/CPU/BIU/bus_unit.v(131)
  and u9 (n16, n15, hready);  // ../../RTL/CPU/BIU/bus_unit.v(146)

endmodule 

module cache  // ../../RTL/CPU/BIU/cache.v(1)
  (
  clk,
  l1d_addr,
  l1d_bsel,
  l1d_in,
  l1d_write,
  l1i_addr,
  l1i_bsel,
  l1i_in,
  l1i_write,
  rst,
  l1d_out,
  l1i_out
  );

  input clk;  // ../../RTL/CPU/BIU/cache.v(3)
  input [8:0] l1d_addr;  // ../../RTL/CPU/BIU/cache.v(8)
  input [7:0] l1d_bsel;  // ../../RTL/CPU/BIU/cache.v(10)
  input [63:0] l1d_in;  // ../../RTL/CPU/BIU/cache.v(9)
  input l1d_write;  // ../../RTL/CPU/BIU/cache.v(11)
  input [8:0] l1i_addr;  // ../../RTL/CPU/BIU/cache.v(15)
  input [7:0] l1i_bsel;  // ../../RTL/CPU/BIU/cache.v(17)
  input [63:0] l1i_in;  // ../../RTL/CPU/BIU/cache.v(16)
  input l1i_write;  // ../../RTL/CPU/BIU/cache.v(18)
  input rst;  // ../../RTL/CPU/BIU/cache.v(4)
  output [63:0] l1d_out;  // ../../RTL/CPU/BIU/cache.v(12)
  output [63:0] l1i_out;  // ../../RTL/CPU/BIU/cache.v(19)

  wire [7:0] l1d0out;  // ../../RTL/CPU/BIU/cache.v(42)
  wire [7:0] l1d1out;  // ../../RTL/CPU/BIU/cache.v(44)
  wire [7:0] l1d2out;  // ../../RTL/CPU/BIU/cache.v(46)
  wire [7:0] l1d3out;  // ../../RTL/CPU/BIU/cache.v(48)
  wire [7:0] l1d4out;  // ../../RTL/CPU/BIU/cache.v(50)
  wire [7:0] l1d5out;  // ../../RTL/CPU/BIU/cache.v(52)
  wire [7:0] l1d6out;  // ../../RTL/CPU/BIU/cache.v(54)
  wire [7:0] l1d7out;  // ../../RTL/CPU/BIU/cache.v(56)
  wire [7:0] l1i0out;  // ../../RTL/CPU/BIU/cache.v(25)
  wire [7:0] l1i1out;  // ../../RTL/CPU/BIU/cache.v(27)
  wire [7:0] l1i2out;  // ../../RTL/CPU/BIU/cache.v(29)
  wire [7:0] l1i3out;  // ../../RTL/CPU/BIU/cache.v(31)
  wire [7:0] l1i4out;  // ../../RTL/CPU/BIU/cache.v(33)
  wire [7:0] l1i5out;  // ../../RTL/CPU/BIU/cache.v(35)
  wire [7:0] l1i6out;  // ../../RTL/CPU/BIU/cache.v(37)
  wire [7:0] l1i7out;  // ../../RTL/CPU/BIU/cache.v(39)
  wire [7:0] n0;
  wire [7:0] n10;
  wire [7:0] n12;
  wire [7:0] n14;
  wire [7:0] n16;
  wire [7:0] n18;
  wire [7:0] n2;
  wire [7:0] n20;
  wire [7:0] n22;
  wire [7:0] n24;
  wire [7:0] n26;
  wire [7:0] n28;
  wire [7:0] n30;
  wire [7:0] n4;
  wire [7:0] n6;
  wire [7:0] n8;
  wire n1;
  wire n11;
  wire n13;
  wire n15;
  wire n17;
  wire n19;
  wire n21;
  wire n23;
  wire n25;
  wire n27;
  wire n29;
  wire n3;
  wire n31;
  wire n5;
  wire n7;
  wire n9;

  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1d0 (
    .clk1(clk),
    .ra1(l1d_addr),
    .re1(1'b1),
    .wa1(l1d_addr),
    .wd1(l1d_in[7:0]),
    .we1(n1),
    .rd1(n0));  // ../../RTL/CPU/BIU/cache.v(41)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1d1 (
    .clk1(clk),
    .ra1(l1d_addr),
    .re1(1'b1),
    .wa1(l1d_addr),
    .wd1(l1d_in[15:8]),
    .we1(n3),
    .rd1(n2));  // ../../RTL/CPU/BIU/cache.v(43)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1d2 (
    .clk1(clk),
    .ra1(l1d_addr),
    .re1(1'b1),
    .wa1(l1d_addr),
    .wd1(l1d_in[23:16]),
    .we1(n5),
    .rd1(n4));  // ../../RTL/CPU/BIU/cache.v(45)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1d3 (
    .clk1(clk),
    .ra1(l1d_addr),
    .re1(1'b1),
    .wa1(l1d_addr),
    .wd1(l1d_in[31:24]),
    .we1(n7),
    .rd1(n6));  // ../../RTL/CPU/BIU/cache.v(47)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1d4 (
    .clk1(clk),
    .ra1(l1d_addr),
    .re1(1'b1),
    .wa1(l1d_addr),
    .wd1(l1d_in[39:32]),
    .we1(n9),
    .rd1(n8));  // ../../RTL/CPU/BIU/cache.v(49)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1d5 (
    .clk1(clk),
    .ra1(l1d_addr),
    .re1(1'b1),
    .wa1(l1d_addr),
    .wd1(l1d_in[47:40]),
    .we1(n11),
    .rd1(n10));  // ../../RTL/CPU/BIU/cache.v(51)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1d6 (
    .clk1(clk),
    .ra1(l1d_addr),
    .re1(1'b1),
    .wa1(l1d_addr),
    .wd1(l1d_in[55:48]),
    .we1(n13),
    .rd1(n12));  // ../../RTL/CPU/BIU/cache.v(53)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1d7 (
    .clk1(clk),
    .ra1(l1d_addr),
    .re1(1'b1),
    .wa1(l1d_addr),
    .wd1(l1d_in[63:56]),
    .we1(n15),
    .rd1(n14));  // ../../RTL/CPU/BIU/cache.v(55)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1i0 (
    .clk1(clk),
    .ra1(l1i_addr),
    .re1(1'b1),
    .wa1(l1i_addr),
    .wd1(l1i_in[7:0]),
    .we1(n17),
    .rd1(n16));  // ../../RTL/CPU/BIU/cache.v(24)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1i1 (
    .clk1(clk),
    .ra1(l1i_addr),
    .re1(1'b1),
    .wa1(l1i_addr),
    .wd1(l1i_in[15:8]),
    .we1(n19),
    .rd1(n18));  // ../../RTL/CPU/BIU/cache.v(26)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1i2 (
    .clk1(clk),
    .ra1(l1i_addr),
    .re1(1'b1),
    .wa1(l1i_addr),
    .wd1(l1i_in[23:16]),
    .we1(n21),
    .rd1(n20));  // ../../RTL/CPU/BIU/cache.v(28)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1i3 (
    .clk1(clk),
    .ra1(l1i_addr),
    .re1(1'b1),
    .wa1(l1i_addr),
    .wd1(l1i_in[31:24]),
    .we1(n23),
    .rd1(n22));  // ../../RTL/CPU/BIU/cache.v(30)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1i4 (
    .clk1(clk),
    .ra1(l1i_addr),
    .re1(1'b1),
    .wa1(l1i_addr),
    .wd1(l1i_in[39:32]),
    .we1(n25),
    .rd1(n24));  // ../../RTL/CPU/BIU/cache.v(32)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1i5 (
    .clk1(clk),
    .ra1(l1i_addr),
    .re1(1'b1),
    .wa1(l1i_addr),
    .wd1(l1i_in[47:40]),
    .we1(n27),
    .rd1(n26));  // ../../RTL/CPU/BIU/cache.v(34)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1i6 (
    .clk1(clk),
    .ra1(l1i_addr),
    .re1(1'b1),
    .wa1(l1i_addr),
    .wd1(l1i_in[55:48]),
    .we1(n29),
    .rd1(n28));  // ../../RTL/CPU/BIU/cache.v(36)
  ram_w9x8_r9x8 #(
    .DATA_DEPTH_LEFT("511"),
    .DATA_DEPTH_RIGHT("0"),
    .DATA_WIDTH_LEFT("7"),
    .DATA_WIDTH_RIGHT("0"))
    ram_l1i7 (
    .clk1(clk),
    .ra1(l1i_addr),
    .re1(1'b1),
    .wa1(l1i_addr),
    .wd1(l1i_in[63:56]),
    .we1(n31),
    .rd1(n30));  // ../../RTL/CPU/BIU/cache.v(38)
  reg_ar_as_w8 reg0 (
    .clk(clk),
    .d(n2),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1d1out));  // ../../RTL/CPU/BIU/cache.v(74)
  reg_ar_as_w8 reg1 (
    .clk(clk),
    .d(n4),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1d2out));  // ../../RTL/CPU/BIU/cache.v(81)
  reg_ar_as_w8 reg10 (
    .clk(clk),
    .d(n22),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1i3out));  // ../../RTL/CPU/BIU/cache.v(148)
  reg_ar_as_w8 reg11 (
    .clk(clk),
    .d(n24),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1i4out));  // ../../RTL/CPU/BIU/cache.v(156)
  reg_ar_as_w8 reg12 (
    .clk(clk),
    .d(n26),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1i5out));  // ../../RTL/CPU/BIU/cache.v(163)
  reg_ar_as_w8 reg13 (
    .clk(clk),
    .d(n28),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1i6out));  // ../../RTL/CPU/BIU/cache.v(170)
  reg_ar_as_w8 reg14 (
    .clk(clk),
    .d(n30),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1i7out));  // ../../RTL/CPU/BIU/cache.v(177)
  reg_ar_as_w8 reg15 (
    .clk(clk),
    .d(n0),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1d0out));  // ../../RTL/CPU/BIU/cache.v(66)
  reg_ar_as_w8 reg2 (
    .clk(clk),
    .d(n6),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1d3out));  // ../../RTL/CPU/BIU/cache.v(88)
  reg_ar_as_w8 reg3 (
    .clk(clk),
    .d(n8),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1d4out));  // ../../RTL/CPU/BIU/cache.v(96)
  reg_ar_as_w8 reg4 (
    .clk(clk),
    .d(n10),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1d5out));  // ../../RTL/CPU/BIU/cache.v(103)
  reg_ar_as_w8 reg5 (
    .clk(clk),
    .d(n12),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1d6out));  // ../../RTL/CPU/BIU/cache.v(110)
  reg_ar_as_w8 reg6 (
    .clk(clk),
    .d(n14),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1d7out));  // ../../RTL/CPU/BIU/cache.v(117)
  reg_ar_as_w8 reg7 (
    .clk(clk),
    .d(n16),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1i0out));  // ../../RTL/CPU/BIU/cache.v(127)
  reg_ar_as_w8 reg8 (
    .clk(clk),
    .d(n18),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1i1out));  // ../../RTL/CPU/BIU/cache.v(134)
  reg_ar_as_w8 reg9 (
    .clk(clk),
    .d(n20),
    .reset(8'b00000000),
    .set(8'b00000000),
    .q(l1i2out));  // ../../RTL/CPU/BIU/cache.v(141)
  and u10 (n13, l1d_write, l1d_bsel[6]);  // ../../RTL/CPU/BIU/cache.v(106)
  buf u100 (l1i_out[18], l1i2out[2]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u101 (l1i_out[19], l1i2out[3]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u102 (l1i_out[20], l1i2out[4]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u103 (l1i_out[21], l1i2out[5]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u104 (l1i_out[22], l1i2out[6]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u105 (l1i_out[23], l1i2out[7]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u106 (l1i_out[24], l1i3out[0]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u107 (l1i_out[25], l1i3out[1]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u108 (l1i_out[26], l1i3out[2]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u109 (l1i_out[27], l1i3out[3]);  // ../../RTL/CPU/BIU/cache.v(179)
  and u11 (n15, l1d_write, l1d_bsel[7]);  // ../../RTL/CPU/BIU/cache.v(113)
  buf u110 (l1i_out[28], l1i3out[4]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u111 (l1i_out[29], l1i3out[5]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u112 (l1i_out[30], l1i3out[6]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u113 (l1i_out[31], l1i3out[7]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u114 (l1i_out[32], l1i4out[0]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u115 (l1i_out[33], l1i4out[1]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u116 (l1i_out[34], l1i4out[2]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u117 (l1i_out[35], l1i4out[3]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u118 (l1i_out[36], l1i4out[4]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u119 (l1i_out[37], l1i4out[5]);  // ../../RTL/CPU/BIU/cache.v(179)
  and u12 (n17, l1i_write, l1i_bsel[0]);  // ../../RTL/CPU/BIU/cache.v(123)
  buf u120 (l1i_out[38], l1i4out[6]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u121 (l1i_out[39], l1i4out[7]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u122 (l1i_out[40], l1i5out[0]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u123 (l1i_out[41], l1i5out[1]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u124 (l1i_out[42], l1i5out[2]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u125 (l1i_out[43], l1i5out[3]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u126 (l1i_out[44], l1i5out[4]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u127 (l1i_out[45], l1i5out[5]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u128 (l1i_out[46], l1i5out[6]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u129 (l1i_out[47], l1i5out[7]);  // ../../RTL/CPU/BIU/cache.v(179)
  and u13 (n19, l1i_write, l1i_bsel[1]);  // ../../RTL/CPU/BIU/cache.v(130)
  buf u130 (l1i_out[48], l1i6out[0]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u131 (l1i_out[49], l1i6out[1]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u132 (l1i_out[50], l1i6out[2]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u133 (l1i_out[51], l1i6out[3]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u134 (l1i_out[52], l1i6out[4]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u135 (l1i_out[53], l1i6out[5]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u136 (l1i_out[54], l1i6out[6]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u137 (l1i_out[55], l1i6out[7]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u138 (l1i_out[56], l1i7out[0]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u139 (l1i_out[57], l1i7out[1]);  // ../../RTL/CPU/BIU/cache.v(179)
  and u14 (n21, l1i_write, l1i_bsel[2]);  // ../../RTL/CPU/BIU/cache.v(137)
  buf u140 (l1i_out[58], l1i7out[2]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u141 (l1i_out[59], l1i7out[3]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u142 (l1i_out[60], l1i7out[4]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u143 (l1i_out[61], l1i7out[5]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u144 (l1i_out[62], l1i7out[6]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u145 (l1i_out[63], l1i7out[7]);  // ../../RTL/CPU/BIU/cache.v(179)
  and u15 (n23, l1i_write, l1i_bsel[3]);  // ../../RTL/CPU/BIU/cache.v(144)
  and u16 (n25, l1i_write, l1i_bsel[4]);  // ../../RTL/CPU/BIU/cache.v(152)
  and u17 (n27, l1i_write, l1i_bsel[5]);  // ../../RTL/CPU/BIU/cache.v(159)
  and u18 (n29, l1i_write, l1i_bsel[6]);  // ../../RTL/CPU/BIU/cache.v(166)
  and u19 (n31, l1i_write, l1i_bsel[7]);  // ../../RTL/CPU/BIU/cache.v(173)
  buf u2 (l1d_out[1], l1d0out[1]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u20 (l1d_out[2], l1d0out[2]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u21 (l1i_out[0], l1i0out[0]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u22 (l1d_out[3], l1d0out[3]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u23 (l1d_out[4], l1d0out[4]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u24 (l1d_out[5], l1d0out[5]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u25 (l1d_out[6], l1d0out[6]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u26 (l1d_out[7], l1d0out[7]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u27 (l1d_out[8], l1d1out[0]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u28 (l1d_out[9], l1d1out[1]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u29 (l1d_out[10], l1d1out[2]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u3 (l1d_out[0], l1d0out[0]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u30 (l1d_out[11], l1d1out[3]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u31 (l1d_out[12], l1d1out[4]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u32 (l1d_out[13], l1d1out[5]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u33 (l1d_out[14], l1d1out[6]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u34 (l1d_out[15], l1d1out[7]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u35 (l1d_out[16], l1d2out[0]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u36 (l1d_out[17], l1d2out[1]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u37 (l1d_out[18], l1d2out[2]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u38 (l1d_out[19], l1d2out[3]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u39 (l1d_out[20], l1d2out[4]);  // ../../RTL/CPU/BIU/cache.v(180)
  and u4 (n1, l1d_write, l1d_bsel[0]);  // ../../RTL/CPU/BIU/cache.v(62)
  buf u40 (l1d_out[21], l1d2out[5]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u41 (l1d_out[22], l1d2out[6]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u42 (l1d_out[23], l1d2out[7]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u43 (l1d_out[24], l1d3out[0]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u44 (l1d_out[25], l1d3out[1]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u45 (l1d_out[26], l1d3out[2]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u46 (l1d_out[27], l1d3out[3]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u47 (l1d_out[28], l1d3out[4]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u48 (l1d_out[29], l1d3out[5]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u49 (l1d_out[30], l1d3out[6]);  // ../../RTL/CPU/BIU/cache.v(180)
  and u5 (n3, l1d_write, l1d_bsel[1]);  // ../../RTL/CPU/BIU/cache.v(70)
  buf u50 (l1d_out[31], l1d3out[7]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u51 (l1d_out[32], l1d4out[0]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u52 (l1d_out[33], l1d4out[1]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u53 (l1d_out[34], l1d4out[2]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u54 (l1d_out[35], l1d4out[3]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u55 (l1d_out[36], l1d4out[4]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u56 (l1d_out[37], l1d4out[5]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u57 (l1d_out[38], l1d4out[6]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u58 (l1d_out[39], l1d4out[7]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u59 (l1d_out[40], l1d5out[0]);  // ../../RTL/CPU/BIU/cache.v(180)
  and u6 (n5, l1d_write, l1d_bsel[2]);  // ../../RTL/CPU/BIU/cache.v(77)
  buf u60 (l1d_out[41], l1d5out[1]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u61 (l1d_out[42], l1d5out[2]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u62 (l1d_out[43], l1d5out[3]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u63 (l1d_out[44], l1d5out[4]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u64 (l1d_out[45], l1d5out[5]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u65 (l1d_out[46], l1d5out[6]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u66 (l1d_out[47], l1d5out[7]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u67 (l1d_out[48], l1d6out[0]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u68 (l1d_out[49], l1d6out[1]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u69 (l1d_out[50], l1d6out[2]);  // ../../RTL/CPU/BIU/cache.v(180)
  and u7 (n7, l1d_write, l1d_bsel[3]);  // ../../RTL/CPU/BIU/cache.v(84)
  buf u70 (l1d_out[51], l1d6out[3]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u71 (l1d_out[52], l1d6out[4]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u72 (l1d_out[53], l1d6out[5]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u73 (l1d_out[54], l1d6out[6]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u74 (l1d_out[55], l1d6out[7]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u75 (l1d_out[56], l1d7out[0]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u76 (l1d_out[57], l1d7out[1]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u77 (l1d_out[58], l1d7out[2]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u78 (l1d_out[59], l1d7out[3]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u79 (l1d_out[60], l1d7out[4]);  // ../../RTL/CPU/BIU/cache.v(180)
  and u8 (n9, l1d_write, l1d_bsel[4]);  // ../../RTL/CPU/BIU/cache.v(92)
  buf u80 (l1d_out[61], l1d7out[5]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u81 (l1d_out[62], l1d7out[6]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u82 (l1d_out[63], l1d7out[7]);  // ../../RTL/CPU/BIU/cache.v(180)
  buf u83 (l1i_out[1], l1i0out[1]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u84 (l1i_out[2], l1i0out[2]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u85 (l1i_out[3], l1i0out[3]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u86 (l1i_out[4], l1i0out[4]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u87 (l1i_out[5], l1i0out[5]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u88 (l1i_out[6], l1i0out[6]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u89 (l1i_out[7], l1i0out[7]);  // ../../RTL/CPU/BIU/cache.v(179)
  and u9 (n11, l1d_write, l1d_bsel[5]);  // ../../RTL/CPU/BIU/cache.v(99)
  buf u90 (l1i_out[8], l1i1out[0]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u91 (l1i_out[9], l1i1out[1]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u92 (l1i_out[10], l1i1out[2]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u93 (l1i_out[11], l1i1out[3]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u94 (l1i_out[12], l1i1out[4]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u95 (l1i_out[13], l1i1out[5]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u96 (l1i_out[14], l1i1out[6]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u97 (l1i_out[15], l1i1out[7]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u98 (l1i_out[16], l1i2out[0]);  // ../../RTL/CPU/BIU/cache.v(179)
  buf u99 (l1i_out[17], l1i2out[1]);  // ../../RTL/CPU/BIU/cache.v(179)

endmodule 

module cache_ctrl_logic  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(5)
  (
  addr_ex,
  addr_if,
  bus_error,
  cache_counter,
  cache_flush,
  cache_reset,
  cache_write,
  cacheable,
  clk,
  data_write,
  ex_priv,
  if_priv,
  l1d_data,
  l1i_data,
  lock,
  mxr,
  paddress,
  page_fault,
  rd_ins,
  read,
  read_data,
  rst,
  satp,
  size,
  sum,
  trans_rdy,
  unpage,
  write,
  cache_addr,
  cache_addr_sel,
  cache_data,
  cache_rdy,
  cache_ready_ex,
  cache_ready_if,
  data_uncache,
  ex_data_sel,
  ins_acc_fault,
  ins_page_fault,
  l1d_bsel,
  l1d_wr,
  l1i_bsel,
  l1i_wr,
  load_acc_fault,
  load_page_fault,
  maddress,
  new_pte_update,
  opc,
  pa_cov,
  paddr,
  priv,
  rd,
  store_acc_fault,
  store_page_fault,
  trans_size,
  uncache_data_rdy,
  wr,
  write_data
  );

  input [63:0] addr_ex;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(77)
  input [63:0] addr_if;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(66)
  input bus_error;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(51)
  input [8:0] cache_counter;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(61)
  input cache_flush;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(81)
  input cache_reset;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(82)
  input cache_write;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(49)
  input cacheable;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(47)
  input clk;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(7)
  input [63:0] data_write;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(78)
  input [3:0] ex_priv;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(76)
  input [3:0] if_priv;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(65)
  input [63:0] l1d_data;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(25)
  input [63:0] l1i_data;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(26)
  input lock;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(85)
  input mxr;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(11)
  input [127:0] paddress;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(54)
  input page_fault;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(50)
  input rd_ins;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(67)
  input read;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(83)
  input [63:0] read_data;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(57)
  input rst;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(8)
  input [63:0] satp;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(12)
  input [3:0] size;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(80)
  input sum;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(10)
  input trans_rdy;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(48)
  input unpage;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(75)
  input write;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(84)
  output [8:0] cache_addr;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(24)
  output cache_addr_sel;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(16)
  output [63:0] cache_data;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(23)
  output cache_rdy;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(40)
  output cache_ready_ex;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(90)
  output cache_ready_if;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(71)
  output [63:0] data_uncache;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(79)
  output [1:0] ex_data_sel;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(18)
  output ins_acc_fault;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(69)
  output ins_page_fault;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(70)
  output [7:0] l1d_bsel;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(22)
  output l1d_wr;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(19)
  output [7:0] l1i_bsel;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(21)
  output l1i_wr;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(20)
  output load_acc_fault;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(86)
  output load_page_fault;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(87)
  output [63:0] maddress;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(53)
  output new_pte_update;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(41)
  output [1:0] opc;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(43)
  output pa_cov;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(36)
  output paddr;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(33)
  output [3:0] priv;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(44)
  output rd;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(35)
  output store_acc_fault;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(88)
  output store_page_fault;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(89)
  output [3:0] trans_size;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(37)
  output uncache_data_rdy;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(91)
  output wr;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(34)
  output [63:0] write_data;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(59)

  parameter A = 6;
  parameter C = 63;
  parameter D = 7;
  parameter R = 1;
  parameter T = 62;
  parameter U = 4;
  parameter V = 0;
  parameter W = 2;
  parameter X = 3;
  parameter iaf = 5'b10001;
  parameter ipf = 5'b10010;
  parameter l1d_pte_upd = 5'b01101;
  parameter l1d_upd = 5'b01001;
  parameter l1d_wt = 5'b10000;
  parameter l1dpacov = 5'b00111;
  parameter l1i_pte_upd = 5'b01110;
  parameter l1i_upd = 5'b00110;
  parameter l1i_wt = 5'b01111;
  parameter l1ipacov = 5'b00100;
  parameter laf = 5'b10110;
  parameter lpf = 5'b10101;
  parameter normal = 5'b00000;
  parameter pte_upd = 5'b01100;
  parameter rd_pa_sg = 5'b01010;
  parameter saf = 5'b10011;
  parameter spf = 5'b10100;
  parameter valu_clr = 5'b00011;
  parameter wr_pa_sg = 5'b01011;
  wire [7:0] ex_bsel;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(167)
  wire [127:0] l1d_pa;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(143)
  wire [63:0] l1d_pte;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(147)
  wire [63:0] l1d_va;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(142)
  wire [127:0] l1i_pa;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(141)
  wire [63:0] l1i_pte;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(146)
  wire [63:0] l1i_va;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(140)
  wire [4:0] n100;
  wire [4:0] n103;
  wire [4:0] n105;
  wire [4:0] n109;
  wire [4:0] n110;
  wire [4:0] n111;
  wire [4:0] n112;
  wire [4:0] n113;
  wire [4:0] n114;
  wire [4:0] n115;
  wire [4:0] n116;
  wire [4:0] n117;
  wire [4:0] n118;
  wire [4:0] n119;
  wire [4:0] n120;
  wire [4:0] n121;
  wire [4:0] n122;
  wire [4:0] n123;
  wire [4:0] n124;
  wire [4:0] n125;
  wire [4:0] n126;
  wire [4:0] n127;
  wire [4:0] n128;
  wire [4:0] n129;
  wire [4:0] n130;
  wire [4:0] n131;
  wire [4:0] n132;
  wire [4:0] n133;
  wire [4:0] n134;
  wire [63:0] n136;
  wire [63:0] n137;
  wire [127:0] n141;
  wire [127:0] n142;
  wire [63:0] n147;
  wire [63:0] n148;
  wire [63:0] n150;
  wire [63:0] n151;
  wire [127:0] n152;
  wire [127:0] n153;
  wire [63:0] n158;
  wire [63:0] n159;
  wire [127:0] n164;
  wire [63:0] n165;
  wire [127:0] n166;
  wire [63:0] n167;
  wire [127:0] n168;
  wire [63:0] n169;
  wire [4:0] n180;
  wire [6:0] n181;
  wire [7:0] n182;
  wire [4:0] n184;
  wire [6:0] n185;
  wire [5:0] n186;
  wire [6:0] n189;
  wire [4:0] n190;
  wire [5:0] n192;
  wire [2:0] n193;
  wire [63:0] n207;
  wire [63:0] n208;
  wire [63:0] n209;
  wire [63:0] n210;
  wire [63:0] n211;
  wire [63:0] n212;
  wire [63:0] n213;
  wire [63:0] n214;
  wire [63:0] n215;
  wire [63:0] n216;
  wire [63:0] n217;
  wire [63:0] n218;
  wire [63:0] n219;
  wire [63:0] n220;
  wire [63:0] n221;
  wire [63:0] n222;
  wire [63:0] n223;
  wire [63:0] n228;
  wire [63:0] n229;
  wire [63:0] n230;
  wire [63:0] n231;
  wire [63:0] n232;
  wire [63:0] n233;
  wire [3:0] n60;
  wire [3:0] n61;
  wire [4:0] n70;
  wire [4:0] n71;
  wire [4:0] n72;
  wire [2:0] n73;
  wire [4:0] n74;
  wire [3:0] n80;
  wire [3:0] n81;
  wire [3:0] n82;
  wire [4:0] n83;
  wire [4:0] n84;
  wire [4:0] n87;
  wire [4:0] n88;
  wire [3:0] n90;
  wire [4:0] n91;
  wire [4:0] n92;
  wire [3:0] n95;
  wire [4:0] n96;
  wire [4:0] n99;
  wire [11:0] off;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(165)
  wire [127:0] pa_temp;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(136)
  wire [63:0] pte_temp;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(145)
  wire [4:0] statu;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(133)
  wire ex_l1d_chkok;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(158)
  wire ex_l1d_hit;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(154)
  wire ex_l1i_chkok;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(157)
  wire ex_l1i_hit;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(155)
  wire if_l1i_chkok;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(159)
  wire if_l1i_hit;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(156)
  wire l1d_miss;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(162)
  wire l1d_value;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(138)
  wire l1d_wr_sel;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(435)
  wire l1d_write_burst;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(170)
  wire l1d_write_through;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(178)
  wire l1i_miss;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(161)
  wire l1i_value;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(137)
  wire l1i_wr_sel;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(434)
  wire l1i_write_burst;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(169)
  wire l1i_write_through;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(177)
  wire n0;
  wire n1;
  wire n10;
  wire n101;
  wire n102;
  wire n104;
  wire n106;
  wire n107;
  wire n108;
  wire n11;
  wire n12;
  wire n13;
  wire n135;
  wire n138;
  wire n139;
  wire n14;
  wire n140;
  wire n143;
  wire n144;
  wire n145;
  wire n146;
  wire n149;
  wire n15;
  wire n154;
  wire n155;
  wire n156;
  wire n157;
  wire n16;
  wire n160;
  wire n161;
  wire n162;
  wire n163;
  wire n17;
  wire n170;
  wire n171;
  wire n172;
  wire n173;
  wire n174;
  wire n175;
  wire n176;
  wire n177;
  wire n178;
  wire n179;
  wire n18;
  wire n183;
  wire n187;
  wire n188;
  wire n19;
  wire n191;
  wire n194;
  wire n195;
  wire n196;
  wire n197;
  wire n198;
  wire n199;
  wire n2;
  wire n20;
  wire n200;
  wire n201;
  wire n202;
  wire n203;
  wire n204;
  wire n205;
  wire n206;
  wire n21;
  wire n22;
  wire n224;
  wire n225;
  wire n226;
  wire n227;
  wire n23;
  wire n234;
  wire n235;
  wire n236;
  wire n237;
  wire n238;
  wire n239;
  wire n24;
  wire n240;
  wire n241;
  wire n242;
  wire n243;
  wire n244;
  wire n245;
  wire n246;
  wire n247;
  wire n248;
  wire n249;
  wire n25;
  wire n250;
  wire n251;
  wire n252;
  wire n253;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire n34;
  wire n35;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n4;
  wire n40;
  wire n41;
  wire n42;
  wire n43;
  wire n44;
  wire n45;
  wire n46;
  wire n47;
  wire n48;
  wire n49;
  wire n5;
  wire n50;
  wire n51;
  wire n52;
  wire n53;
  wire n54;
  wire n55;
  wire n56;
  wire n57;
  wire n58;
  wire n59;
  wire n6;
  wire n62;
  wire n63;
  wire n64;
  wire n65;
  wire n66;
  wire n67;
  wire n68;
  wire n69;
  wire n7;
  wire n75;
  wire n76;
  wire n77;
  wire n78;
  wire n79;
  wire n8;
  wire n85;
  wire n86;
  wire n89;
  wire n9;
  wire n93;
  wire n94;
  wire n97;
  wire n98;
  wire pte_l1d_upd;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(174)
  wire pte_l1i_upd;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(173)
  wire vm_on;  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(152)

  assign cache_rdy = cache_addr_sel;
  add_pu64_pu64_o64 add0 (
    .i0(pa_temp[63:0]),
    .i1({52'b0000000000000000000000000000000000000000000000000000,off}),
    .o(n207));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(503)
  add_pu64_pu64_o64 add1 (
    .i0(l1i_pa[63:0]),
    .i1({52'b0000000000000000000000000000000000000000000000000000,off}),
    .o(n209));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  add_pu64_pu64_o64 add2 (
    .i0(l1d_pa[63:0]),
    .i1({52'b0000000000000000000000000000000000000000000000000000,off}),
    .o(n212));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  eq_w52 eq0 (
    .i0(l1i_va[63:12]),
    .i1(addr_ex[63:12]),
    .o(n3));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(187)
  eq_w52 eq1 (
    .i0(l1d_va[63:12]),
    .i1(addr_ex[63:12]),
    .o(n5));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(188)
  eq_w5 eq10 (
    .i0(statu),
    .i1(5'b00000),
    .o(n55));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(218)
  eq_w5 eq11 (
    .i0(statu),
    .i1(5'b00011),
    .o(n67));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(243)
  eq_w5 eq12 (
    .i0(statu),
    .i1(5'b00100),
    .o(opc[1]));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(249)
  eq_w5 eq13 (
    .i0(statu),
    .i1(5'b00110),
    .o(l1i_wr_sel));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(253)
  eq_w5 eq14 (
    .i0(statu),
    .i1(5'b00111),
    .o(n75));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(258)
  eq_w5 eq15 (
    .i0(statu),
    .i1(5'b01001),
    .o(l1d_wr_sel));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(263)
  eq_w5 eq16 (
    .i0(statu),
    .i1(5'b01011),
    .o(wr));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(268)
  eq_w5 eq17 (
    .i0(statu),
    .i1(5'b01010),
    .o(ex_data_sel[1]));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(272)
  eq_w5 eq18 (
    .i0(statu),
    .i1(5'b01111),
    .o(n93));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(276)
  eq_w5 eq19 (
    .i0(statu),
    .i1(5'b10000),
    .o(n97));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(279)
  eq_w52 eq2 (
    .i0(l1i_va[63:12]),
    .i1(addr_if[63:12]),
    .o(n7));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(189)
  eq_w5 eq20 (
    .i0(statu),
    .i1(5'b01100),
    .o(n101));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(282)
  eq_w5 eq21 (
    .i0(statu),
    .i1(5'b01110),
    .o(n102));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(285)
  eq_w5 eq22 (
    .i0(statu),
    .i1(5'b01101),
    .o(n104));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(288)
  eq_w5 eq23 (
    .i0(statu),
    .i1(5'b10010),
    .o(n106));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(291)
  eq_w5 eq24 (
    .i0(statu),
    .i1(5'b10001),
    .o(ins_acc_fault));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(294)
  eq_w5 eq25 (
    .i0(statu),
    .i1(5'b10100),
    .o(n107));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(297)
  eq_w5 eq26 (
    .i0(statu),
    .i1(5'b10011),
    .o(store_acc_fault));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(300)
  eq_w5 eq27 (
    .i0(statu),
    .i1(5'b10101),
    .o(n108));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(303)
  eq_w5 eq28 (
    .i0(statu),
    .i1(5'b10110),
    .o(load_acc_fault));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(306)
  eq_w9 eq29 (
    .i0(cache_counter),
    .i1(9'b111111111),
    .o(n138));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(330)
  eq_w4 eq3 (
    .i0(satp[63:60]),
    .i1(4'b1000),
    .o(vm_on));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(196)
  eq_w3 eq30 (
    .i0(addr_ex[2:0]),
    .i1(3'b000),
    .o(n172));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(445)
  eq_w4 eq31 (
    .i0(size),
    .i1(4'b0001),
    .o(n173));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(445)
  eq_w4 eq32 (
    .i0(size),
    .i1(4'b0010),
    .o(n174));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(445)
  eq_w4 eq33 (
    .i0(size),
    .i1(4'b0100),
    .o(n176));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(445)
  eq_w4 eq34 (
    .i0(size),
    .i1(4'b1000),
    .o(n178));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(445)
  eq_w3 eq35 (
    .i0(addr_ex[2:0]),
    .i1(3'b001),
    .o(n183));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(447)
  eq_w3 eq36 (
    .i0(addr_ex[2:0]),
    .i1(3'b010),
    .o(n187));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(450)
  eq_w3 eq37 (
    .i0(addr_ex[2:0]),
    .i1(3'b011),
    .o(n191));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(454)
  eq_w3 eq38 (
    .i0(addr_ex[2:0]),
    .i1(3'b100),
    .o(n194));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(459)
  eq_w3 eq39 (
    .i0(addr_ex[2:0]),
    .i1(3'b101),
    .o(n195));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(464)
  eq_w4 eq4 (
    .i0(ex_priv),
    .i1(4'b0001),
    .o(n12));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(201)
  eq_w3 eq40 (
    .i0(addr_ex[2:0]),
    .i1(3'b110),
    .o(n196));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(469)
  eq_w3 eq41 (
    .i0(addr_ex[2:0]),
    .i1(3'b111),
    .o(n197));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(473)
  eq_w4 eq5 (
    .i0(ex_priv),
    .i1(4'b0010),
    .o(n20));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(202)
  eq_w4 eq6 (
    .i0(ex_priv),
    .i1(4'b1000),
    .o(n27));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(203)
  eq_w4 eq7 (
    .i0(if_priv),
    .i1(4'b0001),
    .o(n48));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(207)
  eq_w4 eq8 (
    .i0(if_priv),
    .i1(4'b0010),
    .o(n50));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(208)
  eq_w4 eq9 (
    .i0(if_priv),
    .i1(4'b1000),
    .o(n52));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(209)
  AL_DFF l1d_value_reg (
    .clk(clk),
    .d(n156),
    .reset(1'b0),
    .set(1'b0),
    .q(l1d_value));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(394)
  AL_DFF l1i_value_reg (
    .clk(clk),
    .d(n145),
    .reset(1'b0),
    .set(1'b0),
    .q(l1i_value));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(347)
  binary_mux_s1_w4 mux0 (
    .i0({n59,n60[0],1'b1,n60[0]}),
    .i1(4'b1011),
    .sel(n58),
    .o(n61));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(223)
  binary_mux_s1_w5 mux1 (
    .i0({n69,1'b0,n70[2],1'b0,n69}),
    .i1(5'b00110),
    .sel(n68),
    .o(n71));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(250)
  binary_mux_s1_w4 mux10 (
    .i0({1'b1,trans_rdy,n73[2],n73[2]}),
    .i1(4'b0000),
    .sel(n89),
    .o(n90));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(269)
  binary_mux_s1_w5 mux11 (
    .i0({1'b0,n90}),
    .i1(5'b10011),
    .sel(bus_error),
    .o(n91));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(269)
  binary_mux_s1_w5 mux12 (
    .i0({1'b0,n73[2],1'b0,n73[2],1'b0}),
    .i1(5'b10110),
    .sel(bus_error),
    .o(n92));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(273)
  binary_mux_s1_w4 mux13 (
    .i0({n73[2],n73[2],n73[2],n73[2]}),
    .i1(4'b1110),
    .sel(n94),
    .o(n95));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(277)
  binary_mux_s1_w5 mux14 (
    .i0({1'b0,n95}),
    .i1(5'b10011),
    .sel(bus_error),
    .o(n96));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(277)
  binary_mux_s1_w5 mux15 (
    .i0({n73[2],4'b0000}),
    .i1(5'b01101),
    .sel(n98),
    .o(n99));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(280)
  binary_mux_s1_w5 mux16 (
    .i0(n99),
    .i1(5'b10011),
    .sel(bus_error),
    .o(n100));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(280)
  binary_mux_s1_w5 mux17 (
    .i0({1'b0,n73[2],n73[2],n73[2],1'b0}),
    .i1(5'b10011),
    .sel(bus_error),
    .o(n103));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(286)
  binary_mux_s1_w5 mux18 (
    .i0({1'b0,n73[2],n73[2],1'b0,n73[2]}),
    .i1(5'b10011),
    .sel(bus_error),
    .o(n105));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(289)
  binary_mux_s1_w5 mux19 (
    .i0(statu),
    .i1(5'b00000),
    .sel(load_acc_fault),
    .o(n109));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux2 (
    .i0(n71),
    .i1(5'b10010),
    .sel(page_fault),
    .o(n72));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(250)
  binary_mux_s1_w5 mux20 (
    .i0(n109),
    .i1(5'b00000),
    .sel(n108),
    .o(n110));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux21 (
    .i0(n110),
    .i1(5'b00000),
    .sel(store_acc_fault),
    .o(n111));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux22 (
    .i0(n111),
    .i1(5'b00000),
    .sel(n107),
    .o(n112));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux23 (
    .i0(n112),
    .i1(5'b00000),
    .sel(ins_acc_fault),
    .o(n113));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux24 (
    .i0(n113),
    .i1(5'b00000),
    .sel(n106),
    .o(n114));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux25 (
    .i0(n114),
    .i1(n105),
    .sel(n104),
    .o(n115));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux26 (
    .i0(n115),
    .i1(n103),
    .sel(n102),
    .o(n116));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux27 (
    .i0(n116),
    .i1({1'b0,n73[2],n73[2],2'b00}),
    .sel(n101),
    .o(n117));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux28 (
    .i0(n117),
    .i1(n100),
    .sel(n97),
    .o(n118));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux29 (
    .i0(n118),
    .i1(n96),
    .sel(n93),
    .o(n119));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux3 (
    .i0({2'b00,n73[2],n73[2],1'b0}),
    .i1(5'b10001),
    .sel(bus_error),
    .o(n74));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(254)
  binary_mux_s1_w5 mux30 (
    .i0(n119),
    .i1(n92),
    .sel(ex_data_sel[1]),
    .o(n120));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux31 (
    .i0(n120),
    .i1(n91),
    .sel(wr),
    .o(n121));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux32 (
    .i0(n121),
    .i1(n88),
    .sel(l1d_wr_sel),
    .o(n122));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux33 (
    .i0(n122),
    .i1(n84),
    .sel(n75),
    .o(n123));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux34 (
    .i0(n123),
    .i1(n74),
    .sel(l1i_wr_sel),
    .o(n124));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux35 (
    .i0(n124),
    .i1(n72),
    .sel(opc[1]),
    .o(n125));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux36 (
    .i0(n125),
    .i1(5'b00000),
    .sel(n67),
    .o(n126));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux37 (
    .i0(n126),
    .i1(5'b01111),
    .sel(n66),
    .o(n127));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux38 (
    .i0(n127),
    .i1(5'b10000),
    .sel(n65),
    .o(n128));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux39 (
    .i0(n128),
    .i1(5'b01110),
    .sel(n64),
    .o(n129));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w4 mux4 (
    .i0({n79,n80[2],1'b1,n80[2]}),
    .i1(4'b1011),
    .sel(n78),
    .o(n81));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(259)
  binary_mux_s1_w5 mux40 (
    .i0(n129),
    .i1(5'b01101),
    .sel(n63),
    .o(n130));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux41 (
    .i0(n130),
    .i1(5'b00100),
    .sel(n62),
    .o(n131));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux42 (
    .i0(n131),
    .i1({1'b0,n61}),
    .sel(n57),
    .o(n132));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux43 (
    .i0(n132),
    .i1(5'b00011),
    .sel(n56),
    .o(n133));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w5 mux44 (
    .i0(n133),
    .i1(5'b00000),
    .sel(rst),
    .o(n134));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(311)
  binary_mux_s1_w64 mux45 (
    .i0(l1i_va),
    .i1(addr_if),
    .sel(n135),
    .o(n136));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(322)
  binary_mux_s1_w64 mux46 (
    .i0(n136),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n137));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(322)
  binary_mux_s1_w128 mux47 (
    .i0(l1i_pa),
    .i1(pa_temp),
    .sel(n140),
    .o(n141));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(332)
  binary_mux_s1_w128 mux48 (
    .i0(n141),
    .i1(128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n142));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(332)
  binary_mux_s1_w64 mux49 (
    .i0({l1i_pte[63:8],n146,l1i_pte[6:0]}),
    .i1(pte_temp),
    .sel(n135),
    .o(n147));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(361)
  binary_mux_s1_w4 mux5 (
    .i0(n81),
    .i1(4'b0110),
    .sel(n68),
    .o(n82));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(259)
  binary_mux_s1_w64 mux50 (
    .i0(n147),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n148));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(361)
  binary_mux_s1_w64 mux51 (
    .i0(l1d_va),
    .i1(addr_ex),
    .sel(n149),
    .o(n150));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(371)
  binary_mux_s1_w64 mux52 (
    .i0(n150),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n151));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(371)
  binary_mux_s1_w128 mux53 (
    .i0(l1d_pa),
    .i1(pa_temp),
    .sel(n149),
    .o(n152));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(381)
  binary_mux_s1_w128 mux54 (
    .i0(n152),
    .i1(128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n153));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(381)
  binary_mux_s1_w64 mux55 (
    .i0({l1d_pte[63:8],n157,l1d_pte[6:0]}),
    .i1(pte_temp),
    .sel(n149),
    .o(n158));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(406)
  binary_mux_s1_w64 mux56 (
    .i0(n158),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n159));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(406)
  binary_mux_s1_w128 mux57 (
    .i0(pa_temp),
    .i1(paddress),
    .sel(n162),
    .o(n164));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(428)
  binary_mux_s1_w64 mux58 (
    .i0({pte_temp[63:8],n163,pte_temp[6:0]}),
    .i1(read_data),
    .sel(n162),
    .o(n165));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(428)
  binary_mux_s1_w128 mux59 (
    .i0(n164),
    .i1({pa_temp[127:64],addr_ex}),
    .sel(n161),
    .o(n166));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(428)
  binary_mux_s1_w5 mux6 (
    .i0({1'b0,n82}),
    .i1(5'b10101),
    .sel(n77),
    .o(n83));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(259)
  binary_mux_s1_w64 mux60 (
    .i0(n165),
    .i1(pte_temp),
    .sel(n161),
    .o(n167));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(428)
  binary_mux_s1_w128 mux61 (
    .i0(n166),
    .i1(128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n168));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(428)
  binary_mux_s1_w64 mux62 (
    .i0(n167),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n169));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(428)
  binary_mux_s1_w8 mux63 (
    .i0(8'b11111111),
    .i1(ex_bsel),
    .sel(n170),
    .o(l1i_bsel));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(440)
  binary_mux_s1_w8 mux64 (
    .i0(8'b11111111),
    .i1(ex_bsel),
    .sel(n171),
    .o(l1d_bsel));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(442)
  binary_mux_s1_w4 mux65 (
    .i0(ex_priv),
    .i1(if_priv),
    .sel(opc[1]),
    .o(priv));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(499)
  binary_mux_s1_w64 mux66 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(n207),
    .sel(n206),
    .o(n208));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(503)
  binary_mux_s1_w64 mux67 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(n209),
    .sel(n93),
    .o(n210));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  binary_mux_s1_w64 mux68 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(n212),
    .sel(n97),
    .o(n213));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  binary_mux_s1_w64 mux69 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(addr_ex),
    .sel(n75),
    .o(n215));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  binary_mux_s1_w5 mux7 (
    .i0(n83),
    .i1(5'b10100),
    .sel(n76),
    .o(n84));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(259)
  binary_mux_s1_w64 mux70 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(addr_if),
    .sel(opc[1]),
    .o(n217));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  binary_mux_s1_w64 mux71 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(l1i_pa[127:64]),
    .sel(n102),
    .o(n219));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  binary_mux_s1_w64 mux72 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(l1d_pa[127:64]),
    .sel(n104),
    .o(n221));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  binary_mux_s1_w64 mux73 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(pa_temp[127:64]),
    .sel(n101),
    .o(n223));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  binary_mux_s1_w12 mux74 (
    .i0(12'b000000000000),
    .i1(addr_ex[11:0]),
    .sel(n225),
    .o(off));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(514)
  binary_mux_s1_w64 mux75 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(data_write),
    .sel(n227),
    .o(n228));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(517)
  binary_mux_s1_w64 mux76 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(pte_temp),
    .sel(n101),
    .o(n229));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  binary_mux_s1_w64 mux77 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(l1i_pte),
    .sel(n102),
    .o(n231));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  binary_mux_s1_w64 mux78 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(l1d_pte),
    .sel(n104),
    .o(n233));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  binary_mux_s1_w5 mux8 (
    .i0({1'b0,n73[2],2'b00,n73[2]}),
    .i1(5'b10101),
    .sel(n86),
    .o(n87));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(264)
  binary_mux_s1_w5 mux9 (
    .i0(n87),
    .i1(5'b10100),
    .sel(n85),
    .o(n88));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(264)
  reg_ar_as_w64 reg0 (
    .clk(clk),
    .d(n137),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(l1i_va));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(323)
  reg_ar_as_w128 reg1 (
    .clk(clk),
    .d(n142),
    .reset(128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000),
    .set(128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000),
    .q(l1i_pa));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(333)
  reg_ar_as_w64 reg2 (
    .clk(clk),
    .d(n148),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(l1i_pte));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(362)
  reg_ar_as_w64 reg3 (
    .clk(clk),
    .d(n151),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(l1d_va));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(372)
  reg_ar_as_w128 reg4 (
    .clk(clk),
    .d(n153),
    .reset(128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000),
    .set(128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000),
    .q(l1d_pa));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(382)
  reg_ar_as_w64 reg5 (
    .clk(clk),
    .d(n159),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(l1d_pte));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(407)
  reg_ar_as_w128 reg6 (
    .clk(clk),
    .d(n168),
    .reset(128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000),
    .set(128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000),
    .q(pa_temp));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(429)
  reg_ar_as_w64 reg7 (
    .clk(clk),
    .d(n169),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(pte_temp));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(429)
  reg_ar_as_w5 reg8 (
    .clk(clk),
    .d(n134),
    .reset(5'b00000),
    .set(5'b00000),
    .q(statu));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(312)
  or u10 (n232[17], n230[17], n231[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  and u100 (n78, trans_rdy, write);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(259)
  and u101 (n79, trans_rdy, read);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(259)
  or u102 (write_data[58], n232[58], n233[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u103 (n85, bus_error, write);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(264)
  and u104 (n86, bus_error, read);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(264)
  or u105 (write_data[57], n232[57], n233[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u106 (n89, trans_rdy, pte_temp[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(269)
  or u107 (write_data[56], n232[56], n233[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u108 (write_data[55], n232[55], n233[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u109 (write_data[54], n232[54], n233[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u11 (n232[16], n230[16], n231[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  and u110 (n94, trans_rdy, n0);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(277)
  or u111 (write_data[53], n232[53], n233[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u112 (write_data[52], n232[52], n233[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u113 (n98, trans_rdy, n1);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(280)
  or u114 (write_data[51], n232[51], n233[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u115 (write_data[50], n232[50], n233[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u116 (write_data[49], n232[49], n233[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u117 (n232[19], n230[19], n231[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u118 (write_data[48], n232[48], n233[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u119 (n135, l1i_wr_sel, trans_rdy);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(320)
  or u12 (n2, read, write);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(187)
  or u120 (write_data[47], n232[47], n233[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u121 (n139, l1d_wr_sel, n138);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(330)
  and u122 (n140, n139, trans_rdy);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(330)
  or u123 (write_data[46], n232[46], n233[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u124 (write_data[45], n232[45], n233[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u125 (write_data[44], n232[44], n233[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  AL_MUX u126 (
    .i0(l1i_value),
    .i1(1'b1),
    .sel(n135),
    .o(n143));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(346)
  AL_MUX u127 (
    .i0(n143),
    .i1(1'b0),
    .sel(n67),
    .o(n144));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(346)
  AL_MUX u128 (
    .i0(n144),
    .i1(1'b0),
    .sel(rst),
    .o(n145));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(346)
  or u129 (write_data[43], n232[43], n233[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u13 (n4, n2, n3);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(187)
  or u130 (write_data[42], n232[42], n233[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u131 (write_data[41], n232[41], n233[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  AL_MUX u132 (
    .i0(l1i_pte[7]),
    .i1(1'b1),
    .sel(n102),
    .o(n146));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(361)
  or u133 (write_data[40], n232[40], n233[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u134 (n149, l1d_wr_sel, trans_rdy);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(369)
  or u135 (write_data[39], n232[39], n233[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u136 (write_data[38], n232[38], n233[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u137 (write_data[37], n232[37], n233[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u138 (write_data[36], n232[36], n233[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u139 (write_data[35], n232[35], n233[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u14 (ex_l1i_hit, n4, l1i_value);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(187)
  AL_MUX u140 (
    .i0(l1d_value),
    .i1(1'b1),
    .sel(n149),
    .o(n154));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(393)
  AL_MUX u141 (
    .i0(n154),
    .i1(1'b0),
    .sel(n67),
    .o(n155));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(393)
  AL_MUX u142 (
    .i0(n155),
    .i1(1'b0),
    .sel(rst),
    .o(n156));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(393)
  or u143 (write_data[34], n232[34], n233[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u144 (write_data[33], n232[33], n233[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u145 (write_data[32], n232[32], n233[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  AL_MUX u146 (
    .i0(l1d_pte[7]),
    .i1(1'b1),
    .sel(n104),
    .o(n157));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(406)
  or u147 (write_data[31], n232[31], n233[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u148 (n160, n55, unpage);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(418)
  or u149 (write_data[30], n232[30], n233[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u15 (n232[15], n230[15], n231[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  and u150 (n161, n160, n2);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(418)
  or u151 (write_data[29], n232[29], n233[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u152 (write_data[28], n232[28], n233[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u153 (pa_cov, opc[1], n75);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(421)
  and u154 (n162, pa_cov, trans_rdy);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(421)
  or u155 (write_data[27], n232[27], n233[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  AL_MUX u156 (
    .i0(pte_temp[7]),
    .i1(1'b1),
    .sel(n101),
    .o(n163));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(428)
  or u157 (write_data[26], n232[26], n233[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u158 (write_data[25], n232[25], n233[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u159 (write_data[24], n232[24], n233[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u16 (n6, n2, n5);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(188)
  or u160 (write_data[23], n232[23], n233[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u161 (cache_addr_sel, l1i_wr_sel, l1d_wr_sel);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(436)
  or u162 (write_data[22], n232[22], n233[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u163 (write_data[21], n232[21], n233[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u164 (ex_bsel[1], n182[7], n182[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(473)
  or u165 (write_data[20], n232[20], n233[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u166 (n170, n55, ex_l1i_hit);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(440)
  or u167 (write_data[19], n232[19], n233[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u168 (n171, n55, ex_l1d_hit);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(442)
  or u169 (n175, n173, n174);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(445)
  and u17 (ex_l1d_hit, n6, l1d_value);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(188)
  or u170 (n177, n175, n176);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(445)
  or u171 (n179, n177, n178);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(445)
  and u172 (ex_bsel[0], n172, n179);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(445)
  or u173 (write_data[18], n232[18], n233[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u174 (write_data[17], n232[17], n233[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u175 (write_data[16], n232[16], n233[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u176 (write_data[15], n232[15], n233[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u177 (write_data[14], n232[14], n233[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u178 (n180[3], n173, n174);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  or u179 (n181[3], n180[3], n176);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  and u18 (n8, rd_ins, n7);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(189)
  or u180 (write_data[13], n232[13], n233[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u181 (write_data[12], n232[12], n233[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u182 (write_data[11], n232[11], n233[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u183 (write_data[10], n232[10], n233[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u184 (write_data[9], n232[9], n233[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u185 (n232[24], n230[24], n231[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u186 (n232[62], n230[62], n231[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u187 (write_data[8], n232[8], n233[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u188 (write_data[7], n232[7], n233[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u189 (write_data[6], n232[6], n233[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  and u19 (if_l1i_hit, n8, l1i_value);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(189)
  or u190 (n184[3], n174, n176);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(448)
  and u191 (n182[0], n183, n181[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  or u192 (write_data[5], n232[5], n233[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u193 (write_data[4], n232[4], n233[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u194 (write_data[3], n232[3], n233[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u195 (n232[28], n230[28], n231[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u196 (n232[34], n230[34], n231[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u197 (n232[56], n230[56], n231[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u198 (write_data[2], n232[2], n233[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u199 (write_data[1], n232[1], n233[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  not u2 (n60[0], n59);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(223)
  not u20 (n9, if_l1i_hit);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(192)
  buf u200 (cache_addr[8], cache_counter[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(523)
  buf u201 (cache_addr[7], cache_counter[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(523)
  buf u202 (cache_addr[6], cache_counter[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(523)
  or u203 (n232[23], n230[23], n231[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u204 (n232[61], n230[61], n231[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u205 (cache_addr[5], cache_counter[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(523)
  buf u206 (cache_addr[4], cache_counter[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(523)
  buf u207 (cache_addr[3], cache_counter[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(523)
  or u208 (n188, n176, n178);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(451)
  or u209 (n232[42], n230[42], n231[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  and u21 (l1i_miss, rd_ins, n9);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(192)
  buf u210 (cache_addr[2], cache_counter[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(523)
  buf u211 (cache_addr[1], cache_counter[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(523)
  or u212 (n232[47], n230[47], n231[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u213 (n232[51], n230[51], n231[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u214 (cache_data[63], read_data[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u215 (cache_data[62], read_data[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u216 (cache_data[61], read_data[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u217 (n232[27], n230[27], n231[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u218 (n232[33], n230[33], n231[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u219 (n232[55], n230[55], n231[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u22 (n232[14], n230[14], n231[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u220 (cache_data[60], read_data[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u221 (cache_data[59], read_data[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u222 (cache_data[58], read_data[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u223 (cache_data[57], read_data[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u224 (cache_data[56], read_data[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u225 (n232[22], n230[22], n231[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u226 (n232[60], n230[60], n231[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u227 (cache_data[55], read_data[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u228 (cache_data[54], read_data[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u229 (n232[36], n230[36], n231[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  not u23 (n10, ex_l1d_hit);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(193)
  buf u230 (cache_data[53], read_data[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u231 (cache_data[52], read_data[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u232 (n232[39], n230[39], n231[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u233 (n232[41], n230[41], n231[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u234 (cache_data[51], read_data[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u235 (cache_data[50], read_data[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u236 (n232[46], n230[46], n231[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u237 (n232[50], n230[50], n231[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u238 (cache_data[49], read_data[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u239 (cache_data[48], read_data[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  and u24 (n11, n2, n10);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(193)
  buf u240 (cache_data[47], read_data[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u241 (n232[26], n230[26], n231[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u242 (n232[32], n230[32], n231[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u243 (n232[54], n230[54], n231[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u244 (cache_data[46], read_data[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u245 (cache_data[45], read_data[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u246 (cache_data[44], read_data[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u247 (cache_data[43], read_data[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u248 (cache_data[42], read_data[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u249 (n232[21], n230[21], n231[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u25 (n232[13], n230[13], n231[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u250 (n232[59], n230[59], n231[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u251 (cache_data[41], read_data[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u252 (cache_data[40], read_data[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u253 (n232[35], n230[35], n231[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u254 (cache_data[39], read_data[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u255 (cache_data[38], read_data[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u256 (n232[38], n230[38], n231[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u257 (n232[40], n230[40], n231[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u258 (cache_data[37], read_data[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u259 (cache_data[36], read_data[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  and u26 (l1d_miss, n11, n10);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(193)
  or u260 (n232[45], n230[45], n231[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u261 (n232[49], n230[49], n231[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u262 (cache_data[35], read_data[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u263 (cache_data[34], read_data[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u264 (cache_data[33], read_data[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u265 (n232[25], n230[25], n231[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u266 (n232[31], n230[31], n231[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u267 (n232[53], n230[53], n231[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u268 (cache_data[32], read_data[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u269 (cache_data[31], read_data[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  and u27 (n13, n12, l1i_pte[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(201)
  buf u270 (cache_data[30], read_data[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u271 (n232[20], n230[20], n231[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u272 (n232[58], n230[58], n231[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u273 (cache_data[29], read_data[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u274 (cache_data[28], read_data[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  and u275 (n192[0], n183, n176);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(465)
  buf u276 (cache_data[27], read_data[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u277 (cache_data[26], read_data[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u278 (n232[37], n230[37], n231[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  and u279 (n185[0], n183, n184[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(448)
  and u28 (n14, write, l1i_pte[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(201)
  buf u280 (cache_data[25], read_data[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u281 (cache_data[24], read_data[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u282 (n232[44], n230[44], n231[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u283 (n232[48], n230[48], n231[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u284 (cache_data[23], read_data[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u285 (cache_data[22], read_data[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u286 (n232[30], n230[30], n231[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u287 (n232[52], n230[52], n231[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u288 (cache_data[21], read_data[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u289 (cache_data[20], read_data[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  and u29 (n15, mxr, l1i_pte[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(201)
  buf u290 (cache_data[19], read_data[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u291 (cache_data[18], read_data[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u292 (n232[57], n230[57], n231[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u293 (cache_data[17], read_data[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u294 (cache_data[16], read_data[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  and u295 (n189[0], n183, n176);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(470)
  buf u296 (cache_data[15], read_data[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u297 (cache_data[14], read_data[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u298 (n232[43], n230[43], n231[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u299 (data_uncache[0], read_data[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u3 (n232[18], n230[18], n231[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u30 (n16, l1i_pte[1], n15);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(201)
  buf u300 (cache_data[13], read_data[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u301 (cache_data[12], read_data[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u302 (n232[29], n230[29], n231[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u303 (n193[0], n192[5], n192[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(466)
  buf u304 (cache_data[11], read_data[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u305 (cache_data[10], read_data[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u306 (n190[0], n189[5], n189[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(471)
  buf u307 (cache_data[9], read_data[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  AL_MUX u308 (
    .i0(l1i_write_through),
    .i1(l1i_write_burst),
    .sel(l1i_wr_sel),
    .o(l1i_wr));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(477)
  buf u309 (cache_data[8], read_data[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  and u31 (n17, read, n16);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(201)
  AL_MUX u310 (
    .i0(l1d_write_through),
    .i1(l1d_write_burst),
    .sel(l1d_wr_sel),
    .o(l1d_wr));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(478)
  buf u311 (cache_data[7], read_data[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  AL_MUX u312 (
    .i0(1'b0),
    .i1(cache_write),
    .sel(l1d_wr_sel),
    .o(l1d_write_burst));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(479)
  buf u313 (cache_data[6], read_data[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  AL_MUX u314 (
    .i0(1'b0),
    .i1(cache_write),
    .sel(l1i_wr_sel),
    .o(l1i_write_burst));  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(480)
  not u315 (n198, ex_l1d_chkok);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(482)
  and u316 (ex_data_sel[0], ex_l1i_chkok, n198);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(482)
  buf u317 (cache_data[5], read_data[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u318 (cache_data[4], read_data[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u319 (cache_data[3], read_data[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u32 (n18, n14, n17);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(201)
  buf u320 (cache_data[2], read_data[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  or u321 (rd, cache_addr_sel, ex_data_sel[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(486)
  buf u322 (cache_data[1], read_data[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u323 (trans_size[3], size[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(525)
  buf u324 (trans_size[2], size[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(525)
  buf u325 (trans_size[1], size[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(525)
  buf u326 (data_uncache[63], read_data[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u327 (n199, cache_addr_sel, n101);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(488)
  buf u328 (data_uncache[62], read_data[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u329 (n200, n199, n102);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(488)
  and u33 (n19, n13, n18);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(201)
  buf u330 (data_uncache[61], read_data[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u331 (n201, n200, n104);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(488)
  buf u332 (data_uncache[60], read_data[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u333 (n202, n201, n93);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(488)
  buf u334 (data_uncache[59], read_data[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u335 (paddr, n202, n97);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(488)
  buf u336 (data_uncache[58], read_data[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u337 (data_uncache[57], read_data[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u338 (data_uncache[56], read_data[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u339 (data_uncache[55], read_data[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  and u34 (n21, sum, l1i_pte[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(202)
  buf u340 (data_uncache[54], read_data[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u341 (data_uncache[53], read_data[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u342 (data_uncache[52], read_data[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u343 (data_uncache[51], read_data[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u344 (n203, n102, n104);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(493)
  buf u345 (data_uncache[50], read_data[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u346 (new_pte_update, n203, n101);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(493)
  buf u347 (data_uncache[49], read_data[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u348 (data_uncache[48], read_data[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  and u349 (opc[0], n75, write);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(497)
  not u35 (n22, l1i_pte[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(202)
  buf u350 (data_uncache[47], read_data[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u351 (data_uncache[46], read_data[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u352 (data_uncache[45], read_data[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u353 (n204, wr, ex_data_sel[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(503)
  buf u354 (data_uncache[44], read_data[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u355 (n205, n204, l1i_wr_sel);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(503)
  buf u356 (data_uncache[43], read_data[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u357 (n206, n205, l1d_wr_sel);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(503)
  buf u358 (data_uncache[42], read_data[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u359 (n186[0], n185[6], n185[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(472)
  or u36 (n23, n21, n22);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(202)
  buf u360 (data_uncache[41], read_data[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u361 (n211[0], n208[0], n210[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  buf u362 (data_uncache[40], read_data[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u363 (n214[0], n211[0], n213[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  buf u364 (data_uncache[39], read_data[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u365 (n216[0], n214[0], n215[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  buf u366 (data_uncache[38], read_data[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u367 (n218[0], n216[0], n217[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  buf u368 (data_uncache[37], read_data[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u369 (n220[0], n218[0], n219[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  and u37 (n24, n20, n23);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(202)
  buf u370 (data_uncache[36], read_data[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u371 (n222[0], n220[0], n221[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  buf u372 (data_uncache[35], read_data[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u373 (data_uncache[34], read_data[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u374 (data_uncache[33], read_data[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u375 (data_uncache[32], read_data[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u376 (n224, n204, n97);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(514)
  buf u377 (data_uncache[31], read_data[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u378 (n225, n224, n93);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(514)
  buf u379 (data_uncache[30], read_data[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u38 (n232[12], n230[12], n231[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u380 (data_uncache[29], read_data[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u381 (n226, wr, n93);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(517)
  buf u382 (data_uncache[28], read_data[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u383 (n227, n226, n97);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(517)
  buf u384 (data_uncache[27], read_data[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u385 (maddress[0], n222[0], n223[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  buf u386 (data_uncache[26], read_data[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u387 (n230[0], n228[0], n229[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  buf u388 (data_uncache[25], read_data[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u389 (n232[0], n230[0], n231[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u39 (n232[11], n230[11], n231[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u390 (write_data[0], n232[0], n233[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  buf u391 (cache_addr[0], cache_counter[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(523)
  buf u392 (cache_data[0], read_data[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(524)
  buf u393 (data_uncache[24], read_data[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  not u394 (n234, pte_l1i_upd);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(530)
  not u395 (n235, pte_l1d_upd);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(530)
  or u396 (n236, n234, n235);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(530)
  not u397 (n237, l1i_write_through);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(530)
  or u398 (n238, n236, n237);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(530)
  not u399 (n239, l1d_write_through);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(530)
  and u4 (l1i_write_through, ex_l1i_chkok, write);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(180)
  or u40 (n232[10], n230[10], n231[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u400 (n240, n238, n239);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(530)
  and u401 (n241, n55, n240);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(530)
  buf u402 (data_uncache[23], read_data[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u403 (data_uncache[22], read_data[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u404 (data_uncache[21], read_data[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u405 (data_uncache[20], read_data[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u406 (data_uncache[19], read_data[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  and u407 (n242, n227, trans_rdy);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(531)
  or u408 (n243, n241, n242);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(531)
  buf u409 (data_uncache[18], read_data[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u41 (n232[9], n230[9], n231[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  buf u410 (data_uncache[17], read_data[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u411 (data_uncache[16], read_data[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  and u412 (n244, n203, trans_rdy);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(532)
  or u413 (n245, n243, n244);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(532)
  buf u414 (data_uncache[15], read_data[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u415 (cache_ready_ex, n245, n67);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(533)
  buf u416 (data_uncache[14], read_data[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  and u417 (uncache_data_rdy, ex_data_sel[1], trans_rdy);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(535)
  buf u418 (trans_size[0], size[0]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(525)
  buf u419 (data_uncache[13], read_data[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u42 (n232[8], n230[8], n231[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  and u420 (n246, n55, if_l1i_chkok);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(539)
  not u421 (n247, ex_l1i_chkok);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(539)
  and u422 (cache_ready_if, n246, n247);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(539)
  buf u423 (data_uncache[12], read_data[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u424 (data_uncache[11], read_data[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  not u425 (n248, if_l1i_chkok);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(543)
  and u426 (n249, if_l1i_hit, n248);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(543)
  or u427 (ins_page_fault, n106, n249);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(543)
  buf u428 (data_uncache[10], read_data[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u429 (data_uncache[9], read_data[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  and u43 (n25, n24, n18);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(202)
  buf u430 (data_uncache[8], read_data[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  and u431 (n250, ex_l1i_hit, n247);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(546)
  or u432 (n251, n107, n250);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(546)
  buf u433 (data_uncache[7], read_data[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  and u434 (n252, ex_l1d_hit, n198);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(546)
  or u435 (store_page_fault, n251, n252);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(546)
  buf u436 (data_uncache[6], read_data[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u437 (data_uncache[5], read_data[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u438 (data_uncache[4], read_data[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u439 (data_uncache[3], read_data[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u44 (n26, n19, n25);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(202)
  or u440 (n253, n108, n250);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(549)
  buf u441 (data_uncache[2], read_data[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  buf u442 (data_uncache[1], read_data[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(537)
  or u443 (load_page_fault, n253, n252);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(549)
  or u444 (n232[63], n230[63], n231[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u445 (n230[1], n228[1], n229[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u446 (n230[2], n228[2], n229[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u447 (n230[3], n228[3], n229[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u448 (n230[4], n228[4], n229[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u449 (n230[5], n228[5], n229[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u45 (n28, n26, n27);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(203)
  or u450 (n230[6], n228[6], n229[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u451 (n230[7], n228[7], n229[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u452 (n230[8], n228[8], n229[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u453 (n230[9], n228[9], n229[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u454 (n230[10], n228[10], n229[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u455 (n230[11], n228[11], n229[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u456 (n230[12], n228[12], n229[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u457 (n230[13], n228[13], n229[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u458 (n230[14], n228[14], n229[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u459 (n230[15], n228[15], n229[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u46 (n29, n28, vm_on);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(203)
  or u460 (n230[16], n228[16], n229[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u461 (n230[17], n228[17], n229[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u462 (n230[18], n228[18], n229[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u463 (n230[19], n228[19], n229[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u464 (n230[20], n228[20], n229[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u465 (n230[21], n228[21], n229[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u466 (n230[22], n228[22], n229[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u467 (n230[23], n228[23], n229[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u468 (n230[24], n228[24], n229[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u469 (n230[25], n228[25], n229[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  and u47 (ex_l1i_chkok, ex_l1i_hit, n29);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(203)
  or u470 (n230[26], n228[26], n229[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u471 (n230[27], n228[27], n229[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u472 (n230[28], n228[28], n229[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u473 (n230[29], n228[29], n229[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u474 (n230[30], n228[30], n229[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u475 (n230[31], n228[31], n229[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u476 (n230[32], n228[32], n229[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u477 (n230[33], n228[33], n229[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u478 (n230[34], n228[34], n229[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u479 (n230[35], n228[35], n229[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u48 (n232[7], n230[7], n231[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u480 (n230[36], n228[36], n229[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u481 (n230[37], n228[37], n229[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u482 (n230[38], n228[38], n229[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u483 (n230[39], n228[39], n229[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u484 (n230[40], n228[40], n229[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u485 (n230[41], n228[41], n229[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u486 (n230[42], n228[42], n229[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u487 (n230[43], n228[43], n229[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u488 (n230[44], n228[44], n229[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u489 (n230[45], n228[45], n229[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  and u49 (n30, n12, l1d_pte[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(204)
  or u490 (n230[46], n228[46], n229[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u491 (n230[47], n228[47], n229[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u492 (n230[48], n228[48], n229[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u493 (n230[49], n228[49], n229[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u494 (n230[50], n228[50], n229[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u495 (n230[51], n228[51], n229[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u496 (n230[52], n228[52], n229[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u497 (n230[53], n228[53], n229[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u498 (n230[54], n228[54], n229[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u499 (n230[55], n228[55], n229[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  not u5 (n0, l1i_pte[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(180)
  and u50 (n31, write, l1d_pte[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(204)
  or u500 (n230[56], n228[56], n229[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u501 (n230[57], n228[57], n229[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u502 (n230[58], n228[58], n229[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u503 (n230[59], n228[59], n229[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u504 (n230[60], n228[60], n229[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u505 (n230[61], n228[61], n229[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u506 (n230[62], n228[62], n229[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u507 (n230[63], n228[63], n229[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(518)
  or u508 (maddress[1], n222[1], n223[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u509 (maddress[2], n222[2], n223[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  and u51 (n32, mxr, l1d_pte[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(204)
  or u510 (maddress[3], n222[3], n223[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u511 (maddress[4], n222[4], n223[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u512 (maddress[5], n222[5], n223[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u513 (maddress[6], n222[6], n223[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u514 (maddress[7], n222[7], n223[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u515 (maddress[8], n222[8], n223[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u516 (maddress[9], n222[9], n223[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u517 (maddress[10], n222[10], n223[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u518 (maddress[11], n222[11], n223[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u519 (maddress[12], n222[12], n223[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u52 (n33, l1d_pte[1], n32);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(204)
  or u520 (maddress[13], n222[13], n223[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u521 (maddress[14], n222[14], n223[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u522 (maddress[15], n222[15], n223[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u523 (maddress[16], n222[16], n223[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u524 (maddress[17], n222[17], n223[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u525 (maddress[18], n222[18], n223[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u526 (maddress[19], n222[19], n223[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u527 (maddress[20], n222[20], n223[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u528 (maddress[21], n222[21], n223[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u529 (maddress[22], n222[22], n223[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  and u53 (n34, read, n33);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(204)
  or u530 (maddress[23], n222[23], n223[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u531 (maddress[24], n222[24], n223[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u532 (maddress[25], n222[25], n223[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u533 (maddress[26], n222[26], n223[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u534 (maddress[27], n222[27], n223[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u535 (maddress[28], n222[28], n223[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u536 (maddress[29], n222[29], n223[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u537 (maddress[30], n222[30], n223[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u538 (maddress[31], n222[31], n223[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u539 (maddress[32], n222[32], n223[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u54 (n35, n31, n34);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(204)
  or u540 (maddress[33], n222[33], n223[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u541 (maddress[34], n222[34], n223[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u542 (maddress[35], n222[35], n223[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u543 (maddress[36], n222[36], n223[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u544 (maddress[37], n222[37], n223[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u545 (maddress[38], n222[38], n223[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u546 (maddress[39], n222[39], n223[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u547 (maddress[40], n222[40], n223[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u548 (maddress[41], n222[41], n223[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u549 (maddress[42], n222[42], n223[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  and u55 (n36, n30, n35);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(204)
  or u550 (maddress[43], n222[43], n223[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u551 (maddress[44], n222[44], n223[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u552 (maddress[45], n222[45], n223[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u553 (maddress[46], n222[46], n223[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u554 (maddress[47], n222[47], n223[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u555 (maddress[48], n222[48], n223[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u556 (maddress[49], n222[49], n223[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u557 (maddress[50], n222[50], n223[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u558 (maddress[51], n222[51], n223[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u559 (maddress[52], n222[52], n223[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u56 (n232[6], n230[6], n231[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u560 (maddress[53], n222[53], n223[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u561 (maddress[54], n222[54], n223[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u562 (maddress[55], n222[55], n223[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u563 (maddress[56], n222[56], n223[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u564 (maddress[57], n222[57], n223[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u565 (maddress[58], n222[58], n223[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u566 (maddress[59], n222[59], n223[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u567 (maddress[60], n222[60], n223[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u568 (maddress[61], n222[61], n223[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u569 (maddress[62], n222[62], n223[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  and u57 (n37, sum, l1d_pte[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(205)
  or u570 (maddress[63], n222[63], n223[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(510)
  or u571 (n222[1], n220[1], n221[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u572 (n222[2], n220[2], n221[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u573 (n222[3], n220[3], n221[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u574 (n222[4], n220[4], n221[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u575 (n222[5], n220[5], n221[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u576 (n222[6], n220[6], n221[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u577 (n222[7], n220[7], n221[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u578 (n222[8], n220[8], n221[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u579 (n222[9], n220[9], n221[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  not u58 (n38, l1d_pte[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(205)
  or u580 (n222[10], n220[10], n221[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u581 (n222[11], n220[11], n221[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u582 (n222[12], n220[12], n221[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u583 (n222[13], n220[13], n221[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u584 (n222[14], n220[14], n221[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u585 (n222[15], n220[15], n221[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u586 (n222[16], n220[16], n221[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u587 (n222[17], n220[17], n221[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u588 (n222[18], n220[18], n221[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u589 (n222[19], n220[19], n221[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u59 (n39, n37, n38);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(205)
  or u590 (n222[20], n220[20], n221[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u591 (n222[21], n220[21], n221[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u592 (n222[22], n220[22], n221[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u593 (n222[23], n220[23], n221[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u594 (n222[24], n220[24], n221[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u595 (n222[25], n220[25], n221[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u596 (n222[26], n220[26], n221[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u597 (n222[27], n220[27], n221[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u598 (n222[28], n220[28], n221[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u599 (n222[29], n220[29], n221[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  and u6 (pte_l1i_upd, l1i_write_through, n0);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(180)
  and u60 (n40, n20, n39);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(205)
  or u600 (n222[30], n220[30], n221[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u601 (n222[31], n220[31], n221[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u602 (n222[32], n220[32], n221[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u603 (n222[33], n220[33], n221[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u604 (n222[34], n220[34], n221[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u605 (n222[35], n220[35], n221[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u606 (n222[36], n220[36], n221[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u607 (n222[37], n220[37], n221[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u608 (n222[38], n220[38], n221[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u609 (n222[39], n220[39], n221[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u61 (n232[5], n230[5], n231[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u610 (n222[40], n220[40], n221[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u611 (n222[41], n220[41], n221[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u612 (n222[42], n220[42], n221[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u613 (n222[43], n220[43], n221[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u614 (n222[44], n220[44], n221[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u615 (n222[45], n220[45], n221[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u616 (n222[46], n220[46], n221[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u617 (n222[47], n220[47], n221[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u618 (n222[48], n220[48], n221[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u619 (n222[49], n220[49], n221[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u62 (n232[4], n230[4], n231[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u620 (n222[50], n220[50], n221[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u621 (n222[51], n220[51], n221[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u622 (n222[52], n220[52], n221[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u623 (n222[53], n220[53], n221[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u624 (n222[54], n220[54], n221[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u625 (n222[55], n220[55], n221[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u626 (n222[56], n220[56], n221[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u627 (n222[57], n220[57], n221[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u628 (n222[58], n220[58], n221[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u629 (n222[59], n220[59], n221[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u63 (n41, l1i_pte[1], n32);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(205)
  or u630 (n222[60], n220[60], n221[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u631 (n222[61], n220[61], n221[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u632 (n222[62], n220[62], n221[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u633 (n222[63], n220[63], n221[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(509)
  or u634 (n220[1], n218[1], n219[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u635 (n220[2], n218[2], n219[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u636 (n220[3], n218[3], n219[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u637 (n220[4], n218[4], n219[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u638 (n220[5], n218[5], n219[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u639 (n220[6], n218[6], n219[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  and u64 (n42, read, n41);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(205)
  or u640 (n220[7], n218[7], n219[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u641 (n220[8], n218[8], n219[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u642 (n220[9], n218[9], n219[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u643 (n220[10], n218[10], n219[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u644 (n220[11], n218[11], n219[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u645 (n220[12], n218[12], n219[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u646 (n220[13], n218[13], n219[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u647 (n220[14], n218[14], n219[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u648 (n220[15], n218[15], n219[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u649 (n220[16], n218[16], n219[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u65 (n43, n31, n42);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(205)
  or u650 (n220[17], n218[17], n219[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u651 (n220[18], n218[18], n219[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u652 (n220[19], n218[19], n219[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u653 (n220[20], n218[20], n219[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u654 (n220[21], n218[21], n219[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u655 (n220[22], n218[22], n219[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u656 (n220[23], n218[23], n219[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u657 (n220[24], n218[24], n219[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u658 (n220[25], n218[25], n219[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u659 (n220[26], n218[26], n219[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  and u66 (n44, n40, n43);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(205)
  or u660 (n220[27], n218[27], n219[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u661 (n220[28], n218[28], n219[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u662 (n220[29], n218[29], n219[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u663 (n220[30], n218[30], n219[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u664 (n220[31], n218[31], n219[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u665 (n220[32], n218[32], n219[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u666 (n220[33], n218[33], n219[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u667 (n220[34], n218[34], n219[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u668 (n220[35], n218[35], n219[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u669 (n220[36], n218[36], n219[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u67 (n45, n36, n44);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(205)
  or u670 (n220[37], n218[37], n219[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u671 (n220[38], n218[38], n219[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u672 (n220[39], n218[39], n219[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u673 (n220[40], n218[40], n219[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u674 (n220[41], n218[41], n219[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u675 (n220[42], n218[42], n219[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u676 (n220[43], n218[43], n219[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u677 (n220[44], n218[44], n219[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u678 (n220[45], n218[45], n219[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u679 (n220[46], n218[46], n219[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u68 (n232[3], n230[3], n231[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u680 (n220[47], n218[47], n219[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u681 (n220[48], n218[48], n219[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u682 (n220[49], n218[49], n219[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u683 (n220[50], n218[50], n219[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u684 (n220[51], n218[51], n219[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u685 (n220[52], n218[52], n219[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u686 (n220[53], n218[53], n219[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u687 (n220[54], n218[54], n219[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u688 (n220[55], n218[55], n219[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u689 (n220[56], n218[56], n219[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u69 (n46, n45, n27);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(206)
  or u690 (n220[57], n218[57], n219[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u691 (n220[58], n218[58], n219[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u692 (n220[59], n218[59], n219[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u693 (n220[60], n218[60], n219[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u694 (n220[61], n218[61], n219[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u695 (n220[62], n218[62], n219[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u696 (n220[63], n218[63], n219[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(508)
  or u697 (n218[1], n216[1], n217[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u698 (n218[2], n216[2], n217[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u699 (n218[3], n216[3], n217[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  and u7 (l1d_write_through, ex_l1d_chkok, write);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(181)
  or u70 (n47, n46, vm_on);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(206)
  or u700 (n218[4], n216[4], n217[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u701 (n218[5], n216[5], n217[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u702 (n218[6], n216[6], n217[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u703 (n218[7], n216[7], n217[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u704 (n218[8], n216[8], n217[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u705 (n218[9], n216[9], n217[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u706 (n218[10], n216[10], n217[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u707 (n218[11], n216[11], n217[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u708 (n218[12], n216[12], n217[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u709 (n218[13], n216[13], n217[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  and u71 (ex_l1d_chkok, ex_l1d_hit, n47);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(206)
  or u710 (n218[14], n216[14], n217[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u711 (n218[15], n216[15], n217[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u712 (n218[16], n216[16], n217[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u713 (n218[17], n216[17], n217[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u714 (n218[18], n216[18], n217[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u715 (n218[19], n216[19], n217[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u716 (n218[20], n216[20], n217[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u717 (n218[21], n216[21], n217[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u718 (n218[22], n216[22], n217[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u719 (n218[23], n216[23], n217[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  and u72 (n49, n48, l1i_pte[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(207)
  or u720 (n218[24], n216[24], n217[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u721 (n218[25], n216[25], n217[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u722 (n218[26], n216[26], n217[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u723 (n218[27], n216[27], n217[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u724 (n218[28], n216[28], n217[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u725 (n218[29], n216[29], n217[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u726 (n218[30], n216[30], n217[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u727 (n218[31], n216[31], n217[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u728 (n218[32], n216[32], n217[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u729 (n218[33], n216[33], n217[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u73 (n51, n49, n50);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(208)
  or u730 (n218[34], n216[34], n217[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u731 (n218[35], n216[35], n217[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u732 (n218[36], n216[36], n217[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u733 (n218[37], n216[37], n217[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u734 (n218[38], n216[38], n217[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u735 (n218[39], n216[39], n217[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u736 (n218[40], n216[40], n217[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u737 (n218[41], n216[41], n217[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u738 (n218[42], n216[42], n217[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u739 (n218[43], n216[43], n217[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u74 (n53, n51, n52);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(209)
  or u740 (n218[44], n216[44], n217[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u741 (n218[45], n216[45], n217[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u742 (n218[46], n216[46], n217[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u743 (n218[47], n216[47], n217[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u744 (n218[48], n216[48], n217[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u745 (n218[49], n216[49], n217[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u746 (n218[50], n216[50], n217[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u747 (n218[51], n216[51], n217[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u748 (n218[52], n216[52], n217[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u749 (n218[53], n216[53], n217[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u75 (n54, n53, vm_on);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(209)
  or u750 (n218[54], n216[54], n217[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u751 (n218[55], n216[55], n217[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u752 (n218[56], n216[56], n217[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u753 (n218[57], n216[57], n217[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u754 (n218[58], n216[58], n217[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u755 (n218[59], n216[59], n217[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u756 (n218[60], n216[60], n217[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u757 (n218[61], n216[61], n217[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u758 (n218[62], n216[62], n217[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  or u759 (n218[63], n216[63], n217[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(507)
  and u76 (if_l1i_chkok, if_l1i_hit, n54);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(209)
  or u760 (n216[1], n214[1], n215[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u761 (n216[2], n214[2], n215[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u762 (n216[3], n214[3], n215[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u763 (n216[4], n214[4], n215[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u764 (n216[5], n214[5], n215[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u765 (n216[6], n214[6], n215[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u766 (n216[7], n214[7], n215[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u767 (n216[8], n214[8], n215[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u768 (n216[9], n214[9], n215[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u769 (n216[10], n214[10], n215[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  and u77 (n56, n55, cache_flush);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(218)
  or u770 (n216[11], n214[11], n215[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u771 (n216[12], n214[12], n215[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u772 (n216[13], n214[13], n215[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u773 (n216[14], n214[14], n215[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u774 (n216[15], n214[15], n215[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u775 (n216[16], n214[16], n215[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u776 (n216[17], n214[17], n215[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u777 (n216[18], n214[18], n215[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u778 (n216[19], n214[19], n215[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u779 (n216[20], n214[20], n215[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u78 (n232[2], n230[2], n231[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u780 (n216[21], n214[21], n215[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u781 (n216[22], n214[22], n215[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u782 (n216[23], n214[23], n215[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u783 (n216[24], n214[24], n215[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u784 (n216[25], n214[25], n215[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u785 (n216[26], n214[26], n215[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u786 (n216[27], n214[27], n215[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u787 (n216[28], n214[28], n215[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u788 (n216[29], n214[29], n215[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u789 (n216[30], n214[30], n215[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  and u79 (n57, n55, l1d_miss);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(222)
  or u790 (n216[31], n214[31], n215[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u791 (n216[32], n214[32], n215[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u792 (n216[33], n214[33], n215[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u793 (n216[34], n214[34], n215[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u794 (n216[35], n214[35], n215[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u795 (n216[36], n214[36], n215[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u796 (n216[37], n214[37], n215[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u797 (n216[38], n214[38], n215[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u798 (n216[39], n214[39], n215[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u799 (n216[40], n214[40], n215[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  not u8 (n1, l1d_pte[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(181)
  and u80 (n58, unpage, write);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(223)
  or u800 (n216[41], n214[41], n215[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u801 (n216[42], n214[42], n215[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u802 (n216[43], n214[43], n215[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u803 (n216[44], n214[44], n215[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u804 (n216[45], n214[45], n215[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u805 (n216[46], n214[46], n215[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u806 (n216[47], n214[47], n215[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u807 (n216[48], n214[48], n215[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u808 (n216[49], n214[49], n215[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u809 (n216[50], n214[50], n215[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  and u81 (n59, unpage, read);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(223)
  or u810 (n216[51], n214[51], n215[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u811 (n216[52], n214[52], n215[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u812 (n216[53], n214[53], n215[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u813 (n216[54], n214[54], n215[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u814 (n216[55], n214[55], n215[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u815 (n216[56], n214[56], n215[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u816 (n216[57], n214[57], n215[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u817 (n216[58], n214[58], n215[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u818 (n216[59], n214[59], n215[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u819 (n216[60], n214[60], n215[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  not u82 (n70[2], n69);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(250)
  or u820 (n216[61], n214[61], n215[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u821 (n216[62], n214[62], n215[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u822 (n216[63], n214[63], n215[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(506)
  or u823 (n214[1], n211[1], n213[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u824 (n214[2], n211[2], n213[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u825 (n214[3], n211[3], n213[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u826 (n214[4], n211[4], n213[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u827 (n214[5], n211[5], n213[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u828 (n214[6], n211[6], n213[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u829 (n214[7], n211[7], n213[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u83 (n232[1], n230[1], n231[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(519)
  or u830 (n214[8], n211[8], n213[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u831 (n214[9], n211[9], n213[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u832 (n214[10], n211[10], n213[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u833 (n214[11], n211[11], n213[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u834 (n214[12], n211[12], n213[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u835 (n214[13], n211[13], n213[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u836 (n214[14], n211[14], n213[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u837 (n214[15], n211[15], n213[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u838 (n214[16], n211[16], n213[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u839 (n214[17], n211[17], n213[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  and u84 (n62, n55, l1i_miss);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(225)
  or u840 (n214[18], n211[18], n213[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u841 (n214[19], n211[19], n213[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u842 (n214[20], n211[20], n213[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u843 (n214[21], n211[21], n213[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u844 (n214[22], n211[22], n213[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u845 (n214[23], n211[23], n213[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u846 (n214[24], n211[24], n213[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u847 (n214[25], n211[25], n213[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u848 (n214[26], n211[26], n213[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u849 (n214[27], n211[27], n213[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u85 (write_data[63], n232[63], n233[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u850 (n214[28], n211[28], n213[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u851 (n214[29], n211[29], n213[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u852 (n214[30], n211[30], n213[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u853 (n214[31], n211[31], n213[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u854 (n214[32], n211[32], n213[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u855 (n214[33], n211[33], n213[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u856 (n214[34], n211[34], n213[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u857 (n214[35], n211[35], n213[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u858 (n214[36], n211[36], n213[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u859 (n214[37], n211[37], n213[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  and u86 (n63, n55, pte_l1d_upd);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(228)
  or u860 (n214[38], n211[38], n213[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u861 (n214[39], n211[39], n213[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u862 (n214[40], n211[40], n213[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u863 (n214[41], n211[41], n213[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u864 (n214[42], n211[42], n213[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u865 (n214[43], n211[43], n213[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u866 (n214[44], n211[44], n213[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u867 (n214[45], n211[45], n213[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u868 (n214[46], n211[46], n213[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u869 (n214[47], n211[47], n213[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u87 (write_data[62], n232[62], n233[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u870 (n214[48], n211[48], n213[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u871 (n214[49], n211[49], n213[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u872 (n214[50], n211[50], n213[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u873 (n214[51], n211[51], n213[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u874 (n214[52], n211[52], n213[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u875 (n214[53], n211[53], n213[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u876 (n214[54], n211[54], n213[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u877 (n214[55], n211[55], n213[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u878 (n214[56], n211[56], n213[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u879 (n214[57], n211[57], n213[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  and u88 (n64, n55, pte_l1i_upd);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(231)
  or u880 (n214[58], n211[58], n213[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u881 (n214[59], n211[59], n213[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u882 (n214[60], n211[60], n213[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u883 (n214[61], n211[61], n213[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u884 (n214[62], n211[62], n213[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u885 (n214[63], n211[63], n213[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(505)
  or u886 (n211[1], n208[1], n210[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u887 (n211[2], n208[2], n210[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u888 (n211[3], n208[3], n210[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u889 (n211[4], n208[4], n210[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u89 (write_data[61], n232[61], n233[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u890 (n211[5], n208[5], n210[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u891 (n211[6], n208[6], n210[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u892 (n211[7], n208[7], n210[7]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u893 (n211[8], n208[8], n210[8]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u894 (n211[9], n208[9], n210[9]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u895 (n211[10], n208[10], n210[10]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u896 (n211[11], n208[11], n210[11]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u897 (n211[12], n208[12], n210[12]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u898 (n211[13], n208[13], n210[13]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u899 (n211[14], n208[14], n210[14]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  and u9 (pte_l1d_upd, l1d_write_through, n1);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(181)
  and u90 (n65, n55, l1d_write_through);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(235)
  or u900 (n211[15], n208[15], n210[15]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u901 (n211[16], n208[16], n210[16]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u902 (n211[17], n208[17], n210[17]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u903 (n211[18], n208[18], n210[18]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u904 (n211[19], n208[19], n210[19]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u905 (n211[20], n208[20], n210[20]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u906 (n211[21], n208[21], n210[21]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u907 (n211[22], n208[22], n210[22]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u908 (n211[23], n208[23], n210[23]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u909 (n211[24], n208[24], n210[24]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u91 (write_data[60], n232[60], n233[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u910 (n211[25], n208[25], n210[25]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u911 (n211[26], n208[26], n210[26]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u912 (n211[27], n208[27], n210[27]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u913 (n211[28], n208[28], n210[28]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u914 (n211[29], n208[29], n210[29]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u915 (n211[30], n208[30], n210[30]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u916 (n211[31], n208[31], n210[31]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u917 (n211[32], n208[32], n210[32]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u918 (n211[33], n208[33], n210[33]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u919 (n211[34], n208[34], n210[34]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  and u92 (n66, n55, l1i_write_through);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(238)
  or u920 (n211[35], n208[35], n210[35]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u921 (n211[36], n208[36], n210[36]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u922 (n211[37], n208[37], n210[37]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u923 (n211[38], n208[38], n210[38]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u924 (n211[39], n208[39], n210[39]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u925 (n211[40], n208[40], n210[40]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u926 (n211[41], n208[41], n210[41]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u927 (n211[42], n208[42], n210[42]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u928 (n211[43], n208[43], n210[43]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u929 (n211[44], n208[44], n210[44]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  and u93 (n68, trans_rdy, cacheable);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(250)
  or u930 (n211[45], n208[45], n210[45]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u931 (n211[46], n208[46], n210[46]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u932 (n211[47], n208[47], n210[47]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u933 (n211[48], n208[48], n210[48]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u934 (n211[49], n208[49], n210[49]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u935 (n211[50], n208[50], n210[50]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u936 (n211[51], n208[51], n210[51]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u937 (n211[52], n208[52], n210[52]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u938 (n211[53], n208[53], n210[53]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u939 (n211[54], n208[54], n210[54]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u94 (n69, trans_rdy, bus_error);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(250)
  or u940 (n211[55], n208[55], n210[55]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u941 (n211[56], n208[56], n210[56]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u942 (n211[57], n208[57], n210[57]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u943 (n211[58], n208[58], n210[58]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u944 (n211[59], n208[59], n210[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u945 (n211[60], n208[60], n210[60]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u946 (n211[61], n208[61], n210[61]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u947 (n211[62], n208[62], n210[62]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u948 (n211[63], n208[63], n210[63]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(504)
  or u949 (n186[1], n190[0], n185[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(472)
  not u95 (n73[2], trans_rdy);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(254)
  or u950 (n186[2], n190[1], n185[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(472)
  or u951 (n186[3], n190[2], n185[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(472)
  or u952 (n186[4], n190[3], n185[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(472)
  or u953 (n186[5], n190[4], n185[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(472)
  or u954 (n190[1], n193[0], n189[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(471)
  or u955 (n190[2], n193[1], n189[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(471)
  or u956 (n190[3], n193[2], n189[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(471)
  or u957 (n190[4], n189[6], n189[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(471)
  or u958 (n193[1], n192[5], n192[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(466)
  or u959 (n193[2], n192[5], n192[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(466)
  not u96 (n80[2], n79);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(259)
  and u960 (n189[1], n187, n176);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(470)
  and u961 (n189[2], n191, n176);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(470)
  and u962 (n189[4], n194, n176);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(470)
  and u963 (n189[5], n172, n188);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(470)
  and u964 (n189[6], n172, n178);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(470)
  and u965 (n185[1], n187, n184[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(448)
  and u966 (n185[2], n191, n184[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(448)
  and u967 (n185[3], n194, n184[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(448)
  and u968 (n185[4], n195, n174);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(448)
  and u969 (n185[5], n196, n174);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(448)
  and u97 (n76, page_fault, write);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(259)
  and u970 (n185[6], n172, n184[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(448)
  and u971 (n192[1], n187, n176);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(465)
  and u972 (n192[2], n191, n176);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(465)
  and u973 (n192[5], n172, n178);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(465)
  and u974 (n182[1], n187, n181[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  and u975 (n182[2], n191, n181[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  and u976 (n182[3], n194, n181[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  and u977 (n182[4], n195, n181[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  and u978 (n182[5], n196, n181[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  and u979 (n182[6], n197, n173);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  and u98 (n77, page_fault, read);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(259)
  and u980 (n182[7], n172, n181[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  or u981 (n184[4], n176, n178);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(448)
  or u982 (n181[5], n173, n174);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  or u983 (n181[6], n180[4], n178);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  or u984 (n180[4], n174, n176);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(446)
  or u985 (ex_bsel[2], n186[0], n182[1]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(473)
  or u986 (ex_bsel[3], n186[1], n182[2]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(473)
  or u987 (ex_bsel[4], n186[2], n182[3]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(473)
  or u988 (ex_bsel[5], n186[3], n182[4]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(473)
  or u989 (ex_bsel[6], n186[4], n182[5]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(473)
  or u99 (write_data[59], n232[59], n233[59]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(520)
  or u990 (ex_bsel[7], n186[5], n182[6]);  // ../../RTL/CPU/BIU/cache_ctrl_logic.v(473)

endmodule 

module binary_mux_s1_w9
  (
  i0,
  i1,
  sel,
  o
  );

  input [8:0] i0;
  input [8:0] i1;
  input sel;
  output [8:0] o;



endmodule 

module binary_mux_s1_w12
  (
  i0,
  i1,
  sel,
  o
  );

  input [11:0] i0;
  input [11:0] i1;
  input sel;
  output [11:0] o;



endmodule 

module binary_mux_s1_w64
  (
  i0,
  i1,
  sel,
  o
  );

  input [63:0] i0;
  input [63:0] i1;
  input sel;
  output [63:0] o;



endmodule 

module add_pu62_pu62_o62
  (
  i0,
  i1,
  o
  );

  input [61:0] i0;
  input [61:0] i1;
  output [61:0] o;



endmodule 

module csr_satp  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(1)
  (
  clk,
  csr_write,
  data_csr,
  rst,
  srw_satp_sel,
  satp
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(2)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(7)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(6)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(3)
  input srw_satp_sel;  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(5)
  output [63:0] satp;  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(9)

  wire [3:0] mode;  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(13)
  wire [3:0] n1;
  wire [43:0] n2;
  wire [3:0] n3;
  wire [43:0] n4;
  wire [43:0] ppn;  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(14)
  wire n0;

  binary_mux_s1_w4 mux0 (
    .i0(mode),
    .i1(data_csr[63:60]),
    .sel(n0),
    .o(n1));  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(24)
  binary_mux_s1_w44 mux1 (
    .i0(ppn),
    .i1(data_csr[43:0]),
    .sel(n0),
    .o(n2));  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(24)
  binary_mux_s1_w4 mux2 (
    .i0(n1),
    .i1(4'b0000),
    .sel(rst),
    .o(n3));  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(24)
  binary_mux_s1_w44 mux3 (
    .i0(n2),
    .i1(44'b00000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n4));  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(24)
  reg_ar_as_w44 reg0 (
    .clk(clk),
    .d(n4),
    .reset(44'b00000000000000000000000000000000000000000000),
    .set(44'b00000000000000000000000000000000000000000000),
    .q(ppn));  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(25)
  reg_ar_as_w4 reg1 (
    .clk(clk),
    .d(n3),
    .reset(4'b0000),
    .set(4'b0000),
    .q(mode));  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(25)
  buf u1 (satp[2], ppn[2]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u10 (satp[8], ppn[8]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u11 (satp[9], ppn[9]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u12 (satp[10], ppn[10]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u13 (satp[11], ppn[11]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u14 (satp[12], ppn[12]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u15 (satp[13], ppn[13]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u16 (satp[14], ppn[14]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u17 (satp[15], ppn[15]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u18 (satp[16], ppn[16]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u19 (satp[17], ppn[17]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u2 (satp[1], ppn[1]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u20 (satp[18], ppn[18]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u21 (satp[19], ppn[19]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u22 (satp[20], ppn[20]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u23 (satp[21], ppn[21]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u24 (satp[22], ppn[22]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u25 (satp[23], ppn[23]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u26 (satp[24], ppn[24]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u27 (satp[25], ppn[25]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u28 (satp[26], ppn[26]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u29 (satp[27], ppn[27]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u3 (satp[0], ppn[0]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u30 (satp[28], ppn[28]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u31 (satp[29], ppn[29]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u32 (satp[30], ppn[30]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u33 (satp[31], ppn[31]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u34 (satp[32], ppn[32]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u35 (satp[33], ppn[33]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u36 (satp[34], ppn[34]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u37 (satp[35], ppn[35]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u38 (satp[36], ppn[36]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u39 (satp[37], ppn[37]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  and u4 (n0, srw_satp_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(21)
  buf u40 (satp[38], ppn[38]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u41 (satp[39], ppn[39]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u42 (satp[40], ppn[40]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u43 (satp[41], ppn[41]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u44 (satp[42], ppn[42]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u45 (satp[43], ppn[43]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u46 (satp[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u47 (satp[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u48 (satp[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u49 (satp[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u5 (satp[3], ppn[3]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u50 (satp[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u51 (satp[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u52 (satp[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u53 (satp[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u54 (satp[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u55 (satp[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u56 (satp[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u57 (satp[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u58 (satp[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u59 (satp[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u6 (satp[4], ppn[4]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u60 (satp[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u61 (satp[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u62 (satp[60], mode[0]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u63 (satp[61], mode[1]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u64 (satp[62], mode[2]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u65 (satp[63], mode[3]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u7 (satp[5], ppn[5]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u8 (satp[6], ppn[6]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)
  buf u9 (satp[7], ppn[7]);  // ../../RTL/CPU/CU&RU/csrs/csr_satp.v(27)

endmodule 

module eq_w12
  (
  i0,
  i1,
  o
  );

  input [11:0] i0;
  input [11:0] i1;
  output o;



endmodule 

module eq_w5
  (
  i0,
  i1,
  o
  );

  input [4:0] i0;
  input [4:0] i1;
  output o;



endmodule 

module m_cycle_event  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(1)
  (
  clk,
  csr_write,
  data_csr,
  mrw_instret_sel,
  mrw_mcountinhibit_sel,
  mrw_mcycle_sel,
  rst,
  valid,
  mcountinhibit,
  mcycle,
  minstret
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(2)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(10)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(12)
  input mrw_instret_sel;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(8)
  input mrw_mcountinhibit_sel;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(9)
  input mrw_mcycle_sel;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(7)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(3)
  input valid;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(5)
  output [63:0] mcountinhibit;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(16)
  output [63:0] mcycle;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(14)
  output [63:0] minstret;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(15)

  wire [63:0] n10;
  wire [63:0] n11;
  wire [63:0] n12;
  wire [63:0] n2;
  wire [63:0] n3;
  wire [63:0] n4;
  wire [63:0] n5;
  wire [63:0] n6;
  wire [63:0] n7;
  wire [63:0] n8;
  wire [63:0] n9;
  wire cy;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(21)
  wire ir;  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(22)
  wire n0;
  wire n1;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;

  add_pu64_pu64_o64 add0 (
    .i0(mcycle),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000001),
    .o(n2));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(37)
  add_pu64_pu64_o64 add1 (
    .i0(minstret),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000001),
    .o(n4));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(38)
  AL_DFF cy_reg (
    .clk(clk),
    .d(n16),
    .reset(1'b0),
    .set(1'b0),
    .q(cy));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(51)
  AL_DFF ir_reg (
    .clk(clk),
    .d(n17),
    .reset(1'b0),
    .set(1'b0),
    .q(ir));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(51)
  binary_mux_s1_w64 mux0 (
    .i0(n2),
    .i1(mcycle),
    .sel(cy),
    .o(n3));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(37)
  binary_mux_s1_w64 mux1 (
    .i0(minstret),
    .i1(n4),
    .sel(valid),
    .o(n5));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(38)
  binary_mux_s1_w64 mux2 (
    .i0(n5),
    .i1(minstret),
    .sel(ir),
    .o(n6));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(38)
  binary_mux_s1_w64 mux3 (
    .i0(n6),
    .i1(data_csr),
    .sel(n1),
    .o(n7));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(39)
  binary_mux_s1_w64 mux4 (
    .i0(n3),
    .i1(mcycle),
    .sel(n1),
    .o(n8));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(39)
  binary_mux_s1_w64 mux5 (
    .i0(n8),
    .i1(data_csr),
    .sel(n0),
    .o(n9));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(39)
  binary_mux_s1_w64 mux6 (
    .i0(n7),
    .i1(minstret),
    .sel(n0),
    .o(n10));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(39)
  binary_mux_s1_w64 mux7 (
    .i0(n9),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n11));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(39)
  binary_mux_s1_w64 mux8 (
    .i0(n10),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n12));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(39)
  reg_ar_as_w64 reg0 (
    .clk(clk),
    .d(n12),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(minstret));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(40)
  reg_ar_as_w64 reg1 (
    .clk(clk),
    .d(n11),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(mcycle));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(40)
  AL_MUX u10 (
    .i0(ir),
    .i1(data_csr[2]),
    .sel(n13),
    .o(n15));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(50)
  AL_MUX u11 (
    .i0(n14),
    .i1(1'b0),
    .sel(rst),
    .o(n16));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(50)
  AL_MUX u12 (
    .i0(n15),
    .i1(1'b0),
    .sel(rst),
    .o(n17));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(50)
  buf u13 (mcountinhibit[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u14 (mcountinhibit[5], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u15 (mcountinhibit[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u16 (mcountinhibit[7], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u17 (mcountinhibit[8], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u18 (mcountinhibit[9], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u19 (mcountinhibit[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u2 (mcountinhibit[3], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u20 (mcountinhibit[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u21 (mcountinhibit[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u22 (mcountinhibit[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u23 (mcountinhibit[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u24 (mcountinhibit[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u25 (mcountinhibit[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u26 (mcountinhibit[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u27 (mcountinhibit[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u28 (mcountinhibit[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u29 (mcountinhibit[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u3 (mcountinhibit[2], ir);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u30 (mcountinhibit[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u31 (mcountinhibit[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u32 (mcountinhibit[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u33 (mcountinhibit[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u34 (mcountinhibit[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u35 (mcountinhibit[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u36 (mcountinhibit[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u37 (mcountinhibit[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u38 (mcountinhibit[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u39 (mcountinhibit[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  and u4 (n0, mrw_mcycle_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(30)
  buf u40 (mcountinhibit[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u41 (mcountinhibit[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u42 (mcountinhibit[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u43 (mcountinhibit[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u44 (mcountinhibit[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u45 (mcountinhibit[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u46 (mcountinhibit[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u47 (mcountinhibit[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u48 (mcountinhibit[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u49 (mcountinhibit[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  and u5 (n1, mrw_instret_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(33)
  buf u50 (mcountinhibit[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u51 (mcountinhibit[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u52 (mcountinhibit[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u53 (mcountinhibit[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u54 (mcountinhibit[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u55 (mcountinhibit[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u56 (mcountinhibit[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u57 (mcountinhibit[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u58 (mcountinhibit[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u59 (mcountinhibit[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u6 (mcountinhibit[1], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u60 (mcountinhibit[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u61 (mcountinhibit[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u62 (mcountinhibit[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u63 (mcountinhibit[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u64 (mcountinhibit[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u65 (mcountinhibit[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u66 (mcountinhibit[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u67 (mcountinhibit[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u68 (mcountinhibit[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u69 (mcountinhibit[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u7 (mcountinhibit[0], cy);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u70 (mcountinhibit[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u71 (mcountinhibit[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  buf u72 (mcountinhibit[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(53)
  and u8 (n13, mrw_mcountinhibit_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(47)
  AL_MUX u9 (
    .i0(cy),
    .i1(data_csr[0]),
    .sel(n13),
    .o(n14));  // ../../RTL/CPU/CU&RU/csrs/m_cycle_event.v(50)

endmodule 

module m_s_cause  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(1)
  (
  clk,
  csr_write,
  data_csr,
  mrw_mcause_sel,
  rst,
  srw_scause_sel,
  trap_cause,
  trap_target_m,
  trap_target_s,
  mcause,
  scause
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(2)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(13)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(16)
  input mrw_mcause_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(11)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(3)
  input srw_scause_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(12)
  input [63:0] trap_cause;  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(6)
  input trap_target_m;  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(7)
  input trap_target_s;  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(8)
  output [63:0] mcause;  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(14)
  output [63:0] scause;  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(15)

  wire [63:0] n10;
  wire [63:0] n2;
  wire [63:0] n3;
  wire [63:0] n4;
  wire [63:0] n5;
  wire [63:0] n6;
  wire [63:0] n7;
  wire [63:0] n8;
  wire [63:0] n9;
  wire n0;
  wire n1;

  binary_mux_s1_w64 mux0 (
    .i0(scause),
    .i1(data_csr),
    .sel(n1),
    .o(n2));  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(35)
  binary_mux_s1_w64 mux1 (
    .i0(mcause),
    .i1(data_csr),
    .sel(n0),
    .o(n3));  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(35)
  binary_mux_s1_w64 mux2 (
    .i0(n2),
    .i1(scause),
    .sel(n0),
    .o(n4));  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(35)
  binary_mux_s1_w64 mux3 (
    .i0(n4),
    .i1(trap_cause),
    .sel(trap_target_s),
    .o(n5));  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(35)
  binary_mux_s1_w64 mux4 (
    .i0(n3),
    .i1(mcause),
    .sel(trap_target_s),
    .o(n6));  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(35)
  binary_mux_s1_w64 mux5 (
    .i0(n6),
    .i1(trap_cause),
    .sel(trap_target_m),
    .o(n7));  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(35)
  binary_mux_s1_w64 mux6 (
    .i0(n5),
    .i1(scause),
    .sel(trap_target_m),
    .o(n8));  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(35)
  binary_mux_s1_w64 mux7 (
    .i0(n7),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n9));  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(35)
  binary_mux_s1_w64 mux8 (
    .i0(n8),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n10));  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(35)
  reg_ar_as_w64 reg0 (
    .clk(clk),
    .d(n10),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(scause));  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(36)
  reg_ar_as_w64 reg1 (
    .clk(clk),
    .d(n9),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(mcause));  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(36)
  and u1 (n0, mrw_mcause_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(30)
  and u2 (n1, srw_scause_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_cause.v(33)

endmodule 

module m_s_epc  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(1)
  (
  clk,
  csr_write,
  data_csr,
  ins_pc,
  mrw_mepc_sel,
  new_pc,
  next_pc,
  pc_jmp,
  rst,
  srw_sepc_sel,
  trap_target_m,
  trap_target_s,
  mepc,
  sepc
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(2)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(16)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(19)
  input [63:0] ins_pc;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(11)
  input mrw_mepc_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(14)
  input [63:0] new_pc;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(12)
  input next_pc;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(8)
  input pc_jmp;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(13)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(3)
  input srw_sepc_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(15)
  input trap_target_m;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(6)
  input trap_target_s;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(7)
  output [63:0] mepc;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(17)
  output [63:0] sepc;  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(18)

  wire [61:0] n0;
  wire [63:0] n1;
  wire [63:0] n10;
  wire [63:0] n11;
  wire [63:0] n12;
  wire [63:0] n13;
  wire [63:0] n2;
  wire [63:0] n5;
  wire [63:0] n6;
  wire [63:0] n7;
  wire [63:0] n8;
  wire [63:0] n9;
  wire n3;
  wire n4;

  add_pu62_pu62_o62 add0 (
    .i0(ins_pc[63:2]),
    .i1(62'b00000000000000000000000000000000000000000000000000000000000001),
    .o(n0));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(30)
  binary_mux_s1_w64 mux0 (
    .i0({n0,ins_pc[1:0]}),
    .i1(new_pc),
    .sel(pc_jmp),
    .o(n1));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(30)
  binary_mux_s1_w64 mux1 (
    .i0(ins_pc),
    .i1(n1),
    .sel(next_pc),
    .o(n2));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(30)
  binary_mux_s1_w64 mux10 (
    .i0(n11),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n13));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(40)
  binary_mux_s1_w64 mux2 (
    .i0(sepc),
    .i1(data_csr),
    .sel(n4),
    .o(n5));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(40)
  binary_mux_s1_w64 mux3 (
    .i0(mepc),
    .i1(data_csr),
    .sel(n3),
    .o(n6));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(40)
  binary_mux_s1_w64 mux4 (
    .i0(n5),
    .i1(sepc),
    .sel(n3),
    .o(n7));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(40)
  binary_mux_s1_w64 mux5 (
    .i0(n7),
    .i1(n2),
    .sel(trap_target_s),
    .o(n8));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(40)
  binary_mux_s1_w64 mux6 (
    .i0(n6),
    .i1(mepc),
    .sel(trap_target_s),
    .o(n9));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(40)
  binary_mux_s1_w64 mux7 (
    .i0(n9),
    .i1(n2),
    .sel(trap_target_m),
    .o(n10));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(40)
  binary_mux_s1_w64 mux8 (
    .i0(n8),
    .i1(sepc),
    .sel(trap_target_m),
    .o(n11));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(40)
  binary_mux_s1_w64 mux9 (
    .i0(n10),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n12));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(40)
  reg_ar_as_w64 reg0 (
    .clk(clk),
    .d(n13),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(sepc));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(41)
  reg_ar_as_w64 reg1 (
    .clk(clk),
    .d(n12),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(mepc));  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(41)
  and u2 (n3, mrw_mepc_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(35)
  and u3 (n4, srw_sepc_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_epc.v(38)

endmodule 

module m_s_ie  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(1)
  (
  clk,
  csr_write,
  data_csr,
  m_ext_int,
  mrw_mie_sel,
  rst,
  s_ext_int,
  srw_sie_sel,
  m_s_ie,
  s_ie
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(2)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(12)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(15)
  input m_ext_int;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(6)
  input mrw_mie_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(10)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(3)
  input s_ext_int;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(7)
  input srw_sie_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(11)
  output [63:0] m_s_ie;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(13)
  output [63:0] s_ie;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(14)

  wire meie;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(24)
  wire msie;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(20)
  wire mtie;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(22)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n2;
  wire n3;
  wire n4;
  wire n5;
  wire n6;
  wire n7;
  wire n8;
  wire n9;
  wire seie;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(23)
  wire ssie;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(19)
  wire stie;  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(21)

  AL_DFF meie_reg (
    .clk(clk),
    .d(n16),
    .reset(1'b0),
    .set(1'b0),
    .q(meie));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(50)
  AL_DFF msie_reg (
    .clk(clk),
    .d(n12),
    .reset(1'b0),
    .set(1'b0),
    .q(msie));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(50)
  AL_DFF mtie_reg (
    .clk(clk),
    .d(n14),
    .reset(1'b0),
    .set(1'b0),
    .q(mtie));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(50)
  AL_DFF seie_reg (
    .clk(clk),
    .d(n15),
    .reset(1'b0),
    .set(1'b0),
    .q(seie));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(50)
  AL_DFF ssie_reg (
    .clk(clk),
    .d(n11),
    .reset(1'b0),
    .set(1'b0),
    .q(ssie));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(50)
  AL_DFF stie_reg (
    .clk(clk),
    .d(n13),
    .reset(1'b0),
    .set(1'b0),
    .q(stie));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(50)
  buf u1 (s_ie[2], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  AL_MUX u10 (
    .i0(msie),
    .i1(data_csr[3]),
    .sel(n0),
    .o(n6));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  buf u100 (m_s_ie[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u101 (m_s_ie[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u102 (m_s_ie[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u103 (m_s_ie[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u104 (m_s_ie[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u105 (m_s_ie[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u106 (m_s_ie[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u107 (m_s_ie[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u108 (m_s_ie[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u109 (m_s_ie[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  AL_MUX u11 (
    .i0(n3),
    .i1(data_csr[5]),
    .sel(n0),
    .o(n7));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  buf u110 (m_s_ie[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u111 (m_s_ie[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u112 (m_s_ie[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u113 (m_s_ie[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u114 (m_s_ie[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u115 (m_s_ie[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u116 (m_s_ie[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u117 (m_s_ie[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u118 (m_s_ie[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u119 (m_s_ie[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  AL_MUX u12 (
    .i0(mtie),
    .i1(data_csr[7]),
    .sel(n0),
    .o(n8));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  buf u120 (m_s_ie[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u121 (m_s_ie[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u122 (m_s_ie[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u123 (m_s_ie[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u124 (m_s_ie[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u125 (m_s_ie[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u126 (m_s_ie[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u127 (m_s_ie[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u128 (m_s_ie[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u129 (m_s_ie[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  AL_MUX u13 (
    .i0(n4),
    .i1(data_csr[9]),
    .sel(n0),
    .o(n9));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  buf u130 (m_s_ie[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u131 (m_s_ie[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u132 (m_s_ie[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u133 (m_s_ie[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u134 (m_s_ie[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u135 (m_s_ie[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u136 (m_s_ie[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u137 (m_s_ie[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u138 (m_s_ie[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u139 (m_s_ie[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  AL_MUX u14 (
    .i0(meie),
    .i1(data_csr[11]),
    .sel(n0),
    .o(n10));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  buf u140 (m_s_ie[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u141 (m_s_ie[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u142 (m_s_ie[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u143 (m_s_ie[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u144 (m_s_ie[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u145 (m_s_ie[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  AL_MUX u15 (
    .i0(n5),
    .i1(1'b0),
    .sel(rst),
    .o(n11));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  AL_MUX u16 (
    .i0(n6),
    .i1(1'b0),
    .sel(rst),
    .o(n12));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  AL_MUX u17 (
    .i0(n7),
    .i1(1'b0),
    .sel(rst),
    .o(n13));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  AL_MUX u18 (
    .i0(n8),
    .i1(1'b0),
    .sel(rst),
    .o(n14));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  AL_MUX u19 (
    .i0(n9),
    .i1(1'b0),
    .sel(rst),
    .o(n15));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  buf u2 (s_ie[1], ssie);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  AL_MUX u20 (
    .i0(n10),
    .i1(1'b0),
    .sel(rst),
    .o(n16));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  buf u21 (s_ie[3], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u22 (m_s_ie[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u23 (s_ie[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u24 (s_ie[5], stie);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u25 (s_ie[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u26 (s_ie[7], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u27 (s_ie[8], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u28 (s_ie[9], seie);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u29 (s_ie[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u3 (s_ie[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u30 (s_ie[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u31 (s_ie[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u32 (s_ie[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u33 (s_ie[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u34 (s_ie[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u35 (s_ie[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u36 (s_ie[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u37 (s_ie[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u38 (s_ie[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u39 (s_ie[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  and u4 (n0, mrw_mie_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(35)
  buf u40 (s_ie[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u41 (s_ie[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u42 (s_ie[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u43 (s_ie[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u44 (s_ie[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u45 (s_ie[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u46 (s_ie[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u47 (s_ie[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u48 (s_ie[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u49 (s_ie[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  and u5 (n1, srw_sie_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(43)
  buf u50 (s_ie[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u51 (s_ie[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u52 (s_ie[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u53 (s_ie[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u54 (s_ie[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u55 (s_ie[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u56 (s_ie[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u57 (s_ie[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u58 (s_ie[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u59 (s_ie[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  AL_MUX u6 (
    .i0(ssie),
    .i1(data_csr[1]),
    .sel(n1),
    .o(n2));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  buf u60 (s_ie[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u61 (s_ie[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u62 (s_ie[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u63 (s_ie[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u64 (s_ie[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u65 (s_ie[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u66 (s_ie[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u67 (s_ie[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u68 (s_ie[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u69 (s_ie[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  AL_MUX u7 (
    .i0(stie),
    .i1(data_csr[5]),
    .sel(n1),
    .o(n3));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  buf u70 (s_ie[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u71 (s_ie[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u72 (s_ie[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u73 (s_ie[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u74 (s_ie[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u75 (s_ie[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u76 (s_ie[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u77 (s_ie[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u78 (s_ie[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u79 (s_ie[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  AL_MUX u8 (
    .i0(seie),
    .i1(data_csr[9]),
    .sel(n1),
    .o(n4));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  buf u80 (s_ie[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u81 (s_ie[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u82 (s_ie[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(52)
  buf u83 (m_s_ie[1], ssie);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u84 (m_s_ie[2], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u85 (m_s_ie[3], msie);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u86 (m_s_ie[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u87 (m_s_ie[5], stie);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u88 (m_s_ie[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u89 (m_s_ie[7], mtie);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  AL_MUX u9 (
    .i0(n2),
    .i1(data_csr[1]),
    .sel(n0),
    .o(n5));  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(49)
  buf u90 (m_s_ie[8], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u91 (m_s_ie[9], seie);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u92 (m_s_ie[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u93 (m_s_ie[11], meie);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u94 (m_s_ie[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u95 (m_s_ie[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u96 (m_s_ie[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u97 (m_s_ie[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u98 (m_s_ie[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)
  buf u99 (m_s_ie[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ie.v(51)

endmodule 

module m_s_ip  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(4)
  (
  clk,
  csr_write,
  data_csr,
  m_ext_int,
  m_soft_int,
  m_time_int,
  mrw_mip_sel,
  rst,
  s_ext_int,
  srw_sip_sel,
  m_s_ip,
  s_ip
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(5)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(17)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(20)
  input m_ext_int;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(11)
  input m_soft_int;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(10)
  input m_time_int;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(9)
  input mrw_mip_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(15)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(6)
  input s_ext_int;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(12)
  input srw_sip_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(16)
  output [63:0] m_s_ip;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(18)
  output [63:0] s_ip;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(19)

  wire meip;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(29)
  wire msip;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(25)
  wire mtip;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(27)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n2;
  wire n3;
  wire n4;
  wire n5;
  wire n6;
  wire n7;
  wire n8;
  wire n9;
  wire seip;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(28)
  wire ssip;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(24)
  wire stip;  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(26)

  assign s_ip[9] = m_s_ip[9];
  AL_DFF meip_reg (
    .clk(clk),
    .d(n18),
    .reset(1'b0),
    .set(1'b0),
    .q(meip));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(57)
  AL_DFF msip_reg (
    .clk(clk),
    .d(n14),
    .reset(1'b0),
    .set(1'b0),
    .q(msip));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(57)
  AL_DFF mtip_reg (
    .clk(clk),
    .d(n16),
    .reset(1'b0),
    .set(1'b0),
    .q(mtip));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(57)
  AL_DFF seip_reg (
    .clk(clk),
    .d(n17),
    .reset(1'b0),
    .set(1'b0),
    .q(seip));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(57)
  AL_DFF ssip_reg (
    .clk(clk),
    .d(n13),
    .reset(1'b0),
    .set(1'b0),
    .q(ssip));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(57)
  AL_DFF stip_reg (
    .clk(clk),
    .d(n15),
    .reset(1'b0),
    .set(1'b0),
    .q(stip));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(57)
  buf u1 (s_ip[3], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  AL_MUX u10 (
    .i0(m_ext_int),
    .i1(meip),
    .sel(n2),
    .o(n6));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  buf u100 (s_ip[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u101 (s_ip[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u102 (s_ip[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u103 (s_ip[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u104 (s_ip[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u105 (s_ip[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u106 (s_ip[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u107 (s_ip[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u108 (s_ip[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u109 (s_ip[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  AL_MUX u11 (
    .i0(n3),
    .i1(data_csr[1]),
    .sel(n0),
    .o(n7));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  buf u110 (s_ip[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u111 (s_ip[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u112 (s_ip[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u113 (s_ip[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u114 (s_ip[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u115 (s_ip[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u116 (s_ip[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u117 (s_ip[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u118 (s_ip[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u119 (s_ip[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  AL_MUX u12 (
    .i0(n4),
    .i1(m_soft_int),
    .sel(n0),
    .o(n8));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  buf u120 (s_ip[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u121 (s_ip[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u122 (s_ip[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u123 (s_ip[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u124 (s_ip[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u125 (s_ip[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u126 (s_ip[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u127 (s_ip[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u128 (s_ip[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u129 (s_ip[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  AL_MUX u13 (
    .i0(stip),
    .i1(data_csr[5]),
    .sel(n0),
    .o(n9));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  buf u130 (s_ip[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u131 (s_ip[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u132 (s_ip[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u133 (s_ip[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u134 (s_ip[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u135 (s_ip[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u136 (s_ip[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u137 (s_ip[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u138 (s_ip[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u139 (s_ip[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  AL_MUX u14 (
    .i0(n5),
    .i1(m_time_int),
    .sel(n0),
    .o(n10));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  buf u140 (s_ip[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u141 (s_ip[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u142 (s_ip[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u143 (m_s_ip[1], ssip);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u144 (m_s_ip[2], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u145 (m_s_ip[3], msip);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u146 (m_s_ip[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  AL_MUX u15 (
    .i0(seip),
    .i1(n1),
    .sel(n0),
    .o(n11));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  AL_MUX u16 (
    .i0(n6),
    .i1(m_ext_int),
    .sel(n0),
    .o(n12));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  AL_MUX u17 (
    .i0(n7),
    .i1(1'b0),
    .sel(rst),
    .o(n13));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  AL_MUX u18 (
    .i0(n8),
    .i1(1'b0),
    .sel(rst),
    .o(n14));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  AL_MUX u19 (
    .i0(n9),
    .i1(1'b0),
    .sel(rst),
    .o(n15));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  buf u2 (s_ip[2], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  AL_MUX u20 (
    .i0(n10),
    .i1(1'b0),
    .sel(rst),
    .o(n16));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  AL_MUX u21 (
    .i0(n11),
    .i1(1'b0),
    .sel(rst),
    .o(n17));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  AL_MUX u22 (
    .i0(n12),
    .i1(1'b0),
    .sel(rst),
    .o(n18));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  or u23 (m_s_ip[9], seip, s_ext_int);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u24 (m_s_ip[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u25 (m_s_ip[5], stip);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u26 (m_s_ip[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u27 (m_s_ip[7], mtip);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u28 (m_s_ip[8], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u29 (m_s_ip[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u3 (s_ip[1], ssip);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u30 (m_s_ip[11], meip);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u31 (m_s_ip[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u32 (m_s_ip[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u33 (m_s_ip[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u34 (m_s_ip[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u35 (m_s_ip[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u36 (m_s_ip[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u37 (m_s_ip[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u38 (m_s_ip[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u39 (m_s_ip[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  and u4 (n0, mrw_mip_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(41)
  buf u40 (m_s_ip[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u41 (m_s_ip[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u42 (m_s_ip[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u43 (m_s_ip[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u44 (m_s_ip[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u45 (m_s_ip[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u46 (m_s_ip[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u47 (m_s_ip[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u48 (m_s_ip[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u49 (m_s_ip[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  or u5 (n1, data_csr[9], s_ext_int);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(46)
  buf u50 (m_s_ip[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u51 (m_s_ip[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u52 (m_s_ip[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u53 (m_s_ip[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u54 (m_s_ip[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u55 (m_s_ip[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u56 (m_s_ip[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u57 (m_s_ip[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u58 (m_s_ip[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u59 (m_s_ip[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  and u6 (n2, srw_sip_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(49)
  buf u60 (m_s_ip[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u61 (m_s_ip[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u62 (m_s_ip[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u63 (m_s_ip[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u64 (m_s_ip[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u65 (m_s_ip[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u66 (m_s_ip[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u67 (m_s_ip[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u68 (m_s_ip[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u69 (m_s_ip[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  AL_MUX u7 (
    .i0(ssip),
    .i1(data_csr[1]),
    .sel(n2),
    .o(n3));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  buf u70 (m_s_ip[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u71 (m_s_ip[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u72 (m_s_ip[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u73 (m_s_ip[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u74 (m_s_ip[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u75 (m_s_ip[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u76 (m_s_ip[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u77 (m_s_ip[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u78 (m_s_ip[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u79 (m_s_ip[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  AL_MUX u8 (
    .i0(m_soft_int),
    .i1(msip),
    .sel(n2),
    .o(n4));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  buf u80 (m_s_ip[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u81 (m_s_ip[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u82 (m_s_ip[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(59)
  buf u83 (s_ip[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u84 (s_ip[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u85 (s_ip[5], stip);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u86 (s_ip[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u87 (s_ip[7], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u88 (s_ip[8], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u89 (s_ip[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  AL_MUX u9 (
    .i0(m_time_int),
    .i1(mtip),
    .sel(n2),
    .o(n5));  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(56)
  buf u90 (s_ip[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u91 (s_ip[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u92 (s_ip[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u93 (s_ip[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u94 (s_ip[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u95 (s_ip[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u96 (s_ip[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u97 (s_ip[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u98 (s_ip[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)
  buf u99 (s_ip[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_ip.v(60)

endmodule 

module m_s_scratch  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(1)
  (
  clk,
  csr_write,
  data_csr,
  mrw_mscratch_sel,
  rst,
  srw_sscratch_sel,
  mscratch,
  sscratch
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(2)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(10)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(11)
  input mrw_mscratch_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(5)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(3)
  input srw_sscratch_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(6)
  output [63:0] mscratch;  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(8)
  output [63:0] sscratch;  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(9)

  wire [63:0] n2;
  wire [63:0] n3;
  wire [63:0] n4;
  wire [63:0] n5;
  wire [63:0] n6;
  wire n0;
  wire n1;

  binary_mux_s1_w64 mux0 (
    .i0(sscratch),
    .i1(data_csr),
    .sel(n1),
    .o(n2));  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(25)
  binary_mux_s1_w64 mux1 (
    .i0(mscratch),
    .i1(data_csr),
    .sel(n0),
    .o(n3));  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(25)
  binary_mux_s1_w64 mux2 (
    .i0(n2),
    .i1(sscratch),
    .sel(n0),
    .o(n4));  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(25)
  binary_mux_s1_w64 mux3 (
    .i0(n4),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n5));  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(25)
  binary_mux_s1_w64 mux4 (
    .i0(n3),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n6));  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(25)
  reg_ar_as_w64 reg0 (
    .clk(clk),
    .d(n6),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(mscratch));  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(26)
  reg_ar_as_w64 reg1 (
    .clk(clk),
    .d(n5),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(sscratch));  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(26)
  and u1 (n0, mrw_mscratch_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(20)
  and u2 (n1, srw_sscratch_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_scratch.v(23)

endmodule 

module m_s_status  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(4)
  (
  clk,
  csr_write,
  data_csr,
  m_ret,
  mrw_mstatus_sel,
  rst,
  s_ret,
  srw_sstatus_sel,
  trap_target_m,
  trap_target_s,
  valid,
  mie,
  mod_priv,
  mprv,
  mstatus,
  mxr,
  priv,
  sie,
  sstatus,
  sum,
  tsr,
  tvm,
  tw
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(6)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(22)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(23)
  input m_ret;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(36)
  input mrw_mstatus_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(24)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(7)
  input s_ret;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(37)
  input srw_sstatus_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(25)
  input trap_target_m;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(28)
  input trap_target_s;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(29)
  input valid;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(34)
  output mie;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(10)
  output [3:0] mod_priv;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(20)
  output mprv;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(11)
  output [63:0] mstatus;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(40)
  output mxr;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(13)
  output [3:0] priv;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(19)
  output sie;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(9)
  output [63:0] sstatus;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(39)
  output sum;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(12)
  output tsr;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(16)
  output tvm;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(14)
  output tw;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(15)

  parameter m = 4'b1000;
  parameter s = 4'b0010;
  parameter u = 4'b0001;
  wire [1:0] mpp;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(51)
  wire [1:0] n12;
  wire [1:0] n21;
  wire [1:0] n24;
  wire [1:0] n35;
  wire [1:0] n4;
  wire [1:0] n47;
  wire [1:0] n5;
  wire [1:0] n59;
  wire [1:0] n6;
  wire [1:0] n60;
  wire [3:0] n61;
  wire [1:0] n62;
  wire [3:0] n63;
  wire [3:0] n64;
  wire [3:0] n65;
  wire mpie;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(49)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n2;
  wire n20;
  wire n22;
  wire n23;
  wire n25;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire n34;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n40;
  wire n41;
  wire n42;
  wire n43;
  wire n44;
  wire n45;
  wire n46;
  wire n48;
  wire n49;
  wire n50;
  wire n51;
  wire n52;
  wire n53;
  wire n54;
  wire n55;
  wire n56;
  wire n57;
  wire n58;
  wire n7;
  wire n8;
  wire n9;
  wire spie;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(48)
  wire spp;  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(50)

  eq_w2 eq0 (
    .i0(mpp),
    .i1(2'b11),
    .o(mod_priv[3]));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(118)
  eq_w2 eq1 (
    .i0(mpp),
    .i1(2'b01),
    .o(mod_priv[1]));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(118)
  eq_w2 eq2 (
    .i0(mpp),
    .i1(2'b00),
    .o(mod_priv[0]));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(131)
  AL_DFF mie_reg (
    .clk(clk),
    .d(n49),
    .reset(1'b0),
    .set(1'b0),
    .q(mie));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  AL_DFF mpie_reg (
    .clk(clk),
    .d(n57),
    .reset(1'b0),
    .set(1'b0),
    .q(mpie));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  AL_DFF mprv_reg (
    .clk(clk),
    .d(n50),
    .reset(1'b0),
    .set(1'b0),
    .q(mprv));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  binary_mux_s1_w2 mux0 (
    .i0({n4[1],1'b0}),
    .i1(2'b01),
    .sel(priv[1]),
    .o(n5));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(103)
  binary_mux_s1_w2 mux1 (
    .i0(n5),
    .i1(2'b11),
    .sel(priv[3]),
    .o(n6));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(103)
  binary_mux_s1_w4 mux10 (
    .i0(n63),
    .i1(n61),
    .sel(n2),
    .o(n64));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(122)
  binary_mux_s1_w4 mux11 (
    .i0(n64),
    .i1(4'b1000),
    .sel(rst),
    .o(n65));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(122)
  binary_mux_s1_w2 mux2 (
    .i0(mpp),
    .i1(n6),
    .sel(trap_target_m),
    .o(n12));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  binary_mux_s1_w2 mux3 (
    .i0(n12),
    .i1(mpp),
    .sel(n3),
    .o(n21));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  binary_mux_s1_w2 mux4 (
    .i0(n21),
    .i1(2'b00),
    .sel(n2),
    .o(n24));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  binary_mux_s1_w2 mux5 (
    .i0(n24),
    .i1(mpp),
    .sel(n1),
    .o(n35));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  binary_mux_s1_w2 mux6 (
    .i0(n35),
    .i1(data_csr[12:11]),
    .sel(n0),
    .o(n47));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  binary_mux_s1_w2 mux7 (
    .i0(n47),
    .i1(2'b00),
    .sel(rst),
    .o(n59));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  binary_mux_s1_w4 mux8 (
    .i0({2'b00,mod_priv[1],n60[0]}),
    .i1(4'b1000),
    .sel(mod_priv[3]),
    .o(n61));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(118)
  binary_mux_s1_w4 mux9 (
    .i0(priv),
    .i1({2'b00,spp,n62[0]}),
    .sel(n3),
    .o(n63));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(122)
  AL_DFF mxr_reg (
    .clk(clk),
    .d(n52),
    .reset(1'b0),
    .set(1'b0),
    .q(mxr));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  reg_ar_as_w2 reg0 (
    .clk(clk),
    .d(n59),
    .reset(2'b00),
    .set(2'b00),
    .q(mpp));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  reg_ar_as_w4 reg1 (
    .clk(clk),
    .d(n65),
    .reset(4'b0000),
    .set(4'b0000),
    .q(priv));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(123)
  AL_DFF sie_reg (
    .clk(clk),
    .d(n48),
    .reset(1'b0),
    .set(1'b0),
    .q(sie));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  AL_DFF spie_reg (
    .clk(clk),
    .d(n56),
    .reset(1'b0),
    .set(1'b0),
    .q(spie));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  AL_DFF spp_reg (
    .clk(clk),
    .d(n58),
    .reset(1'b0),
    .set(1'b0),
    .q(spp));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  AL_DFF sum_reg (
    .clk(clk),
    .d(n51),
    .reset(1'b0),
    .set(1'b0),
    .q(sum));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  AL_DFF tsr_reg (
    .clk(clk),
    .d(n55),
    .reset(1'b0),
    .set(1'b0),
    .q(tsr));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  AL_DFF tvm_reg (
    .clk(clk),
    .d(n53),
    .reset(1'b0),
    .set(1'b0),
    .q(tvm));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  AL_DFF tw_reg (
    .clk(clk),
    .d(n54),
    .reset(1'b0),
    .set(1'b0),
    .q(tw));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(110)
  AL_MUX u10 (
    .i0(sie),
    .i1(1'b0),
    .sel(trap_target_s),
    .o(n8));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u100 (sstatus[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u101 (sstatus[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u102 (sstatus[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u103 (sstatus[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u104 (sstatus[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u105 (sstatus[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u106 (sstatus[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u107 (sstatus[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u108 (sstatus[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u109 (sstatus[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  AL_MUX u11 (
    .i0(spp),
    .i1(priv[1]),
    .sel(trap_target_s),
    .o(n9));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u110 (sstatus[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u111 (sstatus[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u112 (sstatus[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u113 (sstatus[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u114 (sstatus[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u115 (sstatus[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u116 (sstatus[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u117 (sstatus[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u118 (sstatus[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u119 (sstatus[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  AL_MUX u12 (
    .i0(mpie),
    .i1(mie),
    .sel(trap_target_m),
    .o(n10));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u120 (sstatus[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u121 (sstatus[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u122 (mstatus[1], sie);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u123 (mstatus[2], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u124 (mstatus[3], mie);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u125 (mstatus[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u126 (mstatus[5], spie);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u127 (mstatus[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u128 (mstatus[7], mpie);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u129 (mstatus[8], spp);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  AL_MUX u13 (
    .i0(mie),
    .i1(1'b0),
    .sel(trap_target_m),
    .o(n11));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u130 (mstatus[9], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u131 (mstatus[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u132 (mstatus[11], mpp[0]);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u133 (mstatus[12], mpp[1]);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u134 (mstatus[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u135 (mstatus[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u136 (mstatus[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u137 (mstatus[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u138 (mstatus[17], mprv);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u139 (mstatus[18], sum);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  AL_MUX u14 (
    .i0(n7),
    .i1(spie),
    .sel(trap_target_m),
    .o(n13));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u140 (mstatus[19], mxr);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u141 (mstatus[20], tvm);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u142 (mstatus[21], tw);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u143 (mstatus[22], tsr);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u144 (mstatus[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u145 (mstatus[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u146 (mstatus[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u147 (mstatus[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u148 (mstatus[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u149 (mstatus[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  AL_MUX u15 (
    .i0(n8),
    .i1(sie),
    .sel(trap_target_m),
    .o(n14));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u150 (mstatus[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u151 (mstatus[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u152 (mstatus[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u153 (mstatus[32], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u154 (mstatus[33], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u155 (mstatus[34], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u156 (mstatus[35], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u157 (mstatus[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u158 (mstatus[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u159 (mstatus[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  AL_MUX u16 (
    .i0(n9),
    .i1(spp),
    .sel(trap_target_m),
    .o(n15));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u160 (mstatus[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u161 (mstatus[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u162 (mstatus[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u163 (mstatus[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u164 (mstatus[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u165 (mstatus[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u166 (mstatus[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u167 (mstatus[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u168 (mstatus[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u169 (mstatus[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  AL_MUX u17 (
    .i0(n14),
    .i1(spie),
    .sel(n3),
    .o(n16));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u170 (mstatus[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u171 (mstatus[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u172 (mstatus[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u173 (mstatus[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u174 (mstatus[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u175 (mstatus[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u176 (mstatus[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u177 (mstatus[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u178 (mstatus[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u179 (mstatus[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  AL_MUX u18 (
    .i0(n13),
    .i1(1'b0),
    .sel(n3),
    .o(n17));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u180 (mstatus[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u181 (mstatus[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u182 (mstatus[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u183 (mstatus[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u184 (mstatus[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  AL_MUX u19 (
    .i0(n15),
    .i1(1'b0),
    .sel(n3),
    .o(n18));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u2 (sstatus[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  AL_MUX u20 (
    .i0(n10),
    .i1(mpie),
    .sel(n3),
    .o(n19));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u21 (
    .i0(n11),
    .i1(mie),
    .sel(n3),
    .o(n20));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u22 (
    .i0(n20),
    .i1(mpie),
    .sel(n2),
    .o(n22));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u23 (
    .i0(n19),
    .i1(1'b0),
    .sel(n2),
    .o(n23));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u24 (
    .i0(n16),
    .i1(sie),
    .sel(n2),
    .o(n25));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u25 (
    .i0(n17),
    .i1(spie),
    .sel(n2),
    .o(n26));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u26 (
    .i0(n18),
    .i1(spp),
    .sel(n2),
    .o(n27));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u27 (
    .i0(n25),
    .i1(data_csr[1]),
    .sel(n1),
    .o(n28));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u28 (
    .i0(n26),
    .i1(data_csr[5]),
    .sel(n1),
    .o(n29));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u29 (
    .i0(n27),
    .i1(data_csr[8]),
    .sel(n1),
    .o(n30));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u3 (sstatus[5], spie);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  AL_MUX u30 (
    .i0(sum),
    .i1(data_csr[18]),
    .sel(n1),
    .o(n31));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u31 (
    .i0(mxr),
    .i1(data_csr[19]),
    .sel(n1),
    .o(n32));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u32 (
    .i0(n22),
    .i1(mie),
    .sel(n1),
    .o(n33));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u33 (
    .i0(n23),
    .i1(mpie),
    .sel(n1),
    .o(n34));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u34 (
    .i0(n28),
    .i1(data_csr[1]),
    .sel(n0),
    .o(n36));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u35 (
    .i0(n33),
    .i1(data_csr[3]),
    .sel(n0),
    .o(n37));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u36 (
    .i0(mprv),
    .i1(data_csr[17]),
    .sel(n0),
    .o(n38));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u37 (
    .i0(n31),
    .i1(data_csr[18]),
    .sel(n0),
    .o(n39));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u38 (
    .i0(n32),
    .i1(data_csr[19]),
    .sel(n0),
    .o(n40));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u39 (
    .i0(tvm),
    .i1(data_csr[20]),
    .sel(n0),
    .o(n41));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  and u4 (n0, mrw_mstatus_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(68)
  AL_MUX u40 (
    .i0(tw),
    .i1(data_csr[21]),
    .sel(n0),
    .o(n42));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u41 (
    .i0(tsr),
    .i1(data_csr[22]),
    .sel(n0),
    .o(n43));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u42 (
    .i0(n29),
    .i1(data_csr[5]),
    .sel(n0),
    .o(n44));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u43 (
    .i0(n34),
    .i1(data_csr[7]),
    .sel(n0),
    .o(n45));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u44 (
    .i0(n30),
    .i1(data_csr[8]),
    .sel(n0),
    .o(n46));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u45 (
    .i0(n36),
    .i1(1'b0),
    .sel(rst),
    .o(n48));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u46 (
    .i0(n37),
    .i1(1'b0),
    .sel(rst),
    .o(n49));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u47 (
    .i0(n38),
    .i1(1'b0),
    .sel(rst),
    .o(n50));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u48 (
    .i0(n39),
    .i1(1'b0),
    .sel(rst),
    .o(n51));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u49 (
    .i0(n40),
    .i1(1'b0),
    .sel(rst),
    .o(n52));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  and u5 (n1, srw_sstatus_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(83)
  AL_MUX u50 (
    .i0(n41),
    .i1(1'b0),
    .sel(rst),
    .o(n53));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u51 (
    .i0(n42),
    .i1(1'b0),
    .sel(rst),
    .o(n54));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u52 (
    .i0(n43),
    .i1(1'b0),
    .sel(rst),
    .o(n55));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u53 (
    .i0(n44),
    .i1(1'b0),
    .sel(rst),
    .o(n56));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u54 (
    .i0(n45),
    .i1(1'b0),
    .sel(rst),
    .o(n57));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  AL_MUX u55 (
    .i0(n46),
    .i1(1'b0),
    .sel(rst),
    .o(n58));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u56 (sstatus[3], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  not u57 (n62[0], spp);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(121)
  buf u58 (sstatus[2], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  not u59 (n4[1], priv[0]);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(103)
  and u6 (n2, valid, m_ret);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(90)
  buf u60 (sstatus[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u61 (sstatus[7], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u62 (mstatus[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(125)
  buf u63 (sstatus[1], sie);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u64 (mod_priv[2], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(129)
  buf u65 (sstatus[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u66 (sstatus[8], spp);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u67 (sstatus[9], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u68 (sstatus[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u69 (sstatus[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  and u7 (n3, valid, s_ret);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(95)
  buf u70 (sstatus[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u71 (sstatus[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u72 (sstatus[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u73 (sstatus[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u74 (sstatus[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u75 (sstatus[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u76 (sstatus[18], sum);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u77 (sstatus[19], mxr);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u78 (sstatus[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u79 (sstatus[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  not u8 (n60[0], mod_priv[1]);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(118)
  buf u80 (sstatus[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u81 (sstatus[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u82 (sstatus[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u83 (sstatus[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u84 (sstatus[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u85 (sstatus[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u86 (sstatus[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u87 (sstatus[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u88 (sstatus[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u89 (sstatus[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  AL_MUX u9 (
    .i0(spie),
    .i1(sie),
    .sel(trap_target_s),
    .o(n7));  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(109)
  buf u90 (sstatus[32], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u91 (sstatus[33], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u92 (sstatus[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u93 (sstatus[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u94 (sstatus[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u95 (sstatus[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u96 (sstatus[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u97 (sstatus[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u98 (sstatus[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)
  buf u99 (sstatus[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/m_s_status.v(126)

endmodule 

module m_s_tval  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(1)
  (
  clk,
  csr_write,
  data_csr,
  ebreak,
  ecall,
  exc_code,
  ill_ins,
  ins_acc_fault,
  ins_addr_mis,
  ins_page_fault,
  ins_pc,
  ld_acc_fault,
  ld_addr_mis,
  ld_page_fault,
  m_ret,
  mrw_mtval_sel,
  rst,
  s_ret,
  srw_stval_sel,
  st_acc_fault,
  st_addr_mis,
  st_page_fault,
  trap_target_m,
  trap_target_s,
  valid,
  mtval,
  stval
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(2)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(31)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(34)
  input ebreak;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(27)
  input ecall;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(26)
  input [63:0] exc_code;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(11)
  input ill_ins;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(23)
  input ins_acc_fault;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(12)
  input ins_addr_mis;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(13)
  input ins_page_fault;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(14)
  input [63:0] ins_pc;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(10)
  input ld_acc_fault;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(17)
  input ld_addr_mis;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(15)
  input ld_page_fault;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(19)
  input m_ret;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(24)
  input mrw_mtval_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(29)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(3)
  input s_ret;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(25)
  input srw_stval_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(30)
  input st_acc_fault;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(18)
  input st_addr_mis;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(16)
  input st_page_fault;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(20)
  input trap_target_m;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(6)
  input trap_target_s;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(7)
  input valid;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(22)
  output [63:0] mtval;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(32)
  output [63:0] stval;  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(33)

  wire [63:0] n10;
  wire [63:0] n11;
  wire [63:0] n12;
  wire [63:0] n13;
  wire [63:0] n14;
  wire [63:0] n3;
  wire [63:0] n6;
  wire [63:0] n7;
  wire [63:0] n8;
  wire [63:0] n9;
  wire n0;
  wire n1;
  wire n2;
  wire n4;
  wire n5;

  binary_mux_s1_w64 mux0 (
    .i0(exc_code),
    .i1(ins_pc),
    .sel(n2),
    .o(n3));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(45)
  binary_mux_s1_w64 mux1 (
    .i0(stval),
    .i1(data_csr),
    .sel(n5),
    .o(n6));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(55)
  binary_mux_s1_w64 mux2 (
    .i0(mtval),
    .i1(data_csr),
    .sel(n4),
    .o(n7));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(55)
  binary_mux_s1_w64 mux3 (
    .i0(n6),
    .i1(stval),
    .sel(n4),
    .o(n8));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(55)
  binary_mux_s1_w64 mux4 (
    .i0(n8),
    .i1(n3),
    .sel(trap_target_s),
    .o(n9));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(55)
  binary_mux_s1_w64 mux5 (
    .i0(n7),
    .i1(mtval),
    .sel(trap_target_s),
    .o(n10));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(55)
  binary_mux_s1_w64 mux6 (
    .i0(n10),
    .i1(n3),
    .sel(trap_target_m),
    .o(n11));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(55)
  binary_mux_s1_w64 mux7 (
    .i0(n9),
    .i1(stval),
    .sel(trap_target_m),
    .o(n12));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(55)
  binary_mux_s1_w64 mux8 (
    .i0(n11),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n13));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(55)
  binary_mux_s1_w64 mux9 (
    .i0(n12),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n14));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(55)
  reg_ar_as_w64 reg0 (
    .clk(clk),
    .d(n14),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(stval));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(56)
  reg_ar_as_w64 reg1 (
    .clk(clk),
    .d(n13),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(mtval));  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(56)
  or u1 (n0, ins_acc_fault, ins_addr_mis);  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(45)
  or u2 (n1, n0, ins_page_fault);  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(45)
  or u3 (n2, n1, ebreak);  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(45)
  and u4 (n4, mrw_mtval_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(50)
  and u5 (n5, srw_stval_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_tval.v(53)

endmodule 

module m_s_tvec  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(4)
  (
  clk,
  csr_write,
  data_csr,
  mrw_mtvec_sel,
  rst,
  srw_stvec_sel,
  trap_target_m,
  trap_target_s,
  mtvec,
  stvec,
  tvec
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(5)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(14)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(17)
  input mrw_mtvec_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(12)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(6)
  input srw_stvec_sel;  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(13)
  input trap_target_m;  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(8)
  input trap_target_s;  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(9)
  output [63:0] mtvec;  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(15)
  output [63:0] stvec;  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(16)
  output [63:0] tvec;  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(10)

  wire [63:0] n2;
  wire [63:0] n3;
  wire [63:0] n4;
  wire [63:0] n5;
  wire [63:0] n6;
  wire [63:0] n7;
  wire n0;
  wire n1;

  binary_mux_s1_w64 mux0 (
    .i0(stvec),
    .i1(data_csr),
    .sel(n1),
    .o(n2));  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(31)
  binary_mux_s1_w64 mux1 (
    .i0(mtvec),
    .i1(data_csr),
    .sel(n0),
    .o(n3));  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(31)
  binary_mux_s1_w64 mux2 (
    .i0(n2),
    .i1(stvec),
    .sel(n0),
    .o(n4));  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(31)
  binary_mux_s1_w64 mux3 (
    .i0(n3),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n5));  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(31)
  binary_mux_s1_w64 mux4 (
    .i0(n4),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n6));  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(31)
  binary_mux_s1_w64 mux5 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(stvec),
    .sel(trap_target_s),
    .o(n7));  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(34)
  binary_mux_s1_w64 mux6 (
    .i0(n7),
    .i1(mtvec),
    .sel(trap_target_m),
    .o(tvec));  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(34)
  reg_ar_as_w64 reg0 (
    .clk(clk),
    .d(n6),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(stvec));  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(32)
  reg_ar_as_w64 reg1 (
    .clk(clk),
    .d(n5),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(mtvec));  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(32)
  and u1 (n0, mrw_mtvec_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(26)
  and u2 (n1, srw_stvec_sel, csr_write);  // ../../RTL/CPU/CU&RU/csrs/m_s_tvec.v(29)

endmodule 

module medeleg_exc_ctrl  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(1)
  (
  clk,
  csr_write,
  data_csr,
  ebreak,
  ecall,
  ill_ins,
  ins_acc_fault,
  ins_addr_mis,
  ins_page_fault,
  ld_acc_fault,
  ld_addr_mis,
  ld_page_fault,
  mrw_medeleg_sel,
  priv,
  rst,
  st_acc_fault,
  st_addr_mis,
  st_page_fault,
  valid,
  exc_cause,
  exc_target_m,
  exc_target_s,
  medeleg
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(2)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(31)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(33)
  input ebreak;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(27)
  input ecall;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(26)
  input ill_ins;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(24)
  input ins_acc_fault;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(13)
  input ins_addr_mis;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(14)
  input ins_page_fault;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(15)
  input ld_acc_fault;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(18)
  input ld_addr_mis;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(16)
  input ld_page_fault;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(20)
  input mrw_medeleg_sel;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(30)
  input [3:0] priv;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(5)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(3)
  input st_acc_fault;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(19)
  input st_addr_mis;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(17)
  input st_page_fault;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(21)
  input valid;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(23)
  output [63:0] exc_cause;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(7)
  output exc_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(10)
  output exc_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(9)
  output [63:0] medeleg;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(32)

  parameter bk = 64'b0000000000000000000000000000000000000000000000000000000000000011;
  parameter ecm = 64'b0000000000000000000000000000000000000000000000000000000000001011;
  parameter ecs = 64'b0000000000000000000000000000000000000000000000000000000000001001;
  parameter ecu = 64'b0000000000000000000000000000000000000000000000000000000000001000;
  parameter iaf = 64'b0000000000000000000000000000000000000000000000000000000000000001;
  parameter iam = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  parameter ii = 64'b0000000000000000000000000000000000000000000000000000000000000010;
  parameter ipf = 64'b0000000000000000000000000000000000000000000000000000000000001100;
  parameter laf = 64'b0000000000000000000000000000000000000000000000000000000000000101;
  parameter lam = 64'b0000000000000000000000000000000000000000000000000000000000000100;
  parameter lpf = 64'b0000000000000000000000000000000000000000000000000000000000001101;
  parameter saf = 64'b0000000000000000000000000000000000000000000000000000000000000111;
  parameter sam = 64'b0000000000000000000000000000000000000000000000000000000000000110;
  parameter spf = 64'b0000000000000000000000000000000000000000000000000000000000001111;
  wire [2:0] n89;
  wire [3:0] n90;
  wire [3:0] n91;
  wire [3:0] n92;
  wire [3:0] n93;
  wire [3:0] n94;
  wire [3:0] n95;
  wire [3:0] n96;
  wire [3:0] n97;
  wire [3:0] n98;
  wire [3:0] n99;
  wire bk_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(73)
  wire bk_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(87)
  wire dbk;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(59)
  wire decs;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(65)
  wire decu;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(64)
  wire diaf;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(57)
  wire diam;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(56)
  wire dii;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(58)
  wire dipf;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(66)
  wire dlaf;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(61)
  wire dlam;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(60)
  wire dlpf;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(67)
  wire dsaf;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(63)
  wire dsam;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(62)
  wire dspf;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(68)
  wire ecs_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(79)
  wire ecs_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(93)
  wire ecu_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(78)
  wire ecu_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(92)
  wire iaf_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(71)
  wire iaf_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(85)
  wire iam_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(70)
  wire iam_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(84)
  wire ii_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(72)
  wire ii_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(86)
  wire ipf_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(80)
  wire ipf_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(94)
  wire laf_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(75)
  wire laf_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(89)
  wire lam_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(74)
  wire lam_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(88)
  wire lpf_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(81)
  wire lpf_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(95)
  wire m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(51)
  wire n0;
  wire n1;
  wire n10;
  wire n100;
  wire n101;
  wire n102;
  wire n103;
  wire n104;
  wire n105;
  wire n106;
  wire n107;
  wire n108;
  wire n109;
  wire n11;
  wire n110;
  wire n111;
  wire n112;
  wire n113;
  wire n114;
  wire n115;
  wire n116;
  wire n117;
  wire n118;
  wire n119;
  wire n12;
  wire n120;
  wire n121;
  wire n122;
  wire n123;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n2;
  wire n20;
  wire n21;
  wire n22;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire n34;
  wire n35;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n4;
  wire n40;
  wire n41;
  wire n42;
  wire n43;
  wire n44;
  wire n45;
  wire n46;
  wire n47;
  wire n48;
  wire n49;
  wire n5;
  wire n50;
  wire n51;
  wire n52;
  wire n53;
  wire n54;
  wire n55;
  wire n56;
  wire n57;
  wire n58;
  wire n59;
  wire n6;
  wire n60;
  wire n61;
  wire n62;
  wire n63;
  wire n64;
  wire n65;
  wire n66;
  wire n67;
  wire n68;
  wire n69;
  wire n7;
  wire n70;
  wire n71;
  wire n72;
  wire n73;
  wire n74;
  wire n75;
  wire n76;
  wire n77;
  wire n78;
  wire n79;
  wire n8;
  wire n80;
  wire n81;
  wire n82;
  wire n83;
  wire n84;
  wire n85;
  wire n86;
  wire n87;
  wire n88;
  wire n9;
  wire s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(52)
  wire saf_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(77)
  wire saf_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(91)
  wire sam_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(76)
  wire sam_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(90)
  wire spf_target_m;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(82)
  wire spf_target_s;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(96)
  wire u;  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(53)

  AL_DFF dbk_reg (
    .clk(clk),
    .d(n17),
    .reset(1'b0),
    .set(1'b0),
    .q(dbk));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF decs_reg (
    .clk(clk),
    .d(n23),
    .reset(1'b0),
    .set(1'b0),
    .q(decs));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF decu_reg (
    .clk(clk),
    .d(n22),
    .reset(1'b0),
    .set(1'b0),
    .q(decu));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF diaf_reg (
    .clk(clk),
    .d(n15),
    .reset(1'b0),
    .set(1'b0),
    .q(diaf));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF diam_reg (
    .clk(clk),
    .d(n14),
    .reset(1'b0),
    .set(1'b0),
    .q(diam));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF dii_reg (
    .clk(clk),
    .d(n16),
    .reset(1'b0),
    .set(1'b0),
    .q(dii));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF dipf_reg (
    .clk(clk),
    .d(n24),
    .reset(1'b0),
    .set(1'b0),
    .q(dipf));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF dlaf_reg (
    .clk(clk),
    .d(n19),
    .reset(1'b0),
    .set(1'b0),
    .q(dlaf));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF dlam_reg (
    .clk(clk),
    .d(n18),
    .reset(1'b0),
    .set(1'b0),
    .q(dlam));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF dlpf_reg (
    .clk(clk),
    .d(n25),
    .reset(1'b0),
    .set(1'b0),
    .q(dlpf));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF dsaf_reg (
    .clk(clk),
    .d(n21),
    .reset(1'b0),
    .set(1'b0),
    .q(dsaf));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF dsam_reg (
    .clk(clk),
    .d(n20),
    .reset(1'b0),
    .set(1'b0),
    .q(dsam));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  AL_DFF dspf_reg (
    .clk(clk),
    .d(n26),
    .reset(1'b0),
    .set(1'b0),
    .q(dspf));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(133)
  binary_mux_s1_w3 mux0 (
    .i0({n88,1'b0,n88}),
    .i1(3'b111),
    .sel(n87),
    .o(n89));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  binary_mux_s1_w4 mux1 (
    .i0({1'b0,n89}),
    .i1(4'b1101),
    .sel(n86),
    .o(n90));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  binary_mux_s1_w4 mux10 (
    .i0(n98),
    .i1(4'b1100),
    .sel(n77),
    .o(n99));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  binary_mux_s1_w4 mux11 (
    .i0(n99),
    .i1(4'b0011),
    .sel(n76),
    .o(exc_cause[3:0]));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  binary_mux_s1_w4 mux2 (
    .i0(n90),
    .i1(4'b1111),
    .sel(n85),
    .o(n91));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  binary_mux_s1_w4 mux3 (
    .i0(n91),
    .i1(4'b0100),
    .sel(n84),
    .o(n92));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  binary_mux_s1_w4 mux4 (
    .i0(n92),
    .i1(4'b0110),
    .sel(n83),
    .o(n93));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  binary_mux_s1_w4 mux5 (
    .i0(n93),
    .i1(4'b1000),
    .sel(n82),
    .o(n94));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  binary_mux_s1_w4 mux6 (
    .i0(n94),
    .i1(4'b1001),
    .sel(n81),
    .o(n95));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  binary_mux_s1_w4 mux7 (
    .i0(n95),
    .i1(4'b0000),
    .sel(n80),
    .o(n96));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  binary_mux_s1_w4 mux8 (
    .i0(n96),
    .i1(4'b0010),
    .sel(n79),
    .o(n97));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  binary_mux_s1_w4 mux9 (
    .i0(n97),
    .i1(4'b0001),
    .sel(n78),
    .o(n98));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  AL_MUX u10 (
    .i0(dii),
    .i1(data_csr[2]),
    .sel(n0),
    .o(n3));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  and u100 (n70, n64, ld_acc_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(154)
  and u101 (laf_target_s, n70, dlaf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(154)
  buf u102 (medeleg[6], dsam);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  and u103 (n71, n64, st_addr_mis);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(155)
  and u104 (sam_target_s, n71, dsam);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(155)
  buf u105 (medeleg[5], dlaf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  and u106 (n72, n64, st_acc_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(156)
  and u107 (saf_target_s, n72, dsaf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(156)
  buf u108 (medeleg[4], dlam);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  and u109 (ecu_target_s, n51, decu);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(157)
  AL_MUX u11 (
    .i0(dbk),
    .i1(data_csr[3]),
    .sel(n0),
    .o(n4));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u110 (medeleg[3], dbk);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  and u111 (ecs_target_s, n53, decs);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(158)
  buf u112 (medeleg[2], dii);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  and u113 (n73, n64, ins_page_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(159)
  and u114 (ipf_target_s, n73, dipf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(159)
  buf u115 (medeleg[1], diaf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  and u116 (n74, n64, ld_page_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(160)
  and u117 (lpf_target_s, n74, dlpf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(160)
  buf u118 (medeleg[0], diam);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  and u119 (n75, n64, st_page_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(161)
  AL_MUX u12 (
    .i0(dlam),
    .i1(data_csr[4]),
    .sel(n0),
    .o(n5));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  and u120 (spf_target_s, n75, dspf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(161)
  or u121 (n76, bk_target_m, bk_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(164)
  or u122 (n77, ipf_target_m, ipf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(165)
  or u123 (n78, iaf_target_m, iaf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(166)
  or u124 (n79, ii_target_m, ii_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(167)
  or u125 (n80, iam_target_m, iam_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(168)
  or u126 (n81, ecs_target_m, ecs_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(169)
  or u127 (n82, ecu_target_m, ecu_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(170)
  or u128 (n83, sam_target_m, sam_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(171)
  or u129 (n84, lam_target_m, lam_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(172)
  AL_MUX u13 (
    .i0(dlaf),
    .i1(data_csr[5]),
    .sel(n0),
    .o(n6));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  or u130 (n85, spf_target_m, spf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(173)
  or u131 (n86, lpf_target_m, lpf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(174)
  or u132 (n87, saf_target_m, saf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(175)
  or u133 (n88, laf_target_m, laf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u134 (medeleg[12], dipf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u135 (medeleg[15], dspf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u136 (medeleg[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u137 (medeleg[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u138 (medeleg[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u139 (medeleg[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  AL_MUX u14 (
    .i0(dsam),
    .i1(data_csr[6]),
    .sel(n0),
    .o(n7));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u140 (medeleg[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u141 (medeleg[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u142 (medeleg[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u143 (medeleg[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u144 (medeleg[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u145 (medeleg[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u146 (medeleg[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u147 (medeleg[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u148 (medeleg[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u149 (medeleg[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  AL_MUX u15 (
    .i0(dsaf),
    .i1(data_csr[7]),
    .sel(n0),
    .o(n8));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u150 (medeleg[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u151 (medeleg[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u152 (medeleg[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u153 (medeleg[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u154 (medeleg[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u155 (medeleg[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u156 (medeleg[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u157 (medeleg[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u158 (medeleg[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u159 (medeleg[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  AL_MUX u16 (
    .i0(decu),
    .i1(data_csr[8]),
    .sel(n0),
    .o(n9));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u160 (medeleg[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u161 (medeleg[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u162 (medeleg[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u163 (medeleg[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u164 (medeleg[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u165 (medeleg[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u166 (medeleg[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u167 (medeleg[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u168 (medeleg[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u169 (medeleg[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  AL_MUX u17 (
    .i0(decs),
    .i1(data_csr[9]),
    .sel(n0),
    .o(n10));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u170 (medeleg[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u171 (medeleg[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u172 (medeleg[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u173 (medeleg[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u174 (medeleg[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u175 (medeleg[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u176 (medeleg[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u177 (medeleg[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u178 (medeleg[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u179 (medeleg[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  AL_MUX u18 (
    .i0(dipf),
    .i1(data_csr[12]),
    .sel(n0),
    .o(n11));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u180 (medeleg[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u181 (medeleg[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u182 (medeleg[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u183 (medeleg[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  buf u184 (exc_cause[5], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u185 (exc_cause[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u186 (exc_cause[7], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u187 (exc_cause[8], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u188 (exc_cause[9], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u189 (exc_cause[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  AL_MUX u19 (
    .i0(dlpf),
    .i1(data_csr[13]),
    .sel(n0),
    .o(n12));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u190 (exc_cause[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u191 (exc_cause[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u192 (exc_cause[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u193 (exc_cause[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u194 (exc_cause[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u195 (exc_cause[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  or u196 (n100, iam_target_m, iaf_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(181)
  or u197 (n101, n100, ii_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(181)
  or u198 (n102, n101, bk_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(181)
  or u199 (n103, n102, lam_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(181)
  buf u2 (medeleg[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  AL_MUX u20 (
    .i0(dspf),
    .i1(data_csr[15]),
    .sel(n0),
    .o(n13));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  or u200 (n104, n103, laf_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(181)
  or u201 (n105, n104, sam_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(181)
  or u202 (n106, n105, saf_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(181)
  or u203 (n107, n106, ecu_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(182)
  or u204 (n108, n107, ecs_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(182)
  or u205 (n109, n108, ipf_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(182)
  or u206 (n110, n109, lpf_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(182)
  or u207 (n111, n110, spf_target_m);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(182)
  and u208 (exc_target_m, valid, n111);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(182)
  or u209 (n112, iam_target_s, iaf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(183)
  AL_MUX u21 (
    .i0(n1),
    .i1(1'b0),
    .sel(rst),
    .o(n14));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  or u210 (n113, n112, ii_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(183)
  or u211 (n114, n113, bk_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(183)
  or u212 (n115, n114, lam_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(183)
  or u213 (n116, n115, laf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(183)
  or u214 (n117, n116, sam_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(183)
  or u215 (n118, n117, saf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(183)
  or u216 (n119, n118, ecu_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(184)
  or u217 (n120, n119, ecs_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(184)
  or u218 (n121, n120, ipf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(184)
  or u219 (n122, n121, lpf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(184)
  AL_MUX u22 (
    .i0(n2),
    .i1(1'b0),
    .sel(rst),
    .o(n15));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  or u220 (n123, n122, spf_target_s);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(184)
  and u221 (exc_target_s, valid, n123);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(184)
  buf u222 (exc_cause[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u223 (exc_cause[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u224 (exc_cause[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u225 (exc_cause[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u226 (exc_cause[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u227 (exc_cause[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u228 (exc_cause[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u229 (exc_cause[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  AL_MUX u23 (
    .i0(n3),
    .i1(1'b0),
    .sel(rst),
    .o(n16));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u230 (exc_cause[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u231 (exc_cause[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u232 (exc_cause[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u233 (exc_cause[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u234 (exc_cause[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u235 (exc_cause[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u236 (exc_cause[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u237 (exc_cause[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u238 (exc_cause[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u239 (exc_cause[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  AL_MUX u24 (
    .i0(n4),
    .i1(1'b0),
    .sel(rst),
    .o(n17));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u240 (exc_cause[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u241 (exc_cause[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u242 (exc_cause[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u243 (exc_cause[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u244 (exc_cause[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u245 (exc_cause[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u246 (exc_cause[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u247 (exc_cause[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u248 (exc_cause[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u249 (exc_cause[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  AL_MUX u25 (
    .i0(n5),
    .i1(1'b0),
    .sel(rst),
    .o(n18));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u250 (exc_cause[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u251 (exc_cause[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u252 (exc_cause[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u253 (exc_cause[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u254 (exc_cause[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u255 (exc_cause[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u256 (exc_cause[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u257 (exc_cause[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u258 (exc_cause[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u259 (exc_cause[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  AL_MUX u26 (
    .i0(n6),
    .i1(1'b0),
    .sel(rst),
    .o(n19));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u260 (exc_cause[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u261 (exc_cause[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u262 (exc_cause[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u263 (exc_cause[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u264 (exc_cause[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u265 (exc_cause[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u266 (exc_cause[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u267 (exc_cause[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u268 (exc_cause[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  buf u269 (exc_cause[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(176)
  AL_MUX u27 (
    .i0(n7),
    .i1(1'b0),
    .sel(rst),
    .o(n20));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  AL_MUX u28 (
    .i0(n8),
    .i1(1'b0),
    .sel(rst),
    .o(n21));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  AL_MUX u29 (
    .i0(n9),
    .i1(1'b0),
    .sel(rst),
    .o(n22));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u3 (medeleg[13], dlpf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  AL_MUX u30 (
    .i0(n10),
    .i1(1'b0),
    .sel(rst),
    .o(n23));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  AL_MUX u31 (
    .i0(n11),
    .i1(1'b0),
    .sel(rst),
    .o(n24));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  AL_MUX u32 (
    .i0(n12),
    .i1(1'b0),
    .sel(rst),
    .o(n25));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  AL_MUX u33 (
    .i0(n13),
    .i1(1'b0),
    .sel(rst),
    .o(n26));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  and u34 (n27, m, ins_addr_mis);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(135)
  not u35 (n28, diam);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(135)
  and u36 (n29, ins_addr_mis, n28);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(135)
  or u37 (iam_target_m, n27, n29);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(135)
  and u38 (n30, m, ins_acc_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(136)
  not u39 (n31, diaf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(136)
  buf u4 (m, priv[3]);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(98)
  and u40 (n32, ins_acc_fault, n31);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(136)
  or u41 (iaf_target_m, n30, n32);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(136)
  and u42 (n33, m, ill_ins);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(137)
  not u43 (n34, dii);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(137)
  and u44 (n35, ill_ins, n34);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(137)
  or u45 (ii_target_m, n33, n35);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(137)
  and u46 (n36, m, ebreak);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(138)
  not u47 (n37, dbk);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(138)
  and u48 (n38, ebreak, n37);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(138)
  or u49 (bk_target_m, n36, n38);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(138)
  buf u5 (s, priv[1]);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(99)
  and u50 (n39, m, ld_addr_mis);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(139)
  not u51 (n40, dlam);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(139)
  and u52 (n41, ld_addr_mis, n40);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(139)
  or u53 (lam_target_m, n39, n41);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(139)
  and u54 (n42, m, ld_acc_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(140)
  not u55 (n43, dlaf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(140)
  and u56 (n44, ld_acc_fault, n43);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(140)
  or u57 (laf_target_m, n42, n44);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(140)
  and u58 (n45, m, st_addr_mis);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(141)
  not u59 (n46, dsam);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(141)
  buf u6 (u, priv[0]);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(100)
  and u60 (n47, st_addr_mis, n46);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(141)
  or u61 (sam_target_m, n45, n47);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(141)
  and u62 (n48, m, st_acc_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(142)
  not u63 (n49, dsaf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(142)
  and u64 (n50, st_acc_fault, n49);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(142)
  or u65 (saf_target_m, n48, n50);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(142)
  and u66 (n51, u, ecall);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(143)
  not u67 (n52, decu);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(143)
  and u68 (ecu_target_m, n51, n52);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(143)
  and u69 (n53, s, ecall);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(144)
  and u7 (n0, csr_write, mrw_medeleg_sel);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(118)
  not u70 (n54, decs);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(144)
  and u71 (ecs_target_m, n53, n54);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(144)
  and u72 (n55, m, ins_page_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(145)
  not u73 (n56, dipf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(145)
  and u74 (n57, ins_page_fault, n56);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(145)
  or u75 (ipf_target_m, n55, n57);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(145)
  and u76 (n58, m, ld_page_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(146)
  not u77 (n59, dlpf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(146)
  and u78 (n60, ld_page_fault, n59);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(146)
  or u79 (lpf_target_m, n58, n60);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(146)
  AL_MUX u8 (
    .i0(diam),
    .i1(data_csr[0]),
    .sel(n0),
    .o(n1));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  and u80 (n61, m, st_page_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(147)
  not u81 (n62, dspf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(147)
  and u82 (n63, st_page_fault, n62);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(147)
  or u83 (spf_target_m, n61, n63);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(147)
  or u84 (n64, s, u);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(149)
  and u85 (n65, n64, ins_addr_mis);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(149)
  and u86 (iam_target_s, n65, diam);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(149)
  buf u87 (medeleg[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  and u88 (n66, n64, ins_acc_fault);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(150)
  and u89 (iaf_target_s, n66, diaf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(150)
  AL_MUX u9 (
    .i0(diaf),
    .i1(data_csr[1]),
    .sel(n0),
    .o(n2));  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(132)
  buf u90 (medeleg[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  and u91 (n67, n64, ill_ins);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(151)
  and u92 (ii_target_s, n67, dii);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(151)
  buf u93 (medeleg[9], decs);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  and u94 (n68, n64, ebreak);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(152)
  and u95 (bk_target_s, n68, dbk);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(152)
  buf u96 (medeleg[8], decu);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)
  and u97 (n69, n64, ld_addr_mis);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(153)
  and u98 (lam_target_s, n69, dlam);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(153)
  buf u99 (medeleg[7], dsaf);  // ../../RTL/CPU/CU&RU/csrs/medeleg_exc_ctrl.v(178)

endmodule 

module mideleg_int_ctrl  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(3)
  (
  clk,
  csr_write,
  data_csr,
  m_s_ie,
  m_s_ip,
  mie,
  mrw_mideleg_sel,
  priv,
  rst,
  s_ext_int,
  sie,
  int_cause,
  int_req,
  int_target_m,
  int_target_s,
  mideleg
  );

  input clk;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(4)
  input csr_write;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(25)
  input [63:0] data_csr;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(27)
  input [63:0] m_s_ie;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(21)
  input [63:0] m_s_ip;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(20)
  input mie;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(18)
  input mrw_mideleg_sel;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(24)
  input [3:0] priv;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(8)
  input rst;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(5)
  input s_ext_int;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(6)
  input sie;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(19)
  output [63:0] int_cause;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(10)
  output int_req;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(15)
  output int_target_m;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(13)
  output int_target_s;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(12)
  output [63:0] mideleg;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(26)

  parameter mei = 11;
  parameter mei_cause = 63'b000000000000000000000000000000000000000000000000000000000001011;
  parameter msi = 3;
  parameter msi_casue = 63'b000000000000000000000000000000000000000000000000000000000000011;
  parameter mti = 7;
  parameter mti_cause = 63'b000000000000000000000000000000000000000000000000000000000000111;
  parameter sei = 9;
  parameter sei_cause = 63'b000000000000000000000000000000000000000000000000000000000001001;
  parameter ssi = 1;
  parameter ssi_casue = 63'b000000000000000000000000000000000000000000000000000000000000001;
  parameter sti = 5;
  parameter sti_cause = 63'b000000000000000000000000000000000000000000000000000000000000101;
  wire [63:0] n36;
  wire [63:0] n37;
  wire [63:0] n38;
  wire [63:0] n39;
  wire dsei;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(49)
  wire dssi;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(50)
  wire dsti;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(51)
  wire mei_ack_m;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(58)
  wire msi_ack_m;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(59)
  wire mti_ack_m;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(60)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n2;
  wire n20;
  wire n21;
  wire n22;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire n34;
  wire n35;
  wire n4;
  wire n5;
  wire n6;
  wire n7;
  wire n8;
  wire n9;
  wire s;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(54)
  wire sei_ack_m;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(61)
  wire sei_ack_s;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(65)
  wire ssi_ack_m;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(62)
  wire ssi_ack_s;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(66)
  wire sti_ack_m;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(63)
  wire sti_ack_s;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(67)
  wire u;  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(55)

  AL_DFF dsei_reg (
    .clk(clk),
    .d(n4),
    .reset(1'b0),
    .set(1'b0),
    .q(dsei));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(81)
  AL_DFF dssi_reg (
    .clk(clk),
    .d(n5),
    .reset(1'b0),
    .set(1'b0),
    .q(dssi));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(81)
  AL_DFF dsti_reg (
    .clk(clk),
    .d(n6),
    .reset(1'b0),
    .set(1'b0),
    .q(dsti));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(81)
  binary_mux_s1_w64 mux0 (
    .i0({n35,60'b000000000000000000000000000000000000000000000000000000000000,n35,1'b0,n35}),
    .i1(64'b1000000000000000000000000000000000000000000000000000000000000001),
    .sel(n34),
    .o(n36));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(105)
  binary_mux_s1_w64 mux1 (
    .i0(n36),
    .i1(64'b1000000000000000000000000000000000000000000000000000000000001001),
    .sel(n33),
    .o(n37));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(105)
  binary_mux_s1_w64 mux2 (
    .i0(n37),
    .i1(64'b1000000000000000000000000000000000000000000000000000000000000111),
    .sel(mti_ack_m),
    .o(n38));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(105)
  binary_mux_s1_w64 mux3 (
    .i0(n38),
    .i1(64'b1000000000000000000000000000000000000000000000000000000000000011),
    .sel(msi_ack_m),
    .o(n39));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(105)
  binary_mux_s1_w64 mux4 (
    .i0(n39),
    .i1(64'b1000000000000000000000000000000000000000000000000000000000001011),
    .sel(mei_ack_m),
    .o(int_cause));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(105)
  AL_MUX u10 (
    .i0(n3),
    .i1(1'b0),
    .sel(rst),
    .o(n6));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(80)
  buf u100 (mideleg[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u101 (mideleg[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u102 (mideleg[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u103 (mideleg[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u104 (mideleg[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u105 (mideleg[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u106 (mideleg[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u107 (mideleg[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u108 (mideleg[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u109 (mideleg[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u11 (mideleg[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u110 (mideleg[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u111 (mideleg[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u112 (mideleg[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u113 (mideleg[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u114 (mideleg[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u115 (mideleg[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  and u12 (n7, mie, m_s_ip[11]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(84)
  and u13 (mei_ack_m, n7, m_s_ie[11]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(84)
  and u14 (n8, mie, m_s_ip[3]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(85)
  and u15 (msi_ack_m, n8, m_s_ie[3]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(85)
  and u16 (n9, mie, m_s_ip[7]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(86)
  and u17 (mti_ack_m, n9, m_s_ie[7]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(86)
  not u18 (n10, dsei);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(87)
  and u19 (n11, mie, n10);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(87)
  buf u2 (mideleg[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  or u20 (n12, m_s_ip[9], s_ext_int);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(87)
  and u21 (sei_ack_m, n11, n12);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(87)
  not u22 (n13, dssi);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(88)
  and u23 (n14, mie, n13);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(88)
  and u24 (ssi_ack_m, n14, m_s_ip[1]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(88)
  not u25 (n15, dsti);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(89)
  and u26 (n16, mie, n15);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(89)
  and u27 (sti_ack_m, n16, m_s_ip[5]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(89)
  or u28 (n17, s, u);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(91)
  and u29 (n18, sie, n17);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(91)
  buf u3 (mideleg[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u30 (mideleg[8], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  and u31 (n19, n18, n12);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(91)
  and u32 (n20, n19, m_s_ie[9]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(91)
  and u33 (sei_ack_s, n20, dsei);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(91)
  buf u34 (mideleg[7], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u35 (mideleg[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  and u36 (n21, n18, m_s_ip[1]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(92)
  and u37 (n22, n21, m_s_ie[1]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(92)
  and u38 (ssi_ack_s, n22, dssi);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(92)
  buf u39 (mideleg[5], dsti);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  and u4 (n0, csr_write, mrw_mideleg_sel);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(76)
  buf u40 (mideleg[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  and u41 (n23, n18, m_s_ip[5]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(93)
  and u42 (n24, n23, m_s_ie[5]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(93)
  and u43 (sti_ack_s, n24, dsti);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(93)
  buf u44 (mideleg[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u45 (s, priv[1]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(97)
  buf u46 (u, priv[0]);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(98)
  or u47 (n25, msi_ack_m, mti_ack_m);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(100)
  or u48 (n26, n25, sei_ack_m);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(100)
  or u49 (n27, n26, ssi_ack_m);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(100)
  AL_MUX u5 (
    .i0(dsei),
    .i1(data_csr[9]),
    .sel(n0),
    .o(n1));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(80)
  or u50 (int_target_m, n27, sti_ack_m);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(100)
  not u51 (n28, int_target_m);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(101)
  or u52 (n29, sei_ack_s, ssi_ack_s);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(101)
  or u53 (n30, n29, sti_ack_s);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(101)
  and u54 (int_target_s, n28, n30);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(101)
  buf u55 (mideleg[3], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u56 (mideleg[2], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u57 (mideleg[1], dssi);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u58 (mideleg[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  or u59 (n31, int_target_m, sei_ack_s);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(103)
  AL_MUX u6 (
    .i0(dssi),
    .i1(data_csr[1]),
    .sel(n0),
    .o(n2));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(80)
  or u60 (n32, n31, ssi_ack_s);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(103)
  or u61 (int_req, n32, sti_ack_s);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(103)
  or u62 (n33, sei_ack_m, sei_ack_s);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(105)
  or u63 (n34, ssi_ack_m, ssi_ack_s);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(105)
  or u64 (n35, sti_ack_m, sti_ack_s);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(105)
  buf u65 (mideleg[9], dsei);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u66 (mideleg[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u67 (mideleg[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u68 (mideleg[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u69 (mideleg[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  AL_MUX u7 (
    .i0(dsti),
    .i1(data_csr[5]),
    .sel(n0),
    .o(n3));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(80)
  buf u70 (mideleg[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u71 (mideleg[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u72 (mideleg[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u73 (mideleg[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u74 (mideleg[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u75 (mideleg[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u76 (mideleg[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u77 (mideleg[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u78 (mideleg[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u79 (mideleg[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  AL_MUX u8 (
    .i0(n1),
    .i1(1'b0),
    .sel(rst),
    .o(n4));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(80)
  buf u80 (mideleg[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u81 (mideleg[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u82 (mideleg[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u83 (mideleg[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u84 (mideleg[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u85 (mideleg[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u86 (mideleg[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u87 (mideleg[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u88 (mideleg[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u89 (mideleg[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  AL_MUX u9 (
    .i0(n2),
    .i1(1'b0),
    .sel(rst),
    .o(n5));  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(80)
  buf u90 (mideleg[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u91 (mideleg[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u92 (mideleg[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u93 (mideleg[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u94 (mideleg[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u95 (mideleg[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u96 (mideleg[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u97 (mideleg[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u98 (mideleg[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)
  buf u99 (mideleg[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mideleg_int_ctrl.v(106)

endmodule 

module mro_csr  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(4)
  (
  marchid,
  mhartid,
  mimpid,
  misa,
  mvendorid
  );

  output [63:0] marchid;  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(5)
  output [63:0] mhartid;  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(7)
  output [63:0] mimpid;  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(6)
  output [63:0] misa;  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(9)
  output [63:0] mvendorid;  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(8)


  buf u10 (mimpid[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u100 (mhartid[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u101 (mhartid[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u102 (mhartid[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u103 (mhartid[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u104 (mhartid[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u105 (mhartid[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u106 (mhartid[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u107 (mhartid[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u108 (mhartid[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u109 (mhartid[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u11 (mimpid[5], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u110 (mhartid[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u111 (mhartid[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u112 (mhartid[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u113 (mhartid[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u114 (mhartid[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u115 (mhartid[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u116 (mhartid[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u117 (mhartid[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u118 (mhartid[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u119 (mhartid[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u12 (mimpid[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u120 (mhartid[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u121 (mhartid[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u122 (mhartid[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u123 (mhartid[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u124 (mhartid[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u125 (mhartid[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u126 (mhartid[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u127 (mhartid[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u128 (mhartid[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u129 (mhartid[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u13 (mimpid[7], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u130 (mhartid[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u131 (mhartid[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u132 (mhartid[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u133 (marchid[1], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u134 (marchid[2], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u135 (marchid[3], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u136 (marchid[4], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u137 (marchid[5], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u138 (marchid[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u139 (marchid[7], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u14 (mimpid[8], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u140 (marchid[8], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u141 (marchid[9], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u142 (marchid[10], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u143 (marchid[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u144 (marchid[12], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u145 (marchid[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u146 (marchid[14], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u147 (marchid[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u148 (marchid[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u149 (marchid[17], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u15 (mimpid[9], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u150 (marchid[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u151 (marchid[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u152 (marchid[20], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u153 (marchid[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u154 (marchid[22], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u155 (marchid[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u156 (marchid[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u157 (marchid[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u158 (marchid[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u159 (marchid[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u16 (mimpid[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u160 (marchid[28], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u161 (marchid[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u162 (marchid[30], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u163 (marchid[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u164 (marchid[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u165 (marchid[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u166 (marchid[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u167 (marchid[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u168 (marchid[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u169 (marchid[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u17 (mimpid[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u170 (marchid[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u171 (marchid[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u172 (marchid[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u173 (marchid[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u174 (marchid[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u175 (marchid[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u176 (marchid[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u177 (marchid[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u178 (marchid[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u179 (marchid[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u18 (mimpid[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u180 (marchid[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u181 (marchid[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u182 (marchid[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u183 (marchid[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u184 (marchid[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u185 (marchid[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u186 (marchid[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u187 (marchid[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u188 (marchid[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u189 (marchid[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u19 (mimpid[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u190 (marchid[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u191 (marchid[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u192 (marchid[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u193 (marchid[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u194 (marchid[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u195 (marchid[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u196 (mvendorid[1], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u197 (mvendorid[2], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u198 (mvendorid[3], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u199 (mvendorid[4], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u2 (mimpid[1], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u20 (mimpid[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u200 (mvendorid[5], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u201 (mvendorid[6], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u202 (mvendorid[7], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u203 (mvendorid[8], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u204 (mvendorid[9], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u205 (mvendorid[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u206 (mvendorid[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u207 (mvendorid[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u208 (mvendorid[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u209 (mvendorid[14], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u21 (mimpid[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u210 (mvendorid[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u211 (mvendorid[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u212 (mvendorid[17], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u213 (mvendorid[18], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u214 (mvendorid[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u215 (mvendorid[20], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u216 (mvendorid[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u217 (mvendorid[22], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u218 (mvendorid[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u219 (mvendorid[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u22 (mimpid[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u220 (mvendorid[25], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u221 (mvendorid[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u222 (mvendorid[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u223 (mvendorid[28], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u224 (mvendorid[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u225 (mvendorid[30], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u226 (mvendorid[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u227 (mvendorid[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u228 (mvendorid[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u229 (mvendorid[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u23 (mimpid[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u230 (mvendorid[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u231 (mvendorid[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u232 (mvendorid[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u233 (mvendorid[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u234 (mvendorid[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u235 (mvendorid[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u236 (mvendorid[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u237 (mvendorid[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u238 (mvendorid[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u239 (mvendorid[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u24 (mimpid[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u240 (mvendorid[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u241 (mvendorid[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u242 (mvendorid[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u243 (mvendorid[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u244 (mvendorid[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u245 (mvendorid[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u246 (mvendorid[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u247 (mvendorid[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u248 (mvendorid[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u249 (mvendorid[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u25 (mimpid[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u250 (mvendorid[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u251 (mvendorid[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u252 (mvendorid[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u253 (mvendorid[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u254 (mvendorid[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u255 (mvendorid[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u256 (mvendorid[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u257 (mvendorid[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u258 (mvendorid[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u259 (misa[1], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u26 (mimpid[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u260 (misa[2], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u261 (misa[3], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u262 (misa[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u263 (misa[5], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u264 (misa[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u265 (misa[7], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u266 (misa[8], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u267 (misa[9], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u268 (misa[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u269 (misa[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u27 (mimpid[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u270 (misa[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u271 (misa[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u272 (misa[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u273 (misa[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u274 (misa[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u275 (misa[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u276 (misa[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u277 (misa[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u278 (misa[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u279 (misa[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u28 (mimpid[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u280 (misa[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u281 (misa[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u282 (misa[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u283 (misa[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u284 (misa[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u285 (misa[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u286 (misa[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u287 (misa[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u288 (misa[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u289 (misa[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u29 (mimpid[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u290 (misa[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u291 (misa[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u292 (misa[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u293 (misa[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u294 (misa[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u295 (misa[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u296 (misa[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u297 (misa[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u298 (misa[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u299 (misa[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u3 (mimpid[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u30 (mimpid[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u300 (misa[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u301 (misa[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u302 (misa[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u303 (misa[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u304 (misa[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u305 (misa[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u306 (misa[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u307 (misa[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u308 (misa[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u309 (misa[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u31 (mimpid[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u310 (misa[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u311 (misa[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u312 (misa[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u313 (misa[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u314 (misa[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u315 (misa[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u316 (misa[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u317 (misa[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u318 (misa[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u319 (misa[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u32 (mimpid[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u320 (misa[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u321 (misa[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u33 (mimpid[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u34 (mimpid[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u35 (mimpid[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u36 (mimpid[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u37 (mimpid[31], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u38 (mimpid[32], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u39 (mimpid[33], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u4 (misa[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(12)
  buf u40 (mimpid[34], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u41 (mimpid[35], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u42 (mimpid[36], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u43 (mimpid[37], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u44 (mimpid[38], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u45 (mimpid[39], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u46 (mimpid[40], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u47 (mimpid[41], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u48 (mimpid[42], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u49 (mimpid[43], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u5 (mvendorid[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(14)
  buf u50 (mimpid[44], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u51 (mimpid[45], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u52 (mimpid[46], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u53 (mimpid[47], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u54 (mimpid[48], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u55 (mimpid[49], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u56 (mimpid[50], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u57 (mimpid[51], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u58 (mimpid[52], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u59 (mimpid[53], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u6 (marchid[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(15)
  buf u60 (mimpid[54], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u61 (mimpid[55], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u62 (mimpid[56], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u63 (mimpid[57], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u64 (mimpid[58], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u65 (mimpid[59], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u66 (mimpid[60], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u67 (mimpid[61], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u68 (mimpid[62], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u69 (mimpid[63], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u7 (mhartid[0], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u70 (mhartid[1], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u71 (mhartid[2], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u72 (mhartid[3], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u73 (mhartid[4], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u74 (mhartid[5], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u75 (mhartid[6], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u76 (mhartid[7], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u77 (mhartid[8], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u78 (mhartid[9], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u79 (mhartid[10], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u8 (mimpid[2], 1'b1);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u80 (mhartid[11], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u81 (mhartid[12], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u82 (mhartid[13], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u83 (mhartid[14], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u84 (mhartid[15], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u85 (mhartid[16], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u86 (mhartid[17], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u87 (mhartid[18], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u88 (mhartid[19], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u89 (mhartid[20], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u9 (mimpid[3], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(17)
  buf u90 (mhartid[21], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u91 (mhartid[22], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u92 (mhartid[23], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u93 (mhartid[24], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u94 (mhartid[25], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u95 (mhartid[26], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u96 (mhartid[27], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u97 (mhartid[28], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u98 (mhartid[29], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)
  buf u99 (mhartid[30], 1'b0);  // ../../RTL/CPU/CU&RU/csrs/mro_csr.v(16)

endmodule 

module binary_mux_s1_w62
  (
  i0,
  i1,
  sel,
  o
  );

  input [61:0] i0;
  input [61:0] i1;
  input sel;
  output [61:0] o;



endmodule 

module ne_w5
  (
  i0,
  i1,
  o
  );

  input [4:0] i0;
  input [4:0] i1;
  output o;



endmodule 

module ram_w5x64_r5x64_r5x64
  (
  clk1,
  ra1,
  ra2,
  re1,
  re2,
  wa1,
  wd1,
  we1,
  rd1,
  rd2
  );

  input clk1;
  input [4:0] ra1;
  input [4:0] ra2;
  input re1;
  input re2;
  input [4:0] wa1;
  input [63:0] wd1;
  input we1;
  output [63:0] rd1;
  output [63:0] rd2;



endmodule 

module add_pu5_mu5_o5
  (
  i0,
  i1,
  o
  );

  input [4:0] i0;
  input [4:0] i1;
  output [4:0] o;



endmodule 

module alu_au  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(1)
  (
  amo_lr_sc,
  and_clr,
  as1,
  as2,
  beq,
  bge,
  blt,
  bne,
  compare,
  ds1,
  ds2,
  jmp,
  mem_csr_data_add,
  mem_csr_data_and,
  mem_csr_data_ds1,
  mem_csr_data_ds2,
  mem_csr_data_max,
  mem_csr_data_min,
  mem_csr_data_or,
  mem_csr_data_xor,
  rd_data_add,
  rd_data_and,
  rd_data_ds1,
  rd_data_or,
  rd_data_slt,
  rd_data_sub,
  rd_data_xor,
  size,
  unsign,
  alu_data_mem_csr,
  alu_data_rd,
  au_addr_pc,
  jmp_ok
  );

  input amo_lr_sc;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(13)
  input and_clr;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(31)
  input [63:0] as1;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(40)
  input [63:0] as2;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(41)
  input beq;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(27)
  input bge;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(26)
  input blt;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(25)
  input bne;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(28)
  input compare;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(12)
  input [63:0] ds1;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(38)
  input [63:0] ds2;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(39)
  input jmp;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(29)
  input mem_csr_data_add;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(18)
  input mem_csr_data_and;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(19)
  input mem_csr_data_ds1;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(16)
  input mem_csr_data_ds2;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(17)
  input mem_csr_data_max;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(22)
  input mem_csr_data_min;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(23)
  input mem_csr_data_or;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(20)
  input mem_csr_data_xor;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(21)
  input rd_data_add;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(6)
  input rd_data_and;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(8)
  input rd_data_ds1;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(5)
  input rd_data_or;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(9)
  input rd_data_slt;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(11)
  input rd_data_sub;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(7)
  input rd_data_xor;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(10)
  input [3:0] size;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(34)
  input unsign;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(30)
  output [63:0] alu_data_mem_csr;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(45)
  output [63:0] alu_data_rd;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(44)
  output [63:0] au_addr_pc;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(46)
  output jmp_ok;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(48)

  wire [63:0] add_64;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(55)
  wire [63:0] alu_add;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(54)
  wire [63:0] alu_and;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(58)
  wire [63:0] alu_lr_sc;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(63)
  wire [63:0] alu_max;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(64)
  wire [63:0] alu_min;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(65)
  wire [63:0] alu_or;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(59)
  wire [63:0] alu_slt;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(61)
  wire [63:0] alu_sub;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(57)
  wire [63:0] alu_xor;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(60)
  wire [63:0] n16;
  wire [63:0] n17;
  wire [63:0] n18;
  wire [63:0] n28;
  wire [63:0] n29;
  wire [63:0] n30;
  wire [63:0] n31;
  wire [63:0] n32;
  wire [63:0] n33;
  wire [63:0] n34;
  wire [63:0] n35;
  wire [63:0] n36;
  wire [63:0] n37;
  wire [63:0] n38;
  wire [63:0] n39;
  wire [63:0] n40;
  wire [63:0] n41;
  wire [63:0] n42;
  wire [63:0] n43;
  wire [63:0] n44;
  wire [63:0] n45;
  wire [63:0] n46;
  wire [63:0] n47;
  wire [63:0] n48;
  wire [63:0] n49;
  wire [63:0] n50;
  wire [63:0] n51;
  wire [63:0] n52;
  wire [63:0] n53;
  wire [63:0] n54;
  wire [63:0] n55;
  wire [63:0] sub_64;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(56)
  wire ds1_equal_ds2;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(69)
  wire ds1_great_than_ds2;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(68)
  wire ds1_light_than_ds2;  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(67)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n19;
  wire n2;
  wire n20;
  wire n21;
  wire n22;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n3;
  wire n4;
  wire n5;
  wire n6;
  wire n7;
  wire n8;
  wire n9;

  add_pu64_pu64_o64 add0 (
    .i0(ds1),
    .i1(n17),
    .o(add_64));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  add_pu64_pu64_o64 add1 (
    .i0(add_64),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000001),
    .o({open_n0,open_n1,open_n2,open_n3,open_n4,open_n5,open_n6,open_n7,open_n8,open_n9,open_n10,open_n11,open_n12,open_n13,open_n14,open_n15,open_n16,open_n17,open_n18,open_n19,open_n20,open_n21,open_n22,open_n23,open_n24,open_n25,open_n26,open_n27,open_n28,open_n29,open_n30,open_n31,sub_64[31:0]}));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(80)
  add_pu64_pu64_o64 add2 (
    .i0(as1),
    .i1(as2),
    .o(au_addr_pc));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(118)
  eq_w64 eq0 (
    .i0(ds1),
    .i1(ds2),
    .o(ds1_equal_ds2));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(77)
  lt_u64_u64 lt0 (
    .ci(1'b0),
    .i0(ds1),
    .i1(ds2),
    .o(n5));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(72)
  lt_u64_u64 lt1 (
    .ci(1'b0),
    .i0(ds2),
    .i1(ds1),
    .o(n12));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(75)
  binary_mux_s1_w64 mux0 (
    .i0(ds2),
    .i1(n16),
    .sel(rd_data_sub),
    .o(n17));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  binary_mux_s1_w32 mux1 (
    .i0(add_64[63:32]),
    .i1({add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31],add_64[31]}),
    .sel(size[2]),
    .o(alu_add[63:32]));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(81)
  binary_mux_s1_w64 mux10 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_or),
    .sel(rd_data_or),
    .o(n35));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  binary_mux_s1_w64 mux11 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_xor),
    .sel(rd_data_xor),
    .o(n37));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  binary_mux_s1_w64 mux12 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_slt),
    .sel(rd_data_slt),
    .o(n39));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  binary_mux_s1_w64 mux13 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_lr_sc),
    .sel(amo_lr_sc),
    .o(n41));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  binary_mux_s1_w64 mux14 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(ds1),
    .sel(mem_csr_data_ds1),
    .o(n42));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(109)
  binary_mux_s1_w64 mux15 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(ds2),
    .sel(mem_csr_data_ds2),
    .o(n43));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  binary_mux_s1_w64 mux16 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_add),
    .sel(mem_csr_data_add),
    .o(n45));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  binary_mux_s1_w64 mux17 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_and),
    .sel(mem_csr_data_and),
    .o(n47));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  binary_mux_s1_w64 mux18 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_or),
    .sel(mem_csr_data_or),
    .o(n49));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  binary_mux_s1_w64 mux19 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_xor),
    .sel(mem_csr_data_xor),
    .o(n51));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  binary_mux_s1_w32 mux2 (
    .i0(add_64[63:32]),
    .i1({sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31],sub_64[31]}),
    .sel(size[2]),
    .o(alu_sub[63:32]));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(84)
  binary_mux_s1_w64 mux20 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_max),
    .sel(mem_csr_data_max),
    .o(n53));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  binary_mux_s1_w64 mux21 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_min),
    .sel(mem_csr_data_min),
    .o(n55));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  binary_mux_s1_w64 mux3 (
    .i0(ds2),
    .i1(n16),
    .sel(and_clr),
    .o(n18));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  binary_mux_s1_w64 mux4 (
    .i0(ds2),
    .i1(ds1),
    .sel(ds1_great_than_ds2),
    .o(alu_max));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(95)
  binary_mux_s1_w64 mux5 (
    .i0(ds2),
    .i1(ds1),
    .sel(ds1_light_than_ds2),
    .o(alu_min));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(96)
  binary_mux_s1_w64 mux6 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(ds1),
    .sel(rd_data_ds1),
    .o(n28));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(99)
  binary_mux_s1_w64 mux7 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_add),
    .sel(rd_data_add),
    .o(n29));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  binary_mux_s1_w64 mux8 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_sub),
    .sel(rd_data_sub),
    .o(n31));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  binary_mux_s1_w64 mux9 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(alu_and),
    .sel(rd_data_and),
    .o(n33));  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u10 (n7, n2, n6);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(72)
  or u100 (alu_data_mem_csr[51], n54[51], n55[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u1000 (alu_slt[6], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1001 (alu_slt[7], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1002 (alu_slt[8], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1003 (alu_slt[9], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1004 (alu_slt[10], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1005 (alu_slt[11], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1006 (alu_slt[12], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1007 (alu_slt[13], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1008 (alu_slt[14], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1009 (alu_slt[15], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  or u101 (alu_data_mem_csr[52], n54[52], n55[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u1010 (alu_slt[16], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1011 (alu_slt[17], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1012 (alu_slt[18], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1013 (alu_slt[19], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1014 (alu_slt[20], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1015 (alu_slt[21], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1016 (alu_slt[22], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1017 (alu_slt[23], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1018 (alu_slt[24], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1019 (alu_slt[25], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  or u102 (alu_data_mem_csr[53], n54[53], n55[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u1020 (alu_slt[26], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1021 (alu_slt[27], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1022 (alu_slt[28], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1023 (alu_slt[29], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1024 (alu_slt[30], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1025 (alu_slt[31], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1026 (alu_slt[32], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1027 (alu_slt[33], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1028 (alu_slt[34], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1029 (alu_slt[35], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  or u103 (alu_data_mem_csr[54], n54[54], n55[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u1030 (alu_slt[36], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1031 (alu_slt[37], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1032 (alu_slt[38], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1033 (alu_slt[39], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1034 (alu_slt[40], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1035 (alu_slt[41], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1036 (alu_slt[42], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1037 (alu_slt[43], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1038 (alu_slt[44], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1039 (alu_slt[45], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  or u104 (alu_data_mem_csr[55], n54[55], n55[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u1040 (alu_slt[46], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1041 (alu_slt[47], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1042 (alu_slt[48], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1043 (alu_slt[49], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1044 (alu_slt[50], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1045 (alu_slt[51], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1046 (alu_slt[52], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1047 (alu_slt[53], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1048 (alu_slt[54], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1049 (alu_slt[55], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  or u105 (alu_data_mem_csr[56], n54[56], n55[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u1050 (alu_slt[56], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1051 (alu_slt[57], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1052 (alu_slt[58], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1053 (alu_slt[59], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1054 (alu_slt[60], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1055 (alu_slt[61], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1056 (alu_slt[62], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u1057 (alu_slt[63], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  xor u1058 (alu_xor[1], ds1[1], ds2[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1059 (alu_xor[2], ds1[2], ds2[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  or u106 (alu_data_mem_csr[57], n54[57], n55[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  xor u1060 (alu_xor[3], ds1[3], ds2[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1061 (alu_xor[4], ds1[4], ds2[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1062 (alu_xor[5], ds1[5], ds2[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1063 (alu_xor[6], ds1[6], ds2[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1064 (alu_xor[7], ds1[7], ds2[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1065 (alu_xor[8], ds1[8], ds2[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1066 (alu_xor[9], ds1[9], ds2[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1067 (alu_xor[10], ds1[10], ds2[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1068 (alu_xor[11], ds1[11], ds2[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1069 (alu_xor[12], ds1[12], ds2[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  or u107 (alu_data_mem_csr[58], n54[58], n55[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  xor u1070 (alu_xor[13], ds1[13], ds2[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1071 (alu_xor[14], ds1[14], ds2[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1072 (alu_xor[15], ds1[15], ds2[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1073 (alu_xor[16], ds1[16], ds2[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1074 (alu_xor[17], ds1[17], ds2[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1075 (alu_xor[18], ds1[18], ds2[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1076 (alu_xor[19], ds1[19], ds2[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1077 (alu_xor[20], ds1[20], ds2[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1078 (alu_xor[21], ds1[21], ds2[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1079 (alu_xor[22], ds1[22], ds2[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  or u108 (alu_data_mem_csr[59], n54[59], n55[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  xor u1080 (alu_xor[23], ds1[23], ds2[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1081 (alu_xor[24], ds1[24], ds2[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1082 (alu_xor[25], ds1[25], ds2[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1083 (alu_xor[26], ds1[26], ds2[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1084 (alu_xor[27], ds1[27], ds2[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1085 (alu_xor[28], ds1[28], ds2[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1086 (alu_xor[29], ds1[29], ds2[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1087 (alu_xor[30], ds1[30], ds2[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1088 (alu_xor[31], ds1[31], ds2[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1089 (alu_xor[32], ds1[32], ds2[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  or u109 (alu_data_mem_csr[60], n54[60], n55[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  xor u1090 (alu_xor[33], ds1[33], ds2[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1091 (alu_xor[34], ds1[34], ds2[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1092 (alu_xor[35], ds1[35], ds2[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1093 (alu_xor[36], ds1[36], ds2[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1094 (alu_xor[37], ds1[37], ds2[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1095 (alu_xor[38], ds1[38], ds2[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1096 (alu_xor[39], ds1[39], ds2[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1097 (alu_xor[40], ds1[40], ds2[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1098 (alu_xor[41], ds1[41], ds2[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1099 (alu_xor[42], ds1[42], ds2[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  and u11 (n8, n0, n7);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(72)
  or u110 (alu_data_mem_csr[61], n54[61], n55[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  xor u1100 (alu_xor[43], ds1[43], ds2[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1101 (alu_xor[44], ds1[44], ds2[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1102 (alu_xor[45], ds1[45], ds2[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1103 (alu_xor[46], ds1[46], ds2[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1104 (alu_xor[47], ds1[47], ds2[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1105 (alu_xor[48], ds1[48], ds2[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1106 (alu_xor[49], ds1[49], ds2[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1107 (alu_xor[50], ds1[50], ds2[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1108 (alu_xor[51], ds1[51], ds2[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1109 (alu_xor[52], ds1[52], ds2[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  or u111 (alu_data_mem_csr[62], n54[62], n55[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  xor u1110 (alu_xor[53], ds1[53], ds2[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1111 (alu_xor[54], ds1[54], ds2[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1112 (alu_xor[55], ds1[55], ds2[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1113 (alu_xor[56], ds1[56], ds2[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1114 (alu_xor[57], ds1[57], ds2[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1115 (alu_xor[58], ds1[58], ds2[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1116 (alu_xor[59], ds1[59], ds2[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1117 (alu_xor[60], ds1[60], ds2[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1118 (alu_xor[61], ds1[61], ds2[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  xor u1119 (alu_xor[62], ds1[62], ds2[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  or u112 (alu_data_mem_csr[63], n54[63], n55[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  xor u1120 (alu_xor[63], ds1[63], ds2[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  or u1121 (alu_or[1], ds1[1], ds2[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1122 (alu_or[2], ds1[2], ds2[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1123 (alu_or[3], ds1[3], ds2[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1124 (alu_or[4], ds1[4], ds2[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1125 (alu_or[5], ds1[5], ds2[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1126 (alu_or[6], ds1[6], ds2[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1127 (alu_or[7], ds1[7], ds2[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1128 (alu_or[8], ds1[8], ds2[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1129 (alu_or[9], ds1[9], ds2[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u113 (n54[1], n52[1], n53[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u1130 (alu_or[10], ds1[10], ds2[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1131 (alu_or[11], ds1[11], ds2[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1132 (alu_or[12], ds1[12], ds2[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1133 (alu_or[13], ds1[13], ds2[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1134 (alu_or[14], ds1[14], ds2[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1135 (alu_or[15], ds1[15], ds2[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1136 (alu_or[16], ds1[16], ds2[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1137 (alu_or[17], ds1[17], ds2[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1138 (alu_or[18], ds1[18], ds2[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1139 (alu_or[19], ds1[19], ds2[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u114 (n54[2], n52[2], n53[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u1140 (alu_or[20], ds1[20], ds2[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1141 (alu_or[21], ds1[21], ds2[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1142 (alu_or[22], ds1[22], ds2[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1143 (alu_or[23], ds1[23], ds2[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1144 (alu_or[24], ds1[24], ds2[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1145 (alu_or[25], ds1[25], ds2[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1146 (alu_or[26], ds1[26], ds2[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1147 (alu_or[27], ds1[27], ds2[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1148 (alu_or[28], ds1[28], ds2[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1149 (alu_or[29], ds1[29], ds2[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u115 (n54[3], n52[3], n53[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u1150 (alu_or[30], ds1[30], ds2[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1151 (alu_or[31], ds1[31], ds2[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1152 (alu_or[32], ds1[32], ds2[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1153 (alu_or[33], ds1[33], ds2[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1154 (alu_or[34], ds1[34], ds2[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1155 (alu_or[35], ds1[35], ds2[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1156 (alu_or[36], ds1[36], ds2[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1157 (alu_or[37], ds1[37], ds2[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1158 (alu_or[38], ds1[38], ds2[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1159 (alu_or[39], ds1[39], ds2[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u116 (n54[4], n52[4], n53[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u1160 (alu_or[40], ds1[40], ds2[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1161 (alu_or[41], ds1[41], ds2[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1162 (alu_or[42], ds1[42], ds2[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1163 (alu_or[43], ds1[43], ds2[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1164 (alu_or[44], ds1[44], ds2[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1165 (alu_or[45], ds1[45], ds2[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1166 (alu_or[46], ds1[46], ds2[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1167 (alu_or[47], ds1[47], ds2[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1168 (alu_or[48], ds1[48], ds2[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1169 (alu_or[49], ds1[49], ds2[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u117 (n54[5], n52[5], n53[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u1170 (alu_or[50], ds1[50], ds2[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1171 (alu_or[51], ds1[51], ds2[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1172 (alu_or[52], ds1[52], ds2[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1173 (alu_or[53], ds1[53], ds2[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1174 (alu_or[54], ds1[54], ds2[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1175 (alu_or[55], ds1[55], ds2[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1176 (alu_or[56], ds1[56], ds2[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1177 (alu_or[57], ds1[57], ds2[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1178 (alu_or[58], ds1[58], ds2[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1179 (alu_or[59], ds1[59], ds2[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u118 (n54[6], n52[6], n53[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u1180 (alu_or[60], ds1[60], ds2[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1181 (alu_or[61], ds1[61], ds2[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1182 (alu_or[62], ds1[62], ds2[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u1183 (alu_or[63], ds1[63], ds2[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  and u1184 (alu_and[1], ds1[1], n18[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1185 (alu_and[2], ds1[2], n18[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1186 (alu_and[3], ds1[3], n18[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1187 (alu_and[4], ds1[4], n18[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1188 (alu_and[5], ds1[5], n18[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1189 (alu_and[6], ds1[6], n18[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  or u119 (n54[7], n52[7], n53[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  and u1190 (alu_and[7], ds1[7], n18[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1191 (alu_and[8], ds1[8], n18[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1192 (alu_and[9], ds1[9], n18[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1193 (alu_and[10], ds1[10], n18[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1194 (alu_and[11], ds1[11], n18[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1195 (alu_and[12], ds1[12], n18[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1196 (alu_and[13], ds1[13], n18[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1197 (alu_and[14], ds1[14], n18[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1198 (alu_and[15], ds1[15], n18[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1199 (alu_and[16], ds1[16], n18[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  or u12 (alu_data_mem_csr[6], n54[6], n55[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u120 (n54[8], n52[8], n53[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  and u1200 (alu_and[17], ds1[17], n18[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1201 (alu_and[18], ds1[18], n18[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1202 (alu_and[19], ds1[19], n18[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1203 (alu_and[20], ds1[20], n18[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1204 (alu_and[21], ds1[21], n18[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1205 (alu_and[22], ds1[22], n18[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1206 (alu_and[23], ds1[23], n18[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1207 (alu_and[24], ds1[24], n18[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1208 (alu_and[25], ds1[25], n18[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1209 (alu_and[26], ds1[26], n18[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  or u121 (n54[9], n52[9], n53[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  and u1210 (alu_and[27], ds1[27], n18[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1211 (alu_and[28], ds1[28], n18[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1212 (alu_and[29], ds1[29], n18[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1213 (alu_and[30], ds1[30], n18[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1214 (alu_and[31], ds1[31], n18[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1215 (alu_and[32], ds1[32], n18[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1216 (alu_and[33], ds1[33], n18[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1217 (alu_and[34], ds1[34], n18[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1218 (alu_and[35], ds1[35], n18[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1219 (alu_and[36], ds1[36], n18[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  or u122 (n54[10], n52[10], n53[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  and u1220 (alu_and[37], ds1[37], n18[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1221 (alu_and[38], ds1[38], n18[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1222 (alu_and[39], ds1[39], n18[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1223 (alu_and[40], ds1[40], n18[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1224 (alu_and[41], ds1[41], n18[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1225 (alu_and[42], ds1[42], n18[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1226 (alu_and[43], ds1[43], n18[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1227 (alu_and[44], ds1[44], n18[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1228 (alu_and[45], ds1[45], n18[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1229 (alu_and[46], ds1[46], n18[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  or u123 (n54[11], n52[11], n53[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  and u1230 (alu_and[47], ds1[47], n18[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1231 (alu_and[48], ds1[48], n18[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1232 (alu_and[49], ds1[49], n18[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1233 (alu_and[50], ds1[50], n18[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1234 (alu_and[51], ds1[51], n18[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1235 (alu_and[52], ds1[52], n18[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1236 (alu_and[53], ds1[53], n18[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1237 (alu_and[54], ds1[54], n18[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1238 (alu_and[55], ds1[55], n18[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1239 (alu_and[56], ds1[56], n18[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  or u124 (n54[12], n52[12], n53[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  and u1240 (alu_and[57], ds1[57], n18[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1241 (alu_and[58], ds1[58], n18[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1242 (alu_and[59], ds1[59], n18[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1243 (alu_and[60], ds1[60], n18[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1244 (alu_and[61], ds1[61], n18[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1245 (alu_and[62], ds1[62], n18[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  and u1246 (alu_and[63], ds1[63], n18[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  buf u1247 (alu_sub[1], sub_64[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1248 (alu_sub[2], sub_64[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1249 (alu_sub[3], sub_64[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  or u125 (n54[13], n52[13], n53[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  buf u1250 (alu_sub[4], sub_64[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1251 (alu_sub[5], sub_64[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1252 (alu_sub[6], sub_64[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1253 (alu_sub[7], sub_64[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1254 (alu_sub[8], sub_64[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1255 (alu_sub[9], sub_64[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1256 (alu_sub[10], sub_64[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1257 (alu_sub[11], sub_64[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1258 (alu_sub[12], sub_64[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1259 (alu_sub[13], sub_64[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  or u126 (n54[14], n52[14], n53[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  buf u1260 (alu_sub[14], sub_64[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1261 (alu_sub[15], sub_64[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1262 (alu_sub[16], sub_64[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1263 (alu_sub[17], sub_64[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1264 (alu_sub[18], sub_64[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1265 (alu_sub[19], sub_64[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1266 (alu_sub[20], sub_64[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1267 (alu_sub[21], sub_64[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1268 (alu_sub[22], sub_64[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1269 (alu_sub[23], sub_64[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  or u127 (n54[15], n52[15], n53[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  buf u1270 (alu_sub[24], sub_64[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1271 (alu_sub[25], sub_64[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1272 (alu_sub[26], sub_64[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1273 (alu_sub[27], sub_64[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1274 (alu_sub[28], sub_64[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1275 (alu_sub[29], sub_64[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1276 (alu_sub[30], sub_64[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1277 (alu_sub[31], sub_64[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  buf u1278 (alu_add[1], add_64[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1279 (alu_add[2], add_64[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  or u128 (n54[16], n52[16], n53[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  buf u1280 (alu_add[3], add_64[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1281 (alu_add[4], add_64[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1282 (alu_add[5], add_64[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1283 (alu_add[6], add_64[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1284 (alu_add[7], add_64[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1285 (alu_add[8], add_64[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1286 (alu_add[9], add_64[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1287 (alu_add[10], add_64[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1288 (alu_add[11], add_64[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1289 (alu_add[12], add_64[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  or u129 (n54[17], n52[17], n53[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  buf u1290 (alu_add[13], add_64[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1291 (alu_add[14], add_64[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1292 (alu_add[15], add_64[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1293 (alu_add[16], add_64[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1294 (alu_add[17], add_64[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1295 (alu_add[18], add_64[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1296 (alu_add[19], add_64[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1297 (alu_add[20], add_64[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1298 (alu_add[21], add_64[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1299 (alu_add[22], add_64[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  and u13 (n9, unsign, n5);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(73)
  or u130 (n54[18], n52[18], n53[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  buf u1300 (alu_add[23], add_64[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1301 (alu_add[24], add_64[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1302 (alu_add[25], add_64[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1303 (alu_add[26], add_64[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1304 (alu_add[27], add_64[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1305 (alu_add[28], add_64[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1306 (alu_add[29], add_64[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1307 (alu_add[30], add_64[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  buf u1308 (alu_add[31], add_64[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  not u1309 (n16[1], ds2[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  or u131 (n54[19], n52[19], n53[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  not u1310 (n16[2], ds2[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1311 (n16[3], ds2[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1312 (n16[4], ds2[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1313 (n16[5], ds2[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1314 (n16[6], ds2[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1315 (n16[7], ds2[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1316 (n16[8], ds2[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1317 (n16[9], ds2[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1318 (n16[10], ds2[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1319 (n16[11], ds2[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  or u132 (n54[20], n52[20], n53[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  not u1320 (n16[12], ds2[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1321 (n16[13], ds2[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1322 (n16[14], ds2[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1323 (n16[15], ds2[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1324 (n16[16], ds2[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1325 (n16[17], ds2[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1326 (n16[18], ds2[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1327 (n16[19], ds2[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1328 (n16[20], ds2[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1329 (n16[21], ds2[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  or u133 (n54[21], n52[21], n53[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  not u1330 (n16[22], ds2[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1331 (n16[23], ds2[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1332 (n16[24], ds2[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1333 (n16[25], ds2[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1334 (n16[26], ds2[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1335 (n16[27], ds2[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1336 (n16[28], ds2[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1337 (n16[29], ds2[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1338 (n16[30], ds2[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1339 (n16[31], ds2[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  or u134 (n54[22], n52[22], n53[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  not u1340 (n16[32], ds2[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1341 (n16[33], ds2[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1342 (n16[34], ds2[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1343 (n16[35], ds2[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1344 (n16[36], ds2[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1345 (n16[37], ds2[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1346 (n16[38], ds2[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1347 (n16[39], ds2[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1348 (n16[40], ds2[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1349 (n16[41], ds2[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  or u135 (n54[23], n52[23], n53[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  not u1350 (n16[42], ds2[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1351 (n16[43], ds2[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1352 (n16[44], ds2[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1353 (n16[45], ds2[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1354 (n16[46], ds2[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1355 (n16[47], ds2[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1356 (n16[48], ds2[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1357 (n16[49], ds2[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1358 (n16[50], ds2[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1359 (n16[51], ds2[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  or u136 (n54[24], n52[24], n53[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  not u1360 (n16[52], ds2[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1361 (n16[53], ds2[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1362 (n16[54], ds2[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1363 (n16[55], ds2[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1364 (n16[56], ds2[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1365 (n16[57], ds2[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1366 (n16[58], ds2[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1367 (n16[59], ds2[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1368 (n16[60], ds2[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1369 (n16[61], ds2[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  or u137 (n54[25], n52[25], n53[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  not u1370 (n16[62], ds2[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  not u1371 (n16[63], ds2[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  or u138 (n54[26], n52[26], n53[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u139 (n54[27], n52[27], n53[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u14 (ds1_light_than_ds2, n8, n9);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(73)
  or u140 (n54[28], n52[28], n53[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u141 (n54[29], n52[29], n53[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u142 (n54[30], n52[30], n53[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u143 (n54[31], n52[31], n53[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u144 (n54[32], n52[32], n53[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u145 (n54[33], n52[33], n53[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u146 (n54[34], n52[34], n53[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u147 (n54[35], n52[35], n53[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u148 (n54[36], n52[36], n53[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u149 (n54[37], n52[37], n53[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u15 (alu_data_mem_csr[5], n54[5], n55[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u150 (n54[38], n52[38], n53[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u151 (n54[39], n52[39], n53[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u152 (n54[40], n52[40], n53[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u153 (n54[41], n52[41], n53[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u154 (n54[42], n52[42], n53[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u155 (n54[43], n52[43], n53[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u156 (n54[44], n52[44], n53[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u157 (n54[45], n52[45], n53[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u158 (n54[46], n52[46], n53[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u159 (n54[47], n52[47], n53[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  not u16 (n10, ds1[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(74)
  or u160 (n54[48], n52[48], n53[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u161 (n54[49], n52[49], n53[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u162 (n54[50], n52[50], n53[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u163 (n54[51], n52[51], n53[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u164 (n54[52], n52[52], n53[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u165 (n54[53], n52[53], n53[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u166 (n54[54], n52[54], n53[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u167 (n54[55], n52[55], n53[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u168 (n54[56], n52[56], n53[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u169 (n54[57], n52[57], n53[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  and u17 (n11, n10, ds2[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(74)
  or u170 (n54[58], n52[58], n53[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u171 (n54[59], n52[59], n53[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u172 (n54[60], n52[60], n53[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u173 (n54[61], n52[61], n53[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u174 (n54[62], n52[62], n53[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u175 (n54[63], n52[63], n53[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u176 (n52[1], n50[1], n51[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u177 (n52[2], n50[2], n51[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u178 (n52[3], n50[3], n51[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u179 (n52[4], n50[4], n51[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u18 (alu_data_mem_csr[4], n54[4], n55[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u180 (n52[5], n50[5], n51[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u181 (n52[6], n50[6], n51[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u182 (n52[7], n50[7], n51[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u183 (n52[8], n50[8], n51[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u184 (n52[9], n50[9], n51[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u185 (n52[10], n50[10], n51[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u186 (n52[11], n50[11], n51[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u187 (n52[12], n50[12], n51[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u188 (n52[13], n50[13], n51[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u189 (n52[14], n50[14], n51[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u19 (alu_data_mem_csr[3], n54[3], n55[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u190 (n52[15], n50[15], n51[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u191 (n52[16], n50[16], n51[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u192 (n52[17], n50[17], n51[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u193 (n52[18], n50[18], n51[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u194 (n52[19], n50[19], n51[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u195 (n52[20], n50[20], n51[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u196 (n52[21], n50[21], n51[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u197 (n52[22], n50[22], n51[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u198 (n52[23], n50[23], n51[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u199 (n52[24], n50[24], n51[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u2 (alu_data_mem_csr[8], n54[8], n55[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  and u20 (n13, n4, n12);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(75)
  or u200 (n52[25], n50[25], n51[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u201 (n52[26], n50[26], n51[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u202 (n52[27], n50[27], n51[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u203 (n52[28], n50[28], n51[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u204 (n52[29], n50[29], n51[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u205 (n52[30], n50[30], n51[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u206 (n52[31], n50[31], n51[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u207 (n52[32], n50[32], n51[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u208 (n52[33], n50[33], n51[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u209 (n52[34], n50[34], n51[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u21 (n14, n11, n13);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(75)
  or u210 (n52[35], n50[35], n51[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u211 (n52[36], n50[36], n51[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u212 (n52[37], n50[37], n51[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u213 (n52[38], n50[38], n51[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u214 (n52[39], n50[39], n51[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u215 (n52[40], n50[40], n51[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u216 (n52[41], n50[41], n51[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u217 (n52[42], n50[42], n51[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u218 (n52[43], n50[43], n51[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u219 (n52[44], n50[44], n51[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  and u22 (n15, n0, n14);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(75)
  or u220 (n52[45], n50[45], n51[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u221 (n52[46], n50[46], n51[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u222 (n52[47], n50[47], n51[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u223 (n52[48], n50[48], n51[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u224 (n52[49], n50[49], n51[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u225 (n52[50], n50[50], n51[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u226 (n52[51], n50[51], n51[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u227 (n52[52], n50[52], n51[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u228 (n52[53], n50[53], n51[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u229 (n52[54], n50[54], n51[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u23 (alu_data_mem_csr[2], n54[2], n55[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u230 (n52[55], n50[55], n51[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u231 (n52[56], n50[56], n51[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u232 (n52[57], n50[57], n51[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u233 (n52[58], n50[58], n51[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u234 (n52[59], n50[59], n51[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u235 (n52[60], n50[60], n51[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u236 (n52[61], n50[61], n51[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u237 (n52[62], n50[62], n51[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u238 (n52[63], n50[63], n51[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u239 (n50[1], n48[1], n49[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u24 (alu_data_mem_csr[1], n54[1], n55[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u240 (n50[2], n48[2], n49[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u241 (n50[3], n48[3], n49[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u242 (n50[4], n48[4], n49[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u243 (n50[5], n48[5], n49[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u244 (n50[6], n48[6], n49[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u245 (n50[7], n48[7], n49[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u246 (n50[8], n48[8], n49[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u247 (n50[9], n48[9], n49[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u248 (n50[10], n48[10], n49[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u249 (n50[11], n48[11], n49[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u25 (ds1_great_than_ds2, n15, n9);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(76)
  or u250 (n50[12], n48[12], n49[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u251 (n50[13], n48[13], n49[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u252 (n50[14], n48[14], n49[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u253 (n50[15], n48[15], n49[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u254 (n50[16], n48[16], n49[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u255 (n50[17], n48[17], n49[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u256 (n50[18], n48[18], n49[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u257 (n50[19], n48[19], n49[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u258 (n50[20], n48[20], n49[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u259 (n50[21], n48[21], n49[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  not u26 (n16[0], ds2[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(79)
  or u260 (n50[22], n48[22], n49[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u261 (n50[23], n48[23], n49[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u262 (n50[24], n48[24], n49[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u263 (n50[25], n48[25], n49[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u264 (n50[26], n48[26], n49[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u265 (n50[27], n48[27], n49[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u266 (n50[28], n48[28], n49[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u267 (n50[29], n48[29], n49[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u268 (n50[30], n48[30], n49[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u269 (n50[31], n48[31], n49[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  buf u27 (alu_add[0], add_64[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(82)
  or u270 (n50[32], n48[32], n49[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u271 (n50[33], n48[33], n49[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u272 (n50[34], n48[34], n49[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u273 (n50[35], n48[35], n49[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u274 (n50[36], n48[36], n49[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u275 (n50[37], n48[37], n49[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u276 (n50[38], n48[38], n49[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u277 (n50[39], n48[39], n49[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u278 (n50[40], n48[40], n49[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u279 (n50[41], n48[41], n49[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u28 (alu_data_mem_csr[0], n54[0], n55[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u280 (n50[42], n48[42], n49[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u281 (n50[43], n48[43], n49[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u282 (n50[44], n48[44], n49[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u283 (n50[45], n48[45], n49[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u284 (n50[46], n48[46], n49[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u285 (n50[47], n48[47], n49[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u286 (n50[48], n48[48], n49[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u287 (n50[49], n48[49], n49[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u288 (n50[50], n48[50], n49[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u289 (n50[51], n48[51], n49[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  buf u29 (alu_sub[0], sub_64[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(85)
  or u290 (n50[52], n48[52], n49[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u291 (n50[53], n48[53], n49[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u292 (n50[54], n48[54], n49[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u293 (n50[55], n48[55], n49[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u294 (n50[56], n48[56], n49[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u295 (n50[57], n48[57], n49[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u296 (n50[58], n48[58], n49[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u297 (n50[59], n48[59], n49[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u298 (n50[60], n48[60], n49[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u299 (n50[61], n48[61], n49[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u3 (alu_data_mem_csr[7], n54[7], n55[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  and u30 (alu_and[0], ds1[0], n18[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(87)
  or u300 (n50[62], n48[62], n49[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u301 (n50[63], n48[63], n49[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u302 (n48[1], n46[1], n47[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u303 (n48[2], n46[2], n47[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u304 (n48[3], n46[3], n47[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u305 (n48[4], n46[4], n47[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u306 (n48[5], n46[5], n47[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u307 (n48[6], n46[6], n47[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u308 (n48[7], n46[7], n47[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u309 (n48[8], n46[8], n47[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u31 (alu_or[0], ds1[0], ds2[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(88)
  or u310 (n48[9], n46[9], n47[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u311 (n48[10], n46[10], n47[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u312 (n48[11], n46[11], n47[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u313 (n48[12], n46[12], n47[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u314 (n48[13], n46[13], n47[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u315 (n48[14], n46[14], n47[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u316 (n48[15], n46[15], n47[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u317 (n48[16], n46[16], n47[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u318 (n48[17], n46[17], n47[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u319 (n48[18], n46[18], n47[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  xor u32 (alu_xor[0], ds1[0], ds2[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(89)
  or u320 (n48[19], n46[19], n47[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u321 (n48[20], n46[20], n47[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u322 (n48[21], n46[21], n47[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u323 (n48[22], n46[22], n47[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u324 (n48[23], n46[23], n47[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u325 (n48[24], n46[24], n47[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u326 (n48[25], n46[25], n47[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u327 (n48[26], n46[26], n47[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u328 (n48[27], n46[27], n47[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u329 (n48[28], n46[28], n47[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  and u33 (n19, beq, ds1_equal_ds2);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(92)
  or u330 (n48[29], n46[29], n47[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u331 (n48[30], n46[30], n47[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u332 (n48[31], n46[31], n47[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u333 (n48[32], n46[32], n47[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u334 (n48[33], n46[33], n47[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u335 (n48[34], n46[34], n47[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u336 (n48[35], n46[35], n47[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u337 (n48[36], n46[36], n47[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u338 (n48[37], n46[37], n47[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u339 (n48[38], n46[38], n47[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  not u34 (n20, ds1_equal_ds2);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(92)
  or u340 (n48[39], n46[39], n47[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u341 (n48[40], n46[40], n47[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u342 (n48[41], n46[41], n47[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u343 (n48[42], n46[42], n47[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u344 (n48[43], n46[43], n47[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u345 (n48[44], n46[44], n47[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u346 (n48[45], n46[45], n47[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u347 (n48[46], n46[46], n47[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u348 (n48[47], n46[47], n47[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u349 (n48[48], n46[48], n47[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  and u35 (n21, bne, n20);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(92)
  or u350 (n48[49], n46[49], n47[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u351 (n48[50], n46[50], n47[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u352 (n48[51], n46[51], n47[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u353 (n48[52], n46[52], n47[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u354 (n48[53], n46[53], n47[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u355 (n48[54], n46[54], n47[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u356 (n48[55], n46[55], n47[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u357 (n48[56], n46[56], n47[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u358 (n48[57], n46[57], n47[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u359 (n48[58], n46[58], n47[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u36 (n22, n19, n21);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(92)
  or u360 (n48[59], n46[59], n47[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u361 (n48[60], n46[60], n47[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u362 (n48[61], n46[61], n47[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u363 (n48[62], n46[62], n47[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u364 (n48[63], n46[63], n47[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u365 (n46[1], n44[1], n45[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u366 (n46[2], n44[2], n45[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u367 (n46[3], n44[3], n45[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u368 (n46[4], n44[4], n45[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u369 (n46[5], n44[5], n45[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  and u37 (n23, bge, ds1_great_than_ds2);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(92)
  or u370 (n46[6], n44[6], n45[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u371 (n46[7], n44[7], n45[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u372 (n46[8], n44[8], n45[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u373 (n46[9], n44[9], n45[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u374 (n46[10], n44[10], n45[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u375 (n46[11], n44[11], n45[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u376 (n46[12], n44[12], n45[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u377 (n46[13], n44[13], n45[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u378 (n46[14], n44[14], n45[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u379 (n46[15], n44[15], n45[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u38 (n24, n22, n23);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(92)
  or u380 (n46[16], n44[16], n45[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u381 (n46[17], n44[17], n45[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u382 (n46[18], n44[18], n45[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u383 (n46[19], n44[19], n45[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u384 (n46[20], n44[20], n45[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u385 (n46[21], n44[21], n45[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u386 (n46[22], n44[22], n45[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u387 (n46[23], n44[23], n45[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u388 (n46[24], n44[24], n45[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u389 (n46[25], n44[25], n45[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  and u39 (n25, blt, ds1_light_than_ds2);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(92)
  or u390 (n46[26], n44[26], n45[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u391 (n46[27], n44[27], n45[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u392 (n46[28], n44[28], n45[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u393 (n46[29], n44[29], n45[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u394 (n46[30], n44[30], n45[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u395 (n46[31], n44[31], n45[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u396 (n46[32], n44[32], n45[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u397 (n46[33], n44[33], n45[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u398 (n46[34], n44[34], n45[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u399 (n46[35], n44[35], n45[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  not u4 (n0, unsign);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(71)
  or u40 (n26, n24, n25);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(92)
  or u400 (n46[36], n44[36], n45[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u401 (n46[37], n44[37], n45[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u402 (n46[38], n44[38], n45[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u403 (n46[39], n44[39], n45[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u404 (n46[40], n44[40], n45[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u405 (n46[41], n44[41], n45[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u406 (n46[42], n44[42], n45[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u407 (n46[43], n44[43], n45[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u408 (n46[44], n44[44], n45[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u409 (n46[45], n44[45], n45[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  and u41 (n27, compare, n26);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(92)
  or u410 (n46[46], n44[46], n45[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u411 (n46[47], n44[47], n45[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u412 (n46[48], n44[48], n45[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u413 (n46[49], n44[49], n45[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u414 (n46[50], n44[50], n45[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u415 (n46[51], n44[51], n45[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u416 (n46[52], n44[52], n45[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u417 (n46[53], n44[53], n45[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u418 (n46[54], n44[54], n45[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u419 (n46[55], n44[55], n45[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u42 (jmp_ok, n27, jmp);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(92)
  or u420 (n46[56], n44[56], n45[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u421 (n46[57], n44[57], n45[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u422 (n46[58], n44[58], n45[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u423 (n46[59], n44[59], n45[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u424 (n46[60], n44[60], n45[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u425 (n46[61], n44[61], n45[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u426 (n46[62], n44[62], n45[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u427 (n46[63], n44[63], n45[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u428 (n44[1], n42[1], n43[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u429 (n44[2], n42[2], n43[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  buf u43 (alu_slt[0], ds1_light_than_ds2);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  or u430 (n44[3], n42[3], n43[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u431 (n44[4], n42[4], n43[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u432 (n44[5], n42[5], n43[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u433 (n44[6], n42[6], n43[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u434 (n44[7], n42[7], n43[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u435 (n44[8], n42[8], n43[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u436 (n44[9], n42[9], n43[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u437 (n44[10], n42[10], n43[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u438 (n44[11], n42[11], n43[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u439 (n44[12], n42[12], n43[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  buf u44 (alu_lr_sc[0], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  or u440 (n44[13], n42[13], n43[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u441 (n44[14], n42[14], n43[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u442 (n44[15], n42[15], n43[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u443 (n44[16], n42[16], n43[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u444 (n44[17], n42[17], n43[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u445 (n44[18], n42[18], n43[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u446 (n44[19], n42[19], n43[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u447 (n44[20], n42[20], n43[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u448 (n44[21], n42[21], n43[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u449 (n44[22], n42[22], n43[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u45 (n30[0], n28[0], n29[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u450 (n44[23], n42[23], n43[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u451 (n44[24], n42[24], n43[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u452 (n44[25], n42[25], n43[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u453 (n44[26], n42[26], n43[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u454 (n44[27], n42[27], n43[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u455 (n44[28], n42[28], n43[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u456 (n44[29], n42[29], n43[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u457 (n44[30], n42[30], n43[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u458 (n44[31], n42[31], n43[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u459 (n44[32], n42[32], n43[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u46 (n32[0], n30[0], n31[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u460 (n44[33], n42[33], n43[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u461 (n44[34], n42[34], n43[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u462 (n44[35], n42[35], n43[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u463 (n44[36], n42[36], n43[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u464 (n44[37], n42[37], n43[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u465 (n44[38], n42[38], n43[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u466 (n44[39], n42[39], n43[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u467 (n44[40], n42[40], n43[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u468 (n44[41], n42[41], n43[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u469 (n44[42], n42[42], n43[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u47 (n34[0], n32[0], n33[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u470 (n44[43], n42[43], n43[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u471 (n44[44], n42[44], n43[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u472 (n44[45], n42[45], n43[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u473 (n44[46], n42[46], n43[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u474 (n44[47], n42[47], n43[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u475 (n44[48], n42[48], n43[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u476 (n44[49], n42[49], n43[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u477 (n44[50], n42[50], n43[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u478 (n44[51], n42[51], n43[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u479 (n44[52], n42[52], n43[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u48 (n36[0], n34[0], n35[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u480 (n44[53], n42[53], n43[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u481 (n44[54], n42[54], n43[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u482 (n44[55], n42[55], n43[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u483 (n44[56], n42[56], n43[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u484 (n44[57], n42[57], n43[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u485 (n44[58], n42[58], n43[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u486 (n44[59], n42[59], n43[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u487 (n44[60], n42[60], n43[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u488 (n44[61], n42[61], n43[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u489 (n44[62], n42[62], n43[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u49 (n38[0], n36[0], n37[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u490 (n44[63], n42[63], n43[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u491 (alu_data_rd[1], n40[1], n41[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u492 (alu_data_rd[2], n40[2], n41[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u493 (alu_data_rd[3], n40[3], n41[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u494 (alu_data_rd[4], n40[4], n41[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u495 (alu_data_rd[5], n40[5], n41[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u496 (alu_data_rd[6], n40[6], n41[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u497 (alu_data_rd[7], n40[7], n41[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u498 (alu_data_rd[8], n40[8], n41[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u499 (alu_data_rd[9], n40[9], n41[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  not u5 (n1, ds2[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(71)
  or u50 (n40[0], n38[0], n39[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u500 (alu_data_rd[10], n40[10], n41[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u501 (alu_data_rd[11], n40[11], n41[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u502 (alu_data_rd[12], n40[12], n41[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u503 (alu_data_rd[13], n40[13], n41[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u504 (alu_data_rd[14], n40[14], n41[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u505 (alu_data_rd[15], n40[15], n41[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u506 (alu_data_rd[16], n40[16], n41[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u507 (alu_data_rd[17], n40[17], n41[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u508 (alu_data_rd[18], n40[18], n41[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u509 (alu_data_rd[19], n40[19], n41[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u51 (alu_data_rd[0], n40[0], n41[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u510 (alu_data_rd[20], n40[20], n41[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u511 (alu_data_rd[21], n40[21], n41[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u512 (alu_data_rd[22], n40[22], n41[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u513 (alu_data_rd[23], n40[23], n41[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u514 (alu_data_rd[24], n40[24], n41[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u515 (alu_data_rd[25], n40[25], n41[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u516 (alu_data_rd[26], n40[26], n41[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u517 (alu_data_rd[27], n40[27], n41[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u518 (alu_data_rd[28], n40[28], n41[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u519 (alu_data_rd[29], n40[29], n41[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u52 (n44[0], n42[0], n43[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(110)
  or u520 (alu_data_rd[30], n40[30], n41[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u521 (alu_data_rd[31], n40[31], n41[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u522 (alu_data_rd[32], n40[32], n41[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u523 (alu_data_rd[33], n40[33], n41[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u524 (alu_data_rd[34], n40[34], n41[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u525 (alu_data_rd[35], n40[35], n41[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u526 (alu_data_rd[36], n40[36], n41[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u527 (alu_data_rd[37], n40[37], n41[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u528 (alu_data_rd[38], n40[38], n41[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u529 (alu_data_rd[39], n40[39], n41[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u53 (n46[0], n44[0], n45[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(111)
  or u530 (alu_data_rd[40], n40[40], n41[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u531 (alu_data_rd[41], n40[41], n41[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u532 (alu_data_rd[42], n40[42], n41[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u533 (alu_data_rd[43], n40[43], n41[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u534 (alu_data_rd[44], n40[44], n41[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u535 (alu_data_rd[45], n40[45], n41[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u536 (alu_data_rd[46], n40[46], n41[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u537 (alu_data_rd[47], n40[47], n41[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u538 (alu_data_rd[48], n40[48], n41[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u539 (alu_data_rd[49], n40[49], n41[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u54 (n48[0], n46[0], n47[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(112)
  or u540 (alu_data_rd[50], n40[50], n41[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u541 (alu_data_rd[51], n40[51], n41[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u542 (alu_data_rd[52], n40[52], n41[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u543 (alu_data_rd[53], n40[53], n41[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u544 (alu_data_rd[54], n40[54], n41[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u545 (alu_data_rd[55], n40[55], n41[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u546 (alu_data_rd[56], n40[56], n41[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u547 (alu_data_rd[57], n40[57], n41[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u548 (alu_data_rd[58], n40[58], n41[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u549 (alu_data_rd[59], n40[59], n41[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u55 (n50[0], n48[0], n49[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(113)
  or u550 (alu_data_rd[60], n40[60], n41[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u551 (alu_data_rd[61], n40[61], n41[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u552 (alu_data_rd[62], n40[62], n41[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u553 (alu_data_rd[63], n40[63], n41[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(106)
  or u554 (n40[1], n38[1], n39[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u555 (n40[2], n38[2], n39[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u556 (n40[3], n38[3], n39[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u557 (n40[4], n38[4], n39[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u558 (n40[5], n38[5], n39[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u559 (n40[6], n38[6], n39[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u56 (n52[0], n50[0], n51[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(114)
  or u560 (n40[7], n38[7], n39[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u561 (n40[8], n38[8], n39[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u562 (n40[9], n38[9], n39[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u563 (n40[10], n38[10], n39[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u564 (n40[11], n38[11], n39[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u565 (n40[12], n38[12], n39[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u566 (n40[13], n38[13], n39[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u567 (n40[14], n38[14], n39[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u568 (n40[15], n38[15], n39[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u569 (n40[16], n38[16], n39[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u57 (n54[0], n52[0], n53[0]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(115)
  or u570 (n40[17], n38[17], n39[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u571 (n40[18], n38[18], n39[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u572 (n40[19], n38[19], n39[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u573 (n40[20], n38[20], n39[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u574 (n40[21], n38[21], n39[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u575 (n40[22], n38[22], n39[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u576 (n40[23], n38[23], n39[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u577 (n40[24], n38[24], n39[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u578 (n40[25], n38[25], n39[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u579 (n40[26], n38[26], n39[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u58 (alu_data_mem_csr[9], n54[9], n55[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u580 (n40[27], n38[27], n39[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u581 (n40[28], n38[28], n39[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u582 (n40[29], n38[29], n39[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u583 (n40[30], n38[30], n39[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u584 (n40[31], n38[31], n39[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u585 (n40[32], n38[32], n39[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u586 (n40[33], n38[33], n39[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u587 (n40[34], n38[34], n39[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u588 (n40[35], n38[35], n39[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u589 (n40[36], n38[36], n39[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u59 (alu_data_mem_csr[10], n54[10], n55[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u590 (n40[37], n38[37], n39[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u591 (n40[38], n38[38], n39[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u592 (n40[39], n38[39], n39[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u593 (n40[40], n38[40], n39[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u594 (n40[41], n38[41], n39[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u595 (n40[42], n38[42], n39[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u596 (n40[43], n38[43], n39[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u597 (n40[44], n38[44], n39[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u598 (n40[45], n38[45], n39[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u599 (n40[46], n38[46], n39[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  and u6 (n2, ds1[63], n1);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(71)
  or u60 (alu_data_mem_csr[11], n54[11], n55[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u600 (n40[47], n38[47], n39[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u601 (n40[48], n38[48], n39[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u602 (n40[49], n38[49], n39[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u603 (n40[50], n38[50], n39[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u604 (n40[51], n38[51], n39[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u605 (n40[52], n38[52], n39[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u606 (n40[53], n38[53], n39[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u607 (n40[54], n38[54], n39[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u608 (n40[55], n38[55], n39[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u609 (n40[56], n38[56], n39[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u61 (alu_data_mem_csr[12], n54[12], n55[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u610 (n40[57], n38[57], n39[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u611 (n40[58], n38[58], n39[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u612 (n40[59], n38[59], n39[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u613 (n40[60], n38[60], n39[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u614 (n40[61], n38[61], n39[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u615 (n40[62], n38[62], n39[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u616 (n40[63], n38[63], n39[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(105)
  or u617 (n38[1], n36[1], n37[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u618 (n38[2], n36[2], n37[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u619 (n38[3], n36[3], n37[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u62 (alu_data_mem_csr[13], n54[13], n55[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u620 (n38[4], n36[4], n37[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u621 (n38[5], n36[5], n37[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u622 (n38[6], n36[6], n37[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u623 (n38[7], n36[7], n37[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u624 (n38[8], n36[8], n37[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u625 (n38[9], n36[9], n37[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u626 (n38[10], n36[10], n37[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u627 (n38[11], n36[11], n37[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u628 (n38[12], n36[12], n37[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u629 (n38[13], n36[13], n37[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u63 (alu_data_mem_csr[14], n54[14], n55[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u630 (n38[14], n36[14], n37[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u631 (n38[15], n36[15], n37[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u632 (n38[16], n36[16], n37[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u633 (n38[17], n36[17], n37[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u634 (n38[18], n36[18], n37[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u635 (n38[19], n36[19], n37[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u636 (n38[20], n36[20], n37[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u637 (n38[21], n36[21], n37[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u638 (n38[22], n36[22], n37[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u639 (n38[23], n36[23], n37[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u64 (alu_data_mem_csr[15], n54[15], n55[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u640 (n38[24], n36[24], n37[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u641 (n38[25], n36[25], n37[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u642 (n38[26], n36[26], n37[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u643 (n38[27], n36[27], n37[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u644 (n38[28], n36[28], n37[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u645 (n38[29], n36[29], n37[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u646 (n38[30], n36[30], n37[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u647 (n38[31], n36[31], n37[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u648 (n38[32], n36[32], n37[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u649 (n38[33], n36[33], n37[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u65 (alu_data_mem_csr[16], n54[16], n55[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u650 (n38[34], n36[34], n37[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u651 (n38[35], n36[35], n37[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u652 (n38[36], n36[36], n37[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u653 (n38[37], n36[37], n37[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u654 (n38[38], n36[38], n37[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u655 (n38[39], n36[39], n37[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u656 (n38[40], n36[40], n37[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u657 (n38[41], n36[41], n37[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u658 (n38[42], n36[42], n37[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u659 (n38[43], n36[43], n37[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u66 (alu_data_mem_csr[17], n54[17], n55[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u660 (n38[44], n36[44], n37[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u661 (n38[45], n36[45], n37[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u662 (n38[46], n36[46], n37[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u663 (n38[47], n36[47], n37[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u664 (n38[48], n36[48], n37[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u665 (n38[49], n36[49], n37[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u666 (n38[50], n36[50], n37[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u667 (n38[51], n36[51], n37[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u668 (n38[52], n36[52], n37[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u669 (n38[53], n36[53], n37[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u67 (alu_data_mem_csr[18], n54[18], n55[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u670 (n38[54], n36[54], n37[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u671 (n38[55], n36[55], n37[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u672 (n38[56], n36[56], n37[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u673 (n38[57], n36[57], n37[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u674 (n38[58], n36[58], n37[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u675 (n38[59], n36[59], n37[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u676 (n38[60], n36[60], n37[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u677 (n38[61], n36[61], n37[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u678 (n38[62], n36[62], n37[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u679 (n38[63], n36[63], n37[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(104)
  or u68 (alu_data_mem_csr[19], n54[19], n55[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u680 (n36[1], n34[1], n35[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u681 (n36[2], n34[2], n35[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u682 (n36[3], n34[3], n35[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u683 (n36[4], n34[4], n35[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u684 (n36[5], n34[5], n35[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u685 (n36[6], n34[6], n35[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u686 (n36[7], n34[7], n35[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u687 (n36[8], n34[8], n35[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u688 (n36[9], n34[9], n35[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u689 (n36[10], n34[10], n35[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u69 (alu_data_mem_csr[20], n54[20], n55[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u690 (n36[11], n34[11], n35[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u691 (n36[12], n34[12], n35[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u692 (n36[13], n34[13], n35[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u693 (n36[14], n34[14], n35[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u694 (n36[15], n34[15], n35[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u695 (n36[16], n34[16], n35[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u696 (n36[17], n34[17], n35[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u697 (n36[18], n34[18], n35[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u698 (n36[19], n34[19], n35[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u699 (n36[20], n34[20], n35[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  xor u7 (n3, ds1[63], ds2[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(72)
  or u70 (alu_data_mem_csr[21], n54[21], n55[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u700 (n36[21], n34[21], n35[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u701 (n36[22], n34[22], n35[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u702 (n36[23], n34[23], n35[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u703 (n36[24], n34[24], n35[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u704 (n36[25], n34[25], n35[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u705 (n36[26], n34[26], n35[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u706 (n36[27], n34[27], n35[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u707 (n36[28], n34[28], n35[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u708 (n36[29], n34[29], n35[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u709 (n36[30], n34[30], n35[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u71 (alu_data_mem_csr[22], n54[22], n55[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u710 (n36[31], n34[31], n35[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u711 (n36[32], n34[32], n35[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u712 (n36[33], n34[33], n35[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u713 (n36[34], n34[34], n35[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u714 (n36[35], n34[35], n35[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u715 (n36[36], n34[36], n35[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u716 (n36[37], n34[37], n35[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u717 (n36[38], n34[38], n35[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u718 (n36[39], n34[39], n35[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u719 (n36[40], n34[40], n35[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u72 (alu_data_mem_csr[23], n54[23], n55[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u720 (n36[41], n34[41], n35[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u721 (n36[42], n34[42], n35[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u722 (n36[43], n34[43], n35[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u723 (n36[44], n34[44], n35[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u724 (n36[45], n34[45], n35[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u725 (n36[46], n34[46], n35[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u726 (n36[47], n34[47], n35[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u727 (n36[48], n34[48], n35[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u728 (n36[49], n34[49], n35[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u729 (n36[50], n34[50], n35[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u73 (alu_data_mem_csr[24], n54[24], n55[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u730 (n36[51], n34[51], n35[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u731 (n36[52], n34[52], n35[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u732 (n36[53], n34[53], n35[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u733 (n36[54], n34[54], n35[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u734 (n36[55], n34[55], n35[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u735 (n36[56], n34[56], n35[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u736 (n36[57], n34[57], n35[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u737 (n36[58], n34[58], n35[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u738 (n36[59], n34[59], n35[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u739 (n36[60], n34[60], n35[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u74 (alu_data_mem_csr[25], n54[25], n55[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u740 (n36[61], n34[61], n35[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u741 (n36[62], n34[62], n35[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u742 (n36[63], n34[63], n35[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(103)
  or u743 (n34[1], n32[1], n33[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u744 (n34[2], n32[2], n33[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u745 (n34[3], n32[3], n33[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u746 (n34[4], n32[4], n33[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u747 (n34[5], n32[5], n33[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u748 (n34[6], n32[6], n33[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u749 (n34[7], n32[7], n33[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u75 (alu_data_mem_csr[26], n54[26], n55[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u750 (n34[8], n32[8], n33[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u751 (n34[9], n32[9], n33[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u752 (n34[10], n32[10], n33[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u753 (n34[11], n32[11], n33[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u754 (n34[12], n32[12], n33[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u755 (n34[13], n32[13], n33[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u756 (n34[14], n32[14], n33[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u757 (n34[15], n32[15], n33[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u758 (n34[16], n32[16], n33[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u759 (n34[17], n32[17], n33[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u76 (alu_data_mem_csr[27], n54[27], n55[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u760 (n34[18], n32[18], n33[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u761 (n34[19], n32[19], n33[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u762 (n34[20], n32[20], n33[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u763 (n34[21], n32[21], n33[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u764 (n34[22], n32[22], n33[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u765 (n34[23], n32[23], n33[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u766 (n34[24], n32[24], n33[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u767 (n34[25], n32[25], n33[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u768 (n34[26], n32[26], n33[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u769 (n34[27], n32[27], n33[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u77 (alu_data_mem_csr[28], n54[28], n55[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u770 (n34[28], n32[28], n33[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u771 (n34[29], n32[29], n33[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u772 (n34[30], n32[30], n33[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u773 (n34[31], n32[31], n33[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u774 (n34[32], n32[32], n33[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u775 (n34[33], n32[33], n33[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u776 (n34[34], n32[34], n33[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u777 (n34[35], n32[35], n33[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u778 (n34[36], n32[36], n33[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u779 (n34[37], n32[37], n33[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u78 (alu_data_mem_csr[29], n54[29], n55[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u780 (n34[38], n32[38], n33[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u781 (n34[39], n32[39], n33[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u782 (n34[40], n32[40], n33[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u783 (n34[41], n32[41], n33[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u784 (n34[42], n32[42], n33[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u785 (n34[43], n32[43], n33[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u786 (n34[44], n32[44], n33[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u787 (n34[45], n32[45], n33[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u788 (n34[46], n32[46], n33[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u789 (n34[47], n32[47], n33[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u79 (alu_data_mem_csr[30], n54[30], n55[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u790 (n34[48], n32[48], n33[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u791 (n34[49], n32[49], n33[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u792 (n34[50], n32[50], n33[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u793 (n34[51], n32[51], n33[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u794 (n34[52], n32[52], n33[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u795 (n34[53], n32[53], n33[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u796 (n34[54], n32[54], n33[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u797 (n34[55], n32[55], n33[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u798 (n34[56], n32[56], n33[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u799 (n34[57], n32[57], n33[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  not u8 (n4, n3);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(72)
  or u80 (alu_data_mem_csr[31], n54[31], n55[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u800 (n34[58], n32[58], n33[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u801 (n34[59], n32[59], n33[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u802 (n34[60], n32[60], n33[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u803 (n34[61], n32[61], n33[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u804 (n34[62], n32[62], n33[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u805 (n34[63], n32[63], n33[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(102)
  or u806 (n32[1], n30[1], n31[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u807 (n32[2], n30[2], n31[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u808 (n32[3], n30[3], n31[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u809 (n32[4], n30[4], n31[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u81 (alu_data_mem_csr[32], n54[32], n55[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u810 (n32[5], n30[5], n31[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u811 (n32[6], n30[6], n31[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u812 (n32[7], n30[7], n31[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u813 (n32[8], n30[8], n31[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u814 (n32[9], n30[9], n31[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u815 (n32[10], n30[10], n31[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u816 (n32[11], n30[11], n31[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u817 (n32[12], n30[12], n31[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u818 (n32[13], n30[13], n31[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u819 (n32[14], n30[14], n31[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u82 (alu_data_mem_csr[33], n54[33], n55[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u820 (n32[15], n30[15], n31[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u821 (n32[16], n30[16], n31[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u822 (n32[17], n30[17], n31[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u823 (n32[18], n30[18], n31[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u824 (n32[19], n30[19], n31[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u825 (n32[20], n30[20], n31[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u826 (n32[21], n30[21], n31[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u827 (n32[22], n30[22], n31[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u828 (n32[23], n30[23], n31[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u829 (n32[24], n30[24], n31[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u83 (alu_data_mem_csr[34], n54[34], n55[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u830 (n32[25], n30[25], n31[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u831 (n32[26], n30[26], n31[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u832 (n32[27], n30[27], n31[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u833 (n32[28], n30[28], n31[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u834 (n32[29], n30[29], n31[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u835 (n32[30], n30[30], n31[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u836 (n32[31], n30[31], n31[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u837 (n32[32], n30[32], n31[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u838 (n32[33], n30[33], n31[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u839 (n32[34], n30[34], n31[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u84 (alu_data_mem_csr[35], n54[35], n55[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u840 (n32[35], n30[35], n31[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u841 (n32[36], n30[36], n31[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u842 (n32[37], n30[37], n31[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u843 (n32[38], n30[38], n31[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u844 (n32[39], n30[39], n31[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u845 (n32[40], n30[40], n31[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u846 (n32[41], n30[41], n31[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u847 (n32[42], n30[42], n31[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u848 (n32[43], n30[43], n31[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u849 (n32[44], n30[44], n31[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u85 (alu_data_mem_csr[36], n54[36], n55[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u850 (n32[45], n30[45], n31[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u851 (n32[46], n30[46], n31[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u852 (n32[47], n30[47], n31[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u853 (n32[48], n30[48], n31[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u854 (n32[49], n30[49], n31[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u855 (n32[50], n30[50], n31[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u856 (n32[51], n30[51], n31[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u857 (n32[52], n30[52], n31[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u858 (n32[53], n30[53], n31[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u859 (n32[54], n30[54], n31[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u86 (alu_data_mem_csr[37], n54[37], n55[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u860 (n32[55], n30[55], n31[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u861 (n32[56], n30[56], n31[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u862 (n32[57], n30[57], n31[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u863 (n32[58], n30[58], n31[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u864 (n32[59], n30[59], n31[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u865 (n32[60], n30[60], n31[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u866 (n32[61], n30[61], n31[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u867 (n32[62], n30[62], n31[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u868 (n32[63], n30[63], n31[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(101)
  or u869 (n30[1], n28[1], n29[1]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u87 (alu_data_mem_csr[38], n54[38], n55[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u870 (n30[2], n28[2], n29[2]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u871 (n30[3], n28[3], n29[3]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u872 (n30[4], n28[4], n29[4]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u873 (n30[5], n28[5], n29[5]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u874 (n30[6], n28[6], n29[6]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u875 (n30[7], n28[7], n29[7]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u876 (n30[8], n28[8], n29[8]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u877 (n30[9], n28[9], n29[9]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u878 (n30[10], n28[10], n29[10]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u879 (n30[11], n28[11], n29[11]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u88 (alu_data_mem_csr[39], n54[39], n55[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u880 (n30[12], n28[12], n29[12]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u881 (n30[13], n28[13], n29[13]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u882 (n30[14], n28[14], n29[14]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u883 (n30[15], n28[15], n29[15]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u884 (n30[16], n28[16], n29[16]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u885 (n30[17], n28[17], n29[17]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u886 (n30[18], n28[18], n29[18]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u887 (n30[19], n28[19], n29[19]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u888 (n30[20], n28[20], n29[20]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u889 (n30[21], n28[21], n29[21]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u89 (alu_data_mem_csr[40], n54[40], n55[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u890 (n30[22], n28[22], n29[22]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u891 (n30[23], n28[23], n29[23]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u892 (n30[24], n28[24], n29[24]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u893 (n30[25], n28[25], n29[25]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u894 (n30[26], n28[26], n29[26]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u895 (n30[27], n28[27], n29[27]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u896 (n30[28], n28[28], n29[28]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u897 (n30[29], n28[29], n29[29]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u898 (n30[30], n28[30], n29[30]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u899 (n30[31], n28[31], n29[31]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  and u9 (n6, n4, n5);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(72)
  or u90 (alu_data_mem_csr[41], n54[41], n55[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u900 (n30[32], n28[32], n29[32]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u901 (n30[33], n28[33], n29[33]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u902 (n30[34], n28[34], n29[34]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u903 (n30[35], n28[35], n29[35]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u904 (n30[36], n28[36], n29[36]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u905 (n30[37], n28[37], n29[37]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u906 (n30[38], n28[38], n29[38]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u907 (n30[39], n28[39], n29[39]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u908 (n30[40], n28[40], n29[40]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u909 (n30[41], n28[41], n29[41]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u91 (alu_data_mem_csr[42], n54[42], n55[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u910 (n30[42], n28[42], n29[42]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u911 (n30[43], n28[43], n29[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u912 (n30[44], n28[44], n29[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u913 (n30[45], n28[45], n29[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u914 (n30[46], n28[46], n29[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u915 (n30[47], n28[47], n29[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u916 (n30[48], n28[48], n29[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u917 (n30[49], n28[49], n29[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u918 (n30[50], n28[50], n29[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u919 (n30[51], n28[51], n29[51]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u92 (alu_data_mem_csr[43], n54[43], n55[43]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u920 (n30[52], n28[52], n29[52]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u921 (n30[53], n28[53], n29[53]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u922 (n30[54], n28[54], n29[54]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u923 (n30[55], n28[55], n29[55]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u924 (n30[56], n28[56], n29[56]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u925 (n30[57], n28[57], n29[57]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u926 (n30[58], n28[58], n29[58]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u927 (n30[59], n28[59], n29[59]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u928 (n30[60], n28[60], n29[60]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u929 (n30[61], n28[61], n29[61]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u93 (alu_data_mem_csr[44], n54[44], n55[44]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  or u930 (n30[62], n28[62], n29[62]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  or u931 (n30[63], n28[63], n29[63]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(100)
  buf u932 (alu_lr_sc[1], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u933 (alu_lr_sc[2], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u934 (alu_lr_sc[3], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u935 (alu_lr_sc[4], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u936 (alu_lr_sc[5], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u937 (alu_lr_sc[6], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u938 (alu_lr_sc[7], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u939 (alu_lr_sc[8], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  or u94 (alu_data_mem_csr[45], n54[45], n55[45]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u940 (alu_lr_sc[9], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u941 (alu_lr_sc[10], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u942 (alu_lr_sc[11], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u943 (alu_lr_sc[12], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u944 (alu_lr_sc[13], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u945 (alu_lr_sc[14], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u946 (alu_lr_sc[15], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u947 (alu_lr_sc[16], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u948 (alu_lr_sc[17], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u949 (alu_lr_sc[18], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  or u95 (alu_data_mem_csr[46], n54[46], n55[46]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u950 (alu_lr_sc[19], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u951 (alu_lr_sc[20], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u952 (alu_lr_sc[21], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u953 (alu_lr_sc[22], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u954 (alu_lr_sc[23], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u955 (alu_lr_sc[24], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u956 (alu_lr_sc[25], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u957 (alu_lr_sc[26], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u958 (alu_lr_sc[27], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u959 (alu_lr_sc[28], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  or u96 (alu_data_mem_csr[47], n54[47], n55[47]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u960 (alu_lr_sc[29], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u961 (alu_lr_sc[30], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u962 (alu_lr_sc[31], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u963 (alu_lr_sc[32], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u964 (alu_lr_sc[33], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u965 (alu_lr_sc[34], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u966 (alu_lr_sc[35], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u967 (alu_lr_sc[36], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u968 (alu_lr_sc[37], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u969 (alu_lr_sc[38], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  or u97 (alu_data_mem_csr[48], n54[48], n55[48]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u970 (alu_lr_sc[39], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u971 (alu_lr_sc[40], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u972 (alu_lr_sc[41], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u973 (alu_lr_sc[42], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u974 (alu_lr_sc[43], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u975 (alu_lr_sc[44], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u976 (alu_lr_sc[45], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u977 (alu_lr_sc[46], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u978 (alu_lr_sc[47], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u979 (alu_lr_sc[48], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  or u98 (alu_data_mem_csr[49], n54[49], n55[49]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u980 (alu_lr_sc[49], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u981 (alu_lr_sc[50], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u982 (alu_lr_sc[51], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u983 (alu_lr_sc[52], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u984 (alu_lr_sc[53], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u985 (alu_lr_sc[54], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u986 (alu_lr_sc[55], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u987 (alu_lr_sc[56], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u988 (alu_lr_sc[57], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u989 (alu_lr_sc[58], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  or u99 (alu_data_mem_csr[50], n54[50], n55[50]);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(116)
  buf u990 (alu_lr_sc[59], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u991 (alu_lr_sc[60], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u992 (alu_lr_sc[61], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u993 (alu_lr_sc[62], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u994 (alu_lr_sc[63], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(94)
  buf u995 (alu_slt[1], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u996 (alu_slt[2], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u997 (alu_slt[3], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u998 (alu_slt[4], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)
  buf u999 (alu_slt[5], 1'b0);  // ../../RTL/CPU/EX/ALU&AU/alu_au.v(90)

endmodule 

module eq_w3
  (
  i0,
  i1,
  o
  );

  input [2:0] i0;
  input [2:0] i1;
  output o;



endmodule 

module eq_w4
  (
  i0,
  i1,
  o
  );

  input [3:0] i0;
  input [3:0] i1;
  output o;



endmodule 

module eq_w8
  (
  i0,
  i1,
  o
  );

  input [7:0] i0;
  input [7:0] i1;
  output o;



endmodule 

module lsu  // ../../RTL/CPU/EX/LSU/lsu.v(3)
  (
  addr,
  data_in,
  data_read,
  size,
  uncache_data,
  unsign,
  data_lsu_cache,
  data_lsu_uncache,
  data_write
  );

  input [2:0] addr;  // ../../RTL/CPU/EX/LSU/lsu.v(6)
  input [63:0] data_in;  // ../../RTL/CPU/EX/LSU/lsu.v(9)
  input [63:0] data_read;  // ../../RTL/CPU/EX/LSU/lsu.v(15)
  input [3:0] size;  // ../../RTL/CPU/EX/LSU/lsu.v(7)
  input [63:0] uncache_data;  // ../../RTL/CPU/EX/LSU/lsu.v(16)
  input unsign;  // ../../RTL/CPU/EX/LSU/lsu.v(5)
  output [63:0] data_lsu_cache;  // ../../RTL/CPU/EX/LSU/lsu.v(11)
  output [63:0] data_lsu_uncache;  // ../../RTL/CPU/EX/LSU/lsu.v(10)
  output [63:0] data_write;  // ../../RTL/CPU/EX/LSU/lsu.v(14)

  parameter offest0 = 3'b000;
  parameter offest1 = 3'b001;
  parameter offest2 = 3'b010;
  parameter offest3 = 3'b011;
  parameter offest4 = 3'b100;
  parameter offest5 = 3'b101;
  parameter offest6 = 3'b110;
  parameter offest7 = 3'b111;
  wire [63:0] data_lsu_cache_shift;  // ../../RTL/CPU/EX/LSU/lsu.v(28)
  wire [63:0] data_lsu_uncache_shift;  // ../../RTL/CPU/EX/LSU/lsu.v(29)
  wire [63:0] n1;
  wire [63:0] n10;
  wire [63:0] n12;
  wire [63:0] n13;
  wire [63:0] n15;
  wire [63:0] n16;
  wire [63:0] n18;
  wire [63:0] n19;
  wire [63:0] n21;
  wire [63:0] n22;
  wire [55:0] n23;
  wire [63:0] n24;
  wire [47:0] n25;
  wire [63:0] n26;
  wire [39:0] n27;
  wire [63:0] n28;
  wire [31:0] n29;
  wire [63:0] n3;
  wire [63:0] n30;
  wire [23:0] n31;
  wire [63:0] n32;
  wire [15:0] n33;
  wire [63:0] n34;
  wire [7:0] n35;
  wire [63:0] n36;
  wire [55:0] n37;
  wire [63:0] n38;
  wire [47:0] n39;
  wire [63:0] n4;
  wire [63:0] n40;
  wire [39:0] n41;
  wire [63:0] n42;
  wire [31:0] n43;
  wire [63:0] n44;
  wire [23:0] n45;
  wire [63:0] n46;
  wire [15:0] n47;
  wire [63:0] n48;
  wire [7:0] n49;
  wire [63:0] n52;
  wire [63:0] n54;
  wire [63:0] n55;
  wire [63:0] n57;
  wire [63:0] n58;
  wire [63:0] n59;
  wire [63:0] n6;
  wire [63:0] n60;
  wire [63:0] n61;
  wire [63:0] n62;
  wire [63:0] n63;
  wire [63:0] n64;
  wire [63:0] n65;
  wire [63:0] n7;
  wire [63:0] n9;
  wire n0;
  wire n11;
  wire n14;
  wire n17;
  wire n2;
  wire n20;
  wire n5;
  wire n50;
  wire n51;
  wire n53;
  wire n56;
  wire n8;

  eq_w3 eq0 (
    .i0(addr),
    .i1(3'b000),
    .o(n0));  // ../../RTL/CPU/EX/LSU/lsu.v(32)
  eq_w3 eq1 (
    .i0(addr),
    .i1(3'b001),
    .o(n2));  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  eq_w3 eq2 (
    .i0(addr),
    .i1(3'b010),
    .o(n5));  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  eq_w3 eq3 (
    .i0(addr),
    .i1(3'b011),
    .o(n8));  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  eq_w3 eq4 (
    .i0(addr),
    .i1(3'b100),
    .o(n11));  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  eq_w3 eq5 (
    .i0(addr),
    .i1(3'b101),
    .o(n14));  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  eq_w3 eq6 (
    .i0(addr),
    .i1(3'b110),
    .o(n17));  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  eq_w3 eq7 (
    .i0(addr),
    .i1(3'b111),
    .o(n20));  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  binary_mux_s1_w64 mux0 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(data_in),
    .sel(n0),
    .o(n1));  // ../../RTL/CPU/EX/LSU/lsu.v(32)
  binary_mux_s1_w64 mux1 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_in[55:0],8'b00000000}),
    .sel(n2),
    .o(n3));  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  binary_mux_s1_w48 mux10 (
    .i0(48'b000000000000000000000000000000000000000000000000),
    .i1(uncache_data[63:16]),
    .sel(n5),
    .o(n25));  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  binary_mux_s1_w40 mux11 (
    .i0(40'b0000000000000000000000000000000000000000),
    .i1(uncache_data[63:24]),
    .sel(n8),
    .o(n27));  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  binary_mux_s1_w32 mux12 (
    .i0(32'b00000000000000000000000000000000),
    .i1(uncache_data[63:32]),
    .sel(n11),
    .o(n29));  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  binary_mux_s1_w24 mux13 (
    .i0(24'b000000000000000000000000),
    .i1(uncache_data[63:40]),
    .sel(n14),
    .o(n31));  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  binary_mux_s1_w16 mux14 (
    .i0(16'b0000000000000000),
    .i1(uncache_data[63:48]),
    .sel(n17),
    .o(n33));  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  binary_mux_s1_w8 mux15 (
    .i0(8'b00000000),
    .i1(uncache_data[63:56]),
    .sel(n20),
    .o(n35));  // ../../RTL/CPU/EX/LSU/lsu.v(49)
  binary_mux_s1_w64 mux16 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(data_read),
    .sel(n0),
    .o({data_lsu_cache_shift[63:56],n36[55:0]}));  // ../../RTL/CPU/EX/LSU/lsu.v(51)
  binary_mux_s1_w56 mux17 (
    .i0(56'b00000000000000000000000000000000000000000000000000000000),
    .i1(data_read[63:8]),
    .sel(n2),
    .o(n37));  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  binary_mux_s1_w48 mux18 (
    .i0(48'b000000000000000000000000000000000000000000000000),
    .i1(data_read[63:16]),
    .sel(n5),
    .o(n39));  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  binary_mux_s1_w40 mux19 (
    .i0(40'b0000000000000000000000000000000000000000),
    .i1(data_read[63:24]),
    .sel(n8),
    .o(n41));  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  binary_mux_s1_w64 mux2 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_in[47:0],16'b0000000000000000}),
    .sel(n5),
    .o(n6));  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  binary_mux_s1_w32 mux20 (
    .i0(32'b00000000000000000000000000000000),
    .i1(data_read[63:32]),
    .sel(n11),
    .o(n43));  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  binary_mux_s1_w24 mux21 (
    .i0(24'b000000000000000000000000),
    .i1(data_read[63:40]),
    .sel(n14),
    .o(n45));  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  binary_mux_s1_w16 mux22 (
    .i0(16'b0000000000000000),
    .i1(data_read[63:48]),
    .sel(n17),
    .o(n47));  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  binary_mux_s1_w8 mux23 (
    .i0(8'b00000000),
    .i1(data_read[63:56]),
    .sel(n20),
    .o(n49));  // ../../RTL/CPU/EX/LSU/lsu.v(58)
  binary_mux_s1_w64 mux24 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7],data_lsu_uncache_shift[7:0]}),
    .sel(n51),
    .o(n52));  // ../../RTL/CPU/EX/LSU/lsu.v(61)
  binary_mux_s1_w64 mux25 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15],data_lsu_uncache_shift[15:0]}),
    .sel(n53),
    .o(n54));  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  binary_mux_s1_w64 mux26 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31],data_lsu_uncache_shift[31:0]}),
    .sel(n56),
    .o(n57));  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  binary_mux_s1_w64 mux27 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(data_lsu_uncache_shift),
    .sel(unsign),
    .o(n59));  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  binary_mux_s1_w64 mux28 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7],data_lsu_cache_shift[7:0]}),
    .sel(n51),
    .o(n60));  // ../../RTL/CPU/EX/LSU/lsu.v(67)
  binary_mux_s1_w64 mux29 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15],data_lsu_cache_shift[15:0]}),
    .sel(n53),
    .o(n61));  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  binary_mux_s1_w64 mux3 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_in[39:0],24'b000000000000000000000000}),
    .sel(n8),
    .o(n9));  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  binary_mux_s1_w64 mux30 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31],data_lsu_cache_shift[31:0]}),
    .sel(n56),
    .o(n63));  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  binary_mux_s1_w64 mux31 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(data_lsu_cache_shift),
    .sel(unsign),
    .o(n65));  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  binary_mux_s1_w64 mux4 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_in[31:0],32'b00000000000000000000000000000000}),
    .sel(n11),
    .o(n12));  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  binary_mux_s1_w64 mux5 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_in[23:0],40'b0000000000000000000000000000000000000000}),
    .sel(n14),
    .o(n15));  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  binary_mux_s1_w64 mux6 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_in[15:0],48'b000000000000000000000000000000000000000000000000}),
    .sel(n17),
    .o(n18));  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  binary_mux_s1_w64 mux7 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1({data_in[7:0],56'b00000000000000000000000000000000000000000000000000000000}),
    .sel(n20),
    .o(n21));  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  binary_mux_s1_w64 mux8 (
    .i0(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .i1(uncache_data),
    .sel(n0),
    .o({data_lsu_uncache_shift[63:56],n22[55:0]}));  // ../../RTL/CPU/EX/LSU/lsu.v(42)
  binary_mux_s1_w56 mux9 (
    .i0(56'b00000000000000000000000000000000000000000000000000000000),
    .i1(uncache_data[63:8]),
    .sel(n2),
    .o(n23));  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u10 (data_lsu_cache[23], n64[23], n65[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u100 (n64[5], n62[5], n63[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1000 (n16[30], n13[30], n15[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1001 (n16[31], n13[31], n15[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1002 (n16[32], n13[32], n15[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1003 (n16[33], n13[33], n15[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1004 (n16[34], n13[34], n15[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1005 (n16[35], n13[35], n15[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1006 (n16[36], n13[36], n15[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1007 (n16[37], n13[37], n15[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1008 (n16[38], n13[38], n15[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1009 (n16[39], n13[39], n15[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u101 (n64[6], n62[6], n63[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1010 (n16[40], n13[40], n15[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1011 (n16[41], n13[41], n15[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1012 (n16[42], n13[42], n15[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1013 (n16[43], n13[43], n15[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1014 (n16[44], n13[44], n15[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1015 (n16[45], n13[45], n15[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1016 (n16[46], n13[46], n15[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1017 (n16[47], n13[47], n15[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1018 (n16[48], n13[48], n15[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1019 (n16[49], n13[49], n15[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u102 (n64[7], n62[7], n63[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1020 (n16[50], n13[50], n15[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1021 (n16[51], n13[51], n15[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1022 (n16[52], n13[52], n15[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1023 (n16[53], n13[53], n15[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1024 (n16[54], n13[54], n15[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1025 (n16[55], n13[55], n15[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1026 (n16[56], n13[56], n15[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1027 (n16[57], n13[57], n15[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1028 (n16[58], n13[58], n15[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1029 (n16[59], n13[59], n15[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u103 (n64[8], n62[8], n63[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1030 (n16[60], n13[60], n15[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1031 (n16[61], n13[61], n15[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1032 (n16[62], n13[62], n15[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1033 (n16[63], n13[63], n15[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u1034 (n13[1], n10[1], n12[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1035 (n13[2], n10[2], n12[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1036 (n13[3], n10[3], n12[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1037 (n13[4], n10[4], n12[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1038 (n13[5], n10[5], n12[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1039 (n13[6], n10[6], n12[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u104 (n64[9], n62[9], n63[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1040 (n13[7], n10[7], n12[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1041 (n13[8], n10[8], n12[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1042 (n13[9], n10[9], n12[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1043 (n13[10], n10[10], n12[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1044 (n13[11], n10[11], n12[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1045 (n13[12], n10[12], n12[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1046 (n13[13], n10[13], n12[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1047 (n13[14], n10[14], n12[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1048 (n13[15], n10[15], n12[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1049 (n13[16], n10[16], n12[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u105 (n64[10], n62[10], n63[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1050 (n13[17], n10[17], n12[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1051 (n13[18], n10[18], n12[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1052 (n13[19], n10[19], n12[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1053 (n13[20], n10[20], n12[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1054 (n13[21], n10[21], n12[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1055 (n13[22], n10[22], n12[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1056 (n13[23], n10[23], n12[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1057 (n13[24], n10[24], n12[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1058 (n13[25], n10[25], n12[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1059 (n13[26], n10[26], n12[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u106 (n64[11], n62[11], n63[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1060 (n13[27], n10[27], n12[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1061 (n13[28], n10[28], n12[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1062 (n13[29], n10[29], n12[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1063 (n13[30], n10[30], n12[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1064 (n13[31], n10[31], n12[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1065 (n13[32], n10[32], n12[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1066 (n13[33], n10[33], n12[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1067 (n13[34], n10[34], n12[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1068 (n13[35], n10[35], n12[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1069 (n13[36], n10[36], n12[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u107 (n64[12], n62[12], n63[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1070 (n13[37], n10[37], n12[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1071 (n13[38], n10[38], n12[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1072 (n13[39], n10[39], n12[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1073 (n13[40], n10[40], n12[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1074 (n13[41], n10[41], n12[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1075 (n13[42], n10[42], n12[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1076 (n13[43], n10[43], n12[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1077 (n13[44], n10[44], n12[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1078 (n13[45], n10[45], n12[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1079 (n13[46], n10[46], n12[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u108 (n64[13], n62[13], n63[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1080 (n13[47], n10[47], n12[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1081 (n13[48], n10[48], n12[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1082 (n13[49], n10[49], n12[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1083 (n13[50], n10[50], n12[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1084 (n13[51], n10[51], n12[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1085 (n13[52], n10[52], n12[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1086 (n13[53], n10[53], n12[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1087 (n13[54], n10[54], n12[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1088 (n13[55], n10[55], n12[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1089 (n13[56], n10[56], n12[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u109 (n64[14], n62[14], n63[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1090 (n13[57], n10[57], n12[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1091 (n13[58], n10[58], n12[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1092 (n13[59], n10[59], n12[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1093 (n13[60], n10[60], n12[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1094 (n13[61], n10[61], n12[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1095 (n13[62], n10[62], n12[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1096 (n13[63], n10[63], n12[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u1097 (n10[1], n7[1], n9[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1098 (n10[2], n7[2], n9[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1099 (n10[3], n7[3], n9[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u11 (data_lsu_cache[22], n64[22], n65[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u110 (n64[15], n62[15], n63[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1100 (n10[4], n7[4], n9[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1101 (n10[5], n7[5], n9[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1102 (n10[6], n7[6], n9[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1103 (n10[7], n7[7], n9[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1104 (n10[8], n7[8], n9[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1105 (n10[9], n7[9], n9[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1106 (n10[10], n7[10], n9[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1107 (n10[11], n7[11], n9[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1108 (n10[12], n7[12], n9[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1109 (n10[13], n7[13], n9[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u111 (n64[16], n62[16], n63[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1110 (n10[14], n7[14], n9[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1111 (n10[15], n7[15], n9[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1112 (n10[16], n7[16], n9[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1113 (n10[17], n7[17], n9[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1114 (n10[18], n7[18], n9[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1115 (n10[19], n7[19], n9[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1116 (n10[20], n7[20], n9[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1117 (n10[21], n7[21], n9[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1118 (n10[22], n7[22], n9[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1119 (n10[23], n7[23], n9[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u112 (n64[17], n62[17], n63[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1120 (n10[24], n7[24], n9[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1121 (n10[25], n7[25], n9[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1122 (n10[26], n7[26], n9[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1123 (n10[27], n7[27], n9[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1124 (n10[28], n7[28], n9[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1125 (n10[29], n7[29], n9[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1126 (n10[30], n7[30], n9[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1127 (n10[31], n7[31], n9[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1128 (n10[32], n7[32], n9[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1129 (n10[33], n7[33], n9[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u113 (n64[18], n62[18], n63[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1130 (n10[34], n7[34], n9[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1131 (n10[35], n7[35], n9[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1132 (n10[36], n7[36], n9[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1133 (n10[37], n7[37], n9[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1134 (n10[38], n7[38], n9[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1135 (n10[39], n7[39], n9[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1136 (n10[40], n7[40], n9[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1137 (n10[41], n7[41], n9[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1138 (n10[42], n7[42], n9[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1139 (n10[43], n7[43], n9[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u114 (n64[19], n62[19], n63[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1140 (n10[44], n7[44], n9[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1141 (n10[45], n7[45], n9[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1142 (n10[46], n7[46], n9[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1143 (n10[47], n7[47], n9[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1144 (n10[48], n7[48], n9[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1145 (n10[49], n7[49], n9[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1146 (n10[50], n7[50], n9[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1147 (n10[51], n7[51], n9[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1148 (n10[52], n7[52], n9[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1149 (n10[53], n7[53], n9[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u115 (n64[20], n62[20], n63[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1150 (n10[54], n7[54], n9[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1151 (n10[55], n7[55], n9[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1152 (n10[56], n7[56], n9[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1153 (n10[57], n7[57], n9[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1154 (n10[58], n7[58], n9[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1155 (n10[59], n7[59], n9[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1156 (n10[60], n7[60], n9[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1157 (n10[61], n7[61], n9[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1158 (n10[62], n7[62], n9[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u1159 (n10[63], n7[63], n9[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u116 (n64[21], n62[21], n63[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1160 (n7[1], n4[1], n6[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1161 (n7[2], n4[2], n6[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1162 (n7[3], n4[3], n6[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1163 (n7[4], n4[4], n6[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1164 (n7[5], n4[5], n6[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1165 (n7[6], n4[6], n6[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1166 (n7[7], n4[7], n6[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1167 (n7[8], n4[8], n6[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1168 (n7[9], n4[9], n6[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1169 (n7[10], n4[10], n6[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u117 (n64[22], n62[22], n63[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1170 (n7[11], n4[11], n6[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1171 (n7[12], n4[12], n6[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1172 (n7[13], n4[13], n6[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1173 (n7[14], n4[14], n6[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1174 (n7[15], n4[15], n6[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1175 (n7[16], n4[16], n6[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1176 (n7[17], n4[17], n6[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1177 (n7[18], n4[18], n6[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1178 (n7[19], n4[19], n6[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1179 (n7[20], n4[20], n6[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u118 (n64[23], n62[23], n63[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1180 (n7[21], n4[21], n6[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1181 (n7[22], n4[22], n6[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1182 (n7[23], n4[23], n6[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1183 (n7[24], n4[24], n6[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1184 (n7[25], n4[25], n6[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1185 (n7[26], n4[26], n6[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1186 (n7[27], n4[27], n6[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1187 (n7[28], n4[28], n6[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1188 (n7[29], n4[29], n6[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1189 (n7[30], n4[30], n6[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u119 (n64[24], n62[24], n63[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1190 (n7[31], n4[31], n6[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1191 (n7[32], n4[32], n6[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1192 (n7[33], n4[33], n6[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1193 (n7[34], n4[34], n6[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1194 (n7[35], n4[35], n6[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1195 (n7[36], n4[36], n6[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1196 (n7[37], n4[37], n6[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1197 (n7[38], n4[38], n6[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1198 (n7[39], n4[39], n6[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1199 (n7[40], n4[40], n6[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u12 (data_write[0], n19[0], n21[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u120 (n64[25], n62[25], n63[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1200 (n7[41], n4[41], n6[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1201 (n7[42], n4[42], n6[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1202 (n7[43], n4[43], n6[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1203 (n7[44], n4[44], n6[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1204 (n7[45], n4[45], n6[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1205 (n7[46], n4[46], n6[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1206 (n7[47], n4[47], n6[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1207 (n7[48], n4[48], n6[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1208 (n7[49], n4[49], n6[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1209 (n7[50], n4[50], n6[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u121 (n64[26], n62[26], n63[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1210 (n7[51], n4[51], n6[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1211 (n7[52], n4[52], n6[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1212 (n7[53], n4[53], n6[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1213 (n7[54], n4[54], n6[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1214 (n7[55], n4[55], n6[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1215 (n7[56], n4[56], n6[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1216 (n7[57], n4[57], n6[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1217 (n7[58], n4[58], n6[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1218 (n7[59], n4[59], n6[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1219 (n7[60], n4[60], n6[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u122 (n64[27], n62[27], n63[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1220 (n7[61], n4[61], n6[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1221 (n7[62], n4[62], n6[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1222 (n7[63], n4[63], n6[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u1223 (n4[1], n1[1], n3[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1224 (n4[2], n1[2], n3[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1225 (n4[3], n1[3], n3[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1226 (n4[4], n1[4], n3[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1227 (n4[5], n1[5], n3[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1228 (n4[6], n1[6], n3[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1229 (n4[7], n1[7], n3[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u123 (n64[28], n62[28], n63[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1230 (n4[8], n1[8], n3[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1231 (n4[9], n1[9], n3[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1232 (n4[10], n1[10], n3[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1233 (n4[11], n1[11], n3[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1234 (n4[12], n1[12], n3[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1235 (n4[13], n1[13], n3[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1236 (n4[14], n1[14], n3[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1237 (n4[15], n1[15], n3[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1238 (n4[16], n1[16], n3[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1239 (n4[17], n1[17], n3[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u124 (n64[29], n62[29], n63[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1240 (n4[18], n1[18], n3[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1241 (n4[19], n1[19], n3[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1242 (n4[20], n1[20], n3[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1243 (n4[21], n1[21], n3[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1244 (n4[22], n1[22], n3[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1245 (n4[23], n1[23], n3[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1246 (n4[24], n1[24], n3[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1247 (n4[25], n1[25], n3[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1248 (n4[26], n1[26], n3[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1249 (n4[27], n1[27], n3[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u125 (n64[30], n62[30], n63[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1250 (n4[28], n1[28], n3[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1251 (n4[29], n1[29], n3[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1252 (n4[30], n1[30], n3[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1253 (n4[31], n1[31], n3[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1254 (n4[32], n1[32], n3[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1255 (n4[33], n1[33], n3[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1256 (n4[34], n1[34], n3[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1257 (n4[35], n1[35], n3[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1258 (n4[36], n1[36], n3[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1259 (n4[37], n1[37], n3[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u126 (n64[31], n62[31], n63[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1260 (n4[38], n1[38], n3[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1261 (n4[39], n1[39], n3[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1262 (n4[40], n1[40], n3[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1263 (n4[41], n1[41], n3[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1264 (n4[42], n1[42], n3[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1265 (n4[43], n1[43], n3[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1266 (n4[44], n1[44], n3[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1267 (n4[45], n1[45], n3[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1268 (n4[46], n1[46], n3[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1269 (n4[47], n1[47], n3[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u127 (n64[32], n62[32], n63[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1270 (n4[48], n1[48], n3[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1271 (n4[49], n1[49], n3[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1272 (n4[50], n1[50], n3[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1273 (n4[51], n1[51], n3[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1274 (n4[52], n1[52], n3[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1275 (n4[53], n1[53], n3[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1276 (n4[54], n1[54], n3[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1277 (n4[55], n1[55], n3[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1278 (n4[56], n1[56], n3[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1279 (n4[57], n1[57], n3[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u128 (n64[33], n62[33], n63[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u1280 (n4[58], n1[58], n3[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1281 (n4[59], n1[59], n3[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1282 (n4[60], n1[60], n3[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1283 (n4[61], n1[61], n3[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1284 (n4[62], n1[62], n3[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u1285 (n4[63], n1[63], n3[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  or u129 (n64[34], n62[34], n63[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u13 (data_lsu_cache[21], n64[21], n65[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u130 (n64[35], n62[35], n63[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u131 (n64[36], n62[36], n63[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u132 (n64[37], n62[37], n63[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u133 (n64[38], n62[38], n63[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u134 (n64[39], n62[39], n63[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u135 (n64[40], n62[40], n63[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u136 (n64[41], n62[41], n63[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u137 (n64[42], n62[42], n63[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u138 (n64[43], n62[43], n63[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u139 (n64[44], n62[44], n63[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u14 (n24[0], n22[0], n23[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u140 (n64[45], n62[45], n63[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u141 (n64[46], n62[46], n63[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u142 (n64[47], n62[47], n63[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u143 (n64[48], n62[48], n63[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u144 (n64[49], n62[49], n63[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u145 (n64[50], n62[50], n63[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u146 (n64[51], n62[51], n63[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u147 (n64[52], n62[52], n63[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u148 (n64[53], n62[53], n63[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u149 (n64[54], n62[54], n63[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u15 (data_lsu_cache[20], n64[20], n65[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u150 (n64[55], n62[55], n63[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u151 (n64[56], n62[56], n63[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u152 (n64[57], n62[57], n63[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u153 (n64[58], n62[58], n63[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u154 (n64[59], n62[59], n63[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u155 (n64[60], n62[60], n63[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u156 (n64[61], n62[61], n63[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u157 (n64[62], n62[62], n63[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u158 (n64[63], n62[63], n63[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u159 (n62[1], n60[1], n61[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u16 (n26[0], n24[0], n25[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u160 (n62[2], n60[2], n61[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u161 (n62[3], n60[3], n61[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u162 (n62[4], n60[4], n61[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u163 (n62[5], n60[5], n61[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u164 (n62[6], n60[6], n61[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u165 (n62[7], n60[7], n61[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u166 (n62[8], n60[8], n61[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u167 (n62[9], n60[9], n61[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u168 (n62[10], n60[10], n61[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u169 (n62[11], n60[11], n61[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u17 (data_lsu_cache[19], n64[19], n65[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u170 (n62[12], n60[12], n61[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u171 (n62[13], n60[13], n61[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u172 (n62[14], n60[14], n61[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u173 (n62[15], n60[15], n61[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u174 (n62[16], n60[16], n61[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u175 (n62[17], n60[17], n61[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u176 (n62[18], n60[18], n61[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u177 (n62[19], n60[19], n61[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u178 (n62[20], n60[20], n61[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u179 (n62[21], n60[21], n61[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u18 (n28[0], n26[0], n27[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u180 (n62[22], n60[22], n61[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u181 (n62[23], n60[23], n61[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u182 (n62[24], n60[24], n61[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u183 (n62[25], n60[25], n61[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u184 (n62[26], n60[26], n61[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u185 (n62[27], n60[27], n61[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u186 (n62[28], n60[28], n61[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u187 (n62[29], n60[29], n61[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u188 (n62[30], n60[30], n61[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u189 (n62[31], n60[31], n61[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u19 (data_lsu_cache[18], n64[18], n65[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u190 (n62[32], n60[32], n61[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u191 (n62[33], n60[33], n61[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u192 (n62[34], n60[34], n61[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u193 (n62[35], n60[35], n61[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u194 (n62[36], n60[36], n61[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u195 (n62[37], n60[37], n61[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u196 (n62[38], n60[38], n61[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u197 (n62[39], n60[39], n61[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u198 (n62[40], n60[40], n61[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u199 (n62[41], n60[41], n61[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u2 (data_lsu_cache[25], n64[25], n65[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u20 (n30[0], n28[0], n29[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u200 (n62[42], n60[42], n61[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u201 (n62[43], n60[43], n61[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u202 (n62[44], n60[44], n61[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u203 (n62[45], n60[45], n61[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u204 (n62[46], n60[46], n61[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u205 (n62[47], n60[47], n61[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u206 (n62[48], n60[48], n61[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u207 (n62[49], n60[49], n61[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u208 (n62[50], n60[50], n61[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u209 (n62[51], n60[51], n61[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u21 (data_lsu_cache[17], n64[17], n65[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u210 (n62[52], n60[52], n61[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u211 (n62[53], n60[53], n61[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u212 (n62[54], n60[54], n61[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u213 (n62[55], n60[55], n61[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u214 (n62[56], n60[56], n61[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u215 (n62[57], n60[57], n61[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u216 (n62[58], n60[58], n61[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u217 (n62[59], n60[59], n61[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u218 (n62[60], n60[60], n61[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u219 (n62[61], n60[61], n61[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u22 (n32[0], n30[0], n31[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u220 (n62[62], n60[62], n61[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u221 (n62[63], n60[63], n61[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u222 (data_lsu_uncache[1], n58[1], n59[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u223 (data_lsu_uncache[2], n58[2], n59[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u224 (data_lsu_uncache[3], n58[3], n59[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u225 (data_lsu_uncache[4], n58[4], n59[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u226 (data_lsu_uncache[5], n58[5], n59[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u227 (data_lsu_uncache[6], n58[6], n59[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u228 (data_lsu_uncache[7], n58[7], n59[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u229 (data_lsu_uncache[8], n58[8], n59[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u23 (data_lsu_cache[16], n64[16], n65[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u230 (data_lsu_uncache[9], n58[9], n59[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u231 (data_lsu_uncache[10], n58[10], n59[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u232 (data_lsu_uncache[11], n58[11], n59[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u233 (data_lsu_uncache[12], n58[12], n59[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u234 (data_lsu_uncache[13], n58[13], n59[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u235 (data_lsu_uncache[14], n58[14], n59[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u236 (data_lsu_uncache[15], n58[15], n59[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u237 (data_lsu_uncache[16], n58[16], n59[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u238 (data_lsu_uncache[17], n58[17], n59[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u239 (data_lsu_uncache[18], n58[18], n59[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u24 (n34[0], n32[0], n33[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u240 (data_lsu_uncache[19], n58[19], n59[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u241 (data_lsu_uncache[20], n58[20], n59[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u242 (data_lsu_uncache[21], n58[21], n59[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u243 (data_lsu_uncache[22], n58[22], n59[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u244 (data_lsu_uncache[23], n58[23], n59[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u245 (data_lsu_uncache[24], n58[24], n59[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u246 (data_lsu_uncache[25], n58[25], n59[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u247 (data_lsu_uncache[26], n58[26], n59[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u248 (data_lsu_uncache[27], n58[27], n59[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u249 (data_lsu_uncache[28], n58[28], n59[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u25 (data_lsu_cache[15], n64[15], n65[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u250 (data_lsu_uncache[29], n58[29], n59[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u251 (data_lsu_uncache[30], n58[30], n59[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u252 (data_lsu_uncache[31], n58[31], n59[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u253 (data_lsu_uncache[32], n58[32], n59[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u254 (data_lsu_uncache[33], n58[33], n59[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u255 (data_lsu_uncache[34], n58[34], n59[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u256 (data_lsu_uncache[35], n58[35], n59[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u257 (data_lsu_uncache[36], n58[36], n59[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u258 (data_lsu_uncache[37], n58[37], n59[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u259 (data_lsu_uncache[38], n58[38], n59[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u26 (data_lsu_cache[14], n64[14], n65[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u260 (data_lsu_uncache[39], n58[39], n59[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u261 (data_lsu_uncache[40], n58[40], n59[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u262 (data_lsu_uncache[41], n58[41], n59[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u263 (data_lsu_uncache[42], n58[42], n59[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u264 (data_lsu_uncache[43], n58[43], n59[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u265 (data_lsu_uncache[44], n58[44], n59[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u266 (data_lsu_uncache[45], n58[45], n59[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u267 (data_lsu_uncache[46], n58[46], n59[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u268 (data_lsu_uncache[47], n58[47], n59[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u269 (data_lsu_uncache[48], n58[48], n59[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u27 (data_lsu_uncache_shift[0], n34[0], n35[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(49)
  or u270 (data_lsu_uncache[49], n58[49], n59[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u271 (data_lsu_uncache[50], n58[50], n59[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u272 (data_lsu_uncache[51], n58[51], n59[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u273 (data_lsu_uncache[52], n58[52], n59[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u274 (data_lsu_uncache[53], n58[53], n59[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u275 (data_lsu_uncache[54], n58[54], n59[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u276 (data_lsu_uncache[55], n58[55], n59[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u277 (data_lsu_uncache[56], n58[56], n59[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u278 (data_lsu_uncache[57], n58[57], n59[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u279 (data_lsu_uncache[58], n58[58], n59[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u28 (data_lsu_cache[13], n64[13], n65[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u280 (data_lsu_uncache[59], n58[59], n59[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u281 (data_lsu_uncache[60], n58[60], n59[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u282 (data_lsu_uncache[61], n58[61], n59[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u283 (data_lsu_uncache[62], n58[62], n59[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u284 (data_lsu_uncache[63], n58[63], n59[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u285 (n58[1], n55[1], n57[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u286 (n58[2], n55[2], n57[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u287 (n58[3], n55[3], n57[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u288 (n58[4], n55[4], n57[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u289 (n58[5], n55[5], n57[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u29 (n38[0], n36[0], n37[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u290 (n58[6], n55[6], n57[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u291 (n58[7], n55[7], n57[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u292 (n58[8], n55[8], n57[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u293 (n58[9], n55[9], n57[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u294 (n58[10], n55[10], n57[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u295 (n58[11], n55[11], n57[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u296 (n58[12], n55[12], n57[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u297 (n58[13], n55[13], n57[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u298 (n58[14], n55[14], n57[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u299 (n58[15], n55[15], n57[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u3 (data_lsu_cache[24], n64[24], n65[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u30 (data_lsu_cache[12], n64[12], n65[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u300 (n58[16], n55[16], n57[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u301 (n58[17], n55[17], n57[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u302 (n58[18], n55[18], n57[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u303 (n58[19], n55[19], n57[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u304 (n58[20], n55[20], n57[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u305 (n58[21], n55[21], n57[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u306 (n58[22], n55[22], n57[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u307 (n58[23], n55[23], n57[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u308 (n58[24], n55[24], n57[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u309 (n58[25], n55[25], n57[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u31 (n40[0], n38[0], n39[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u310 (n58[26], n55[26], n57[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u311 (n58[27], n55[27], n57[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u312 (n58[28], n55[28], n57[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u313 (n58[29], n55[29], n57[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u314 (n58[30], n55[30], n57[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u315 (n58[31], n55[31], n57[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u316 (n58[32], n55[32], n57[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u317 (n58[33], n55[33], n57[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u318 (n58[34], n55[34], n57[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u319 (n58[35], n55[35], n57[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u32 (data_lsu_cache[11], n64[11], n65[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u320 (n58[36], n55[36], n57[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u321 (n58[37], n55[37], n57[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u322 (n58[38], n55[38], n57[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u323 (n58[39], n55[39], n57[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u324 (n58[40], n55[40], n57[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u325 (n58[41], n55[41], n57[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u326 (n58[42], n55[42], n57[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u327 (n58[43], n55[43], n57[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u328 (n58[44], n55[44], n57[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u329 (n58[45], n55[45], n57[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u33 (n42[0], n40[0], n41[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u330 (n58[46], n55[46], n57[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u331 (n58[47], n55[47], n57[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u332 (n58[48], n55[48], n57[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u333 (n58[49], n55[49], n57[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u334 (n58[50], n55[50], n57[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u335 (n58[51], n55[51], n57[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u336 (n58[52], n55[52], n57[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u337 (n58[53], n55[53], n57[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u338 (n58[54], n55[54], n57[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u339 (n58[55], n55[55], n57[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u34 (data_lsu_cache[10], n64[10], n65[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u340 (n58[56], n55[56], n57[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u341 (n58[57], n55[57], n57[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u342 (n58[58], n55[58], n57[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u343 (n58[59], n55[59], n57[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u344 (n58[60], n55[60], n57[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u345 (n58[61], n55[61], n57[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u346 (n58[62], n55[62], n57[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u347 (n58[63], n55[63], n57[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u348 (n55[1], n52[1], n54[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u349 (n55[2], n52[2], n54[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u35 (n44[0], n42[0], n43[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u350 (n55[3], n52[3], n54[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u351 (n55[4], n52[4], n54[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u352 (n55[5], n52[5], n54[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u353 (n55[6], n52[6], n54[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u354 (n55[7], n52[7], n54[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u355 (n55[8], n52[8], n54[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u356 (n55[9], n52[9], n54[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u357 (n55[10], n52[10], n54[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u358 (n55[11], n52[11], n54[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u359 (n55[12], n52[12], n54[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u36 (data_lsu_cache[9], n64[9], n65[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u360 (n55[13], n52[13], n54[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u361 (n55[14], n52[14], n54[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u362 (n55[15], n52[15], n54[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u363 (n55[16], n52[16], n54[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u364 (n55[17], n52[17], n54[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u365 (n55[18], n52[18], n54[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u366 (n55[19], n52[19], n54[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u367 (n55[20], n52[20], n54[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u368 (n55[21], n52[21], n54[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u369 (n55[22], n52[22], n54[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u37 (n46[0], n44[0], n45[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u370 (n55[23], n52[23], n54[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u371 (n55[24], n52[24], n54[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u372 (n55[25], n52[25], n54[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u373 (n55[26], n52[26], n54[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u374 (n55[27], n52[27], n54[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u375 (n55[28], n52[28], n54[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u376 (n55[29], n52[29], n54[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u377 (n55[30], n52[30], n54[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u378 (n55[31], n52[31], n54[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u379 (n55[32], n52[32], n54[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u38 (data_lsu_cache[8], n64[8], n65[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u380 (n55[33], n52[33], n54[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u381 (n55[34], n52[34], n54[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u382 (n55[35], n52[35], n54[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u383 (n55[36], n52[36], n54[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u384 (n55[37], n52[37], n54[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u385 (n55[38], n52[38], n54[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u386 (n55[39], n52[39], n54[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u387 (n55[40], n52[40], n54[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u388 (n55[41], n52[41], n54[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u389 (n55[42], n52[42], n54[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u39 (n48[0], n46[0], n47[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u390 (n55[43], n52[43], n54[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u391 (n55[44], n52[44], n54[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u392 (n55[45], n52[45], n54[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u393 (n55[46], n52[46], n54[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u394 (n55[47], n52[47], n54[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u395 (n55[48], n52[48], n54[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u396 (n55[49], n52[49], n54[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u397 (n55[50], n52[50], n54[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u398 (n55[51], n52[51], n54[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u399 (n55[52], n52[52], n54[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u4 (n4[0], n1[0], n3[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(33)
  not u40 (n50, unsign);  // ../../RTL/CPU/EX/LSU/lsu.v(61)
  or u400 (n55[53], n52[53], n54[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u401 (n55[54], n52[54], n54[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u402 (n55[55], n52[55], n54[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u403 (n55[56], n52[56], n54[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u404 (n55[57], n52[57], n54[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u405 (n55[58], n52[58], n54[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u406 (n55[59], n52[59], n54[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u407 (n55[60], n52[60], n54[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u408 (n55[61], n52[61], n54[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u409 (n55[62], n52[62], n54[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  and u41 (n51, size[0], n50);  // ../../RTL/CPU/EX/LSU/lsu.v(61)
  or u410 (n55[63], n52[63], n54[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u411 (data_lsu_cache_shift[1], n48[1], n49[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(58)
  or u412 (data_lsu_cache_shift[2], n48[2], n49[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(58)
  or u413 (data_lsu_cache_shift[3], n48[3], n49[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(58)
  or u414 (data_lsu_cache_shift[4], n48[4], n49[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(58)
  or u415 (data_lsu_cache_shift[5], n48[5], n49[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(58)
  or u416 (data_lsu_cache_shift[6], n48[6], n49[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(58)
  or u417 (data_lsu_cache_shift[7], n48[7], n49[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(58)
  or u418 (n48[1], n46[1], n47[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u419 (n48[2], n46[2], n47[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u42 (data_lsu_cache[7], n64[7], n65[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u420 (n48[3], n46[3], n47[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u421 (n48[4], n46[4], n47[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u422 (n48[5], n46[5], n47[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u423 (n48[6], n46[6], n47[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u424 (n48[7], n46[7], n47[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u425 (data_lsu_cache_shift[8], n46[8], n47[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u426 (data_lsu_cache_shift[9], n46[9], n47[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u427 (data_lsu_cache_shift[10], n46[10], n47[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u428 (data_lsu_cache_shift[11], n46[11], n47[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u429 (data_lsu_cache_shift[12], n46[12], n47[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  and u43 (n53, size[1], n50);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u430 (data_lsu_cache_shift[13], n46[13], n47[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u431 (data_lsu_cache_shift[14], n46[14], n47[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u432 (data_lsu_cache_shift[15], n46[15], n47[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(57)
  or u433 (n46[1], n44[1], n45[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u434 (n46[2], n44[2], n45[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u435 (n46[3], n44[3], n45[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u436 (n46[4], n44[4], n45[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u437 (n46[5], n44[5], n45[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u438 (n46[6], n44[6], n45[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u439 (n46[7], n44[7], n45[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u44 (data_lsu_cache_shift[0], n48[0], n49[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(58)
  or u440 (n46[8], n44[8], n45[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u441 (n46[9], n44[9], n45[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u442 (n46[10], n44[10], n45[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u443 (n46[11], n44[11], n45[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u444 (n46[12], n44[12], n45[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u445 (n46[13], n44[13], n45[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u446 (n46[14], n44[14], n45[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u447 (n46[15], n44[15], n45[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u448 (data_lsu_cache_shift[16], n44[16], n45[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u449 (data_lsu_cache_shift[17], n44[17], n45[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u45 (data_lsu_cache[6], n64[6], n65[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u450 (data_lsu_cache_shift[18], n44[18], n45[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u451 (data_lsu_cache_shift[19], n44[19], n45[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u452 (data_lsu_cache_shift[20], n44[20], n45[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u453 (data_lsu_cache_shift[21], n44[21], n45[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u454 (data_lsu_cache_shift[22], n44[22], n45[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u455 (data_lsu_cache_shift[23], n44[23], n45[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(56)
  or u456 (n44[1], n42[1], n43[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u457 (n44[2], n42[2], n43[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u458 (n44[3], n42[3], n43[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u459 (n44[4], n42[4], n43[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  and u46 (n56, size[2], n50);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u460 (n44[5], n42[5], n43[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u461 (n44[6], n42[6], n43[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u462 (n44[7], n42[7], n43[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u463 (n44[8], n42[8], n43[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u464 (n44[9], n42[9], n43[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u465 (n44[10], n42[10], n43[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u466 (n44[11], n42[11], n43[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u467 (n44[12], n42[12], n43[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u468 (n44[13], n42[13], n43[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u469 (n44[14], n42[14], n43[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u47 (n55[0], n52[0], n54[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(62)
  or u470 (n44[15], n42[15], n43[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u471 (n44[16], n42[16], n43[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u472 (n44[17], n42[17], n43[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u473 (n44[18], n42[18], n43[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u474 (n44[19], n42[19], n43[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u475 (n44[20], n42[20], n43[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u476 (n44[21], n42[21], n43[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u477 (n44[22], n42[22], n43[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u478 (n44[23], n42[23], n43[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u479 (data_lsu_cache_shift[24], n42[24], n43[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u48 (n58[0], n55[0], n57[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(63)
  or u480 (data_lsu_cache_shift[25], n42[25], n43[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u481 (data_lsu_cache_shift[26], n42[26], n43[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u482 (data_lsu_cache_shift[27], n42[27], n43[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u483 (data_lsu_cache_shift[28], n42[28], n43[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u484 (data_lsu_cache_shift[29], n42[29], n43[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u485 (data_lsu_cache_shift[30], n42[30], n43[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u486 (data_lsu_cache_shift[31], n42[31], n43[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(55)
  or u487 (n42[1], n40[1], n41[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u488 (n42[2], n40[2], n41[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u489 (n42[3], n40[3], n41[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u49 (data_lsu_cache[5], n64[5], n65[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u490 (n42[4], n40[4], n41[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u491 (n42[5], n40[5], n41[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u492 (n42[6], n40[6], n41[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u493 (n42[7], n40[7], n41[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u494 (n42[8], n40[8], n41[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u495 (n42[9], n40[9], n41[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u496 (n42[10], n40[10], n41[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u497 (n42[11], n40[11], n41[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u498 (n42[12], n40[12], n41[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u499 (n42[13], n40[13], n41[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u5 (n7[0], n4[0], n6[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(34)
  or u50 (data_lsu_cache[4], n64[4], n65[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u500 (n42[14], n40[14], n41[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u501 (n42[15], n40[15], n41[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u502 (n42[16], n40[16], n41[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u503 (n42[17], n40[17], n41[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u504 (n42[18], n40[18], n41[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u505 (n42[19], n40[19], n41[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u506 (n42[20], n40[20], n41[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u507 (n42[21], n40[21], n41[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u508 (n42[22], n40[22], n41[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u509 (n42[23], n40[23], n41[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u51 (data_lsu_cache[3], n64[3], n65[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u510 (n42[24], n40[24], n41[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u511 (n42[25], n40[25], n41[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u512 (n42[26], n40[26], n41[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u513 (n42[27], n40[27], n41[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u514 (n42[28], n40[28], n41[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u515 (n42[29], n40[29], n41[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u516 (n42[30], n40[30], n41[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u517 (n42[31], n40[31], n41[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u518 (data_lsu_cache_shift[32], n40[32], n41[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u519 (data_lsu_cache_shift[33], n40[33], n41[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u52 (data_lsu_cache[2], n64[2], n65[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u520 (data_lsu_cache_shift[34], n40[34], n41[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u521 (data_lsu_cache_shift[35], n40[35], n41[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u522 (data_lsu_cache_shift[36], n40[36], n41[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u523 (data_lsu_cache_shift[37], n40[37], n41[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u524 (data_lsu_cache_shift[38], n40[38], n41[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u525 (data_lsu_cache_shift[39], n40[39], n41[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(54)
  or u526 (n40[1], n38[1], n39[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u527 (n40[2], n38[2], n39[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u528 (n40[3], n38[3], n39[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u529 (n40[4], n38[4], n39[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u53 (data_lsu_uncache[0], n58[0], n59[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(64)
  or u530 (n40[5], n38[5], n39[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u531 (n40[6], n38[6], n39[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u532 (n40[7], n38[7], n39[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u533 (n40[8], n38[8], n39[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u534 (n40[9], n38[9], n39[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u535 (n40[10], n38[10], n39[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u536 (n40[11], n38[11], n39[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u537 (n40[12], n38[12], n39[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u538 (n40[13], n38[13], n39[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u539 (n40[14], n38[14], n39[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u54 (data_lsu_cache[1], n64[1], n65[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u540 (n40[15], n38[15], n39[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u541 (n40[16], n38[16], n39[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u542 (n40[17], n38[17], n39[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u543 (n40[18], n38[18], n39[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u544 (n40[19], n38[19], n39[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u545 (n40[20], n38[20], n39[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u546 (n40[21], n38[21], n39[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u547 (n40[22], n38[22], n39[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u548 (n40[23], n38[23], n39[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u549 (n40[24], n38[24], n39[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u55 (data_lsu_cache[0], n64[0], n65[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u550 (n40[25], n38[25], n39[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u551 (n40[26], n38[26], n39[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u552 (n40[27], n38[27], n39[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u553 (n40[28], n38[28], n39[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u554 (n40[29], n38[29], n39[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u555 (n40[30], n38[30], n39[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u556 (n40[31], n38[31], n39[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u557 (n40[32], n38[32], n39[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u558 (n40[33], n38[33], n39[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u559 (n40[34], n38[34], n39[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u56 (n62[0], n60[0], n61[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(68)
  or u560 (n40[35], n38[35], n39[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u561 (n40[36], n38[36], n39[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u562 (n40[37], n38[37], n39[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u563 (n40[38], n38[38], n39[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u564 (n40[39], n38[39], n39[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u565 (data_lsu_cache_shift[40], n38[40], n39[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u566 (data_lsu_cache_shift[41], n38[41], n39[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u567 (data_lsu_cache_shift[42], n38[42], n39[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u568 (data_lsu_cache_shift[43], n38[43], n39[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u569 (data_lsu_cache_shift[44], n38[44], n39[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u57 (n64[0], n62[0], n63[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u570 (data_lsu_cache_shift[45], n38[45], n39[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u571 (data_lsu_cache_shift[46], n38[46], n39[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u572 (data_lsu_cache_shift[47], n38[47], n39[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(53)
  or u573 (n38[1], n36[1], n37[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u574 (n38[2], n36[2], n37[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u575 (n38[3], n36[3], n37[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u576 (n38[4], n36[4], n37[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u577 (n38[5], n36[5], n37[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u578 (n38[6], n36[6], n37[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u579 (n38[7], n36[7], n37[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u58 (data_lsu_cache[26], n64[26], n65[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u580 (n38[8], n36[8], n37[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u581 (n38[9], n36[9], n37[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u582 (n38[10], n36[10], n37[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u583 (n38[11], n36[11], n37[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u584 (n38[12], n36[12], n37[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u585 (n38[13], n36[13], n37[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u586 (n38[14], n36[14], n37[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u587 (n38[15], n36[15], n37[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u588 (n38[16], n36[16], n37[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u589 (n38[17], n36[17], n37[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u59 (data_lsu_cache[27], n64[27], n65[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u590 (n38[18], n36[18], n37[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u591 (n38[19], n36[19], n37[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u592 (n38[20], n36[20], n37[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u593 (n38[21], n36[21], n37[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u594 (n38[22], n36[22], n37[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u595 (n38[23], n36[23], n37[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u596 (n38[24], n36[24], n37[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u597 (n38[25], n36[25], n37[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u598 (n38[26], n36[26], n37[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u599 (n38[27], n36[27], n37[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u6 (n10[0], n7[0], n9[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(35)
  or u60 (data_lsu_cache[28], n64[28], n65[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u600 (n38[28], n36[28], n37[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u601 (n38[29], n36[29], n37[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u602 (n38[30], n36[30], n37[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u603 (n38[31], n36[31], n37[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u604 (n38[32], n36[32], n37[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u605 (n38[33], n36[33], n37[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u606 (n38[34], n36[34], n37[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u607 (n38[35], n36[35], n37[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u608 (n38[36], n36[36], n37[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u609 (n38[37], n36[37], n37[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u61 (data_lsu_cache[29], n64[29], n65[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u610 (n38[38], n36[38], n37[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u611 (n38[39], n36[39], n37[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u612 (n38[40], n36[40], n37[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u613 (n38[41], n36[41], n37[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u614 (n38[42], n36[42], n37[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u615 (n38[43], n36[43], n37[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u616 (n38[44], n36[44], n37[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u617 (n38[45], n36[45], n37[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u618 (n38[46], n36[46], n37[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u619 (n38[47], n36[47], n37[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u62 (data_lsu_cache[30], n64[30], n65[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u620 (data_lsu_cache_shift[48], n36[48], n37[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u621 (data_lsu_cache_shift[49], n36[49], n37[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u622 (data_lsu_cache_shift[50], n36[50], n37[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u623 (data_lsu_cache_shift[51], n36[51], n37[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u624 (data_lsu_cache_shift[52], n36[52], n37[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u625 (data_lsu_cache_shift[53], n36[53], n37[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u626 (data_lsu_cache_shift[54], n36[54], n37[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u627 (data_lsu_cache_shift[55], n36[55], n37[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(52)
  or u628 (data_lsu_uncache_shift[1], n34[1], n35[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(49)
  or u629 (data_lsu_uncache_shift[2], n34[2], n35[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(49)
  or u63 (data_lsu_cache[31], n64[31], n65[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u630 (data_lsu_uncache_shift[3], n34[3], n35[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(49)
  or u631 (data_lsu_uncache_shift[4], n34[4], n35[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(49)
  or u632 (data_lsu_uncache_shift[5], n34[5], n35[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(49)
  or u633 (data_lsu_uncache_shift[6], n34[6], n35[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(49)
  or u634 (data_lsu_uncache_shift[7], n34[7], n35[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(49)
  or u635 (n34[1], n32[1], n33[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u636 (n34[2], n32[2], n33[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u637 (n34[3], n32[3], n33[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u638 (n34[4], n32[4], n33[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u639 (n34[5], n32[5], n33[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u64 (data_lsu_cache[32], n64[32], n65[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u640 (n34[6], n32[6], n33[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u641 (n34[7], n32[7], n33[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u642 (data_lsu_uncache_shift[8], n32[8], n33[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u643 (data_lsu_uncache_shift[9], n32[9], n33[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u644 (data_lsu_uncache_shift[10], n32[10], n33[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u645 (data_lsu_uncache_shift[11], n32[11], n33[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u646 (data_lsu_uncache_shift[12], n32[12], n33[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u647 (data_lsu_uncache_shift[13], n32[13], n33[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u648 (data_lsu_uncache_shift[14], n32[14], n33[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u649 (data_lsu_uncache_shift[15], n32[15], n33[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(48)
  or u65 (data_lsu_cache[33], n64[33], n65[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u650 (n32[1], n30[1], n31[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u651 (n32[2], n30[2], n31[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u652 (n32[3], n30[3], n31[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u653 (n32[4], n30[4], n31[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u654 (n32[5], n30[5], n31[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u655 (n32[6], n30[6], n31[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u656 (n32[7], n30[7], n31[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u657 (n32[8], n30[8], n31[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u658 (n32[9], n30[9], n31[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u659 (n32[10], n30[10], n31[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u66 (data_lsu_cache[34], n64[34], n65[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u660 (n32[11], n30[11], n31[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u661 (n32[12], n30[12], n31[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u662 (n32[13], n30[13], n31[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u663 (n32[14], n30[14], n31[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u664 (n32[15], n30[15], n31[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u665 (data_lsu_uncache_shift[16], n30[16], n31[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u666 (data_lsu_uncache_shift[17], n30[17], n31[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u667 (data_lsu_uncache_shift[18], n30[18], n31[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u668 (data_lsu_uncache_shift[19], n30[19], n31[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u669 (data_lsu_uncache_shift[20], n30[20], n31[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u67 (data_lsu_cache[35], n64[35], n65[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u670 (data_lsu_uncache_shift[21], n30[21], n31[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u671 (data_lsu_uncache_shift[22], n30[22], n31[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u672 (data_lsu_uncache_shift[23], n30[23], n31[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(47)
  or u673 (n30[1], n28[1], n29[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u674 (n30[2], n28[2], n29[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u675 (n30[3], n28[3], n29[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u676 (n30[4], n28[4], n29[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u677 (n30[5], n28[5], n29[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u678 (n30[6], n28[6], n29[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u679 (n30[7], n28[7], n29[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u68 (data_lsu_cache[36], n64[36], n65[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u680 (n30[8], n28[8], n29[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u681 (n30[9], n28[9], n29[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u682 (n30[10], n28[10], n29[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u683 (n30[11], n28[11], n29[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u684 (n30[12], n28[12], n29[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u685 (n30[13], n28[13], n29[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u686 (n30[14], n28[14], n29[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u687 (n30[15], n28[15], n29[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u688 (n30[16], n28[16], n29[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u689 (n30[17], n28[17], n29[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u69 (data_lsu_cache[37], n64[37], n65[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u690 (n30[18], n28[18], n29[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u691 (n30[19], n28[19], n29[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u692 (n30[20], n28[20], n29[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u693 (n30[21], n28[21], n29[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u694 (n30[22], n28[22], n29[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u695 (n30[23], n28[23], n29[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u696 (data_lsu_uncache_shift[24], n28[24], n29[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u697 (data_lsu_uncache_shift[25], n28[25], n29[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u698 (data_lsu_uncache_shift[26], n28[26], n29[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u699 (data_lsu_uncache_shift[27], n28[27], n29[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u7 (n13[0], n10[0], n12[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(36)
  or u70 (data_lsu_cache[38], n64[38], n65[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u700 (data_lsu_uncache_shift[28], n28[28], n29[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u701 (data_lsu_uncache_shift[29], n28[29], n29[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u702 (data_lsu_uncache_shift[30], n28[30], n29[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u703 (data_lsu_uncache_shift[31], n28[31], n29[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(46)
  or u704 (n28[1], n26[1], n27[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u705 (n28[2], n26[2], n27[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u706 (n28[3], n26[3], n27[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u707 (n28[4], n26[4], n27[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u708 (n28[5], n26[5], n27[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u709 (n28[6], n26[6], n27[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u71 (data_lsu_cache[39], n64[39], n65[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u710 (n28[7], n26[7], n27[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u711 (n28[8], n26[8], n27[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u712 (n28[9], n26[9], n27[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u713 (n28[10], n26[10], n27[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u714 (n28[11], n26[11], n27[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u715 (n28[12], n26[12], n27[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u716 (n28[13], n26[13], n27[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u717 (n28[14], n26[14], n27[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u718 (n28[15], n26[15], n27[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u719 (n28[16], n26[16], n27[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u72 (data_lsu_cache[40], n64[40], n65[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u720 (n28[17], n26[17], n27[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u721 (n28[18], n26[18], n27[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u722 (n28[19], n26[19], n27[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u723 (n28[20], n26[20], n27[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u724 (n28[21], n26[21], n27[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u725 (n28[22], n26[22], n27[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u726 (n28[23], n26[23], n27[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u727 (n28[24], n26[24], n27[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u728 (n28[25], n26[25], n27[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u729 (n28[26], n26[26], n27[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u73 (data_lsu_cache[41], n64[41], n65[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u730 (n28[27], n26[27], n27[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u731 (n28[28], n26[28], n27[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u732 (n28[29], n26[29], n27[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u733 (n28[30], n26[30], n27[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u734 (n28[31], n26[31], n27[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u735 (data_lsu_uncache_shift[32], n26[32], n27[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u736 (data_lsu_uncache_shift[33], n26[33], n27[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u737 (data_lsu_uncache_shift[34], n26[34], n27[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u738 (data_lsu_uncache_shift[35], n26[35], n27[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u739 (data_lsu_uncache_shift[36], n26[36], n27[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u74 (data_lsu_cache[42], n64[42], n65[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u740 (data_lsu_uncache_shift[37], n26[37], n27[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u741 (data_lsu_uncache_shift[38], n26[38], n27[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u742 (data_lsu_uncache_shift[39], n26[39], n27[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(45)
  or u743 (n26[1], n24[1], n25[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u744 (n26[2], n24[2], n25[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u745 (n26[3], n24[3], n25[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u746 (n26[4], n24[4], n25[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u747 (n26[5], n24[5], n25[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u748 (n26[6], n24[6], n25[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u749 (n26[7], n24[7], n25[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u75 (data_lsu_cache[43], n64[43], n65[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u750 (n26[8], n24[8], n25[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u751 (n26[9], n24[9], n25[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u752 (n26[10], n24[10], n25[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u753 (n26[11], n24[11], n25[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u754 (n26[12], n24[12], n25[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u755 (n26[13], n24[13], n25[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u756 (n26[14], n24[14], n25[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u757 (n26[15], n24[15], n25[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u758 (n26[16], n24[16], n25[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u759 (n26[17], n24[17], n25[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u76 (data_lsu_cache[44], n64[44], n65[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u760 (n26[18], n24[18], n25[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u761 (n26[19], n24[19], n25[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u762 (n26[20], n24[20], n25[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u763 (n26[21], n24[21], n25[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u764 (n26[22], n24[22], n25[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u765 (n26[23], n24[23], n25[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u766 (n26[24], n24[24], n25[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u767 (n26[25], n24[25], n25[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u768 (n26[26], n24[26], n25[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u769 (n26[27], n24[27], n25[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u77 (data_lsu_cache[45], n64[45], n65[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u770 (n26[28], n24[28], n25[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u771 (n26[29], n24[29], n25[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u772 (n26[30], n24[30], n25[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u773 (n26[31], n24[31], n25[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u774 (n26[32], n24[32], n25[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u775 (n26[33], n24[33], n25[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u776 (n26[34], n24[34], n25[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u777 (n26[35], n24[35], n25[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u778 (n26[36], n24[36], n25[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u779 (n26[37], n24[37], n25[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u78 (data_lsu_cache[46], n64[46], n65[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u780 (n26[38], n24[38], n25[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u781 (n26[39], n24[39], n25[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u782 (data_lsu_uncache_shift[40], n24[40], n25[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u783 (data_lsu_uncache_shift[41], n24[41], n25[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u784 (data_lsu_uncache_shift[42], n24[42], n25[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u785 (data_lsu_uncache_shift[43], n24[43], n25[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u786 (data_lsu_uncache_shift[44], n24[44], n25[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u787 (data_lsu_uncache_shift[45], n24[45], n25[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u788 (data_lsu_uncache_shift[46], n24[46], n25[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u789 (data_lsu_uncache_shift[47], n24[47], n25[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(44)
  or u79 (data_lsu_cache[47], n64[47], n65[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u790 (n24[1], n22[1], n23[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u791 (n24[2], n22[2], n23[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u792 (n24[3], n22[3], n23[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u793 (n24[4], n22[4], n23[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u794 (n24[5], n22[5], n23[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u795 (n24[6], n22[6], n23[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u796 (n24[7], n22[7], n23[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u797 (n24[8], n22[8], n23[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u798 (n24[9], n22[9], n23[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u799 (n24[10], n22[10], n23[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u8 (n16[0], n13[0], n15[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u80 (data_lsu_cache[48], n64[48], n65[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u800 (n24[11], n22[11], n23[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u801 (n24[12], n22[12], n23[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u802 (n24[13], n22[13], n23[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u803 (n24[14], n22[14], n23[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u804 (n24[15], n22[15], n23[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u805 (n24[16], n22[16], n23[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u806 (n24[17], n22[17], n23[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u807 (n24[18], n22[18], n23[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u808 (n24[19], n22[19], n23[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u809 (n24[20], n22[20], n23[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u81 (data_lsu_cache[49], n64[49], n65[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u810 (n24[21], n22[21], n23[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u811 (n24[22], n22[22], n23[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u812 (n24[23], n22[23], n23[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u813 (n24[24], n22[24], n23[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u814 (n24[25], n22[25], n23[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u815 (n24[26], n22[26], n23[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u816 (n24[27], n22[27], n23[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u817 (n24[28], n22[28], n23[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u818 (n24[29], n22[29], n23[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u819 (n24[30], n22[30], n23[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u82 (data_lsu_cache[50], n64[50], n65[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u820 (n24[31], n22[31], n23[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u821 (n24[32], n22[32], n23[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u822 (n24[33], n22[33], n23[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u823 (n24[34], n22[34], n23[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u824 (n24[35], n22[35], n23[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u825 (n24[36], n22[36], n23[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u826 (n24[37], n22[37], n23[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u827 (n24[38], n22[38], n23[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u828 (n24[39], n22[39], n23[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u829 (n24[40], n22[40], n23[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u83 (data_lsu_cache[51], n64[51], n65[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u830 (n24[41], n22[41], n23[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u831 (n24[42], n22[42], n23[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u832 (n24[43], n22[43], n23[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u833 (n24[44], n22[44], n23[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u834 (n24[45], n22[45], n23[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u835 (n24[46], n22[46], n23[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u836 (n24[47], n22[47], n23[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u837 (data_lsu_uncache_shift[48], n22[48], n23[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u838 (data_lsu_uncache_shift[49], n22[49], n23[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u839 (data_lsu_uncache_shift[50], n22[50], n23[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u84 (data_lsu_cache[52], n64[52], n65[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u840 (data_lsu_uncache_shift[51], n22[51], n23[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u841 (data_lsu_uncache_shift[52], n22[52], n23[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u842 (data_lsu_uncache_shift[53], n22[53], n23[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u843 (data_lsu_uncache_shift[54], n22[54], n23[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u844 (data_lsu_uncache_shift[55], n22[55], n23[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(43)
  or u845 (data_write[1], n19[1], n21[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u846 (data_write[2], n19[2], n21[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u847 (data_write[3], n19[3], n21[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u848 (data_write[4], n19[4], n21[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u849 (data_write[5], n19[5], n21[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u85 (data_lsu_cache[53], n64[53], n65[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u850 (data_write[6], n19[6], n21[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u851 (data_write[7], n19[7], n21[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u852 (data_write[8], n19[8], n21[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u853 (data_write[9], n19[9], n21[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u854 (data_write[10], n19[10], n21[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u855 (data_write[11], n19[11], n21[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u856 (data_write[12], n19[12], n21[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u857 (data_write[13], n19[13], n21[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u858 (data_write[14], n19[14], n21[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u859 (data_write[15], n19[15], n21[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u86 (data_lsu_cache[54], n64[54], n65[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u860 (data_write[16], n19[16], n21[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u861 (data_write[17], n19[17], n21[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u862 (data_write[18], n19[18], n21[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u863 (data_write[19], n19[19], n21[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u864 (data_write[20], n19[20], n21[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u865 (data_write[21], n19[21], n21[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u866 (data_write[22], n19[22], n21[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u867 (data_write[23], n19[23], n21[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u868 (data_write[24], n19[24], n21[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u869 (data_write[25], n19[25], n21[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u87 (data_lsu_cache[55], n64[55], n65[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u870 (data_write[26], n19[26], n21[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u871 (data_write[27], n19[27], n21[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u872 (data_write[28], n19[28], n21[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u873 (data_write[29], n19[29], n21[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u874 (data_write[30], n19[30], n21[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u875 (data_write[31], n19[31], n21[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u876 (data_write[32], n19[32], n21[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u877 (data_write[33], n19[33], n21[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u878 (data_write[34], n19[34], n21[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u879 (data_write[35], n19[35], n21[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u88 (data_lsu_cache[56], n64[56], n65[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u880 (data_write[36], n19[36], n21[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u881 (data_write[37], n19[37], n21[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u882 (data_write[38], n19[38], n21[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u883 (data_write[39], n19[39], n21[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u884 (data_write[40], n19[40], n21[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u885 (data_write[41], n19[41], n21[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u886 (data_write[42], n19[42], n21[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u887 (data_write[43], n19[43], n21[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u888 (data_write[44], n19[44], n21[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u889 (data_write[45], n19[45], n21[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u89 (data_lsu_cache[57], n64[57], n65[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u890 (data_write[46], n19[46], n21[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u891 (data_write[47], n19[47], n21[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u892 (data_write[48], n19[48], n21[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u893 (data_write[49], n19[49], n21[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u894 (data_write[50], n19[50], n21[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u895 (data_write[51], n19[51], n21[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u896 (data_write[52], n19[52], n21[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u897 (data_write[53], n19[53], n21[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u898 (data_write[54], n19[54], n21[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u899 (data_write[55], n19[55], n21[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u9 (n19[0], n16[0], n18[0]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u90 (data_lsu_cache[58], n64[58], n65[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u900 (data_write[56], n19[56], n21[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u901 (data_write[57], n19[57], n21[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u902 (data_write[58], n19[58], n21[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u903 (data_write[59], n19[59], n21[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u904 (data_write[60], n19[60], n21[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u905 (data_write[61], n19[61], n21[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u906 (data_write[62], n19[62], n21[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u907 (data_write[63], n19[63], n21[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(39)
  or u908 (n19[1], n16[1], n18[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u909 (n19[2], n16[2], n18[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u91 (data_lsu_cache[59], n64[59], n65[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u910 (n19[3], n16[3], n18[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u911 (n19[4], n16[4], n18[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u912 (n19[5], n16[5], n18[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u913 (n19[6], n16[6], n18[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u914 (n19[7], n16[7], n18[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u915 (n19[8], n16[8], n18[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u916 (n19[9], n16[9], n18[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u917 (n19[10], n16[10], n18[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u918 (n19[11], n16[11], n18[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u919 (n19[12], n16[12], n18[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u92 (data_lsu_cache[60], n64[60], n65[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u920 (n19[13], n16[13], n18[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u921 (n19[14], n16[14], n18[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u922 (n19[15], n16[15], n18[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u923 (n19[16], n16[16], n18[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u924 (n19[17], n16[17], n18[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u925 (n19[18], n16[18], n18[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u926 (n19[19], n16[19], n18[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u927 (n19[20], n16[20], n18[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u928 (n19[21], n16[21], n18[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u929 (n19[22], n16[22], n18[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u93 (data_lsu_cache[61], n64[61], n65[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u930 (n19[23], n16[23], n18[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u931 (n19[24], n16[24], n18[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u932 (n19[25], n16[25], n18[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u933 (n19[26], n16[26], n18[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u934 (n19[27], n16[27], n18[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u935 (n19[28], n16[28], n18[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u936 (n19[29], n16[29], n18[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u937 (n19[30], n16[30], n18[30]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u938 (n19[31], n16[31], n18[31]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u939 (n19[32], n16[32], n18[32]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u94 (data_lsu_cache[62], n64[62], n65[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u940 (n19[33], n16[33], n18[33]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u941 (n19[34], n16[34], n18[34]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u942 (n19[35], n16[35], n18[35]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u943 (n19[36], n16[36], n18[36]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u944 (n19[37], n16[37], n18[37]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u945 (n19[38], n16[38], n18[38]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u946 (n19[39], n16[39], n18[39]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u947 (n19[40], n16[40], n18[40]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u948 (n19[41], n16[41], n18[41]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u949 (n19[42], n16[42], n18[42]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u95 (data_lsu_cache[63], n64[63], n65[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(70)
  or u950 (n19[43], n16[43], n18[43]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u951 (n19[44], n16[44], n18[44]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u952 (n19[45], n16[45], n18[45]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u953 (n19[46], n16[46], n18[46]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u954 (n19[47], n16[47], n18[47]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u955 (n19[48], n16[48], n18[48]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u956 (n19[49], n16[49], n18[49]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u957 (n19[50], n16[50], n18[50]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u958 (n19[51], n16[51], n18[51]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u959 (n19[52], n16[52], n18[52]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u96 (n64[1], n62[1], n63[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u960 (n19[53], n16[53], n18[53]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u961 (n19[54], n16[54], n18[54]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u962 (n19[55], n16[55], n18[55]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u963 (n19[56], n16[56], n18[56]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u964 (n19[57], n16[57], n18[57]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u965 (n19[58], n16[58], n18[58]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u966 (n19[59], n16[59], n18[59]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u967 (n19[60], n16[60], n18[60]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u968 (n19[61], n16[61], n18[61]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u969 (n19[62], n16[62], n18[62]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u97 (n64[2], n62[2], n63[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u970 (n19[63], n16[63], n18[63]);  // ../../RTL/CPU/EX/LSU/lsu.v(38)
  or u971 (n16[1], n13[1], n15[1]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u972 (n16[2], n13[2], n15[2]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u973 (n16[3], n13[3], n15[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u974 (n16[4], n13[4], n15[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u975 (n16[5], n13[5], n15[5]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u976 (n16[6], n13[6], n15[6]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u977 (n16[7], n13[7], n15[7]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u978 (n16[8], n13[8], n15[8]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u979 (n16[9], n13[9], n15[9]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u98 (n64[3], n62[3], n63[3]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u980 (n16[10], n13[10], n15[10]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u981 (n16[11], n13[11], n15[11]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u982 (n16[12], n13[12], n15[12]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u983 (n16[13], n13[13], n15[13]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u984 (n16[14], n13[14], n15[14]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u985 (n16[15], n13[15], n15[15]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u986 (n16[16], n13[16], n15[16]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u987 (n16[17], n13[17], n15[17]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u988 (n16[18], n13[18], n15[18]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u989 (n16[19], n13[19], n15[19]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u99 (n64[4], n62[4], n63[4]);  // ../../RTL/CPU/EX/LSU/lsu.v(69)
  or u990 (n16[20], n13[20], n15[20]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u991 (n16[21], n13[21], n15[21]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u992 (n16[22], n13[22], n15[22]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u993 (n16[23], n13[23], n15[23]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u994 (n16[24], n13[24], n15[24]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u995 (n16[25], n13[25], n15[25]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u996 (n16[26], n13[26], n15[26]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u997 (n16[27], n13[27], n15[27]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u998 (n16[28], n13[28], n15[28]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)
  or u999 (n16[29], n13[29], n15[29]);  // ../../RTL/CPU/EX/LSU/lsu.v(37)

endmodule 

module binary_mux_s1_w4
  (
  i0,
  i1,
  sel,
  o
  );

  input [3:0] i0;
  input [3:0] i1;
  input sel;
  output [3:0] o;



endmodule 

module binary_mux_s1_w8
  (
  i0,
  i1,
  sel,
  o
  );

  input [7:0] i0;
  input [7:0] i1;
  input sel;
  output [7:0] o;



endmodule 

module binary_mux_s1_w32
  (
  i0,
  i1,
  sel,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  input sel;
  output [31:0] o;



endmodule 

module binary_mux_s1_w65
  (
  i0,
  i1,
  sel,
  o
  );

  input [64:0] i0;
  input [64:0] i1;
  input sel;
  output [64:0] o;



endmodule 

module binary_mux_s1_w5
  (
  i0,
  i1,
  sel,
  o
  );

  input [4:0] i0;
  input [4:0] i1;
  input sel;
  output [4:0] o;



endmodule 

module binary_mux_s1_w33
  (
  i0,
  i1,
  sel,
  o
  );

  input [32:0] i0;
  input [32:0] i1;
  input sel;
  output [32:0] o;



endmodule 

module binary_mux_s1_w2
  (
  i0,
  i1,
  sel,
  o
  );

  input [1:0] i0;
  input [1:0] i1;
  input sel;
  output [1:0] o;



endmodule 

module binary_mux_s1_w3
  (
  i0,
  i1,
  sel,
  o
  );

  input [2:0] i0;
  input [2:0] i1;
  input sel;
  output [2:0] o;



endmodule 

module ne_w2
  (
  i0,
  i1,
  o
  );

  input [1:0] i0;
  input [1:0] i1;
  output o;



endmodule 

module ne_w3
  (
  i0,
  i1,
  o
  );

  input [2:0] i0;
  input [2:0] i1;
  output o;



endmodule 

module reg_ar_as_w8
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [7:0] d;
  input en;
  input [7:0] reset;
  input [7:0] set;
  output [7:0] q;



endmodule 

module reg_ar_as_w64
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [63:0] d;
  input en;
  input [63:0] reset;
  input [63:0] set;
  output [63:0] q;



endmodule 

module reg_ar_as_w12
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [11:0] d;
  input en;
  input [11:0] reset;
  input [11:0] set;
  output [11:0] q;



endmodule 

module reg_ar_as_w5
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [4:0] d;
  input en;
  input [4:0] reset;
  input [4:0] set;
  output [4:0] q;



endmodule 

module reg_ar_as_w4
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [3:0] d;
  input en;
  input [3:0] reset;
  input [3:0] set;
  output [3:0] q;



endmodule 

module add_pu8_mu8_o8
  (
  i0,
  i1,
  o
  );

  input [7:0] i0;
  input [7:0] i1;
  output [7:0] o;



endmodule 

module eq_w7
  (
  i0,
  i1,
  o
  );

  input [6:0] i0;
  input [6:0] i1;
  output o;



endmodule 

module eq_w6
  (
  i0,
  i1,
  o
  );

  input [5:0] i0;
  input [5:0] i1;
  output o;



endmodule 

module eq_w2
  (
  i0,
  i1,
  o
  );

  input [1:0] i0;
  input [1:0] i1;
  output o;



endmodule 

module reg_ar_as_w32
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [31:0] d;
  input en;
  input [31:0] reset;
  input [31:0] set;
  output [31:0] q;



endmodule 

module add_pu9_pu9_o9
  (
  i0,
  i1,
  o
  );

  input [8:0] i0;
  input [8:0] i1;
  output [8:0] o;



endmodule 

module add_pu61_pu61_o61
  (
  i0,
  i1,
  o
  );

  input [60:0] i0;
  input [60:0] i1;
  output [60:0] o;



endmodule 

module eq_w9
  (
  i0,
  i1,
  o
  );

  input [8:0] i0;
  input [8:0] i1;
  output o;



endmodule 

module mmu  // ../../RTL/CPU/BIU/mmu.v(4)
  (
  cacheability_block,
  clk,
  hrdata,
  hready,
  hreset_n,
  hresp,
  maddress,
  mxr,
  opc,
  pa_cov,
  priv,
  rst,
  satp,
  sum,
  bus_error,
  cacheable,
  haddr,
  hburst,
  hmastlock,
  hprot,
  hsize,
  htrans,
  hwdata,
  hwrite,
  paddress,
  pagefault,
  read_data,
  trans_rdy
  );

  input [31:0] cacheability_block;  // ../../RTL/CPU/BIU/mmu.v(10)
  input clk;  // ../../RTL/CPU/BIU/mmu.v(5)
  input [63:0] hrdata;  // ../../RTL/CPU/BIU/mmu.v(56)
  input hready;  // ../../RTL/CPU/BIU/mmu.v(53)
  input hreset_n;  // ../../RTL/CPU/BIU/mmu.v(55)
  input hresp;  // ../../RTL/CPU/BIU/mmu.v(54)
  input [63:0] maddress;  // ../../RTL/CPU/BIU/mmu.v(35)
  input mxr;  // ../../RTL/CPU/BIU/mmu.v(14)
  input [1:0] opc;  // ../../RTL/CPU/BIU/mmu.v(27)
  input pa_cov;  // ../../RTL/CPU/BIU/mmu.v(24)
  input [3:0] priv;  // ../../RTL/CPU/BIU/mmu.v(28)
  input rst;  // ../../RTL/CPU/BIU/mmu.v(6)
  input [63:0] satp;  // ../../RTL/CPU/BIU/mmu.v(13)
  input sum;  // ../../RTL/CPU/BIU/mmu.v(15)
  output bus_error;  // ../../RTL/CPU/BIU/mmu.v(33)
  output cacheable;  // ../../RTL/CPU/BIU/mmu.v(30)
  output [63:0] haddr;  // ../../RTL/CPU/BIU/mmu.v(44)
  output [2:0] hburst;  // ../../RTL/CPU/BIU/mmu.v(47)
  output hmastlock;  // ../../RTL/CPU/BIU/mmu.v(50)
  output [3:0] hprot;  // ../../RTL/CPU/BIU/mmu.v(48)
  output [3:0] hsize;  // ../../RTL/CPU/BIU/mmu.v(46)
  output [1:0] htrans;  // ../../RTL/CPU/BIU/mmu.v(49)
  output [63:0] hwdata;  // ../../RTL/CPU/BIU/mmu.v(51)
  output hwrite;  // ../../RTL/CPU/BIU/mmu.v(45)
  output [127:0] paddress;  // ../../RTL/CPU/BIU/mmu.v(36)
  output pagefault;  // ../../RTL/CPU/BIU/mmu.v(32)
  output [63:0] read_data;  // ../../RTL/CPU/BIU/mmu.v(39)
  output trans_rdy;  // ../../RTL/CPU/BIU/mmu.v(31)

  parameter A = 6;
  parameter D = 7;
  parameter R = 1;
  parameter U = 4;
  parameter V = 0;
  parameter W = 2;
  parameter X = 3;
  parameter acc_fault = 4'b1001;
  parameter cacheable_chk = 4'b0111;
  parameter idle = 2'b00;
  parameter mach = 4'b1000;
  parameter nseq = 2'b10;
  parameter page_fault = 4'b1000;
  parameter pte_upd0 = 4'b0101;
  parameter pte_upd1 = 4'b0110;
  parameter s2_1 = 4'b0001;
  parameter s2_2 = 4'b0010;
  parameter s4 = 4'b0011;
  parameter s5 = 4'b0100;
  parameter stb = 4'b0000;
  parameter supe = 4'b0010;
  parameter user = 4'b0001;
  wire [63:0] a;  // ../../RTL/CPU/BIU/mmu.v(91)
  wire [1:0] i;  // ../../RTL/CPU/BIU/mmu.v(94)
  wire [8:0] n28;
  wire [8:0] n29;
  wire [2:0] n33;
  wire [3:0] n36;
  wire [2:0] n38;
  wire [2:0] n39;
  wire [3:0] n40;
  wire [3:0] n43;
  wire [3:0] n44;
  wire [3:0] n46;
  wire [3:0] n47;
  wire [3:0] n48;
  wire [3:0] n49;
  wire [3:0] n50;
  wire [3:0] n51;
  wire [3:0] n52;
  wire [3:0] n53;
  wire [3:0] n54;
  wire [3:0] n55;
  wire [3:0] n56;
  wire [3:0] n57;
  wire [1:0] n59;
  wire [1:0] n60;
  wire [1:0] n61;
  wire [1:0] n62;
  wire [63:0] n63;
  wire [63:0] n64;
  wire [63:0] n65;
  wire [63:0] n66;
  wire [63:0] n67;
  wire [63:0] n68;
  wire [63:0] n69;
  wire [63:0] n70;
  wire [63:0] n71;
  wire [63:0] n72;
  wire [63:0] n75;
  wire [63:0] n76;
  wire [63:0] n78;
  wire [63:0] n79;
  wire [63:0] n80;
  wire [63:0] p_address;  // ../../RTL/CPU/BIU/mmu.v(93)
  wire [63:0] pte_temp;  // ../../RTL/CPU/BIU/mmu.v(92)
  wire [3:0] statu;  // ../../RTL/CPU/BIU/mmu.v(95)
  wire [8:0] va_vpn;  // ../../RTL/CPU/BIU/mmu.v(102)
  wire leaf_page;  // ../../RTL/CPU/BIU/mmu.v(99)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n2;
  wire n20;
  wire n21;
  wire n22;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n34;
  wire n35;
  wire n37;
  wire n4;
  wire n41;
  wire n42;
  wire n45;
  wire n5;
  wire n58;
  wire n6;
  wire n7;
  wire n73;
  wire n74;
  wire n77;
  wire n8;
  wire n81;
  wire n9;
  wire page_chk_ok;  // ../../RTL/CPU/BIU/mmu.v(100)
  wire page_unvalid;  // ../../RTL/CPU/BIU/mmu.v(97)
  wire pointer_page;  // ../../RTL/CPU/BIU/mmu.v(98)

  assign htrans[0] = 1'b0;
  eq_w2 eq0 (
    .i0(i),
    .i1(2'b00),
    .o(n1));  // ../../RTL/CPU/BIU/mmu.v(105)
  eq_w4 eq1 (
    .i0(priv),
    .i1(4'b0001),
    .o(n7));  // ../../RTL/CPU/BIU/mmu.v(110)
  eq_w4 eq10 (
    .i0(satp[63:60]),
    .i1(4'b1000),
    .o(n31));  // ../../RTL/CPU/BIU/mmu.v(125)
  eq_w4 eq11 (
    .i0(statu),
    .i1(4'b0001),
    .o(n34));  // ../../RTL/CPU/BIU/mmu.v(127)
  eq_w4 eq12 (
    .i0(statu),
    .i1(4'b0010),
    .o(n35));  // ../../RTL/CPU/BIU/mmu.v(130)
  eq_w4 eq13 (
    .i0(statu),
    .i1(4'b0011),
    .o(n37));  // ../../RTL/CPU/BIU/mmu.v(133)
  eq_w4 eq14 (
    .i0(statu),
    .i1(4'b0100),
    .o(n41));  // ../../RTL/CPU/BIU/mmu.v(136)
  eq_w4 eq15 (
    .i0(statu),
    .i1(4'b0101),
    .o(hwrite));  // ../../RTL/CPU/BIU/mmu.v(139)
  eq_w4 eq16 (
    .i0(statu),
    .i1(4'b0110),
    .o(n45));  // ../../RTL/CPU/BIU/mmu.v(142)
  eq_w4 eq17 (
    .i0(statu),
    .i1(4'b0111),
    .o(trans_rdy));  // ../../RTL/CPU/BIU/mmu.v(145)
  eq_w4 eq18 (
    .i0(statu),
    .i1(4'b1000),
    .o(pagefault));  // ../../RTL/CPU/BIU/mmu.v(148)
  eq_w4 eq19 (
    .i0(statu),
    .i1(4'b1001),
    .o(bus_error));  // ../../RTL/CPU/BIU/mmu.v(151)
  eq_w4 eq2 (
    .i0(priv),
    .i1(4'b0010),
    .o(n8));  // ../../RTL/CPU/BIU/mmu.v(110)
  eq_w32 eq20 (
    .i0(p_address[63:32]),
    .i1(cacheability_block),
    .o(n81));  // ../../RTL/CPU/BIU/mmu.v(221)
  eq_w2 eq3 (
    .i0(opc),
    .i1(2'b01),
    .o(n12));  // ../../RTL/CPU/BIU/mmu.v(111)
  eq_w2 eq4 (
    .i0(opc),
    .i1(2'b00),
    .o(n14));  // ../../RTL/CPU/BIU/mmu.v(111)
  eq_w2 eq5 (
    .i0(opc),
    .i1(2'b10),
    .o(n19));  // ../../RTL/CPU/BIU/mmu.v(111)
  eq_w4 eq6 (
    .i0(priv),
    .i1(4'b1000),
    .o(n25));  // ../../RTL/CPU/BIU/mmu.v(113)
  eq_w2 eq7 (
    .i0(i),
    .i1(2'b10),
    .o(n26));  // ../../RTL/CPU/BIU/mmu.v(115)
  eq_w2 eq8 (
    .i0(i),
    .i1(2'b01),
    .o(n27));  // ../../RTL/CPU/BIU/mmu.v(115)
  eq_w4 eq9 (
    .i0(statu),
    .i1(4'b0000),
    .o(n30));  // ../../RTL/CPU/BIU/mmu.v(124)
  binary_mux_s1_w9 mux0 (
    .i0(9'b000000000),
    .i1(maddress[38:30]),
    .sel(n1),
    .o(n28));  // ../../RTL/CPU/BIU/mmu.v(115)
  binary_mux_s1_w9 mux1 (
    .i0(n28),
    .i1(maddress[29:21]),
    .sel(n27),
    .o(n29));  // ../../RTL/CPU/BIU/mmu.v(115)
  binary_mux_s1_w4 mux10 (
    .i0(n48),
    .i1(4'b0000),
    .sel(trans_rdy),
    .o(n49));  // ../../RTL/CPU/BIU/mmu.v(153)
  binary_mux_s1_w4 mux11 (
    .i0(n49),
    .i1({hresp,n46[1],n46[1],n46[1]}),
    .sel(n45),
    .o(n50));  // ../../RTL/CPU/BIU/mmu.v(153)
  binary_mux_s1_w4 mux12 (
    .i0(n50),
    .i1(4'b0110),
    .sel(hwrite),
    .o(n51));  // ../../RTL/CPU/BIU/mmu.v(153)
  binary_mux_s1_w4 mux13 (
    .i0(n51),
    .i1(n44),
    .sel(n41),
    .o(n52));  // ../../RTL/CPU/BIU/mmu.v(153)
  binary_mux_s1_w4 mux14 (
    .i0(n52),
    .i1(n40),
    .sel(n37),
    .o(n53));  // ../../RTL/CPU/BIU/mmu.v(153)
  binary_mux_s1_w4 mux15 (
    .i0(n53),
    .i1(n36),
    .sel(n35),
    .o(n54));  // ../../RTL/CPU/BIU/mmu.v(153)
  binary_mux_s1_w4 mux16 (
    .i0(n54),
    .i1(4'b0010),
    .sel(n34),
    .o(n55));  // ../../RTL/CPU/BIU/mmu.v(153)
  binary_mux_s1_w4 mux17 (
    .i0(n55),
    .i1({1'b0,n33}),
    .sel(n30),
    .o(n56));  // ../../RTL/CPU/BIU/mmu.v(153)
  binary_mux_s1_w4 mux18 (
    .i0(n56),
    .i1(4'b0000),
    .sel(rst),
    .o(n57));  // ../../RTL/CPU/BIU/mmu.v(153)
  binary_mux_s1_w2 mux19 (
    .i0(i),
    .i1(n59),
    .sel(pointer_page),
    .o(n60));  // ../../RTL/CPU/BIU/mmu.v(164)
  binary_mux_s1_w9 mux2 (
    .i0(n29),
    .i1(maddress[20:12]),
    .sel(n26),
    .o(va_vpn));  // ../../RTL/CPU/BIU/mmu.v(115)
  binary_mux_s1_w2 mux20 (
    .i0(i),
    .i1(n60),
    .sel(n37),
    .o(n61));  // ../../RTL/CPU/BIU/mmu.v(165)
  binary_mux_s1_w2 mux21 (
    .i0(n61),
    .i1(2'b10),
    .sel(n58),
    .o(n62));  // ../../RTL/CPU/BIU/mmu.v(165)
  binary_mux_s1_w64 mux22 (
    .i0(p_address),
    .i1({maddress[63:12],12'b000000000000}),
    .sel(pa_cov),
    .o(n63));  // ../../RTL/CPU/BIU/mmu.v(174)
  binary_mux_s2_w64 mux23 (
    .i0({8'b00000000,pte_temp[53:10],12'b000000000000}),
    .i1({8'b00000000,pte_temp[53:19],maddress[20:12],12'b000000000000}),
    .i2({8'b00000000,pte_temp[53:28],maddress[29:12],12'b000000000000}),
    .i3(p_address),
    .sel(i),
    .o(n64));  // ../../RTL/CPU/BIU/mmu.v(181)
  binary_mux_s1_w64 mux24 (
    .i0(p_address),
    .i1(n64),
    .sel(n41),
    .o(n65));  // ../../RTL/CPU/BIU/mmu.v(182)
  binary_mux_s1_w64 mux25 (
    .i0(n65),
    .i1(n63),
    .sel(n30),
    .o(n66));  // ../../RTL/CPU/BIU/mmu.v(182)
  binary_mux_s1_w64 mux26 (
    .i0(n66),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n67));  // ../../RTL/CPU/BIU/mmu.v(182)
  binary_mux_s1_w64 mux27 (
    .i0(a),
    .i1({8'b00000000,satp[43:0],va_vpn,3'b000}),
    .sel(n32),
    .o(n68));  // ../../RTL/CPU/BIU/mmu.v(193)
  binary_mux_s1_w64 mux28 (
    .i0(a),
    .i1({8'b00000000,pte_temp[53:10],va_vpn,3'b000}),
    .sel(pointer_page),
    .o(n69));  // ../../RTL/CPU/BIU/mmu.v(197)
  binary_mux_s1_w64 mux29 (
    .i0(a),
    .i1(n69),
    .sel(n37),
    .o(n70));  // ../../RTL/CPU/BIU/mmu.v(198)
  binary_mux_s1_w3 mux3 (
    .i0({pa_cov,pa_cov,pa_cov}),
    .i1(3'b001),
    .sel(n32),
    .o(n33));  // ../../RTL/CPU/BIU/mmu.v(125)
  binary_mux_s1_w64 mux30 (
    .i0(n70),
    .i1(n68),
    .sel(n30),
    .o(n71));  // ../../RTL/CPU/BIU/mmu.v(198)
  binary_mux_s1_w64 mux31 (
    .i0(n71),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n72));  // ../../RTL/CPU/BIU/mmu.v(198)
  binary_mux_s1_w64 mux32 (
    .i0(pte_temp),
    .i1(64'b1111111111111111111111111111111111111111111111111111111111111111),
    .sel(n74),
    .o(n75));  // ../../RTL/CPU/BIU/mmu.v(209)
  binary_mux_s1_w64 mux33 (
    .i0(pte_temp),
    .i1(hrdata),
    .sel(hready),
    .o(n76));  // ../../RTL/CPU/BIU/mmu.v(212)
  binary_mux_s1_w64 mux34 (
    .i0({pte_temp[63:7],n77,pte_temp[5:0]}),
    .i1(n76),
    .sel(n35),
    .o(n78));  // ../../RTL/CPU/BIU/mmu.v(217)
  binary_mux_s1_w64 mux35 (
    .i0(n78),
    .i1(n75),
    .sel(n30),
    .o(n79));  // ../../RTL/CPU/BIU/mmu.v(217)
  binary_mux_s1_w64 mux36 (
    .i0(n79),
    .i1(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .sel(rst),
    .o(n80));  // ../../RTL/CPU/BIU/mmu.v(217)
  binary_mux_s1_w4 mux4 (
    .i0({3'b001,hready}),
    .i1(4'b1001),
    .sel(hresp),
    .o(n36));  // ../../RTL/CPU/BIU/mmu.v(131)
  binary_mux_s1_w3 mux5 (
    .i0({leaf_page,n38[0],n38[0]}),
    .i1(3'b001),
    .sel(pointer_page),
    .o(n39));  // ../../RTL/CPU/BIU/mmu.v(134)
  binary_mux_s1_w4 mux6 (
    .i0({1'b0,n39}),
    .i1(4'b1000),
    .sel(page_unvalid),
    .o(n40));  // ../../RTL/CPU/BIU/mmu.v(134)
  binary_mux_s1_w4 mux7 (
    .i0({n43[3],page_chk_ok,page_chk_ok,page_chk_ok}),
    .i1(4'b0101),
    .sel(n42),
    .o(n44));  // ../../RTL/CPU/BIU/mmu.v(137)
  binary_mux_s1_w4 mux8 (
    .i0(statu),
    .i1(4'b0000),
    .sel(bus_error),
    .o(n47));  // ../../RTL/CPU/BIU/mmu.v(153)
  binary_mux_s1_w4 mux9 (
    .i0(n47),
    .i1(4'b0000),
    .sel(pagefault),
    .o(n48));  // ../../RTL/CPU/BIU/mmu.v(153)
  ne_w4 neq0 (
    .i0(satp[63:60]),
    .i1(4'b1000),
    .o(n73));  // ../../RTL/CPU/BIU/mmu.v(209)
  reg_ar_as_w2 reg0 (
    .clk(clk),
    .d(n62),
    .reset(2'b00),
    .set(2'b00),
    .q(i));  // ../../RTL/CPU/BIU/mmu.v(166)
  reg_ar_as_w64 reg1 (
    .clk(clk),
    .d(n67),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(p_address));  // ../../RTL/CPU/BIU/mmu.v(183)
  reg_ar_as_w64 reg2 (
    .clk(clk),
    .d(n72),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(a));  // ../../RTL/CPU/BIU/mmu.v(200)
  reg_ar_as_w64 reg3 (
    .clk(clk),
    .d(n80),
    .reset(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .set(64'b0000000000000000000000000000000000000000000000000000000000000000),
    .q(pte_temp));  // ../../RTL/CPU/BIU/mmu.v(218)
  reg_ar_as_w4 reg4 (
    .clk(clk),
    .d(n57),
    .reset(4'b0000),
    .set(4'b0000),
    .q(statu));  // ../../RTL/CPU/BIU/mmu.v(154)
  add_pu2_mu2_o2 sub0 (
    .i0(i),
    .i1(2'b01),
    .o(n59));  // ../../RTL/CPU/BIU/mmu.v(164)
  not u10 (n6, pte_temp[1]);  // ../../RTL/CPU/BIU/mmu.v(106)
  buf u100 (hwdata[58], pte_temp[58]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u101 (hwdata[59], pte_temp[59]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u102 (hwdata[60], pte_temp[60]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u103 (hwdata[61], pte_temp[61]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u104 (hwdata[62], pte_temp[62]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u105 (hwdata[63], pte_temp[63]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u106 (hprot[1], 1'b1);  // ../../RTL/CPU/BIU/mmu.v(237)
  buf u107 (hprot[2], 1'b0);  // ../../RTL/CPU/BIU/mmu.v(237)
  buf u108 (hprot[3], 1'b0);  // ../../RTL/CPU/BIU/mmu.v(237)
  buf u109 (hburst[1], 1'b0);  // ../../RTL/CPU/BIU/mmu.v(236)
  and u11 (pointer_page, n5, n6);  // ../../RTL/CPU/BIU/mmu.v(106)
  buf u110 (hburst[2], 1'b0);  // ../../RTL/CPU/BIU/mmu.v(236)
  buf u111 (hsize[1], 1'b1);  // ../../RTL/CPU/BIU/mmu.v(235)
  buf u112 (hsize[2], 1'b0);  // ../../RTL/CPU/BIU/mmu.v(235)
  buf u113 (hsize[3], 1'b0);  // ../../RTL/CPU/BIU/mmu.v(235)
  buf u114 (haddr[1], a[1]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u115 (haddr[2], a[2]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u116 (haddr[3], a[3]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u117 (haddr[4], a[4]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u118 (haddr[5], a[5]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u119 (haddr[6], a[6]);  // ../../RTL/CPU/BIU/mmu.v(233)
  or u12 (leaf_page, pte_temp[1], pte_temp[3]);  // ../../RTL/CPU/BIU/mmu.v(107)
  buf u120 (haddr[7], a[7]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u121 (haddr[8], a[8]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u122 (haddr[9], a[9]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u123 (haddr[10], a[10]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u124 (haddr[11], a[11]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u125 (haddr[12], a[12]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u126 (haddr[13], a[13]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u127 (haddr[14], a[14]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u128 (haddr[15], a[15]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u129 (haddr[16], a[16]);  // ../../RTL/CPU/BIU/mmu.v(233)
  and u13 (n9, n8, sum);  // ../../RTL/CPU/BIU/mmu.v(110)
  buf u130 (haddr[17], a[17]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u131 (haddr[18], a[18]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u132 (haddr[19], a[19]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u133 (haddr[20], a[20]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u134 (haddr[21], a[21]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u135 (haddr[22], a[22]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u136 (haddr[23], a[23]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u137 (haddr[24], a[24]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u138 (haddr[25], a[25]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u139 (haddr[26], a[26]);  // ../../RTL/CPU/BIU/mmu.v(233)
  or u14 (n10, n7, n9);  // ../../RTL/CPU/BIU/mmu.v(110)
  buf u140 (haddr[27], a[27]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u141 (haddr[28], a[28]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u142 (haddr[29], a[29]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u143 (haddr[30], a[30]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u144 (haddr[31], a[31]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u145 (haddr[32], a[32]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u146 (haddr[33], a[33]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u147 (haddr[34], a[34]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u148 (haddr[35], a[35]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u149 (haddr[36], a[36]);  // ../../RTL/CPU/BIU/mmu.v(233)
  and u15 (n11, pte_temp[4], n10);  // ../../RTL/CPU/BIU/mmu.v(110)
  buf u150 (haddr[37], a[37]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u151 (haddr[38], a[38]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u152 (haddr[39], a[39]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u153 (haddr[40], a[40]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u154 (haddr[41], a[41]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u155 (haddr[42], a[42]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u156 (haddr[43], a[43]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u157 (haddr[44], a[44]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u158 (haddr[45], a[45]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u159 (haddr[46], a[46]);  // ../../RTL/CPU/BIU/mmu.v(233)
  and u16 (n13, n12, pte_temp[2]);  // ../../RTL/CPU/BIU/mmu.v(111)
  buf u160 (haddr[47], a[47]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u161 (haddr[48], a[48]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u162 (haddr[49], a[49]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u163 (haddr[50], a[50]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u164 (haddr[51], a[51]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u165 (haddr[52], a[52]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u166 (haddr[53], a[53]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u167 (haddr[54], a[54]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u168 (haddr[55], a[55]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u169 (haddr[56], a[56]);  // ../../RTL/CPU/BIU/mmu.v(233)
  and u17 (n15, mxr, pte_temp[3]);  // ../../RTL/CPU/BIU/mmu.v(111)
  buf u170 (haddr[57], a[57]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u171 (haddr[58], a[58]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u172 (haddr[59], a[59]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u173 (haddr[60], a[60]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u174 (haddr[61], a[61]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u175 (haddr[62], a[62]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u176 (haddr[63], a[63]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u177 (read_data[1], pte_temp[1]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u178 (read_data[2], pte_temp[2]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u179 (read_data[3], pte_temp[3]);  // ../../RTL/CPU/BIU/mmu.v(230)
  or u18 (n16, pte_temp[1], n15);  // ../../RTL/CPU/BIU/mmu.v(111)
  buf u180 (read_data[4], pte_temp[4]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u181 (read_data[5], pte_temp[5]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u182 (read_data[6], pte_temp[6]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u183 (read_data[7], pte_temp[7]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u184 (read_data[8], pte_temp[8]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u185 (read_data[9], pte_temp[9]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u186 (read_data[10], pte_temp[10]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u187 (read_data[11], pte_temp[11]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u188 (read_data[12], pte_temp[12]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u189 (read_data[13], pte_temp[13]);  // ../../RTL/CPU/BIU/mmu.v(230)
  and u19 (n17, n14, n16);  // ../../RTL/CPU/BIU/mmu.v(111)
  buf u190 (read_data[14], pte_temp[14]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u191 (read_data[15], pte_temp[15]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u192 (read_data[16], pte_temp[16]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u193 (read_data[17], pte_temp[17]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u194 (read_data[18], pte_temp[18]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u195 (read_data[19], pte_temp[19]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u196 (read_data[20], pte_temp[20]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u197 (read_data[21], pte_temp[21]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u198 (read_data[22], pte_temp[22]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u199 (read_data[23], pte_temp[23]);  // ../../RTL/CPU/BIU/mmu.v(230)
  not u2 (n46[1], hresp);  // ../../RTL/CPU/BIU/mmu.v(143)
  or u20 (n18, n13, n17);  // ../../RTL/CPU/BIU/mmu.v(111)
  buf u200 (read_data[24], pte_temp[24]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u201 (read_data[25], pte_temp[25]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u202 (read_data[26], pte_temp[26]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u203 (read_data[27], pte_temp[27]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u204 (read_data[28], pte_temp[28]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u205 (read_data[29], pte_temp[29]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u206 (read_data[30], pte_temp[30]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u207 (read_data[31], pte_temp[31]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u208 (read_data[32], pte_temp[32]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u209 (read_data[33], pte_temp[33]);  // ../../RTL/CPU/BIU/mmu.v(230)
  and u21 (n20, n19, pte_temp[3]);  // ../../RTL/CPU/BIU/mmu.v(111)
  buf u210 (read_data[34], pte_temp[34]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u211 (read_data[35], pte_temp[35]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u212 (read_data[36], pte_temp[36]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u213 (read_data[37], pte_temp[37]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u214 (read_data[38], pte_temp[38]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u215 (read_data[39], pte_temp[39]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u216 (read_data[40], pte_temp[40]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u217 (read_data[41], pte_temp[41]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u218 (read_data[42], pte_temp[42]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u219 (read_data[43], pte_temp[43]);  // ../../RTL/CPU/BIU/mmu.v(230)
  or u22 (n21, n18, n20);  // ../../RTL/CPU/BIU/mmu.v(111)
  buf u220 (read_data[44], pte_temp[44]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u221 (read_data[45], pte_temp[45]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u222 (read_data[46], pte_temp[46]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u223 (read_data[47], pte_temp[47]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u224 (read_data[48], pte_temp[48]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u225 (read_data[49], pte_temp[49]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u226 (read_data[50], pte_temp[50]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u227 (read_data[51], pte_temp[51]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u228 (read_data[52], pte_temp[52]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u229 (read_data[53], pte_temp[53]);  // ../../RTL/CPU/BIU/mmu.v(230)
  and u23 (n22, n11, n21);  // ../../RTL/CPU/BIU/mmu.v(111)
  buf u230 (read_data[54], pte_temp[54]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u231 (read_data[55], pte_temp[55]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u232 (read_data[56], pte_temp[56]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u233 (read_data[57], pte_temp[57]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u234 (read_data[58], pte_temp[58]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u235 (read_data[59], pte_temp[59]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u236 (read_data[60], pte_temp[60]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u237 (read_data[61], pte_temp[61]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u238 (read_data[62], pte_temp[62]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u239 (read_data[63], pte_temp[63]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u24 (hwdata[33], pte_temp[33]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u240 (paddress[1], p_address[1]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u241 (paddress[2], p_address[2]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u242 (paddress[3], p_address[3]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u243 (paddress[4], p_address[4]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u244 (paddress[5], p_address[5]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u245 (paddress[6], p_address[6]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u246 (paddress[7], p_address[7]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u247 (paddress[8], p_address[8]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u248 (paddress[9], p_address[9]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u249 (paddress[10], p_address[10]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u25 (hwdata[32], pte_temp[32]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u250 (paddress[11], p_address[11]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u251 (paddress[12], p_address[12]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u252 (paddress[13], p_address[13]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u253 (paddress[14], p_address[14]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u254 (paddress[15], p_address[15]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u255 (paddress[16], p_address[16]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u256 (paddress[17], p_address[17]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u257 (paddress[18], p_address[18]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u258 (paddress[19], p_address[19]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u259 (paddress[20], p_address[20]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u26 (hwdata[31], pte_temp[31]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u260 (paddress[21], p_address[21]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u261 (paddress[22], p_address[22]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u262 (paddress[23], p_address[23]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u263 (paddress[24], p_address[24]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u264 (paddress[25], p_address[25]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u265 (paddress[26], p_address[26]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u266 (paddress[27], p_address[27]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u267 (paddress[28], p_address[28]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u268 (paddress[29], p_address[29]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u269 (paddress[30], p_address[30]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u27 (hwdata[30], pte_temp[30]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u270 (paddress[31], p_address[31]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u271 (paddress[32], p_address[32]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u272 (paddress[33], p_address[33]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u273 (paddress[34], p_address[34]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u274 (paddress[35], p_address[35]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u275 (paddress[36], p_address[36]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u276 (paddress[37], p_address[37]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u277 (paddress[38], p_address[38]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u278 (paddress[39], p_address[39]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u279 (paddress[40], p_address[40]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u28 (hwdata[29], pte_temp[29]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u280 (paddress[41], p_address[41]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u281 (paddress[42], p_address[42]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u282 (paddress[43], p_address[43]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u283 (paddress[44], p_address[44]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u284 (paddress[45], p_address[45]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u285 (paddress[46], p_address[46]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u286 (paddress[47], p_address[47]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u287 (paddress[48], p_address[48]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u288 (paddress[49], p_address[49]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u289 (paddress[50], p_address[50]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u29 (hwdata[28], pte_temp[28]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u290 (paddress[51], p_address[51]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u291 (paddress[52], p_address[52]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u292 (paddress[53], p_address[53]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u293 (paddress[54], p_address[54]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u294 (paddress[55], p_address[55]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u295 (paddress[56], p_address[56]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u296 (paddress[57], p_address[57]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u297 (paddress[58], p_address[58]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u298 (paddress[59], p_address[59]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u299 (paddress[60], p_address[60]);  // ../../RTL/CPU/BIU/mmu.v(227)
  not u3 (n38[0], leaf_page);  // ../../RTL/CPU/BIU/mmu.v(134)
  buf u30 (hwdata[27], pte_temp[27]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u300 (paddress[61], p_address[61]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u301 (paddress[62], p_address[62]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u302 (paddress[63], p_address[63]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u303 (paddress[64], a[0]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u304 (paddress[65], a[1]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u305 (paddress[66], a[2]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u306 (paddress[67], a[3]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u307 (paddress[68], a[4]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u308 (paddress[69], a[5]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u309 (paddress[70], a[6]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u31 (hwdata[26], pte_temp[26]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u310 (paddress[71], a[7]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u311 (paddress[72], a[8]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u312 (paddress[73], a[9]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u313 (paddress[74], a[10]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u314 (paddress[75], a[11]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u315 (paddress[76], a[12]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u316 (paddress[77], a[13]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u317 (paddress[78], a[14]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u318 (paddress[79], a[15]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u319 (paddress[80], a[16]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u32 (hwdata[25], pte_temp[25]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u320 (paddress[81], a[17]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u321 (paddress[82], a[18]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u322 (paddress[83], a[19]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u323 (paddress[84], a[20]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u324 (paddress[85], a[21]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u325 (paddress[86], a[22]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u326 (paddress[87], a[23]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u327 (paddress[88], a[24]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u328 (paddress[89], a[25]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u329 (paddress[90], a[26]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u33 (hwdata[24], pte_temp[24]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u330 (paddress[91], a[27]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u331 (paddress[92], a[28]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u332 (paddress[93], a[29]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u333 (paddress[94], a[30]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u334 (paddress[95], a[31]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u335 (paddress[96], a[32]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u336 (paddress[97], a[33]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u337 (paddress[98], a[34]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u338 (paddress[99], a[35]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u339 (paddress[100], a[36]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u34 (hwdata[23], pte_temp[23]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u340 (paddress[101], a[37]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u341 (paddress[102], a[38]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u342 (paddress[103], a[39]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u343 (paddress[104], a[40]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u344 (paddress[105], a[41]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u345 (paddress[106], a[42]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u346 (paddress[107], a[43]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u347 (paddress[108], a[44]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u348 (paddress[109], a[45]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u349 (paddress[110], a[46]);  // ../../RTL/CPU/BIU/mmu.v(227)
  and u35 (n23, n8, n21);  // ../../RTL/CPU/BIU/mmu.v(112)
  buf u350 (paddress[111], a[47]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u351 (paddress[112], a[48]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u352 (paddress[113], a[49]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u353 (paddress[114], a[50]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u354 (paddress[115], a[51]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u355 (paddress[116], a[52]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u356 (paddress[117], a[53]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u357 (paddress[118], a[54]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u358 (paddress[119], a[55]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u359 (paddress[120], a[56]);  // ../../RTL/CPU/BIU/mmu.v(227)
  or u36 (n24, n22, n23);  // ../../RTL/CPU/BIU/mmu.v(112)
  buf u360 (paddress[121], a[57]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u361 (paddress[122], a[58]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u362 (paddress[123], a[59]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u363 (paddress[124], a[60]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u364 (paddress[125], a[61]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u365 (paddress[126], a[62]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u366 (paddress[127], a[63]);  // ../../RTL/CPU/BIU/mmu.v(227)
  or u37 (page_chk_ok, n24, n25);  // ../../RTL/CPU/BIU/mmu.v(113)
  buf u38 (hwdata[22], pte_temp[22]);  // ../../RTL/CPU/BIU/mmu.v(240)
  and u39 (n32, pa_cov, n31);  // ../../RTL/CPU/BIU/mmu.v(125)
  not u4 (n0, pte_temp[6]);  // ../../RTL/CPU/BIU/mmu.v(105)
  buf u40 (hwdata[21], pte_temp[21]);  // ../../RTL/CPU/BIU/mmu.v(240)
  not u41 (n43[3], page_chk_ok);  // ../../RTL/CPU/BIU/mmu.v(137)
  buf u42 (hwdata[20], pte_temp[20]);  // ../../RTL/CPU/BIU/mmu.v(240)
  and u43 (n42, page_chk_ok, n0);  // ../../RTL/CPU/BIU/mmu.v(137)
  buf u44 (hwdata[19], pte_temp[19]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u45 (hwdata[35], pte_temp[35]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u46 (hwdata[18], pte_temp[18]);  // ../../RTL/CPU/BIU/mmu.v(240)
  or u47 (n58, rst, n30);  // ../../RTL/CPU/BIU/mmu.v(160)
  buf u48 (hwdata[17], pte_temp[17]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u49 (hwdata[16], pte_temp[16]);  // ../../RTL/CPU/BIU/mmu.v(240)
  and u5 (n2, pointer_page, n1);  // ../../RTL/CPU/BIU/mmu.v(105)
  buf u50 (hwdata[15], pte_temp[15]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u51 (hwdata[14], pte_temp[14]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u52 (hwdata[13], pte_temp[13]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u53 (hwdata[12], pte_temp[12]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u54 (hwdata[11], pte_temp[11]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u55 (hwdata[10], pte_temp[10]);  // ../../RTL/CPU/BIU/mmu.v(240)
  and u56 (n74, n73, pa_cov);  // ../../RTL/CPU/BIU/mmu.v(209)
  buf u57 (hwdata[9], pte_temp[9]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u58 (hwdata[8], pte_temp[8]);  // ../../RTL/CPU/BIU/mmu.v(240)
  AL_MUX u59 (
    .i0(pte_temp[6]),
    .i1(1'b1),
    .sel(n41),
    .o(n77));  // ../../RTL/CPU/BIU/mmu.v(217)
  or u6 (page_unvalid, n0, n2);  // ../../RTL/CPU/BIU/mmu.v(105)
  buf u60 (hwdata[7], pte_temp[7]);  // ../../RTL/CPU/BIU/mmu.v(240)
  and u61 (cacheable, trans_rdy, n81);  // ../../RTL/CPU/BIU/mmu.v(221)
  buf u62 (hwdata[6], pte_temp[6]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u63 (hwdata[5], pte_temp[5]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u64 (hwdata[4], pte_temp[4]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u65 (hwdata[3], pte_temp[3]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u66 (hwdata[36], pte_temp[36]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u67 (paddress[0], p_address[0]);  // ../../RTL/CPU/BIU/mmu.v(227)
  buf u68 (read_data[0], pte_temp[0]);  // ../../RTL/CPU/BIU/mmu.v(230)
  buf u69 (hwdata[2], pte_temp[2]);  // ../../RTL/CPU/BIU/mmu.v(240)
  not u7 (n3, pte_temp[3]);  // ../../RTL/CPU/BIU/mmu.v(106)
  buf u70 (haddr[0], a[0]);  // ../../RTL/CPU/BIU/mmu.v(233)
  buf u71 (hsize[0], 1'b1);  // ../../RTL/CPU/BIU/mmu.v(235)
  buf u72 (hburst[0], 1'b0);  // ../../RTL/CPU/BIU/mmu.v(236)
  buf u73 (hwdata[1], pte_temp[1]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u74 (hwdata[0], pte_temp[0]);  // ../../RTL/CPU/BIU/mmu.v(240)
  or u75 (htrans[1], n34, hwrite);  // ../../RTL/CPU/BIU/mmu.v(238)
  buf u76 (hwdata[34], pte_temp[34]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u77 (hmastlock, 1'b0);  // ../../RTL/CPU/BIU/mmu.v(239)
  buf u78 (hprot[0], 1'b1);  // ../../RTL/CPU/BIU/mmu.v(237)
  buf u79 (hwdata[37], pte_temp[37]);  // ../../RTL/CPU/BIU/mmu.v(240)
  not u8 (n4, pte_temp[2]);  // ../../RTL/CPU/BIU/mmu.v(106)
  buf u80 (hwdata[38], pte_temp[38]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u81 (hwdata[39], pte_temp[39]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u82 (hwdata[40], pte_temp[40]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u83 (hwdata[41], pte_temp[41]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u84 (hwdata[42], pte_temp[42]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u85 (hwdata[43], pte_temp[43]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u86 (hwdata[44], pte_temp[44]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u87 (hwdata[45], pte_temp[45]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u88 (hwdata[46], pte_temp[46]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u89 (hwdata[47], pte_temp[47]);  // ../../RTL/CPU/BIU/mmu.v(240)
  and u9 (n5, n3, n4);  // ../../RTL/CPU/BIU/mmu.v(106)
  buf u90 (hwdata[48], pte_temp[48]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u91 (hwdata[49], pte_temp[49]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u92 (hwdata[50], pte_temp[50]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u93 (hwdata[51], pte_temp[51]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u94 (hwdata[52], pte_temp[52]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u95 (hwdata[53], pte_temp[53]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u96 (hwdata[54], pte_temp[54]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u97 (hwdata[55], pte_temp[55]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u98 (hwdata[56], pte_temp[56]);  // ../../RTL/CPU/BIU/mmu.v(240)
  buf u99 (hwdata[57], pte_temp[57]);  // ../../RTL/CPU/BIU/mmu.v(240)

endmodule 

module reg_ar_as_w9
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [8:0] d;
  input en;
  input [8:0] reset;
  input [8:0] set;
  output [8:0] q;



endmodule 

module add_pu9_mu9_o9
  (
  i0,
  i1,
  o
  );

  input [8:0] i0;
  input [8:0] i1;
  output [8:0] o;



endmodule 

module ram_w9x8_r9x8
  (
  clk1,
  ra1,
  re1,
  wa1,
  wd1,
  we1,
  rd1
  );

  input clk1;
  input [8:0] ra1;
  input re1;
  input [8:0] wa1;
  input [7:0] wd1;
  input we1;
  output [7:0] rd1;



endmodule 

module add_pu64_pu64_o64
  (
  i0,
  i1,
  o
  );

  input [63:0] i0;
  input [63:0] i1;
  output [63:0] o;



endmodule 

module eq_w52
  (
  i0,
  i1,
  o
  );

  input [51:0] i0;
  input [51:0] i1;
  output o;



endmodule 

module binary_mux_s1_w128
  (
  i0,
  i1,
  sel,
  o
  );

  input [127:0] i0;
  input [127:0] i1;
  input sel;
  output [127:0] o;



endmodule 

module reg_ar_as_w128
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [127:0] d;
  input en;
  input [127:0] reset;
  input [127:0] set;
  output [127:0] q;



endmodule 

module binary_mux_s1_w44
  (
  i0,
  i1,
  sel,
  o
  );

  input [43:0] i0;
  input [43:0] i1;
  input sel;
  output [43:0] o;



endmodule 

module reg_ar_as_w44
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [43:0] d;
  input en;
  input [43:0] reset;
  input [43:0] set;
  output [43:0] q;



endmodule 

module reg_ar_as_w2
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [1:0] d;
  input en;
  input [1:0] reset;
  input [1:0] set;
  output [1:0] q;



endmodule 

module eq_w64
  (
  i0,
  i1,
  o
  );

  input [63:0] i0;
  input [63:0] i1;
  output o;



endmodule 

module lt_u64_u64
  (
  ci,
  i0,
  i1,
  o
  );

  input ci;
  input [63:0] i0;
  input [63:0] i1;
  output o;



endmodule 

module binary_mux_s1_w48
  (
  i0,
  i1,
  sel,
  o
  );

  input [47:0] i0;
  input [47:0] i1;
  input sel;
  output [47:0] o;



endmodule 

module binary_mux_s1_w40
  (
  i0,
  i1,
  sel,
  o
  );

  input [39:0] i0;
  input [39:0] i1;
  input sel;
  output [39:0] o;



endmodule 

module binary_mux_s1_w24
  (
  i0,
  i1,
  sel,
  o
  );

  input [23:0] i0;
  input [23:0] i1;
  input sel;
  output [23:0] o;



endmodule 

module binary_mux_s1_w16
  (
  i0,
  i1,
  sel,
  o
  );

  input [15:0] i0;
  input [15:0] i1;
  input sel;
  output [15:0] o;



endmodule 

module binary_mux_s1_w56
  (
  i0,
  i1,
  sel,
  o
  );

  input [55:0] i0;
  input [55:0] i1;
  input sel;
  output [55:0] o;



endmodule 

module eq_w32
  (
  i0,
  i1,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  output o;



endmodule 

module binary_mux_s2_w64
  (
  i0,
  i1,
  i2,
  i3,
  sel,
  o
  );

  input [63:0] i0;
  input [63:0] i1;
  input [63:0] i2;
  input [63:0] i3;
  input [1:0] sel;
  output [63:0] o;



endmodule 

module ne_w4
  (
  i0,
  i1,
  o
  );

  input [3:0] i0;
  input [3:0] i1;
  output o;



endmodule 

module add_pu2_mu2_o2
  (
  i0,
  i1,
  o
  );

  input [1:0] i0;
  input [1:0] i1;
  output [1:0] o;



endmodule 

module AL_MUX
  (
  input i0,
  input i1,
  input sel,
  output o
  );

  wire not_sel, sel_i0, sel_i1;
  not u0 (not_sel, sel);
  and u1 (sel_i1, sel, i1);
  and u2 (sel_i0, not_sel, i0);
  or u3 (o, sel_i1, sel_i0);

endmodule

module AL_DFF
  (
  input reset,
  input set,
  input clk,
  input d,
  output reg q
  );

  parameter INI = 1'b0;

  always @(posedge reset or posedge set or posedge clk)
  begin
    if (reset)
      q <= 1'b0;
    else if (set)
      q <= 1'b1;
    else
      q <= d;
  end

endmodule

