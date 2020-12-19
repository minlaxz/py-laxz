#### Python Utility for Sys Admin or Personal Use.

### Installation
```
$ python3 -m pip install --no-cache-dir --upgrade py-laxz
```

### Usage (as binary)
```
$ pylaxz -option(s) argument(s)
$ pylaxz -h # for help
```

### Usage (or you can use it as direct module)
```
$ python3 -m pylaxz -h
```

### Usage (as python module - logxs for machine learning)
```
>>> from pylaxz.utils.logxs import printf
>>> printf(ANYTHING)
```

### Submodule endpoints
    1. pylaxz.utils.logxs.printf
    2. pylaxz.utils.check
        1. internet # checking internet connection
        2. speed    # check internet speed
        3. ip       # check ipaddress
        4. os_info  # check os information
        5. hw_info  # check hardware information

if you have time : 

``` 
>>> import pylaxz
>>> dir(pylaxz)
>>> help(pylaxz)
```

+ printf is logger function and works well with python's data types
+ and also with numpy's data shapes.
