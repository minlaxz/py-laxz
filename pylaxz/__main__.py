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

    -L, --lxz      Ingegrate with lxz TODO
        --help for HELP.
        


More information is available at:
- https://pypi.org/project/py-laxz/
- https://github.com/minlaxz/py-laxz/

"""
# Standard library imports
from subprocess import run #, PIPE, Popen, STDOUT
from sys import argv, stdout, stderr
import getopt
import os

# pylaxz imports
from .utils import logxs, _network, _system
from .__version__ import version


# save_history = False

DIR_PATH = os.path.dirname(os.path.realpath(__file__))
SCRIPT_PATH = os.path.join(DIR_PATH, "shells/")
ARG_L = ["--lxz-DE", "--help", "--version", "--help-long",
         "--has-internet",
         "--how-enc","--how-dec", "--how-compress", "--how-decompress",
         "--how-copy",  "--how-safe-rm", "--issue-opencv"]
SUDO_ARG_L = ["--sys-upgrade",
            "--sys-setup",
            "--scan-host",
            "--port-service", 
            "--is-installed"]
# if save_history:
#     from .orm import Database
#     db = Database(DIR_PATH+'/data/sqlite.db')
# else:
#     db = None


# class DBModel(db.Model if db else None):
#     text = str
#     time = str
#     direct = bool

#     def __init__(self, text, time, direct) -> None:
#         self.text = text
#         self.time = time
#         self.direct = direct


def main(direct=True):
    """

    Main function of pylaxz

    """

    # if save_history:
    #     _save([argv[:], direct])

    if len(argv[1:]) == 0:
        logxs.printf("$ pylaxz -h for help", _int=True)

    try:
        args, _ = getopt.getopt(
            argv[1:],
            "hvuiN:S:L:",
            ["help", "version", "update", "info", "network", "system", "lxz"],
        )
        for c_flag, c_val in args:

            # stable args
            if c_flag in ("-h", "--help"): _logxs_out(__doc__)
            elif c_flag in ("-v", "--version"): _logxs_out(version)
            elif c_flag in ("-u", "--update"): _updater()

            elif c_flag in ("-N", "--network"):
                n = _network.Network()
                if c_val in ("-h", "--help"): _logxs_out(n.__doc__)
                elif c_val in ("ip", "ipaddress"): n.ip()
                elif c_val in ("i", "internet"): n.internet()
                elif c_val in ("s", "speed"): n.internet_speed()

            elif c_flag in ("-S", "--system"):
                s = _system.System()
                if c_val in ("-h", "--help"): _logxs_out(s.__doc__)
                elif c_val in ("os"): _logxs_out(s.info())
                elif c_val in ("os-info"): _logxs_out(s.info(all=True))

            elif c_flag in ("-L", "--lxz"):
                _ = "bash " + SCRIPT_PATH + "script.sh "
                if c_val in SUDO_ARG_L :  
                    assert os.uname()[-1] == 'x86_64'
                    _call_shell(cmd= _ + c_val)
                if c_val in ARG_L: 
                    _call_shell(cmd= _ + c_val)
                else: _logxs_out("Not an option ({}),  -L --help for more.".format(c_val))

    except getopt.error as err:
        # output error, and return with an error code
        logxs.printf(str(err), _int=True, _err=True)

    except AssertionError:
        logxs.printf("a command is excepted to be run on 'x86_64'", _int=True, _err=True)
# def _save(cmd):
#     _ = DBModel(cmd[0], str(datetime.now()), cmd[1]).save()
#     db.commit()


def _call_shell(cmd):
    # result = run(cmd, shell=True, check=False,
    #              stdout=PIPE, universal_newlines=True)
    # while True:
    #     line = result.stdout.rstrip()
    #     if not line: break
    #     yield  line
    # return result.stdout[:-1] if return_ else _logxs_out(result.stdout[:-1])

    # p = Popen(cmd, stdout = PIPE, 
    #     stderr = STDOUT, shell = True, bufsize=1 )
    # for line in iter(p.stdout.readline, b''):
    #     logxs.printf(line.decode("utf-8")[:-1] , _int=True, _shell=True)
    # p.stdout.close()
    # p.wait()
    
    run(cmd, shell=True, stderr=stderr, stdout=stdout)


def _logxs_out(msg):
    logxs.printf(msg, _int=True)


def _updater():
    _logxs_out("updating the script...")
    cmd = "find . -maxdepth 2 -name '*.py' -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}'"
    _call_shell(cmd, return_=False)


if __name__ == "__main__":
    main(direct=False)  # this will be invoked when python -m pylaxz -N i
