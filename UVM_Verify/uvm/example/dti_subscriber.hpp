#ifndef DTI_SUBSCRIBER_H_
#define DTI_SUBSCRIBER_H_

#include <systemc>
#include <tlm.h>
#include <uvm>

#include "dti_scoreboard.hpp"

template <class packet_type, class sb_t, void (sb_t::*F)(const packet_type& a)>
class dti_subscriber : public uvm::uvm_subscriber<packet_type> {
public:
  sb_t *sb;
  uvm::uvm_object *obj;

  UVM_COMPONENT_UTILS(dti_subscriber);

  dti_subscriber(uvm::uvm_component_name name)
    : uvm::uvm_subscriber<packet_type>(name){
      uvm::uvm_config_db<uvm::uvm_object*>::get(this, "", "sb", obj);

      sb = dynamic_cast<sb_t *>(obj);
  };

  virtual void write(const packet_type &p){
    // sb->write(p);
    (sb->*F)(p);
  }
};

#endif /* DTI_SUBSCRIBER_H_ */
