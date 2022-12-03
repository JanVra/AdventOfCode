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


@dataclass
class Group:
    rucksacks: list[Rucksack]
    prio: int = 0

    def find_badge(self):
        for item1 in self.rucksacks[0].inp:
            for item2 in self.rucksacks[1].inp:
                for item3 in self.rucksacks[2].inp:
                    if item1 == item2 == item3:
                        self.prio = self.rucksacks[0].prio_list.index(item1) + 1


def parse(inp):
    lines = inp.split("\n")
    groups = []
    rucksacks = []
    for ix, line in enumerate(lines):
        rucksacks.append(Rucksack(line))
        if ix % 3 == 2:
            assert (
                len(rucksacks) == 3
            ), f"Wrong number of rucksacks, expected 3, got {len(rucksacks)}"

            groups.append(Group(rucksacks))
            rucksacks = []
    return groups


def main(inp):
    groups = parse(inp)
    [group.find_badge() for group in groups]
    print(sum(group.prio for group in groups))


if __name__ == "__main__":
    main(inp)
    with open("3/data.txt") as f:
        main(f.read())
