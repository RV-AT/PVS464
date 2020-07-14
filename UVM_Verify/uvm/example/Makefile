## Written from example by
## https://github.com/ZipCPU/dbgbus/blob/master/bench/rtl/Makefile

SYSTEMC := /tools/systemc
UVM_DIR = /tools/uvm_systemc
UVM_INSTALL_DIR = $(UVM_DIR)/objdir
CXX	:= g++
OBJDIR	:= obj-pc
RTLD	:= ../../systemc/rtl
VOBJDR	:= $(RTLD)/obj_dir
TOP_MOD = wrap_ii_gen
SYSC_OPT = -I${SYSTEMC}/include -L${SYSTEMC}/lib-linux64 -lsystemc
UVM_OPT = $(UVM_INSTALL_DIR)/src/uvmsc/.libs/libuvm-systemc.so -L$(UVM_DIR)/lib-linux64
UVM_SRC = -I$(UVM_DIR)/src/ -I$(UVM_INSTALL_DIR)/src/ -I$(UVM_DIR)/include

VERILATOR_ROOT ?= $(shell bash -c 'verilator -V|grep VERILATOR_ROOT | head -1 | sed -e " s/^.*=\s*//"')
VROOT	:= $(VERILATOR_ROOT)
VINCD   := $(VROOT)/include
VINC	:= -I$(VINCD) -I$(VOBJDR) -I$(SYSTEMC)/include

# We'll need to build these two Verilater files, and include them with our
# build
VSRCRAW := verilated.cpp verilated_vcd_sc.cpp verilated_vcd_c.cpp
VSRC    := $(addprefix $(VINCD)/,$(VSRCRAW))
VOBJ    := $(addprefix $(OBJDIR)/,$(subst .cpp,.o,$(VSRCRAW)))
INCS	:= $(VINC)
CFLAGS	:= -DHAVE_CONFIG_H -Wall -pedantic -Wno-long-long -Wno-variadic-macros -fmessage-length=0 -m64  -O3 -c -std=c++14 $(INCS)
LINK_FLAGS = -Og -g -Wall --std=c++14

all: main_tb
SUBMAKE := $(MAKE) --no-print-directory -C

SOURCES := $(wildcard *.cpp)
HEADERS := $(wildcard *.hpp)
OBJECTS := $(addprefix $(OBJDIR)/,$(subst .cpp,.o,$(SOURCES))) $(VOBJ)

PROGRAMS := main_tb

all: $(PROGRAMS)

# Generic build instructions for object files
$(OBJDIR)/%.o: %.cpp
	$(mk-objdir)
	$(CXX) $(CFLAGS) -c $(SYSC_OPT) $(UVM_SRC) $< -o $@

# And we'll repeat those instructions for building object files from sources
# within the Verilator directory found within $(VERILATOR_ROOT)
$(OBJDIR)/%.o: $(VINCD)/%.cpp
	$(mk-objdir)
	$(CXX) $(CFLAGS) $(SYSC_OPT) -c $< -o $@

# Build our actual target.  Note the dependency on the $(OBJECTS) list of
# object files above
main_tb: $(OBJECTS) $(VOBJDR)/V$(TOP_MOD)__ALL.a
	-g++ $(LINK_FLAGS) $(SYSC_OPT) $(UVM_OPT) $(OBJECTS) $(VOBJDR)/V$(TOP_MOD)__ALL.a -lpthread -pthread -Wl,-rpath -Wl,$(UVM_DIR)/lib-linux64 -Wl,-rpath -Wl,$(SYSTEMC)/lib-linux64 -o $@

# The "test" target, just runs our test bench object
#
.PHONY: test
test: main_tb
	./main_tb

.PHONY: wave
wave: test
	gtkwave top.vcd

#
# The "clean" target, removing any and all remaining build (and test) products
#
.PHONY: clean
clean:
	rm -f *.vcd
	rm -f $(PROGRAMS)
	rm -rf $(OBJDIR)/

# The "depends" target, to know what files things depend upon.  The depends
# file itself is kept in $(OBJDIR)/depends.txt
#
define build-depends
	$(mk-objdir)
	@echo "Building dependency file"
	@$(CXX) $(CFLAGS) $(SYSC_OPT) $(INCS) -MM $(SOURCES) > $(OBJDIR)/xdepends.txt
	@sed -e 's/^.*.o: /$(OBJDIR)\/&/' < $(OBJDIR)/xdepends.txt > $(OBJDIR)/depends.txt
	@rm $(OBJDIR)/xdepends.txt
endef

.PHONY: depends
depends: tags
	$(build-depends)

$(OBJDIR)/depends.txt: depends

#
# Make sure the $(OBJDIR)/ directory exists.  This has taken some work to get
# right.  While "mkdir -p $(OBJDIR)" could be used to do this as well, it
# always bothered me that it seemed to be perpetually running.  Hence, we'll
# first check if the directory exists, and only create it if it does not.
# Finally, by adding the @ in front of the bash command, it won't get printed
# to the screen.  That way ... I can run it as often as I want without getting
# annoyed by it.  ;)
define	mk-objdir
	@bash -c "if [ ! -e $(OBJDIR) ]; then mkdir -p $(OBJDIR); fi"
endef


#
# The "tags" target
#
tags:	$(SOURCES) $(HEADERS)
	@echo "Generating tags"
	@ctags $(SOURCES) $(HEADERS)

#
# Include our generated dependency file.  The "-" in front of the include
# basically tells "make" to include it if it can, and ignore it if it cannot
# be included (i.e. if it doesn't exist)
-include $(OBJDIR)/depends.txt