from subprocess import (
    run as _run, 
    PIPE as _PIPE
)
from sys import argv as _argv
from .utils.logxs import *

helper = """
python -m pylaxz help
"""


def main(**kwargs) -> None:
    for k, v in kwargs.items():
        printf('{} = {}'.format(k, v), _int=True)


def main_help():
    printf('I am helping you.', _int=True)

def main_updater():
    cmd = "find . -maxdepth 2 -name '*.py' -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}'"
    result = _run(cmd, shell=True, check=False, stdout=_PIPE, universal_newlines=True)
    printf(result.stdout[:-1], _int=True)

if __name__ == "__main__":
    if len(_argv) == 1:
        printf(helper, _int=True)
    else:
        if 'help' in _argv: main_help()
        elif 'update' in _argv: main_updater()
        
    # try:
    #     main ( ** dict(arg.split('=') for arg in sys.argv[1:]))

    # except ValueError:
    #     printf('Internal Error', internal=True)

    # except Exception as e:
    #     printf(e, internal=True)
