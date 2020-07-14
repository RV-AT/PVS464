#ifndef INTF_HPP
#define INTF_HPP

#include "systemc.h"

class dti_intf {
public:
  sc_signal<bool> *dti_ready;
  sc_signal<bool> *dti_valid;
  sc_signal<uint32_t> *dti_data;

  dti_intf(sc_signal<bool> *ready, sc_signal<bool> *valid,
           sc_signal<uint32_t> *data) {
    dti_ready = ready;
    dti_valid = valid;
    dti_data = data;
  }

  dti_intf(dti_intf *intf_ext){
    dti_ready = intf_ext->dti_ready;
    dti_valid = intf_ext->dti_valid;
    dti_data = intf_ext->dti_data;
  }

  ~dti_intf(){

  }
};

#endif
