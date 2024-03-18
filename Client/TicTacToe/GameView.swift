//
//  ContentView.swift
//  Tic_Tac_toe
//
import SwiftUI

struct GameView: View
{
    //@StateObject private var viewModel = GameViewModel()
    
    @StateObject private var viewModel = GameModel()
    let serverController : ServerController
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),]
    
    @State var isGame = false
    init(serverController: ServerController){
        self.serverController = serverController
        
    }
    var body: some View {
        
        if(!isGame){
            Button("Начать игру", action: {isGame = true; connect()})
        }else{
            VStack{
                Text("Id игры: " + String(viewModel.id))
                Text("Роль: " + viewModel.role.stringValue)
                Text("Ход: " + viewModel.turn.stringValue)
                Text("Статус: " + viewModel.status.stringValue)
                if(viewModel.status == GameStatus.finished){
                    Text("Победитель: " + viewModel.winner.stringValue)
                }

                
                GeometryReader {
                    geometry in
                    VStack {
                        Spacer()
                        LazyVGrid( columns: columns, spacing: 10) {
                            ForEach(0..<9){ i in
                                ZStack {
                                    GameCircleBox(geometryProxy: geometry)
                                    ImagePlayerIndicator(geometryProxy: geometry, systemName: viewModel.boardModel.getCell(i: i))
                                }.onTapGesture {
                                    makeMove(position: i)
                                }
                                
                            }
                        }
                        //Button(viewModel.abc, action: { updateAbc() })
                        Spacer()
                    }
                    .disabled(!viewModel.ableMakeMove())
                    .padding()
                    //.alert(item: $viewModel.alertItem, content: { alertItem in
                     //   Alert(title: alertItem.titles, message: alertItem.messages, dismissButton: .default(alertItem.buttonTitle, action: {viewModel.resetGame() })) })
                }
            }
        }
    }
    
    
    
    
    func updateGame(){
        serverController.getGame(id: viewModel.id){ result in
            switch result {
            case .success(let data):
                // Обработка полученных данных
                if let decodedResponse = try? JSONDecoder().decode(GameResponse.self, from: data) {
                                    DispatchQueue.main.async {
                                        viewModel.update(gameResponse: decodedResponse)
                                    }
                                }
            case .failure(let error):
                // Обработка ошибки
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func connect(){
        serverController.connect { result in
            switch result {
            case .success(let data):
                // Обработка полученных данных
                if let decodedResponse = try? JSONDecoder().decode(ConnectResponse.self, from: data) {
                                    DispatchQueue.main.async {
                                        viewModel.update(connectResponse: decodedResponse)
                                        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: viewModel.status != GameStatus.finished) { timer in
                                            // Проверяем текущий ход игрока каждую секунду
                                            updateGame()
                                            isGame.toggle()
                                            isGame.toggle()

                                            
                                        }
                                    }
                                }
            case .failure(let error):
                // Обработка ошибки
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func makeMove(position: Int){
        serverController.makeMove(id: viewModel.id, move: Move2(player: viewModel.role, positon: position)) { result in
            
                DispatchQueue.main.async {
                    
                    print("сделан ход")
                    print(viewModel.boardModel.board[0])
                    
                }
                
            
        }
    }
}

enum Player{
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct GameCircleBox: View{
    var geometryProxy: GeometryProxy
    var body: some View{
        Circle()
            .foregroundColor(.blue).opacity(0.7)
            .frame(width: geometryProxy.size.width / 3.5,
                   height: geometryProxy.size.width / 3.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(serverController: ServerController())
    }
}

struct ImagePlayerIndicator: View {
    var geometryProxy: GeometryProxy
    
    var systemName: String
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .frame(width: geometryProxy.size.width / 6,
                   height: geometryProxy.size.width / 6)
            .foregroundColor(.white)
    }
}
