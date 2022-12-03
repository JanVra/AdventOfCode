from dataclasses import dataclass, field
import string

inp = """vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw"""


@dataclass
class Rucksack:
    inp: str
    prio: int = 0
    c1: str = ""
    c2: str = ""
    prio_list = string.ascii_lowercase + string.ascii_uppercase

    def __post_init__(self):
        self.parse()
        self.find_duplicate()

    def parse(self) -> None:
        num_items = len(self.inp)
        self.c1 = self.inp[: num_items // 2]
        self.c2 = self.inp[num_items // 2 :]

    def find_duplicate(self):
        for item1 in self.c1:
            for item2 in self.c2:
                if item1 == item2:
                    self.prio = self.prio_list.index(item1) + 1


def parse(inp):
    lines = inp.split("\n")
    return [Rucksack(line) for line in lines]


def main(inp):
    rucksacks = parse(inp)
    print(sum(r.prio for r in rucksacks))


if __name__ == "__main__":
    main(inp)
    with open("3/data.txt") as f:
        main(f.read())
