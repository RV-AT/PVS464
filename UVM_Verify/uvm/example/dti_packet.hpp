#ifndef DTI_PACKET_HPP_
#define DTI_PACKET_HPP_

#include <systemc>
#include <tlm.h>
#include <uvm>
#include <sstream>

#include <iostream>

template <class data_type>
class dti_packet : public uvm::uvm_sequence_item
{
public:
  UVM_OBJECT_UTILS(dti_packet);

  dti_packet(const std::string& name = "packet") : data(0){}
  dti_packet(unsigned int i) : data(i){}
  virtual ~dti_packet() { }

  virtual void do_print(const uvm::uvm_printer& printer) const
  {
    std::ostringstream ss;
    ss << data;
    printer.print_string("Packet: \n", ss.str(), ".");
  }

  bool eos() const{
    return data.eos();
  }
  // virtual void do_pack(uvm::uvm_packer& p) const
  // {
  //   p << data;
  // }

  // virtual void do_unpack(uvm::uvm_packer& p)
  // {
  //   p >> data;
  // }

  // virtual void do_copy(const uvm::uvm_object& rhs)
  // {
  //   const dti_packet* drhs = dynamic_cast<const dti_packet*>(&rhs);
  //   if (!drhs) { std::cerr << "ERROR in do_copy" << std::endl; return; }
  //   data = drhs->data;
  // }

  // virtual bool do_compare(const uvm_object& rhs, const uvm::uvm_comparer*) const
  // {
  //   const dti_packet* drhs = dynamic_cast<const dti_packet*>(&rhs);
  //   if (!drhs) { std::cerr << "ERROR in do_compare" << std::endl; return true; }
  //   if (!(data == drhs->data)) return false;
  //   return true;
  // }

  std::string str() const
  {
    std::ostringstream str;
    str << " data: " << data;
    return str.str();
  }


public:
  data_type data;

};

#endif
