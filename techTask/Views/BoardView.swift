
import SwiftUI

struct BoardView: View {
    
    @ObservedObject var boardViewModel: BoardViewModel
    
    var body: some View {
        ZStack {
            Image("board")
                .resizable()
                .frame(width: 300, height: 300)
            VStack {
                ForEach(0..<3) { i in
                    HStack {
                        Spacer()
                        FieldView(boardViewModel: boardViewModel, index: 0 + i * 3)
                        FieldView(boardViewModel: boardViewModel, index: 1 + i * 3)
                        FieldView(boardViewModel: boardViewModel, index: 2 + i * 3)
                        Spacer()
                    }
                }
            }
        }
        .alert(isPresented: $boardViewModel.boardModel.gameOver) {
            Alert(title: Text(boardViewModel.boardModel.gameOverText!), dismissButton: Alert.Button.destructive(Text("Play Again"), action:  boardViewModel.reset) )
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(boardViewModel: BoardViewModel())
    }
}
