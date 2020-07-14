#ifndef DTI_SEQUENCE_HPP_
#define DTI_SEQUENCE_HPP_

#include <sstream>
#include <string>
#include <systemc>
#include <tlm.h>
#include <uvm>

#include <iostream>
#include <vector>
#include <typeinfo>

#include <csignal>

template <typename packet_type = uvm::uvm_sequence_item, typename RSP = packet_type>
class dti_sequence : public uvm::uvm_sequence<packet_type, RSP> {
public:
  std::vector<std::vector <unsigned int> > data;

  dti_sequence(const std::string &name) : uvm::uvm_sequence<packet_type, RSP>(name) {}

  UVM_OBJECT_PARAM_UTILS(dti_sequence<packet_type, RSP>);

  void pre_body() {
    // raise objection if started as a root dti_sequence
    if (this->starting_phase != NULL)
      this->starting_phase->raise_objection(this);

    generate_sequence();
  }

  void body() {
    packet_type *req;
    RSP *rsp;
    req = new packet_type();
    rsp = new RSP();

    for (auto j = data.begin(); j != data.end(); ++j) {
      if(j+1 == data.end())
        req->data.eot[1] = 1;

      for (auto i = j->begin(); i != j->end(); ++i){
        unsigned int out_data;

        if(i+1 == j->end())
          req->data.eot[0] = 1;
        else
          req->data.eot[0] = 0;

        req->data = *i;
        // std::cout << req << "\n";

        message(*req);

        this->start_item(req);
        this->finish_item(req);
        this->get_response(rsp);
      }
    }
    UVM_INFO(this->get_name(), "Finishing sequence", uvm::UVM_MEDIUM);
  }

  void post_body() {
    // drop objection if started as a root dti_sequence
    if (this->starting_phase != NULL)
      this->starting_phase->drop_objection(this);
  }

  void message(const packet_type &p) {
    std::stringstream ss;
    ss << p.data;
    std::string msg = ss.str();
    UVM_INFO(" Generated data:", msg, uvm::UVM_MEDIUM);
  }

  void generate_sequence() {

    for(int j = 0; j<5; j++){
      std::vector<unsigned int> lower;
      for(int i = 0; i<5; i++){
        lower.push_back(i+1);
      }
      data.push_back(lower);
    }
  }
};

#endif
