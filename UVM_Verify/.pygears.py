import os
from pygears.conf.registry import registry, bind
from cascade_classifier.pygears_impl import design as design_dir

package_dir = os.path.dirname(design_dir.__file__)

svlib_dir = os.path.join(
    package_dir, 'gears', 'svlib')
registry('hdl/include_paths').append(svlib_dir)

bind('hdl/debug_intfs', ['*'])
