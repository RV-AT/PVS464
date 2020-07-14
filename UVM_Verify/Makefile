
verilate:
	make -C systemc/ verilate

uvm: verilate
	make -C uvm/example

test: uvm
	make -C uvm/example test

wave: test
	make -C uvm/example wave

.PHONY: clean
clean:
	make -C systemc/ clean
	make -C uvm/example clean
