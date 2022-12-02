from dataclasses import dataclass, field

inp = """A Y
B X
C Z"""


@dataclass
class Game:
    playerA:list
    outcome:list
    score_mapping = dict(lose=0, draw=3, win=6, Rock=1, Paper=2, Scissors=3)
    human_readable_mapping = dict(A="Rock", B="Paper", C="Scissors", X="lose", Y="draw", Z="win")

    def __post_init__(self) -> None:
        self.action_outcome_table = {}
        for a in ("Rock", "Paper", "Scissors"):
            for b in ("Rock", "Paper", "Scissors"):
                self.action_outcome_table[f"{a}|{self.calc_outcome_table(a,b)}"] = b
        self.action = self.calc_action()

    def calc_outcome_table(self, hr_A:str, hr_B:str) -> str:
        if ((hr_A == "Paper") and (hr_B == "Rock")) or ((hr_A == "Rock") and (hr_B == "Scissors")) or ((hr_A == "Scissors") and (hr_B == "Paper")):
            return "lose"
        elif hr_A == hr_B:
            return "draw"
        else:
            return "win"

    def get_action(self, a, o):
        return self.action_outcome_table[f"{self.human_readable_mapping[a]}|{self.human_readable_mapping[o]}"]
    
    def calc_action(self):
        l = []
        for a, o in zip(self.playerA, self.outcome):
            action = self.get_action(a, o)
            l.append(action)
        return l

    def calc_score(self) -> int:
        return sum(self.score_mapping[b] + self.score_mapping[self.human_readable_mapping[outcome]] for b, outcome in zip(self.action, self.outcome))


def parse(raw: str):
    p_A =  [] 
    outcome = [] 
    for line in raw.split("\n"):
        actions = line.split(" ")
        p_A.append(actions[0])
        outcome.append(actions[1])
    return p_A, outcome

def main(inp_str):
    pA, outcome = parse(inp_str)
    game = Game(pA, outcome)
    return game.calc_score()

if "__main__" in __name__:
    print(main(inp))

    with open("2/data.txt") as f:
        print(main(f.read()))
