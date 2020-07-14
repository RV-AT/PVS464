#ifndef DTI_SEQUENCER_HPP_
#define DTI_SEQUENCER_HPP_

#include <systemc>
#include <tlm.h>
#include <uvm>

template <class REQ>
class dti_sequencer : public uvm::uvm_sequencer<REQ>
{
public:
  dti_sequencer( uvm::uvm_component_name name ) : uvm::uvm_sequencer<REQ>( name )
  {
  }

  UVM_COMPONENT_PARAM_UTILS(dti_sequencer<REQ>);

};


#endif
