#ifndef DTI_MONITOR_HPP_
#define DTI_MONITOR_HPP_

#include <systemc>
#include <tlm.h>
#include <uvm>
#include <sstream>

template <class vif_type, class packet_type>
class dti_monitor : public uvm::uvm_monitor {
public:
  uvm::uvm_analysis_port<packet_type> item_collected_port;

  vif_type *vif;
  bool checks_enable;
  bool coverage_enable;

  dti_monitor(uvm::uvm_component_name name)
      : uvm_monitor(name), item_collected_port("item_collected_port"), vif(0),
        checks_enable(false), coverage_enable(false) {}

  UVM_COMPONENT_UTILS(dti_monitor);

  void build_phase(uvm::uvm_phase &phase) {
    uvm::uvm_monitor::build_phase(phase);

    uvm::uvm_config_db<bool>::get(this, "*", "checks_enable", checks_enable);
    uvm::uvm_config_db<bool>::get(this, "*", "coverage_enable",
                                  coverage_enable);
  }

  void connect_phase(uvm::uvm_phase &phase) {
    if (!uvm::uvm_config_db<vif_type *>::get(this, "*", "vif", vif))
      UVM_FATAL(this->name(),
                "Virtual interface not defined! Simulation aborted!");
  }

  void run_phase(uvm::uvm_phase &phase) {
    packet_type p;

    while (true) // monitor forever
    {
      sc_core::wait(vif->dti_data.default_event()); // wait for input changes
      p.data = vif->dti_data.read();
      message(p);
      item_collected_port.write(p);

      if (checks_enable) {
        UVM_FATAL(this->name(), "No checks yet");
      }
      if (coverage_enable) {
        UVM_FATAL(this->name(), "No checks yet");
      }
    }
  }

  void message(const packet_type &p) {
    std::stringstream ss;
    ss << p.data;
    std::string msg = ss.str();
    if(uvm::uvm_report_enabled(uvm::UVM_HIGH, uvm::UVM_INFO, "Test") == true)
      UVM_INFO(" Read data: ", msg, uvm::UVM_MEDIUM);
  }
};

#endif
