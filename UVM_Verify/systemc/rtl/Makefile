## Written from example by
## https://github.com/ZipCPU/dbgbus/blob/master/bench/rtl/Makefile

all:
OJB_DIR  := obj_dir
TOP_MOD = wrap_ii_gen
SUBMAKE := $(MAKE) --no-print-directory -C
VERILATOR := verilator

VFLAGS = -sc -CFLAGS -fpic -LDFLAGS -Wno-fatal --Mdir $(OJB_DIR) -Ibuild/svlib -Ibuild --pins-sc-uint
TRACE_FLAGS = --trace -no-trace-params --trace-structs

.PHONY: all
all: verilate library

.PHONY: verilate
verilate: $(OJB_DIR)/V$(TOP_MOD).h

$(OJB_DIR)/V$(TOP_MOD).h:
	-$(VERILATOR) $(VFLAGS) $(TRACE_FLAGS) build/$(TOP_MOD).sv

.PHONY: library
library: $(OJB_DIR)/V$(TOP_MOD).h
	$(SUBMAKE) $(OJB_DIR)/ -f V$(TOP_MOD).mk

.PHONY: clean
clean:
	rm -rf $(OJB_DIR)/

DEPS := $(wildcard $(OJB_DIR)/*.d)

ifneq ($(DEPS),)
include $(DEPS)
endif
