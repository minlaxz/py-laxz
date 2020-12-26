from configparser import SafeConfigParser
from os import path

class AppParser:
    """
    docstring
    """
    def __init__ (self):
        # this will create an object
        self.parser = SafeConfigParser()
        self.path = './pylaxz/data/settings.ini'
    
    @property
    def config(self):
        if(path.exists(self.path)):
            self.parser.read(self.path)
        else:
            raise FileNotFoundError("Config file not found error.")
        self._get_config()

    def _get_config(self):
        print(self.parser.get('main', 'arch'))

    @config.setter
    def config(self, *val):
        self._set_config(self, *val)

    def _set_config(self, *value):
        pass
