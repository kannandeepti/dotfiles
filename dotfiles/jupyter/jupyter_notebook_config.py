#--- nbextensions configuration ---
import sys
sys.path.append('/home/bbeltr1/.local/share/jupyter/extensions')
#--- nbextensions configuration ---
from IPython.paths import get_ipython_dir
import os
import sys

ipythondir = get_ipython_dir()
extensions = os.path.join(ipythondir, 'extensions')
sys.path.append(extensions)


c = get_config()
# ... Any other configurables you want to set
c.IPKernelApp.matplotlib = 'inline'
c.NotebookApp.server_extensions = ['nbextensions']
c.NotebookApp.extra_template_paths = [os.path.join(ipythondir, 'templates')]