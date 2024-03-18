from TicTacToeGame import TicTacToeGame, GameStatus, Player


class GameManager():
    def __init__(self):
        self.all_games = []

    # возвращает id игры (номер в self.all_games) и за кого будет играть игрок
    def new_game(self):
        if len(self.all_games) == 0:
            self.all_games.append(TicTacToeGame(0))
            return {"id": 0, "role": Player.cross.value}
        elif self.all_games[-1].status == GameStatus.wait_second_player:
            self.all_games[-1].status = GameStatus.playing
            return {"id": self.all_games[-1].id, "role": Player.nought.value}
        else:
            self.all_games.append(TicTacToeGame(len(self.all_games)))
            return {"id": self.all_games[-1].id, "role": Player.cross.value}

    def get_game(self, id):
        return self.all_games[id]

    def make_move(self, id, move):
        return self.all_games[id].make_move(move)
