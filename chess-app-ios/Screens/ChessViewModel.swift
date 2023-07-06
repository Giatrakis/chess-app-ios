//
//  ChessViewModel.swift
//  chess-app-ios
//
//  Created by Alex Giatrakis on 6/7/23.
//

import Foundation

final class ChessViewModel {
    let chessRowsCount = 6
    let cellID = "ChessPieceID"
    var chessPieces: [ChessPieceModel] = []
    
    
    func createChess() {
        for row in 0..<chessRowsCount {
            for column in 0..<chessRowsCount {
                chessPieces.append(ChessPieceModel(row: row, column: column))
            }
        }
    }
}
