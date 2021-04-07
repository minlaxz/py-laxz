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
from sys import argv, stdout, stderr, exit

# from sqlalchemy import create_engine
# from sqlalchemy.orm import sessionmaker
# from .settings.dbcore import Settings

import click
import os

# pylaxz imports
from .utils import logxs, _network, _system
from .__version__ import version
from .utils.logxs import printf

VERBOSE=False

DIR_PATH = os.path.dirname(os.path.realpath(__file__))
SCRIPT_PATH = os.path.join(DIR_PATH, "shells/")
DK_SHELL = "bash " + SCRIPT_PATH + "dkx.sh "
CHECK_SHELL = "bash " + SCRIPT_PATH + "checkx.sh "
HOW_SHELL = "bash " + SCRIPT_PATH + "howx.sh "
OUTLINE_SHELL = "bash " + SCRIPT_PATH + "outlinex.sh "
X_SHELL = "bash " + SCRIPT_PATH + "xx.sh "
SQL_SHELL = "bash " + SCRIPT_PATH + "sqlx.sh "
DO_SHELL = "bash " + SCRIPT_PATH + "dox.sh "
SYS_SHELL = "bash " + SCRIPT_PATH + "sysx.sh "

@click.group()
def main(direct=True):
    """
    Script: pylaxz\n
    Info: This is under developement / by minlaxz
    """
    pass

@main.command()
@click.argument('arg', type=str, required=False)
def version(**kw):
    printf(f"Version: {version}", _int=1)
    print(version)


@main.command()
@click.option('--verbose', '-v', is_flag=True, help="Verbose Extra Option")
@click.argument('arg',type=str, required=False)
@click.argument('container_id',required=False)
def dk(**kw):
    """
    Description: operating with dockers.
    """
    with open(DK_SHELL[5:-1], 'r') as f:
        lines = f.readlines()
    DKX_OPTS=[i[:-2] for i in lines if i.startswith('--')]
    try:
        if kw['arg'] is None:
            __logxsOut(f'{[i[5:] for i in DKX_OPTS]}')
        else:
            if ('--dk-'+kw['arg']) in DKX_OPTS:
                if (kw['container_id'] is not None):
                    __callShell(cmd=DK_SHELL+ '--dk-{0} {1}'.format(kw['arg'],kw['container_id']))
                else:
                    __callShell(cmd=DK_SHELL+ '--dk-{0}'.format(kw['arg']))
    except (KeyError, Exception) as e:
        click.echo(f"Internal Error. {e}")

@main.command()
@click.option('--verbose', '-v', is_flag=True, help="Verbose Extra Option")
@click.argument('arg',type=str, required=False)
def check(**kw):
    """
    Description: operating with system checks.
    """
    with open(CHECK_SHELL[5:-1], 'r') as f:
        lines = f.readlines()
    CHECKX_OPTS=[i[:-2] for i in lines if i.startswith('--')]
    try:
        if kw['arg'] is None:
            __logxsOut(f"{[i[2:] for i in CHECKX_OPTS]}")
        else:
            if ('--'+kw['arg']) in CHECKX_OPTS:
                __callShell(cmd=CHECK_SHELL+ '--{0}'.format(kw['arg']))
    except (KeyError, Exception) as e:
        click.echo(f"Internal Error. {e}")

@main.command()
@click.option('--verbose', '-v', is_flag=True, help="Verbose Extra Option")
@click.argument('arg',type=str, required=False)
def how(**kw):
    """
    Description: How to do that.
    """
    with open(HOW_SHELL[5:-1], 'r') as f:
        lines = f.readlines()
    HOWX_OPTS=[i[:-2] for i in lines if i.startswith('--')]
    try:
        if kw['arg'] is None:
            __logxsOut(f"{[i[6:] for i in HOWX_OPTS]}")
        else:
            if ('--how-'+kw['arg']) in HOWX_OPTS:
                __callShell(cmd=HOW_SHELL+ '--how-{0}'.format(kw['arg']))
    except (KeyError, Exception) as e:
        click.echo(f"Internal Error. {e}")

