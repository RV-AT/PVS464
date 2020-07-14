#ifndef SEQUENCER_HPP
#define SEQUENCER_HPP

#include <systemc>
#include <tlm>
#include <string>
#include <tlm_utils/simple_initiator_socket.h>
#include <sstream>
#include <queue>

class sequencer :
  public sc_core::sc_module
{
public:
  sequencer(sc_core::sc_module_name);

	tlm_utils::simple_initiator_socket<sequencer> isoc;

protected:
	// sc_dt::sc_uint<8> val;
  std::queue<sc_dt::sc_uint<32> > data;

	void test();
  void gen();

	typedef tlm::tlm_base_protocol_types::tlm_payload_type pl_t;
	void b_transport(pl_t&, sc_core::sc_time&);
  void msg(const pl_t& pl);
};

#endif
