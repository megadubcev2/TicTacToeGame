//
//  Tic_Tac_toeApp.swift
//  Tic_Tac_toe
//
import SwiftUI

@main
struct Tic_Tac_toeApp: App
{
    let serverController = ServerController()
    var body: some Scene {
        WindowGroup {
            GameView(serverController: serverController)
        }
    }
}
