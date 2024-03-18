//
//  GameScreen.swift
//  TicTacToe
//
//  Created by Andrew on 16.03.2024.
//

import SwiftUI

struct GameScreen: View {
    
    @State var isGame = false
    let serverController : ServerController
    init(serverController: ServerController) {
        self.serverController = serverController
    }
    var body: some View {
        if(!isGame){
            Button("Начать игру", action: {isGame = true})
        }
        else{
            GameView(serverController: serverController)
        }
            

    }
}
