"""
pylaxz -c --check network -n

checking everying about network.
"""

# Standard library imports
from subprocess import call
import os

import speedtest as _st

class Network:
    """
    Network checker

    Arguments : (ip)address, (i)nternet, (s)peed, -h

    Examples:
      $ pylaxz -n i # for internet status
      $ pylaxz -n s # for internet speed

    """
    def __init__(self) -> None:
        self.target_host = 'www.google.com'
        self.timeout = 3
        self.is_internet = False
        
    def ip(self):
        call(['ifconfig', '-a']) if _linux else call(['ipconfig'])

    def internet(self):
        try:
            import httplib2 as _httplib
        except ImportError:
            import http.client as _httplib

        conn = _httplib.HTTPConnection(self.target_host, timeout=self.timeout)
        try:
            conn.request("HEAD", "/")
            conn.close()
            self.is_internet = True
    
        except: self.is_internet = False


    def internet_speed(self):
        try:
            self.internet()
            if self.is_internet :
                _speedr = _st.Speedtest()
                printf('Please wait ... ', _int=True)
                _speedr.get_best_server()
                printf('Ping : {} ms'.format(_speedr.results.ping), _int=True)
                printf('Download, {:.2f} MB/s'.format(_speedr.download()/1000000) , _int=True)
                printf('Upload, {:.2f} MB/s'.format(_speedr.upload()/1000000) , _int=True)
        except _st.ConfigRetrievalError:
            printf('no internet to be checked!', _int=True)