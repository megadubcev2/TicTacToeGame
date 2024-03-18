from enum import Enum


class Symbol(Enum):
    empty = 0
    cross = 1
    nought = 2


class Player(Enum):
    cross = 0
    nought = 1


def PlayerToSymbol(player):
    if str(Player.cross) == str(player):
        return Symbol.cross
    if str(Player.nought) == str(player):
        return Symbol.nought


class GameStatus(Enum):
    wait_second_player = 0
    playing = 1
    finished = 2
    paused = 3


class Board:
    def __init__(self):
        self.board = [Symbol.empty.value] * 9


class Move:
    def __init__(self, player):
        self.board = [Symbol.empty.value] * 9


class TicTacToeGame:
    def __init__(self, id):
        self.id = id
        self.board = Board()
        self.turn = Player.cross
        self.status = GameStatus.wait_second_player
        self.winner = Symbol.empty
        self.moves_count = 0

        self.win_patterns = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [2, 4, 6],
                             [0, 4, 8]]

    def to_dict(self):
        return {
            "id": self.id,
            "board": self.board.board,
            "turn": self.turn.value,
            "status": self.status.value,
            "winner": self.winner.value
        }

    def change_turn(self):
        if self.turn == Player.cross:
            self.turn = Player.nought
        else:
            self.turn = Player.cross

    def make_move(self, move):
        if self.status == GameStatus.playing:
            if str(move.player) == self.turn.name:
                if self.board.board[move.position] == Symbol.empty.value:
                    self.board.board[move.position] = self.turn.value + 1
                    self.moves_count += 1
                    self.check_finished()
                    self.change_turn()

    def check_finished(self):
        for win_pattern in self.win_patterns:
            sovpad = 0
            for cell in win_pattern:
                if self.board.board[cell] == 2:
                    sovpad += 1
            if sovpad == 3:
                self.winner = Symbol.nought
                self.status = GameStatus.finished
                return

        for win_pattern in self.win_patterns:
            sovpad = 0
            for cell in win_pattern:
                if self.board.board[cell] == 1:
                    sovpad += 1
            if sovpad == 3:
                self.winner = Symbol.cross
                self.status = GameStatus.finished
                return
        if self.moves_count == 9:
            self.status = GameStatus.finished


class Move:
    def __init__(self, player, position):
        self.player = player
        self.position = position
