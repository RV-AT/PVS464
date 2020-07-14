#include <systemc>
#include <uvm>
#include <verilated.h>
#include "Vwrap_ii_gen.h"

#include "top.hpp"

#include <iostream>
#include "data_types.hpp"

using namespace uvm;

int sc_main(int argc, char **argv) {
  Verilated::commandArgs(argc, argv);

  uvm::uvm_config_db<int>::set(NULL, "*", "recording_detail", uvm::UVM_LOW);
  uvm::uvm_set_verbosity_level(uvm::UVM_HIGH);


  top<Vwrap_ii_gen> *mytop = new top<Vwrap_ii_gen>("top", "v_top", 1000, "top.vcd");

  mytop->set_report_verbosity_level(UVM_HIGH);

  uvm_default_printer->knobs.reference = 0;

  uvm::uvm_root::get()->print_topology();

  uvm::run_test();

  delete mytop;

  return 0;
}
