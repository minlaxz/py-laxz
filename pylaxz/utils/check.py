"""
pylaxz -c --check

checking everying.
"""
# Standard library imports
from subprocess import call
import os

# pylaxz imports
from .logxs import *
import speedtest as _st

_linux = True if os.name == 'posix' else False

def internet(url="www.google.com", timeout=3):
    try:
        import httplib2 as _httplib
    except ImportError:
        import http.client as _httplib
    conn = _httplib.HTTPConnection(url, timeout=timeout)
    try:
        conn.request("HEAD", "/")
        conn.close()
        return True
    except Exception as e:
        return False

def ip():
    call(['ifconfig', '-a']) if _linux else call(['ipconfig'])

def os_info():       
    printf(os.uname(), _int=True) if _linux else printf('r u on windows ? omg!', _int=True)

def hw_info():
    pass

def speed():
    try:
        if internet:
            _speedr = _st.Speedtest()
            printf('Please wait ... ', _int=True)
            _speedr.get_best_server()
            printf('Ping : {} ms'.format(_speedr.results.ping), _int=True)
            printf('Download, {:.2f} MB/s'.format(_speedr.download()/1000000) , _int=True)
            printf('Upload, {:.2f} MB/s'.format(_speedr.upload()/1000000) , _int=True)
    except _st.ConfigRetrievalError:
        printf('no internet to be checked!', _int=True)

class Os:
    def __init__(self) -> None:
        pass

    def software(self):
        print('checking software information.')
    
    def hardware(self):
        print('checking hardware information.')