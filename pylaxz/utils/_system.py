"""
pylaxz -S arguments

Arguments : 
    os
    os-info

checking everying about network.
"""

from os import uname as _uname, name as _name


class System:
    """

    For System Purposes

    Arguments : (os), (os-all), -h

    Examples:
      $ pylaxz -S os # for short OS information
      $ pylaxz -S os-info # for long description about OS

    """

    def __init__(self) -> None:
        self.arch = True if _name == "posix" else False

    @property
    def __partial(self) -> None:
        return f"{_uname()}" if self.arch else f"Not supported on Windows yet."
        # logxs.printf(os.uname() if self.type else "r u on windows ? omg!" , _int=True)

    @property
    def __all(self) -> None:
        return f"Showing all information..."

    def info(self, all=False):
        return self.__all if all else self.__partial

    # @check.setter
    # def check(self, value) -> int:
    #     return None

