"""
pylaxz -c --check

checking everying.
"""
# Standard library imports
from subprocess import call
import os

# pylaxz imports
from .logxs import printf
import speedtest as _st

_linux = True if os.name == 'posix' else False

class Network:
    """
    Network checker
    """
    def __init__(self) -> None:
        pass
        
    def ip(self):
        call(['ifconfig', '-a']) if _linux else call(['ipconfig'])

    def internet(self, timeout=3):
        try:
            import httplib2 as _httplib
        except ImportError:
            import http.client as _httplib

        conn = _httplib.HTTPConnection("www.google.com", timeout=3)
        try:
            conn.request("HEAD", "/")
            conn.close()
            return True
        except Exception as e:
            printf(e, _int=True, _err=True)
            return False

    def internet_speed(self):
        try:
            if self.internet():
                _speedr = _st.Speedtest()
                printf('Please wait ... ', _int=True)
                _speedr.get_best_server()
                printf('Ping : {} ms'.format(_speedr.results.ping), _int=True)
                printf('Download, {:.2f} MB/s'.format(_speedr.download()/1000000) , _int=True)
                printf('Upload, {:.2f} MB/s'.format(_speedr.upload()/1000000) , _int=True)
        except _st.ConfigRetrievalError:
            printf('no internet to be checked!', _int=True)

class Sys:
    """
    For system admin
    """
    def __init__(self) -> None:
        pass

    def _software_info(self):
        printf(os.uname(), _int=True) if _linux else printf('r u on windows ? omg!', _int=True)

    def _hardware_info(self):
        pass

    def _is_current_user(self):
        pass


## TODO
# class Util:
#     def __init__(self) -> None:
#         print('sys called')
    
#     def ip():
#         call(['ifconfig', '-a']) if _linux else call(['ipconfig'])

# class Check(Util):
#     def __init__(self) -> None:
#         super().__init__()
## TODO_END