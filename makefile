
verilate:
	make -C systemc/ verilate

uvm: verilate
	make -C uvm/example

test: uvm
	make -C uvm/example test

wave: test
	make -C uvm/example wave

APR: 
	find -name ".v" ./RTL | xargs cat >> ./APR/RTL/$(target).v
	make -C APR 


.PHONY: clean
clean:
	make -C systemc/ clean
	make -C uvm/example clean