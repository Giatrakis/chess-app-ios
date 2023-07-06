//
//  ChessVC.swift
//  chess-app-ios
//
//  Created by Alex Giatrakis on 6/7/23.
//

import UIKit

class ChessVC: UIViewController {
    private let stackView = UIStackView()
    private let descriptionLabel = UILabel()
    private var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    private let cellID = "ChessPieceID"
    private var viewModel = ChessViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewsSetup()
        viewModel.createChess()
    }
}


//MARK: - Views Setup
extension ChessVC {
    private func viewsSetup() {
        view.backgroundColor = .white
        title = "Chess Game"
        configureStackView()
        configureDescriptionLabel()
        configureCollectionView()
    }
    
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
    }
    
    
    private func configureDescriptionLabel() {
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        descriptionLabel.text = "Select start position"
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .red.withAlphaComponent(0.3)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChessPieceCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
}


//MARK: - Collection View
extension ChessVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
