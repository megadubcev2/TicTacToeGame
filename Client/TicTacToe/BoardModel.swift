//
//  ClientModel.swift
//  TicTacToe
//
//  Created by Andrew on 16.03.2024.
//

import Foundation

class BoardModel : ObservableObject{
    @Published var board : [Symbol] = [Symbol.empty, Symbol.empty, Symbol.empty,
                                       Symbol.empty, Symbol.empty, Symbol.empty,
                                       Symbol.empty, Symbol.empty, Symbol.empty]
    func getCell(i : Int) -> String{
        switch board[i]{
        case .empty :
            return " "
            
        case .cross :
            return "xmark"
            
        case .nought:
            return "circle"
        }
        
    }
}

enum Symbol{
    case empty, cross, nought
    
    var stringValue: String {
            switch self {
            case .empty:
                return "draw game"
            case .cross:
                return "cross"
            case .nought:
                return "nought"
            }
        }
}

