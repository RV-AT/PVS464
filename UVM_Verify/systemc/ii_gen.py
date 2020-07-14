from cascade_classifier.pygears_impl.design import ii_gen
from cascade_classifier.pygears_impl.scripts.svlib_utils import copy_svlib

from pygears.typing import Queue, Uint
from pygears.lib.verif import drv
from pygears.lib import shred
from pygears.hdl import hdlgen
from pygears.conf.registry import bind
from pygears.synth import list_hdl_files

from string import Template
signal_spy_connect_t = Template("""
/*verilator tracing_on*/
${intf_name}_t ${intf_name}_data;
logic ${intf_name}_valid;
logic ${intf_name}_ready;
/*verilator tracing_off*/

assign ${intf_name}_data = ${conn_name}.data;
assign ${intf_name}_valid = ${conn_name}.valid;
assign ${intf_name}_ready = ${conn_name}.ready;
""")

din_t = Queue[Uint[8], 2]

ii_gen(din=drv(t=din_t, seq=[]), frame_size=(5, 5))

bind('hdl/debug_intfs', [''])
bind('hdl/spy_connection_template', signal_spy_connect_t)
hdlgen('/ii_gen', outdir="rtl/build", wrapper=True, copy_files=True)
# print(list_hdl_files('/ii_gen', outdir='rtl/build', language='sv', rtl_only=True))

# copy_svlib(list_hdl_files('/ii_gen', outdir='rtl/build', language='sv', rtl_only=True))
