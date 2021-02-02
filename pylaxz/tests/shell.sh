echo "Hello" && echo "World"

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