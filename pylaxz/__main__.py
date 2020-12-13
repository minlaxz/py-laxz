import sys
from .utils.logxs import *

helper = """
python -m pylaxz help
"""


def main(**kwargs) -> None:
    for k, v in kwargs.items():
        printf('{} = {}'.format(k, v), _int=True)


def main_():
    printf(helper, _int=True)


if __name__ == "__main__":
    main_() if 'help' in sys.argv else printf(helper, _int=True)
        
    # try:
    #     main ( ** dict(arg.split('=') for arg in sys.argv[1:]))

    # except ValueError:
    #     printf('Internal Error', internal=True)

    # except Exception as e:
    #     printf(e, internal=True)
