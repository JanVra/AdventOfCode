from dataclasses import dataclass, field

inp = """A Y
B X
C Z"""

@dataclass
class Player:
    actions : list[str] = field(default_factory=list)


@dataclass
class Game:
    playerA: Player
    playerB: Player
    score_mapping = dict(Y=2, X=1, Z=3, loss=0, draw=3, win=6)
    human_readable_mapping = dict(A="Rock", B="Paper", C="Scissors", Y="Paper", X="Rock", Z="Scissors")

    def __post_init__(self) -> None:
        self.outcome = self._calc_outcome()

    def _calc_game(self, actionA:str, actionB:str) -> str:
        hr_A = self.human_readable_mapping[actionA]
        hr_B = self.human_readable_mapping[actionB]

        if ((hr_A == "Paper") and (hr_B == "Rock")) or ((hr_A == "Rock") and (hr_B == "Scissors")) or ((hr_A == "Scissors") and (hr_B == "Paper")):
            return "loss"
        elif hr_A == hr_B:
            return "draw"
        else:
            return "win"

    def _calc_outcome(self) -> None:
        l = []
        for a, b in zip(self.playerA.actions, self.playerB.actions):
            outcome = self._calc_game(a, b)
            l.append(outcome)
        return l

    def calc_score(self) -> int:
        return sum(self.score_mapping[b] + self.score_mapping[outcome] for b, outcome in zip(self.playerB.actions, self.outcome))

def parse(raw: str) -> tuple[Player, Player]:
    p_A = Player()
    p_B = Player()
    for line in raw.split("\n"):
        actions = line.split(" ")
        p_A.actions.append(actions[0])
        p_B.actions.append(actions[1])
    return p_A, p_B

def main(inp_str):
    pA, pB = parse(inp_str)
    game = Game(pA, pB)
    return game.calc_score()

if "__main__" in __name__:
    print(main(inp))

    with open("2/data.txt") as f:
        print(main(f.read()))
