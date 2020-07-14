#ifndef TOP_HPP_
#define TOP_HPP_

#include "verilated_vcd_sc.h"
#include <systemc>
#include <uvm>

#include "dti_vif.hpp"
#include "dti_packet.hpp"
#include "dti_agent.hpp"
#include "dti_sequence.hpp"
#include "data_types.hpp"

#include "dti_scoreboard.hpp"
#include "dti_subscriber.hpp"

#define W_DIN  10
#define W_DOUT  16

using vif_din_type = dti_vif<sc_dt::sc_uint<W_DIN> >;
using vif_dout_type = dti_vif<sc_dt::sc_uint<W_DOUT> >;

using packet_type = dti_packet<queue_type<sc_dt::sc_uint<W_DIN-2>, 2> >;


template <class MODULE> class top : public uvm::uvm_env {
public:
  MODULE dut;
  VerilatedVcdSc *m_trace;

  dti_agent<vif_din_type, packet_type >  *din_agent;
  dti_agent<vif_dout_type, packet_type >  *dout_agent;
  dti_scoreboard<packet_type> * scoreboard0;

  sc_core::sc_time T;
  sc_core::sc_time Tsim;

  sc_clock clk;
  sc_signal<bool> rst;

  vif_din_type *din_vif;
  vif_dout_type *dout_vif;

  UVM_COMPONENT_UTILS(top);

  /* clang-format off */
  top(uvm::uvm_component_name name, const char *dut_name, unsigned long Ncycle, const char *vcdname) :
    uvm::uvm_env(name),
    dut(dut_name),
    T(10, SC_NS),
    Tsim(T * Ncycle),
    clk("clk", T),
    rst("rst")
  {
    /* clang-format on */
    m_trace = new VerilatedVcdSc;
    Verilated::traceEverOn(true);
    open_trace(vcdname);
  }

  void build_phase(uvm::uvm_phase& phase)
  {

    uvm::uvm_env::build_phase(phase);
    uvm_config_db_options::turn_on_tracing();

    din_vif = new vif_din_type(&clk, &rst);
    dout_vif = new vif_dout_type(&clk, &rst);

    din_agent = dti_agent<vif_din_type, packet_type>::type_id::create("din_agent", this);
    assert(din_agent);

    dout_agent = dti_agent<vif_dout_type, packet_type >::type_id::create("dout_agent", this);
    assert(dout_agent);

    scoreboard0 = dti_scoreboard<packet_type>::type_id::create("scoreboard0", this);
    assert(scoreboard0);

    uvm::uvm_config_db<int>::set(this, "din_agent", "is_active", uvm::UVM_ACTIVE);
    uvm::uvm_config_db<Mode_T>::set(this, "din_agent.*", "mode", producer);

    uvm::uvm_config_db<int>::set(this, "dout_agent", "is_active", uvm::UVM_ACTIVE);
    uvm::uvm_config_db<Mode_T>::set(this, "dout_agent.*", "mode", consumer);

    uvm::uvm_config_db<vif_din_type *>::set(0, "top.din_agent.*", "vif", din_vif);
    uvm::uvm_config_db<vif_dout_type *>::set(0, "top.dout_agent.*", "vif", dout_vif);

    uvm::uvm_config_db<uvm_object_wrapper*>
      ::set(this,"din_agent.sequencer.run_phase","default_sequence",
            dti_sequence<packet_type>::type_id::get());

    // uvm::uvm_config_db<uvm_object_wrapper*>
    //   ::set(this,"dout_agent.sequencer.run_phase","default_sequence",
    //         dti_sequence<packet_type>::type_id::get());
  }


  void connect_phase(uvm::uvm_phase& phase){
    dut.clk(clk);
    dut.rst(rst);

    dut.din_ready(din_vif->dti_ready);
    dut.din_valid(din_vif->dti_valid);
    dut.din_data(din_vif->dti_data);
    dut.dout_valid(dout_vif->dti_valid);
    dut.dout_ready(dout_vif->dti_ready);
    dut.dout_data(dout_vif->dti_data);

    din_agent->monitor->item_collected_port.connect(scoreboard0->din_listener_imp);
    dout_agent->monitor->item_collected_port.connect(scoreboard0->dout_listener_imp);
  }


  void reset_phase(uvm::uvm_phase &phase) {
    phase.raise_objection(this);
    reset();
    phase.drop_objection(this);
  }

  void final_phase(uvm::uvm_phase &phase) {
    close_trace();
  }

  virtual void main_phase(uvm::uvm_phase &phase) {
    phase.raise_objection(this);
    sc_core::wait(Tsim); // 1ms
    UVM_INFO("Finishing simulation", "by watchdog", UVM_LOW);
    phase.drop_objection(this);
  }

  virtual void reset(void) {
    rst = 1;
    sc_core::wait(2 * T);
    rst = 0;
  }

  virtual void open_trace(const char *vcdname) {
    dut.trace(m_trace, 10);
    m_trace->open(vcdname);
  }

  virtual void close_trace(void) {
    m_trace->close();
    m_trace = NULL;
  }
};

#endif /* TOP_HPP_ */
