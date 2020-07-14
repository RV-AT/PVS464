#ifndef DTI_SCOREBOARD_H_
#define DTI_SCOREBOARD_H_

#include <systemc>
#include <uvm>

#include "dti_subscriber.hpp"

template <class packet_type>
class dti_scoreboard : public uvm::uvm_scoreboard
{
 public:
  uvm::uvm_analysis_export<packet_type> din_listener_imp;
  uvm::uvm_analysis_export<packet_type> dout_listener_imp;

  void din_write(const packet_type& p)
  {
    UVM_INFO("DIN_WRITE: ", p.str(), UVM_MEDIUM);
  }

  void dout_write(const packet_type& p)
  {
    UVM_INFO("DOUT_WRITE: ", p.str(), UVM_MEDIUM);
  }

  dti_subscriber<packet_type, dti_scoreboard<packet_type>, &dti_scoreboard<packet_type>::din_write > * din_listener;
  dti_subscriber<packet_type, dti_scoreboard<packet_type>, &dti_scoreboard<packet_type>::dout_write > * dout_listener;

  dti_scoreboard( uvm::uvm_component_name name ) : uvm::uvm_scoreboard( name ){}

  UVM_COMPONENT_UTILS(dti_scoreboard);


  void build_phase(uvm::uvm_phase& phase)
  {
    uvm::uvm_scoreboard::build_phase(phase);

    uvm::uvm_config_db<uvm_object*>::set(this, "din_listener", "sb", this);
    uvm::uvm_config_db<uvm_object*>::set(this, "dout_listener", "sb", this);

    din_listener = dti_subscriber<packet_type, dti_scoreboard<packet_type>, &dti_scoreboard<packet_type>::din_write  >::type_id::create("din_listener", this);
    assert(din_listener);

    dout_listener = dti_subscriber<packet_type, dti_scoreboard<packet_type>, &dti_scoreboard<packet_type>::dout_write  >::type_id::create("dout_listener", this);
    assert(dout_listener);
  }

  void connect_phase(uvm::uvm_phase& phase)
  {
    din_listener_imp.connect(din_listener->analysis_export);
    dout_listener_imp.connect(dout_listener->analysis_export);
  }

};

#endif /* DTI_SCOREBOARD_H_ */
