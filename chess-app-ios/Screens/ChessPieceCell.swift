//
//  ChessPieceCell.swift
//  chess-app-ios
//
//  Created by Alex Giatrakis on 6/7/23.
//

import UIKit

class ChessPieceCell: UICollectionViewCell {
    
    private let rowLabel = UILabel()
    private let columnLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupConstraints()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rowLabel.text = ""
        columnLabel.text = ""
    }
    
    
    func configureCell(piece: ChessPieceModel, chessRowsCount: Int) {
        switch (piece.row + piece.column)%2 == 0 {
        case true:
            backgroundColor = .appGreen
            rowLabel.textColor = .appBeige
            columnLabel.textColor = .appBeige
        case false:
            backgroundColor = .appBeige
            rowLabel.textColor = .appGreen
            columnLabel.textColor = .appGreen
        }
        
        rowLabel.text = "\(chessRowsCount - piece.row)"
        rowLabel.isHidden = piece.column != 0
        columnLabel.text = piece.columnLabel
        columnLabel.isHidden = piece.row != chessRowsCount - 1
    }
  
    
    private func setupConstraints() {
        rowLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rowLabel)
        NSLayoutConstraint.activate([
            rowLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            rowLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2)
        ])
        
        columnLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(columnLabel)
        NSLayoutConstraint.activate([
            columnLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            columnLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
