#ifndef DTI_DRIVER_HPP_
#define DTI_DRIVER_HPP_

#include <iostream>
#include <sstream>
#include <string>
#include <systemc>
#include <tlm.h>
#include <uvm>

enum Mode_T { producer = 0, consumer = 1 };

template <class REQ, class vif_type>
class dti_driver : public uvm::uvm_driver<REQ>
{
public:
  vif_type *vif;
  Mode_T mode;

  dti_driver(uvm::uvm_component_name name) : uvm::uvm_driver<REQ>(name) {}

  UVM_COMPONENT_PARAM_UTILS(dti_driver<REQ, vif_type>);

  void build_phase(uvm::uvm_phase &phase) {

    uvm::uvm_driver<REQ>::build_phase(phase);

    if (!uvm::uvm_config_db<Mode_T>::get(this, "*", "mode", mode))
      UVM_FATAL(this->name(), "Mode not defined! Simulation aborted!");
  }

  void connect_phase(uvm::uvm_phase &phase) {
    if (!uvm::uvm_config_db<vif_type *>::get(this, "*", "vif", vif))
      UVM_FATAL(this->name(),
                "Virtual interface not defined! Simulation aborted!");
  }

  void main_phase(uvm::uvm_phase &phase) {
    REQ req, rsp;

    if (mode == consumer)
      vif->dti_ready=1;

    while (true) // execute all sequences
    {
      this->seq_item_port->get_next_item(req);

      if (mode == producer){
        message(req);
        drive_transfer_producer(req);
      }

      rsp.set_id_info(req);
      this->seq_item_port->item_done();
      this->seq_item_port->put_response(rsp);
    }
  }

  int return_in(int data_in){
    return data_in;
  }
  void drive_transfer_producer(const REQ &p) {
    unsigned int tmp = p.data;
    vif->dti_data.write(tmp);
    vif->dti_valid = 1;
    do {
      sc_core::wait(vif->clk->posedge_event());
    } while (vif->dti_ready == 0);

    if(p.eos())
      vif->dti_valid = 0;
  }

  void drive_transfer_consumer(const REQ &p) {
    vif->dti_ready = 1;
    sc_core::wait(vif->clk->posedge_event());
  }

  void message(const REQ &p) {
    std::stringstream ss;
    ss << p.data;
    std::string msg = ss.str();
    UVM_INFO(" Driving data: ", msg, uvm::UVM_HIGH);
  }
};

#endif
