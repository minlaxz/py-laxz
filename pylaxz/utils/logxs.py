"""
logxs: noice print.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Copyright (c) 2020 Min Latt.
License: MIT, see LICENSE for more details.
"""

from rich import print as _p

def printf(*argv, _int=False, _err=False):
    data, data_type, data_shape = [], [], []
    for arg in argv:
        try:
            data.append(arg)
            data_type.append(type(arg))
            data_shape.append(arg.shape)
        except AttributeError:
            data_shape.append(None)
        except Exception as e:
            _p(e)

    for i in range(len(data)):
        if _int:
            _print_error(data[i]) if _err else _print_internal(data[i])
        else:
            _print_data(data[i])
            _print_ext(data_type[i], None) if (data_shape[i] == () or 
            data_shape[i] == None) else _print_ext(data_type[i], data_shape[i])  

def _print_ext(dtype, dshape):
    _print_type(dtype)
    if dshape: _print_shape(dshape)

def _print_internal(m):
    _p('[magenta] info >> {0}[/magenta]'.format(m))

def _print_error(m):
    _p('[red] error >> {0}[/red]'.format(m))

def _print_data(m):
    _p('[italic red]{0}[/italic red]'.format(m))

def _print_type(m):
    _p('[blue]{0}[/blue]'.format(m))

def _print_shape(m):
    _p('shape => [red]{0}[/red]'.format(m))
