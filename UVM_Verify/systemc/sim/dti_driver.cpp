#include "dti_driver.hpp"

using namespace sc_core;
using namespace tlm;
using namespace std;
using namespace sc_dt;

dti_drv::dti_drv(sc_module_name name, dti_intf *intf_ext)
    : sc_module(name), soc("soc") {
  soc.register_b_transport(this, &dti_drv::b_transport);
  intf = new dti_intf(intf_ext);
}

void dti_drv::b_transport(pl_t &pl, sc_time &offset) {
  tlm_command cmd = pl.get_command();

  wait(clk.negedge_event());
  if(rst == 0){
    if(cmd == TLM_WRITE_COMMAND) {
      sc_uint<32> val = *((sc_uint<32> *)pl.get_data_ptr());
      msg(pl);
      *(intf->dti_data) = val;
      *(intf->dti_valid) = 1;
      wait(clk.posedge_event());
      if(*(intf->dti_ready) != 1)
        pl.set_response_status(TLM_INCOMPLETE_RESPONSE);
      else
        pl.set_response_status(TLM_OK_RESPONSE);
    }
    else{
      pl.set_response_status(TLM_COMMAND_ERROR_RESPONSE);
      SC_REPORT_ERROR(sc_object::name(), "TLM bad command");
    }
  }
  else
    pl.set_response_status(TLM_INCOMPLETE_RESPONSE);
  // offset = sc_time(1, SC_NS);
}

void dti_drv::msg(const pl_t &pl) {
  stringstream ss;
  ss << hex << pl.get_address();
  sc_uint<32> val = *((sc_uint<32> *)pl.get_data_ptr());
  std::cout << val << std::endl;
  string cmd = pl.get_command() == TLM_READ_COMMAND ? "read  " : "write ";

  string msg = cmd + "val: " + to_string((int)val) + " adr: " + ss.str();
  msg += " @ " + sc_time_stamp().to_string();

  SC_REPORT_INFO(sc_object::name(), msg.c_str());
}
