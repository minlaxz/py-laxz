from subprocess import Popen, PIPE, STDOUT
from sys import stdin
from pylaxz.utils import logxs
# import subprocess, sys


p = Popen('bash ./shell.sh' , stdin=PIPE, stdout = PIPE, 
        stderr = STDOUT, shell = True, bufsize=1 )

for line in iter(p.stdout.readline, b''):
    logxs.printf(line.decode("utf-8")[:-1] , _int=True, _shell=True)

p.stdout.close()
p.wait()

# subprocess.run('bash ./shell.sh', shell = True, stderr=sys.stderr, stdout=sys.stdout)
