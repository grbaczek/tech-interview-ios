import Foundation

enum player{
    case X
    case O
}

struct BoardModel {
    
    var gameOver = false
    var gameOverText: String?
    var currentPlayer = player.X
    var board = [FieldState?](repeating: .empty, count: 9)
    
    let winConditions = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    mutating func reset() {
        board = [FieldState?](repeating: .empty, count: 9)
        currentPlayer = player.X
    }
    
    mutating func setField(index: Int) {
        if (board[index] == .empty) {
            board[index] = currentPlayer == player.X ? .cross : .nought
            //has winner
            if (winConditions.contains{ condition in
                board[condition.first!] != .empty && condition.dropFirst()
                    .map{board[$0]}
                    .allSatisfy{$0 == board[condition.first!]}
            }) {
                gameOver = true
                gameOverText = "Player \(currentPlayer == player.X ? "X" : "O") won!"
            //is full
            } else if (board.allSatisfy{$0 != .empty}) {
                gameOver = true
                gameOverText = "Draw"
            }
            currentPlayer = currentPlayer == player.X ? player.O : player.X
        }
    }
    
    mutating func timeElapsed(){
        gameOver = true
        gameOverText = "Player \(currentPlayer == player.X ? "O" : "X") won!"
    }
    
    subscript(index: Int) -> FieldState? {
        get {
            board[index]
        }
        set {
            board[index] = newValue
        }
    }
}
