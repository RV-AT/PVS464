#ifndef DTI_AGENT_HPP_
#define DTI_AGENT_HPP_

#include <systemc>
#include <tlm.h>
#include <uvm>

#include "dti_driver.hpp"
#include "dti_monitor.hpp"
#include "dti_sequencer.hpp"

template <class vif_type, class packet_type>
class dti_agent : public uvm::uvm_agent {
public:
  dti_sequencer<packet_type> *sequencer;
  dti_driver<packet_type, vif_type> *driver;
  dti_monitor<vif_type, packet_type> *monitor;

  UVM_COMPONENT_UTILS(dti_agent);

  dti_agent(uvm::uvm_component_name name)
      : uvm_agent(name), driver(0), sequencer(0), monitor(0) {}

  void build_phase(uvm::uvm_phase &phase) {
    uvm::uvm_agent::build_phase(phase);

    if (get_is_active() == uvm::UVM_ACTIVE) {
      UVM_INFO(get_name(), "is set to UVM_ACTIVE", uvm::UVM_HIGH);

      sequencer =
          dti_sequencer<packet_type>::type_id::create("sequencer", this);
      assert(sequencer);

      driver =
          dti_driver<packet_type, vif_type>::type_id::create("driver", this);
      assert(driver);
    } else
      UVM_INFO(get_name(), "is set to UVM_PASSIVE", uvm::UVM_HIGH);

    monitor = dti_monitor<vif_type, packet_type>::type_id::create("monitor", this);
    assert(monitor);
  }

  void connect_phase(uvm::uvm_phase &phase) {
    if (get_is_active() == uvm::UVM_ACTIVE) {
      driver->seq_item_port.connect(sequencer->seq_item_export);
    }
  }
};

#endif