@main.command()
@click.option('--verbose', '-v', is_flag=True, help="Verbose Extra Option")
@click.argument('arg',type=str, required=False)
def outline(**kw):
    """
    Description: operating with outline VPN.
    """
    with open(OUTLINE_SHELL[5:-1], 'r') as f:
        lines = f.readlines()
    OUTLINEX_OPTS=[i[:-2] for i in lines if i.startswith('--')]
    try:
        if kw['arg'] is None:
            __logxsOut(f"{[i[10:] for i in OUTLINEX_OPTS]}")
        else:
            if ('--outline-'+kw['arg']) in OUTLINEX_OPTS:
                __callShell(cmd=OUTLINE_SHELL+ '--outline-{0}'.format(kw['arg']))
    except (KeyError, Exception) as e:
        click.echo(f"Internal Error. {e}")


@main.command()
@click.option('--verbose', '-v', is_flag=True, help="Verbose Extra Option")
@click.argument('arg',type=str, required=False)
def sys(**kw):
    """
    Description: Configuraing system.
    """
    with open(SYS_SHELL[5:-1], 'r') as f:
        lines = f.readlines()
    SYSX_OPTS=[i[:-2] for i in lines if i.startswith('--')]
    try:
        if kw['arg'] is None:
            __logxsOut(f"{[i[6:] for i in SYSX_OPTS]}")
        else:
            if ('--sys-'+kw['arg']) in SYSX_OPTS:
                __callShell(cmd=SYS_SHELL+ '--sys-{0}'.format(kw['arg']))
    except (KeyError, Exception) as e:
        click.echo(f"Internal Error. {e}")

@main.command()
@click.option('--verbose', '-v', is_flag=True, help="Verbose Extra Option")
@click.argument('arg',type=str, required=False)
def x(**kw):
    """
    Description: \ x options for minlaxz / 
    """
    with open(X_SHELL[5:-1], 'r') as f:
        lines = f.readlines()
    X_OPTS=[i[:-2] for i in lines if i.startswith('--')]
    try:
        if kw['arg'] is None:
            __logxsOut(f"{[i[4:] for i in X_OPTS]}")
        else:
            if ('--x-'+kw['arg']) in X_OPTS:
                __callShell(cmd=X_SHELL+ '--x-{0}'.format(kw['arg']))
    except (KeyError, Exception) as e:
        click.echo(f"Internal Error. {e}")


@main.command()
@click.option('--verbose', '-v', is_flag=True, help="Verbose Extra Option")
@click.argument('arg',type=str, required=False)
def do(**kw):
    """
    Description: \ DO options for minlaxz / 
    """
    with open(DO_SHELL[5:-1], 'r') as f:
        lines = f.readlines()
    DO_OPTS=[i[:-2] for i in lines if i.startswith('--')]
    try:
        if kw['arg'] is None:
            __logxsOut(f"{[i[5:] for i in DO_OPTS]}")
        else:
            if ('--do-'+kw['arg']) in DO_OPTS:
                __callShell(cmd=DO_SHELL+ '--do-{0}'.format(kw['arg']))
    except (KeyError, Exception) as e:
        click.echo(f"Internal Error. {e}")


# @main.command()
# @click.option('--verbose', '-v', is_flag=True, help="Verbose Extra Option")
# @click.argument('arg',type=str, required=False)
# def sql(**kw):
#     """
#     Description: \ sql options for minlaxz / 
#     """
#     engine = create_engine('sqlite:///settings/commands.db')
#     # Base.metadata.bind = engine
#     Session = sessionmaker(bind=engine)
#     session = Session()
#     proxy = session.query(Settings).all()
#     print(proxy.one_or_none())


def __callShell(cmd):
    if VERBOSE: print(cmd)
    try:
        run(cmd, shell=True, stderr=stderr, stdout=stdout)
    except (KeyboardInterrupt,Exception) as e:
        __logxsOut(f"{e}\nEXIT.")

def __logxsOut(msg):
    if isinstance(msg, list):
        for i in msg: logxs.printf(i, _int=1)
    else:
        logxs.printf(msg, _int=True)


# def _updater():
#     __logxsOut("updating the script...")
#     cmd = "find . -maxdepth 2 -name '*.py' -print0 | xargs -0 sha1sum | sort -h | sha256sum | awk '{print $1}'"
#     __callShell(cmd)

if __name__ == '__main__':
    main(direct=False)