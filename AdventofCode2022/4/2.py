from dataclasses import dataclass, field

inp = """2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8"""


@dataclass
class Pair:
    inp: str
    overlap: set = field(default_factory=set)

    def __post_init__(self):
        self.parse()

    def parse(self):
        a, b = self.inp.split(",")
        a = a.split("-")
        b = b.split("-")
        self.e1 = set(range(int(a[0]), int(a[-1]) + 1))
        self.e2 = set(range(int(b[0]), int(b[-1]) + 1))

    def calc_intersect(self):
        inter = self.e1.intersection(self.e2)
        n = len(inter)
        # if n >= len(self.e1) or n >= len(self.e2):
        self.overlap = inter
        return self


def parse(inp):
    return [Pair(el.strip()).calc_intersect() for el in inp.split("\n")]


def main(inp):
    pairs = parse(inp)
    print(sum(len(pair.overlap) > 0 for pair in pairs))


if __name__ == "__main__":
    main(inp)
    with open("4/data.txt") as f:
        main(f.read())
