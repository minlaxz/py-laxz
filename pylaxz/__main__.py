"""
Small utility for sys admin or personal use

Usage:
------

    $ pylaxz -option(s) argument(s)

Available options are:
    -h, --help         Show this help
    -u, --update       Update available check
    -V, --version      Show current version


More information is available at:
- https://pypi.org/project/py-laxz/
- https://github.com/minlaxz/py-laxz/

"""
# Standard library imports
from subprocess import ( run , PIPE)
from sys import argv

# pylaxz imports
from .utils import logxs
from .__version__ import version
from .utils import check

def main(direct=True):
    """Main function of pylaxz""" # pylaxz script call

    if len(argv) > 1:
        args = [arg for arg in argv[1:] if not arg.startswith("-")]
        opts = [opt for opt in argv[1:] if opt.startswith("-")]

        # Show help message  
        if "-h" in opts or "--help" in opts:
            logxs.printf(__doc__, _int=True)
            return

        # Show version info
        if "-V" in opts or "--version" in opts:
            logxs.printf(version, _int=True)
            return

        # Calling updater
        if "-u" in opts or "--update" in opts:
            updater()
            return
        
        if "-c" in opts or "--check" in opts:
            if args:
                if "internet" in args: check.internet()
                if "speed" in args: check.speed()
                if "ip" in args: check.ip()
                if "os_info" in args: check.os_info()
                if "hw_info" in args: check.hw_info()
                if "os" in args: 
                    os = check.Os()
                    if argv[-1] == "s" : os.software()
                    if argv[-1] == "h" : os.hardware()
            else:
                logxs.printf('Need argument to check.', _int=True, _err=True)
    else:
        logxs.printf("'pylaxz -h' for more info", _int=True, _err=True)
    



# def main(**kwargs) -> None:
#     for k, v in kwargs.items():
#         printf('{} = {}'.format(k, v), _int=True)


def updater():
    cmd = "find . -maxdepth 2 -name '*.py' -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}'"
    result = run(cmd, shell=True, check=False, stdout=PIPE, universal_newlines=True)
    logxs.printf(result.stdout[:-1], _int=True)

if __name__ == "__main__":
    main(direct=False) # this will be invoked when python -m pylaxz



    # try:
    #     main ( ** dict(arg.split('=') for arg in sys.argv[1:]))

    # except ValueError:
    #     printf('Internal Error', internal=True)

    # except Exception as e:
    #     printf(e, internal=True)
