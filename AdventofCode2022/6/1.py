from dataclasses import dataclass, field


@dataclass
class Datastream:
    stream: str

    def solve(self, unique_chars=4):
        l = []
        rm_chars = []
        for char in list(self.stream):
            l.append(char)
            if len(set(l)) == unique_chars:
                break
            if len(l) == unique_chars:
                rm_chars.append(l.pop(0))
        return len(rm_chars + l)


assert Datastream("bvwbjplbgvbhsrlpgdmjqwftvncz").solve() == 5
assert Datastream("nppdvjthqldpwncqszvftbrmjlhg").solve() == 6

print(Datastream("bvwbjplbgvbhsrlpgdmjqwftvncz").solve())
with open("6/data.txt") as f:
    print(Datastream(f.read()).solve())
