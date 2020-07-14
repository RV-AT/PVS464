#ifndef DTI_VIF_HPP_
#define DTI_VIF_HPP_

#include <systemc>
#include <uvm>

using namespace uvm;

template <class data_type>
class dti_vif
{
public:
  sc_core::sc_clock *clk;
  sc_core::sc_signal<bool> *rst;

  sc_core::sc_signal<bool> dti_valid;
  sc_core::sc_signal<bool> dti_ready;
  sc_core::sc_signal<data_type> dti_data;

  dti_vif(sc_core::sc_clock *clk_in, sc_core::sc_signal<bool> *rst_in){
    clk = clk_in;
    rst = rst_in;
  }
};

#endif /* DTI_VIF_HPP_ */
