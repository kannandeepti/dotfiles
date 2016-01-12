"""exec(this_file, dict(venv_directory=os.environ['VIRTUAL_ENV']))
will activate the current virtualenv environment.

This can be used when you must use an existing Python interpreter, not
the virtualenv bin/python. Modified from virtualenv's activate_this.py script.
"""
usage_string = __doc__.split('\n', 1)
try:
    venv_directory
except NameError:
    raise AssertionError("You must run this like " + usage_string)
import sys
import os
base = os.path.dirname(venv_directory)
old_os_path = os.environ.get('PATH', '')
os.environ['PATH'] = os.path.join(base, 'bin') + os.pathsep + old_os_path
if sys.platform == 'win32':
    site_packages = os.path.join(base, 'Lib', 'site-packages')
else:
    site_packages = os.path.join(base, 'lib', 'python%s' % sys.version[:3], 'site-packages')
prev_sys_path = list(sys.path)
import site
site.addsitedir(site_packages)
sys.real_prefix = sys.prefix
sys.prefix = base
# Move the added items to the front of the path:
new_sys_path = []
for item in list(sys.path):
    if item not in prev_sys_path:
        new_sys_path.append(item)
        sys.path.remove(item)
sys.path[:0] = new_sys_path
