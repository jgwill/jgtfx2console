import os
import sys
sys.path.insert(0, os.path.abspath('../'))
sys.path.insert(0, os.path.abspath('../jgtfx2console'))
from jgtfx2console import __version__
from jgtfx2console import jgtfxc,JGTPDS,jgtetl

autodoc_mock_imports = ['pandas']

project = 'jgtfx2console'
copyright = '2023, Guillaume Isabelle'
author = 'Guillaume Isabelle'

extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.doctest',
    'sphinx.ext.intersphinx',
]

templates_path = ['_templates']

source_suffix = '.rst'
master_doc = 'index'

version = __version__
release = __version__

exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

# Comment out or remove this line if the _static directory doesn't exist
# html_static_path = ['_static']

pygments_style = 'default'

html_theme = 'sphinx_rtd_theme'
# Make sure to update sphinx_rtd_theme to the latest version

htmlhelp_basename = 'JGTFxConDoc'

latex_documents = [
  ('index', 'TaPy.tex', 'JGTFxCon Documentation',
   'JGTPy Contributors', 'manual'),
]

# Updated format
#intersphinx_mapping = {'python': ('http://docs.python.org/', None)}
intersphinx_mapping = {
    'python': ('https://docs.python.org/3', None),
    'numpy': ('https://numpy.org/doc/stable', None),
    'pandas': ('https://pandas.pydata.org/pandas-docs/stable', None),
    'jgtapy': ('https://jgtfx2console.jgwill.com', None)
}

