"""
logxs: noice print using rich.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

by Min Latt.
License: MIT, see LICENSE for more details.
"""

from rich import print as _p

# import keyword


def printf(*argv, _int=False, _err=False, _shell=False) -> None:
    """

    Parameters:
        in << takes any given arguments
        out >> return data back, type, also shape for ML purpose.

    Usage:
    ------
    logxs.printf(ANY)

    """
    if _int:  # for internal prints and error messages
        for _ in argv:
            _print_error(_) if _err else _print_internal(_, _shell)
    else:  # called for other purpose by user.
        data, data_type, data_shape = [], [], []
        for _ in argv:
            try:
                data.append(_)
                data_type.append(type(_))
                data_shape.append(_.shape)
            except AttributeError:
                data_shape.append(None)
            except Exception as e:
                _print_error(e)

        for _ in range(len(data)):
            _print_data(data[_])
            _print_type(data_type[_])
            if not (data_shape[_] == () or data_shape[_] == None):
                _print_shape(data_shape[_])


def _print_internal(m, _shell) -> None:
    _p("[magenta]>> {0}[/magenta]".format(m)) if _shell else _p("[magenta]>> \n{0}[/magenta]".format(m))


def _print_error(m) -> None:
    _p("[red]>> {0}[/red]".format(m))


def _print_data(m) -> None:
    _p("[italic red]{0}[/italic red]".format(m))


def _print_type(m) -> None:
    _p("[blue]{0}[/blue]".format(m))


def _print_shape(m) -> None:
    _p("shape => [red]{0}[/red]".format(m))
