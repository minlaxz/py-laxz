"""
pylaxz -c --check network -n

checking everying about network.
"""




import os

class System:
    """

    For System Purposes

    Arguments : (os), (os-all), -h

    Examples:
      $ pylaxz -S os # for short OS information
      $ pylaxz -S os-all # for long description about OS

    """
    def __init__(self) -> None:
        self.type = True if os.name == 'posix' else False

    @property
    def check(self) -> None:
        return f"{os.uname()}" if self.type else f"Not supported on Windows yet."
        # logxs.printf(os.uname() if self.type else "r u on windows ? omg!" , _int=True)

    @property
    def all(self) -> None :
        return f"Showing all information..."

    @check.setter
    def check(self, value) -> int:
        return None


