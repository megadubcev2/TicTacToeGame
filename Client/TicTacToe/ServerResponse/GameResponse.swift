//
//  GameResponse.swift
//  TicTacToe
//
//  Created by Andrew on 17.03.2024.
//

import Foundation

struct GameResponse: Codable {
    let id: Int
    let board: [Int]
    let turn: Int
    let status: Int
    let winner: Int
}
