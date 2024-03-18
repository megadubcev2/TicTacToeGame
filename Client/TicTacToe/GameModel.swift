//
//  GameModel.swift
//  TicTacToe
//
//  Created by Andrew on 16.03.2024.
//

import Foundation

class GameModel : ObservableObject
{
    @Published var id : Int
    @Published var boardModel: BoardModel
    @Published var turn: Player2
    @Published var role: Player2
    @Published var status: GameStatus
    @Published var winner: Symbol

    init(){
        id = 0
        boardModel = BoardModel()
        turn = Player2.cross
        role = Player2.cross
        status = GameStatus.wait_second_player
        winner = Symbol.empty

    }
    
    
    func update(gameResponse : GameResponse){
        print("aaa")
        id = gameResponse.id
        boardModel.board = gameResponse.board.map({ i in
            if (i == 0){
                return Symbol.empty
            }
            if (i == 1){
                return Symbol.cross
            }
            return Symbol.nought
        })
        if (gameResponse.turn == 0){
            turn = Player2.cross
        }
        else {
            turn = Player2.nought
        }
        
        switch gameResponse.status {
        case 0:
            status = GameStatus.wait_second_player
        case 1:
            status = GameStatus.playing
        case 2:
            status = GameStatus.finished
        case 3:
            status = GameStatus.paused
        default:
            break
        }
        
        switch gameResponse.winner {
        case 0:
            winner = Symbol.empty
        case 1:
            winner = Symbol.cross
        case 2:
            winner = Symbol.nought
        default:
            break
        }
        
        
    }
    func update(connectResponse : ConnectResponse){
        
        id = connectResponse.id
        if (connectResponse.role == 0){
            role = Player2.cross
        }
        else {
            role = Player2.nought
        }
    }
    func ableMakeMove() -> Bool{
        return turn == role
    }
    
    
}

enum Player2 : Codable{
    case cross, nought
    
    var stringValue: String {
            switch self {
            case .cross:
                return "cross"
            case .nought:
                return "nought"
            }
        }
}

enum GameStatus: Int, Codable {
    case wait_second_player = 0
    case playing = 1
    case finished = 2
    case paused = 3
    
    // Вычисляемое свойство для возврата строкового значения
    var stringValue: String {
        switch self {
        case .wait_second_player:
            return "wait_second_player"
        case .playing:
            return "playing"
        case .finished:
            return "finished"
        case .paused:
            return "paused"
        }
    }
}

class Move2 : Codable{
    var player : String
    var position : Int
    init(player : Player2, positon : Int){
        self.player = player.stringValue
        self.position = positon
    }
}

