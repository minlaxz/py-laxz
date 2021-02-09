class Length:
    '''Convert length US to MM'''
    _mode = 1  # 'toMM'

    def __init__(self, *args):
        if Length._mode == 1:
            self.cm = args[0]
            self.inch = None
        else:
            self.inch = args[0]
            self.cm = None
        self.calc()

    def show_MM(self):
        return f"{self.inch} in -> {self.cm} cm"

    def show_US(self):
        return f"{self.cm} cm -> {self.inch} in"

    def calc(self):
        if self.cm == None:
            self.cm = self.inch * 2.54

        else:
            self.inch = self.cm / 2.54

    def result(self):
        self.show_MM() if Length._mode == 1 else self.show_US()

    @classmethod
    def convert(cls, *arg):
        return cls(*arg)


# 2.54 cm = 1 in = 10 muu = 4 mat = 25.4 mm
# 1.27 cm = 0.5 in = 5 muu = 2 mat = 12.7 mm
# 0.254 cm = 0.1 in = 1 muu = 0.4 mat = 2.54 mm
