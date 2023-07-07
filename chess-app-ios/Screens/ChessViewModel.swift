//
//  ChessViewModel.swift
//  chess-app-ios
//
//  Created by Alex Giatrakis on 6/7/23.
//

import Foundation

final class ChessViewModel {
    let chessRowsCount = 6
    let maxAttempts = 3
    let cellID = "ChessPieceID"
    var chessPieces: [ChessPieceModel] = []
    var startingPositionIndex: Int? = nil
    var endingPositionIndex: Int? = nil
    var finalMovements: [[ChessPieceModel]] = [[]]
    
    var headerTitle: String {
        switch startingPositionIndex == nil {
        case true:
            return "Select starting position"
        case false where endingPositionIndex == nil:
            return "Select ending position"
        default:
            return "You need x moves"
        }
    }
    
    var startingPositionLabelText: String {
        guard let startingPosition = startingPositionIndex else { return "Starting Position\n" }
        return "Starting Position\n\(chessPieces[startingPosition].selection(chessRowsCount: chessRowsCount))"
    }
    
    var endingPositionLabelText: String {
        guard let endingPosition = endingPositionIndex else { return "Ending Position\n" }
        return "Ending Position\n\(chessPieces[endingPosition].selection(chessRowsCount: chessRowsCount))"
    }
    
    
    func createChess() {
        for row in 0..<chessRowsCount {
            for column in 0..<chessRowsCount {
                chessPieces.append(ChessPieceModel(row: row, column: column, index: (row * chessRowsCount) + column))
            }
        }
    }
    
    
    func tapPieceIn(position: Int) {
        switch startingPositionIndex == nil {
        case true:
            startingPositionIndex = position
        case false where endingPositionIndex == nil:
            endingPositionIndex = position
            movementsAlgorithm()
        default:
            break
        }
    }
    
    
    private func calculatePossibleMovements(fromIndex index: Int) -> [ChessPieceModel] {
        let allPossibleMovements: [(row: Int, column: Int)] = [(2, -1), (2,  1), (-2,  1), (-2, -1), (1,  2), (1, -2), (-1,  2), (-1, -2)]
        var verifiedMovements: [ChessPieceModel] = []
        
        for possibleMovement in allPossibleMovements {
            let currentPiece = chessPieces[index]
            var movement = ChessPieceModel(row: possibleMovement.row + currentPiece.row, column: possibleMovement.column + currentPiece.column)
            movement.index = (movement.row * chessRowsCount) + movement.column
            verifiedMovements.append(movement)
        }
        
        verifiedMovements.removeAll(where: { $0.row >= chessRowsCount || $0.column >= chessRowsCount || [$0.row, $0.column].contains(where: { $0 < 0 }) })
        return verifiedMovements
    }
    
    
    private func movementsAlgorithm() {
        guard let startingPositionIndex = startingPositionIndex, let endingPositionIndex = endingPositionIndex else { return }
        let movements = calculatePossibleMovements(fromIndex: startingPositionIndex)
        finalMovements = Array(repeating: [chessPieces[startingPositionIndex]], count: movements.count)
        
        guard !movements.contains(where: { $0.index == endingPositionIndex }) else {
            finalMovements = [movements.filter({ $0.index == endingPositionIndex })]
            return
        }
        
        for movementIndex in 0..<movements.count {
            finalMovements[movementIndex].append(movements[movementIndex])
            
            for attempt in 1..<maxAttempts {
                if let destinationIndex = movements[movementIndex].index {
                    let currentMovements = calculatePossibleMovements(fromIndex: destinationIndex)
                    
                    if let finalMovementIndex = currentMovements.firstIndex(where: { $0.index == endingPositionIndex }) {
                        finalMovements[movementIndex].append(currentMovements[finalMovementIndex])
                        break
                    }
                    
                    if attempt == 2 { finalMovements[movementIndex].removeAll() }
                }
            }
        }
        
        finalMovements.removeAll(where: { $0.isEmpty })
    }
}
