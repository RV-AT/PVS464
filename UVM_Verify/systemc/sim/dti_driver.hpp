#ifndef DTI_DRIVER_HPP
#define DTI_DRIVER_HPP

#include "systemc.h"
#include <stdint.h>
#include <stdio.h>
#include <tlm>
#include <tlm_utils/simple_target_socket.h>
#include "intf.hpp"
#include <sstream>

template <class data_T> struct seq_item {
  bool valid;
  bool ready;
  data_T data;
};

// template <class data_T>
class dti_drv :
  public sc_core::sc_module
{
public:
  seq_item<sc_bv<32> > item;
  dti_intf *intf;
  sc_in<bool> clk;
  sc_in<bool> rst;


  dti_drv(sc_core::sc_module_name, dti_intf *intf_ext);

  ~dti_drv(){
  }

	tlm_utils::simple_target_socket<dti_drv> soc;

protected:
	// sc_dt::sc_uint<32> val;

	typedef tlm::tlm_base_protocol_types::tlm_payload_type pl_t;
	void b_transport(pl_t&, sc_core::sc_time&);
	void msg(const pl_t&);

};

#endif
