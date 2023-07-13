//
//  ChessViewModel.swift
//  chess-app-ios
//
//  Created by Alex Giatrakis on 6/7/23.
//

import Foundation

final class ChessViewModel {
    let chessRowsCount = 8
    let cellID = "ChessPieceID"
    var chessPieces: [ChessPieceModel] = []
    var startingPositionIndex: Int? = nil
    var endingPositionIndex: Int? = nil
    var finalMovements: [[ChessPieceModel]] = []
    
    var headerTitle: String {
        switch startingPositionIndex == nil {
        case true:
            return "Select starting position"
        case false where endingPositionIndex == nil:
            return "Select ending position"
        default:
            if let firstMove = finalMovements.first {
                return "You need \(firstMove.count) \(firstMove.count == 1 ? "move" : "moves")"
            }
            
            guard let endingPositionIndex = endingPositionIndex else { return "" }
            return "You can't go to \(chessPieces[endingPositionIndex].selection(chessRowsCount: chessRowsCount)) with 3 moves"
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
    
    var solutionsText: String {
        switch finalMovements.isEmpty {
        case true:
            return ""
        case false:
            return "Solutions:\n" + finalMovements.map({ $0.map({ $0.selection(chessRowsCount: chessRowsCount) }).joined(separator: " > ") }).joined(separator: "\n")
        }
    }
    
    
//MARK: - Methods
    
    func createChess() {
        for row in 0..<chessRowsCount {
            for column in 0..<chessRowsCount {
                chessPieces.append(ChessPieceModel(row: row, column: column, index: (row * chessRowsCount) + column))
            }
        }
    }
    
    
    func reset() {
        startingPositionIndex = nil
        endingPositionIndex = nil
        finalMovements.removeAll()
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
        let firstMovements = calculatePossibleMovements(fromIndex: startingPositionIndex)
        var finalMovements: [[ChessPieceModel]] = []
        
        for firstMovement in firstMovements {
            finalMovements.append([firstMovement])

            if let index = firstMovement.index, index != endingPositionIndex {
                let secondMovements = calculatePossibleMovements(fromIndex: index)

                for secondMovement in secondMovements {
                    finalMovements.append([firstMovement, secondMovement])

                    if let secondMovementIndex = secondMovement.index {
                        calculatePossibleMovements(fromIndex: secondMovementIndex)
                            .forEach({ finalMovements.append([firstMovement, secondMovement, $0]) })
                    }
                }
            }
        }
        
        self.finalMovements = finalMovements.filter({ $0.contains(where: { $0.index == endingPositionIndex }) }).sorted(by: { $0.count < $1.count })
    }
}
