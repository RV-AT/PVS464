#ifndef TESTBENCH_H
#define TESTBENCH_H

#include "systemc.h"
#include "verilated_vcd_sc.h"
#include <stdint.h>
#include <stdio.h>
#include <verilated.h>
#include <cstdlib>
#include "intf.hpp"
#include "dti_driver.hpp"
#include "sequencer.hpp"

template <class MODULE> class TOP_ENV : sc_core::sc_module {
public:
  MODULE top_v;
  VerilatedVcdSc *m_trace;
  sc_core::sc_time T;
  sc_core::sc_time Tsim;

  /* Signal Declarations
   */

  dti_intf *din;
  dti_intf *dout;

  dti_drv *din_drv;
  // dti_drv *dout_drv;

  sequencer *din_seq;
  // sequencer *dout_seq;

  sc_clock clk;
  sc_signal<bool> rst;

  sc_signal<bool> din_ready;
  sc_signal<bool> din_valid;
  sc_signal<uint32_t> din_data;

  sc_signal<bool> dout_valid;
  sc_signal<bool> dout_ready;
  sc_signal<uint32_t> dout_data;

  /// ***************************************//////////

  /* clang-format off */

  SC_HAS_PROCESS(TOP_ENV);
  TOP_ENV(sc_module_name nm_top, const char *nm_mod, unsigned long Ncycle)
    : sc_module(nm_top),
      top_v(nm_mod),
      T(10, SC_NS),
      Tsim(T * Ncycle),
      clk("clk", T),
      rst("rst"),
      din_ready("din_ready"),
      din_valid("din_valid"),
      din_data("din_data"),
      dout_valid("dout_valid"),
      dout_ready("dout_ready"),
      dout_data("dout_data")
  {
    dout_ready = 1;

    top_v.clk(clk);
    top_v.rst(rst);
    top_v.din_ready(din_ready);
    top_v.din_valid(din_valid);
    top_v.din_data(din_data);
    top_v.dout_valid(dout_valid);
    top_v.dout_ready(dout_ready);
    top_v.dout_data(dout_data);

    din = new dti_intf(&din_ready, &din_valid, &din_data);
    dout = new dti_intf(&dout_ready, &dout_valid, &dout_data);

    din_drv = new dti_drv("din_drv", din);
    din_drv->clk(clk);
    din_drv->rst(rst);
    // dout_drv = new dti_drv("dout_drv", dout);

    din_seq = new sequencer("din_seq");
    // dout_seq = new sequencer("dout_seq");

    din_seq->isoc.bind(din_drv->soc);
    // dout_seq->isoc.bind(dout_drv->soc);

    m_trace = new VerilatedVcdSc;

    // SC_METHOD(monitor);
    // sensitive << clk.posedge_event();

    Verilated::traceEverOn(true);
  }
  /* clang-format on */

  ~TOP_ENV() {
    close_trace();
    delete din;
    delete dout;
    delete din_drv;
    // delete dout_drv;
    delete din_seq;
    // delete dout_seq;
  }

  void monitor(){
    std::cout << "@_" << sc_time_stamp() << "_ " << std::endl;
    if(sc_time_stamp() > sc_time(300, SC_NS) && sc_time_stamp() < sc_time(600, SC_NS)){
      *(dout->dti_ready) = 0;
    }
    else
      *(dout->dti_ready) = 1;
  }

  virtual void reset(void) {
    rst = 1;
    sc_start(10 * T);
    rst = 0;
  }

  virtual void start_sim(void) {
    reset();
    sc_start(Tsim);
  }

  virtual void open_trace(const char *vcdname) {
    top_v.trace(m_trace, 10);
    m_trace->open(vcdname);
  }

  virtual void close_trace(void) {
    m_trace->close();
    m_trace = NULL;
  }

  virtual bool done(void) { return (Verilated::gotFinish()); }
};

#endif
