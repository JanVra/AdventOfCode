from dataclasses import dataclass, field


@dataclass
class Tower:
    crates: list


@dataclass
class Instruction:
    quant: int
    src: int
    dest: int


@dataclass
class UnloadArea:
    num_towers: int
    max_crate_height: int
    instructions_text: list
    crate_layers: dict
    towers: dict = field(default_factory=dict)
    instructions: list[str] = field(default_factory=list)

    def __post_init__(self):
        self.fill_towers()
        self.parse_instructions()
        self.execute_instructions()

        # check if stuff is correct
        # assert self.max_crate_height == len(self.get_highest_tower())

    def fill_towers(self):
        for ix, key in enumerate(sorted(self.crate_layers.keys())):
            self.crate_layers[key].reverse()
            tower = Tower(self.crate_layers[key])
            self.towers[ix + 1] = tower

    def parse_instructions(self):
        for instruction in self.instructions_text:
            quant, src, dest = filter(lambda x: x.isdigit(), instruction.split(" "))
            self.instructions.append(Instruction(int(quant), int(src), int(dest)))

    def execute_instructions(self):
        for instruction in self.instructions:
            # self.print_step(0, instruction)
            quant = instruction.quant  # crates
            src = self.towers[instruction.src].crates
            dest = self.towers[instruction.dest].crates

            dest.extend(src[-quant:])
            self.towers[instruction.src].crates = src[:-quant]

    def top_crates(self):
        return "".join([tower.crates[-1] for tower in self.towers.values()])

    def print_step(self, step, instruction):
        print(instruction)
        print(f"------------------- Step {step} -------------------")
        for key, tower in self.towers.items():
            print(key, tower)


def parse(inp):
    with open(inp) as f:
        inp = f.read()
        break_line = False
        max_crate_height = 0
        crate_layers = {}
        lines = inp.split("\n")
        instructions = []
        # instructions
        for ix, line in enumerate(lines):
            if "[" in line:
                max_crate_height += 1
            if line == "":
                break_line = ix
            if break_line:
                instructions.append(line)
        instructions = instructions[1:]

        num_towers = len(lines[break_line].split())
        # crates
        for ix, line in enumerate(lines):
            if ix == break_line:
                break

            l_of_str = list(line)
            for i, el in enumerate(l_of_str):
                if el == "[":
                    if (i + 1) not in crate_layers:
                        crate_layers[i + 1] = []
                    crate_layers[i + 1].append(l_of_str[i + 1])
        return num_towers, max_crate_height, instructions, crate_layers


def main(inp):
    num_towers, max_crate_height, instructions, crate_layers = parse(inp)
    ua = UnloadArea(num_towers, max_crate_height, instructions, crate_layers)
    print(ua.top_crates())


if __name__ == "__main__":
    main("5/test.txt")
    main("5/data.txt")
