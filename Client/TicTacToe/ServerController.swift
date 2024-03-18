//
//  serverController.swift
//  TicTacToe
//
//  Created by Andrew on 15.03.2024.
//

import Foundation

class ServerController {
    // Здесь можно определить URL вашего сервера
    let baseURL = URL(string: "http://127.0.0.1:5000")!


    
    func connect(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/connect")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "ServerController", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            }
        }.resume()
    }
    
    
    func makeMove(id: Int, move : Move2, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/game/" + String(id) + "/make_move")
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let data2 = try JSONEncoder().encode(move)
            request.httpBody = data2
            
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(NSError(domain: "ServerController", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    // Метод для выполнения GET-запросов к серверу
    func getGame(id: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/game/" + String(id))

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "ServerController", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            }
        }.resume()
    }
}
