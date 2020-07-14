TOP_MOD = wrap_ii_gen
TOP_FN = $(TOP_MOD).sv

all: svgen verilate testbench

python_exec:
	python ii_gen.py

rmline: python_exec
	$(shell bash -c 'cat rtl/build/$(TOP_FN) | sed 1d > $(TOP_MOD).tmp')
	$(shell bash -c 'mv $(TOP_MOD).tmp rtl/build/$(TOP_FN)')

svgen: python_exec rmline

verilate: svgen
	make -C rtl/ all

testbench: verilate
	make -C sim/ all

test: testbench
	make -C sim/ test

wave: test
	make -C sim/ wave

.PHONY: clean
clean:
	rm -rf rtl/build
	make -C rtl/ clean
	make -C sim/ clean
