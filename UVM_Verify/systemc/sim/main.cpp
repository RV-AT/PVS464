#include <iostream>
#include <stdlib.h>

#include "Vwrap_ii_gen.h"
#include "systemc.h"
#include "top_env.hpp"
#include <cstdlib>
#include <verilated.h>

#include "sequencer.hpp"
#include "dti_driver.hpp"

int sc_main(int argc, char **argv) {
  Verilated::commandArgs(argc, argv);
  TOP_ENV<Vwrap_ii_gen> top_obj("aaaa", "mod1", 1000);

  // dti_drv drv1("drv1");
  // sequencer seq("sequencer1");
  // seq.isoc.bind(drv1.soc);

  top_obj.open_trace("top.vcd");
  top_obj.start_sim();

  top_obj.close_trace();
  exit(EXIT_SUCCESS);
}
