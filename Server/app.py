from flask import Flask, render_template, request, jsonify
from GameManager import GameManager
from TicTacToeGame import Move

gameManager = GameManager()

app = Flask(__name__)


@app.route('/')
def index():
    return "hello World"
    # return render_template('index.html')

@app.route('/connect', methods=['POST'])
def connect():
    return jsonify(gameManager.new_game())


@app.route('/game/<int:id>', methods=['GET'])
def get_game(id):
    return jsonify(gameManager.get_game(id).to_dict())



@app.route('/game/<int:id>/make_move', methods=['PATCH'])
def make_move(id):
    data = request.json
    move = Move(data['player'], data['position'])
    gameManager.make_move(id, move)
    return "hello World"


if __name__ == '__main__':
    app.run()
