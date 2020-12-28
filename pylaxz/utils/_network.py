"""
pylaxz -c --check network -n

checking everying about network.
"""

# Standard library imports
from enum import Flag
from subprocess import call
import os
import speedtest as _speedtest

from . import logxs


class Network:
    """
    Network checker

    Arguments : (ip)address, (i)nternet, (s)peed, -h

    Examples:
      $ pylaxz -n i # for internet status
      $ pylaxz -n s # for internet speed

    """

    def __init__(self) -> None:
        self.target_host = "www.google.com"
        self.timeout = 3
        self.is_internet = False
        self.arch = True if os.name == "posix" else False

    def ip(self):
        call(["ifconfig", "-a"]) if self.arch else call(["ipconfig"])

    def internet(self, log=True):
        try:
            import httplib2 as _httplib

            conn = _httplib.HTTPConnectionWithTimeout(
                self.target_host, timeout=self.timeout
            )
        except ImportError:
            import http.client as _httplib

            conn = _httplib.HTTPConnection(self.target_host, timeout=self.timeout)
        try:
            conn.request("HEAD", "/")
            conn.close()
            self.is_internet = True

        except:
            self.is_internet = False
        if log:
            logxs.printf("Internet status : " + str(self.is_internet), _int=True)

    def internet_speed(self):
        try:
            self.internet(log=False)
            if self.is_internet:
                _st = _speedtest.Speedtest()
                logxs.printf("Getting best servers, please wait ... ", _int=True)
                _st.get_best_server()

                logxs.printf("Ping : {} ms".format(_st.results.ping), _int=True)
                logxs.printf(
                    "Download, {:.2f} MB/s".format(_st.download() / 1000000), _int=True
                )
                logxs.printf(
                    "Upload, {:.2f} MB/s".format(_st.upload() / 1000000), _int=True
                )
        except _speedtest.ConfigRetrievalError:
            logxs.printf("no internet to be checked!", _int=True)

