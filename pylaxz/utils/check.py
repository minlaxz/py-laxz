import subprocess as _subprocess
import os as _os
from .logxs import *
import speedtest as _st
import sys as _sys

try:
    import httplib2 as _httplib
except ImportError:
    import http.client as _httplib

if _os.name == 'posix': _linux = True

def internet(url="www.google.com", timeout=3):
    conn = _httplib.HTTPConnection(url, timeout=timeout)
    try:
        conn.request("HEAD", "/")
        conn.close()
        return True
    except Exception as e:
        return False

def ip():
    _subprocess.call(['ifconfig', '-a']) if _linux else _subprocess.call(['ipconfig'])

def os_info():       
    printf(_os.uname(), internal=True) if _linux else printf('r u on windows ? omg!', internal=True)

def hw_info():
    pass

def speed():
    try:
        if internet:
            _speedr = _st.Speedtest()
            printf('Please wait ... ', internal=True)
            _speedr.get_best_server()
            printf('Ping : {} ms'.format(_speedr.results.ping), internal=True)
            printf('Download, {:.2f} MB/s'.format(_speedr.download()/1000000) , internal=True)
            printf('Upload, {:.2f} MB/s'.format(_speedr.upload()/1000000) , internal=True)
    except _st.ConfigRetrievalError:
        printf('no internet to be checked!', internal=True)
