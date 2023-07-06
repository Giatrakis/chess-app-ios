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
    var startingPosition: Int? = nil
    var endingPosition: Int? = nil
    
    var headerTitle: String {
        switch startingPosition == nil {
        case true:
            return "Select starting position"
        case false where endingPosition == nil:
            return "Select ending position"
        default:
            return "You need x moves"
        }
    }
    
    var startingPositionLabelText: String {
        guard let startingPosition = startingPosition else { return "Starting Position\n" }
        return "Starting Position\n\(chessPieces[startingPosition].selection(chessRowsCount: chessRowsCount))"
    }
    
    var endingPositionLabelText: String {
        guard let endingPosition = endingPosition else { return "Ending Position\n" }
        return "Ending Position\n\(chessPieces[endingPosition].selection(chessRowsCount: chessRowsCount))"
    }
    
    
    func createChess() {
        for row in 0..<chessRowsCount {
            for column in 0..<chessRowsCount {
                chessPieces.append(ChessPieceModel(row: row, column: column))
            }
        }
    }
    
    
    func tapPieceIn(position: Int) {
        switch startingPosition == nil {
        case true:
            startingPosition = position
        case false where endingPosition == nil:
            endingPosition = position
        default:
            break
        }
    }
}
