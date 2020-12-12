"""
logxs: noice print.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Copyright (c) 2020 Min Latt.
License: MIT, see LICENSE for more details.
"""

from rich import print as _p

def printf(*argv, internal=False):
    data, data_type, data_shape = [], [], []
    for arg in argv:
        try:
            data.append(arg)
            data_type.append(type(arg))
            data_shape.append(arg.shape)
        except AttributeError:
            data_shape.append(None)
        except Exception as e:
            _print(e)

    for i in range(len(data)):
        _print(data[i])
        if not internal:
            if (data_shape[i] == () or data_shape[i] == None):
                _p('{0}'.format(data_type[i]))
            else:
                _p('{0} => shape: {1}'.format(data_type[i], data_shape[i]))

def _print(m):
    _p('[italic red]{0}[/italic red]'.format(m))

