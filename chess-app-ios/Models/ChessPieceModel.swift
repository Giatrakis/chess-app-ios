//
//  ChessPieceModel.swift
//  chess-app-ios
//
//  Created by Alex Giatrakis on 6/7/23.
//

import Foundation

struct ChessPieceModel {
    let row: Int
    let column: Int
    var index: Int? = nil
    
    var columnLabel: String {
        let alphabet = (UnicodeScalar("a").value...UnicodeScalar("z").value).compactMap { UnicodeScalar($0) }.map({ String($0) })
        guard row < alphabet.count else { return "" }
        return column < alphabet.count ? alphabet[column] : ""
    }
    
    
    func selection(chessRowsCount: Int) -> String {
        "\(columnLabel)\(chessRowsCount - row)"
    }
}
