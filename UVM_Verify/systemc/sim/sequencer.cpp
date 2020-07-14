#include "sequencer.hpp"
#include <tlm_utils/tlm_quantumkeeper.h>

using namespace sc_core;
using namespace sc_dt;
using namespace tlm;
using namespace std;

SC_HAS_PROCESS(sequencer);

sequencer::sequencer(sc_module_name name) :
  sc_module(name),
  isoc("isoc")
{
  SC_THREAD(gen);
	SC_THREAD(test);
}

void sequencer::gen()
{
  for(int i = 0; i < 5; i++){
    for(int j = 0; j < 5; j++){
      sc_uint<32> val = j+1;
      if(j == 4){
        val = val | 0x0100;
        if(i == 4)
          val = val | 0x0200;
      }
      data.push(val);
    }
  }

}

void sequencer::test()
{
	tlm_generic_payload pl;
	sc_time loct;
	tlm_utils::tlm_quantumkeeper qk;

  while(!data.empty()){
    sc_uint<32> val = data.front();
    data.pop();
    pl.set_address(0);
    pl.set_command(TLM_WRITE_COMMAND);
    pl.set_data_length(4);
    pl.set_data_ptr((unsigned char*)&val);
    // msg(pl);

    do
      isoc->b_transport(pl, loct);
    while(pl.get_response_status() != TLM_OK_RESPONSE);

    qk.set_and_sync(loct);

    loct = sc_time(1, SC_NS);
  }
}

void sequencer::msg(const pl_t& pl)
{
	stringstream ss;
	ss << std::hex << pl.get_address();
	sc_uint<32> val = *((sc_uint<32>*)pl.get_data_ptr());
	string cmd  = pl.get_command() == TLM_READ_COMMAND ? "read  " : "write ";

	string msg = cmd + "val: " + to_string((int)val) + " adr: " + ss.str();
	msg += " @ " + sc_time_stamp().to_string();

	SC_REPORT_INFO(sc_object::name(), msg.c_str());
}
