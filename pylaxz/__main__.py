import sys
from .utils.logxs import *

def main(**kwargs) -> None:
    for k, v in kwargs.items():
        printf('{} = {}'.format(k,v), internal=True)

if __name__ == "__main__":
    try:
        main ( ** dict(arg.split('=') for arg in sys.argv[1:]))

    except ValueError:
        printf('Internal Error', internal=True)
    
    except Exception as e:
        printf(e, internal=True)
