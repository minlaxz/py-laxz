"""
Small utility for sys admin or personal use

Usage:
------

    $ pylaxz -option(s) argument(s)

Available options are:
    -h, --help         Show this help
    -u, --update       Update available check
    -v, --version      Show current version
    -N, --network      Check network infomation
    -S, --system       Check system information
    -I, --install      Ingegrate with lxz TODO
        Arguments : (ip), (i)nternet, (s)peed, 


More information is available at:
- https://pypi.org/project/py-laxz/
- https://github.com/minlaxz/py-laxz/

"""
# Standard library imports
from subprocess import ( run , PIPE)
from sys import argv
import getopt

# pylaxz imports
from .utils import logxs, _network, _system
from .__version__ import version

def main(direct=True):
    """

    Main function of pylaxz
    
    """ 
    if len(argv[1:]) == 0:
        logxs.printf('$ pylaxz -h for help', _int=True)
    
    try:
        args, _ = getopt.getopt(argv[1:], "hvun:", ["help", "version", "update", "network"])
        for c_arg, c_val in args:

            if c_arg in ("-h", "--help"): logxs.printf(__doc__,_int=True)

            elif c_arg in ("-v", "--version"): logxs.printf(version, _int=True)

            elif c_arg in ("-u", "--update"): updater()

            elif c_arg in ("-N", "--network"):
                n = _network.Network()
                if c_val in ("-h", "--help"): logxs.printf(n.__doc__, _int=True)

                elif c_val in ("ip", "ipaddress") : n.ip()

                elif c_val in ("i", "internet") : n.internet()

                elif c_val in ("s", "speed") : n.internet_speed()

            elif c_arg in ("-S", "--system"):
                s = _system.System()
                if c_val in ("-h", "--help"): logxs.printf(s.__doc__, _int=True)

                elif c_val in ("os") :  s.os()

                elif c_val in ("os-info"): s.os_info()

    except getopt.error as err:
	# output error, and return with an error code
	    logxs.printf (str(err), _int=True, _err=True)

#     if len(argv) > 1:

#         args = [_ for _ in argv[1:] if not _.startswith("--")]
#         opts = [_ for _ in argv[1:] if _.startswith("--")]

#         for _ in opts:
#             # Show help message  
#             if _ == "--help":
#                 logxs.printf(__doc__, _int=True)
#                 return

#             # Show version info
#             elif _ == "--version":
#                 logxs.printf(version, _int=True)
#                 return

#             # Calling updater
#             elif _ == "--update":
#                 updater()
#                 return

#             elif _ == "--check":
#                 if args:
#                     if "internet" in args: check.internet()
#                     if "speed" in args: check.speed()
#                     if "ip" in args: check.ip()
#                     if "os_info" in args: check.os_info()
#                     if "hw_info" in args: check.hw_info()
#                     if "os" in args: 
#                         os = check.Os()
#                         if argv[-1] == "s" : os.software()
#                         if argv[-1] == "h" : os.hardware()
#                 else:
#                     logxs.printf('No argument specified.', _int=True, _err=True)
#             else:
#                 logxs.printf("Not an option", _int=True, _err=True)
#     else:
#         logxs.printf("'$ pylaxz --help' for more info", _int=True, _err=True)


# # def main(**kwargs) -> None:
# #     for k, v in kwargs.items():
# #         printf('{} = {}'.format(k, v), _int=True)


def updater():
    logxs.printf("updating the script...", _int=True)
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
