"""
Small utility for me or your personal use

Usage:
------

    $ pylaxz -flag argument

Available flag are:
    -h, --help         Show this help
    -u, --update       Update available check
    -v, --version      Show current version

    -N, --network      Check network infomation
        Arguments : (ip), (i)nternet, (s)peed, 
    -S, --system       Check system information
        Arguments : (os), (os-info), 

    -I, --install      Ingegrate with lxz TODO
        


More information is available at:
- https://pypi.org/project/py-laxz/
- https://github.com/minlaxz/py-laxz/

"""
# Standard library imports
from subprocess import ( run , PIPE )
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
        args, _ = getopt.getopt(argv[1:], "hvuN:S:", ["help", "version", "update", "network", "system"])
        for c_flag, c_val in args:

            if c_flag in ("-h", "--help"): logxs.printf(__doc__,_int=True)
            elif c_flag in ("-v", "--version"): logxs.printf(version, _int=True)
            elif c_flag in ("-u", "--update"): updater()

            elif c_flag in ("-N", "--network"):
                n = _network.Network()
                if c_val in ("-h", "--help"): logxs.printf(n.__doc__, _int=True)
                elif c_val in ("ip", "ipaddress") : n.ip()
                elif c_val in ("i", "internet") : n.internet()
                elif c_val in ("s", "speed") : n.internet_speed()

            elif c_flag in ("-S", "--system"):
                s = _system.System()
                if c_val in ("-h", "--help"): logxs.printf(s.__doc__, _int=True)
                elif c_val in ("os") :  logxs.printf(s.info(), _int=True)
                elif c_val in ("os-info"): logxs.printf(s.info(all=True), _int=True)

    except getopt.error as err:
	# output error, and return with an error code
	    logxs.printf(str(err), _int=True, _err=True)


def updater():
    logxs.printf("updating the script...", _int=True)
    cmd = "find . -maxdepth 2 -name '*.py' -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}'"
    result = run(cmd, shell=True, check=False, stdout=PIPE, universal_newlines=True)
    logxs.printf(result.stdout[:-1], _int=True)

if __name__ == "__main__":
    main(direct=False) # this will be invoked when python -m pylaxz -N i
