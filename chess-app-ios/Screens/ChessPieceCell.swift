//
//  ChessPieceCell.swift
//  chess-app-ios
//
//  Created by Alex Giatrakis on 6/7/23.
//

import UIKit

class ChessPieceCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupConstraints()
        cellCustomization()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    
    func configureCell() {
        
    }
    
    
    private func cellCustomization() {
        backgroundColor = UIColor.random
    }
  
    
    private func setupConstraints() {

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1)
    }
}
