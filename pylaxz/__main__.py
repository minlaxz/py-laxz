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
from subprocess import run  # , PIPE, Popen, STDOUT
from sys import argv, stdout, stderr
import getopt
import os

# pylaxz imports
from .utils import logxs, _network, _system
from .__version__ import version


# save_history = False
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
            if c_flag in ("-h", "--help"):
                _logxs_out(__doc__)
            elif c_flag in ("-v", "--version"):
                _logxs_out(version)
            elif c_flag in ("-u", "--update"):
                _updater()

            elif c_flag in ("-N", "--network"):
                n = _network.Network()
                if c_val in ("-h", "--help"):
                    _logxs_out(n.__doc__)
                elif c_val in ("ip", "ipaddress"):
                    n.ip()
                elif c_val in ("i", "internet"):
                    n.internet()
                elif c_val in ("s", "speed"):
                    n.internet_speed()

            elif c_flag in ("-S", "--system"):
                s = _system.System()
                if c_val in ("-h", "--help"):
                    _logxs_out(s.__doc__)
                elif c_val in ("os"):
                    _logxs_out(s.info())
                elif c_val in ("os-info"):
                    _logxs_out(s.info(all=True))

            elif c_flag in ("-L", "--lxz"):
                DIR_PATH = os.path.dirname(os.path.realpath(__file__))
                SCRIPT_PATH = os.path.join(DIR_PATH, "shells/")

                SYSX_PATH = "bash " + SCRIPT_PATH + "sysx.sh "
                with open(SYSX_PATH[5:-1], 'r') as f:
                    lines = f.readlines()
                SYSX_OPTS=[i[:-2] for i in lines if i.startswith('--')]

                HOWX_PATH = "bash " + SCRIPT_PATH + "howx.sh "
                with open(HOWX_PATH[5:-1], 'r') as f:
                    lines = f.readlines()
                HOWX_OPTS=[i[:-2] for i in lines if i.startswith('--')]

                SCRIPTX_PATH = "bash " + SCRIPT_PATH + "scriptx.sh "
                with open(SCRIPTX_PATH[5:-1], 'r') as f:
                    lines = f.readlines()
                SCRIPTX_OPTS=[i[:-2] for i in lines if i.startswith('--')]

                DKX_PATH = "bash " + SCRIPT_PATH + "dkx.sh "
                with open(DKX_PATH[5:-1], 'r') as f:
                    lines = f.readlines()
                DKX_OPTS=[i[:-2] for i in lines if i.startswith('--')]

                CHECKX_PATH = "bash " + SCRIPT_PATH + "checkx.sh "
                with open(CHECKX_PATH[5:-1], 'r') as f:
                    lines = f.readlines()
                CHECKX_OPTS=[i[:-2] for i in lines if i.startswith('--')]

                if c_val == '--help':
                    _logxs_out([SYSX_OPTS, SCRIPTX_OPTS, HOWX_OPTS, DKX_OPTS, CHECKX_OPTS])

                elif c_val in SYSX_OPTS:
                    assert os.uname()[-1] == 'x86_64'
                    _call_shell(cmd=SYSX_PATH + c_val)

                elif c_val in CHECKX_OPTS:
                    _call_shell(cmd=CHECKX_PATH + c_val)

                elif c_val in HOWX_OPTS:
                    _call_shell(cmd=HOWX_PATH + c_val)

                elif c_val in SCRIPTX_OPTS:
                    _call_shell(cmd=SCRIPTX_PATH + c_val)

                elif c_val in DKX_OPTS:
                    _call_shell(cmd=DKX_PATH + c_val)

                else:
                    _logxs_out("Not an option ({}),  -L --help for help.".format(c_val))

    except getopt.error as err:
        # output error, and return with an error code
        logxs.printf(str(err), _int=True, _err=True)

    except AssertionError:
        logxs.printf("that command is excepted to be run on 'x86_64, pc'",
                     _int=True, _err=True)
# def _save(cmd):
#     _ = DBModel(cmd[0], str(datetime.now()), cmd[1]).save()
#     db.commit()

def _call_shell(cmd):
    run(cmd, shell=True, stderr=stderr, stdout=stdout)


def _logxs_out(msg):
    if isinstance(msg, list):
        for i in msg: logxs.printf(i, _int=1)
    else:
        logxs.printf(msg, _int=True)


def _updater():
    _logxs_out("updating the script...")
    cmd = "find . -maxdepth 2 -name '*.py' -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}'"
    _call_shell(cmd, return_=False)


if __name__ == "__main__":
    main(direct=False)  # this will be invoked when python -m pylaxz -N i
