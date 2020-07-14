#ifndef DATA_TYPES_HPP_
#define DATA_TYPES_HPP_

#include <systemc>
#include <iostream>
#include <string>
#include <sstream>

template <class dt, int LVL> class queue_type {
public:
  dt data;
  sc_dt::sc_uint<LVL> eot;

  queue_type() : data(0), eot(0) {}
  queue_type(unsigned int d) : data(d) {}

  void operator=(const unsigned int rhs){ data = rhs; }
  void operator=(const queue_type rhs) {
    data = rhs.data;
    eot = rhs.eot;
  }
  template<int W>
  void operator=(const sc_dt::sc_uint<W> rhs) {
    data = (dt)rhs;
    eot = rhs >> data.length();
  }

  void set(const dt data_rhs, const sc_dt::sc_uint<LVL> eot_rhs)const {
    data = data_rhs;
    eot = eot_rhs;
  }

  bool eos() const{
    for(int i=0; i<LVL; i++)
      if(eot[i] == 0)
        return false;

    return true;
  }

  unsigned int pack() const{
    unsigned int tmp = (unsigned int) data;
    tmp = (eot << data.length()) | tmp;
    return tmp;
  }

  operator unsigned int() const {
    return pack();
  };

  operator int() const {return pack();};

  template<class D, int L>
  friend std::ostream& operator<<(std::ostream& out, const queue_type<D, L>& q);

  std::string str(){
    std::stringstream ss;
    ss << "0x" << std::hex << data;
    return ss.str();
  }

};

template<class D, int L>
std::ostream& operator<<(std::ostream& out, const queue_type<D, L>& q){
  out << "Data: " << q.data << " eot: " << q.eot << std::endl;
  return out;
}

#endif /* DATA_TYPES_HPP_ */
