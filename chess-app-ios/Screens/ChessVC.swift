//
//  ChessVC.swift
//  chess-app-ios
//
//  Created by Alex Giatrakis on 6/7/23.
//

import UIKit

class ChessVC: UIViewController {
    private let stackView = UIStackView()
    private let headerLabel = UILabel()
    private var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let startingPositionLabel = UILabel()
    private let endingPositionLabel = UILabel()
    
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
        configureSelectionLabels()
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
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        headerLabel.text = viewModel.headerTitle
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(headerLabel)
        headerLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    private func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChessPieceCell.self, forCellWithReuseIdentifier: viewModel.cellID)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    
    private func configureSelectionLabels() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(containerView)
        containerView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        startingPositionLabel.text = viewModel.startingPositionLabelText
        startingPositionLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        startingPositionLabel.textAlignment = .center
        startingPositionLabel.numberOfLines = 0
        startingPositionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(startingPositionLabel)
        NSLayoutConstraint.activate([
            startingPositionLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            startingPositionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            startingPositionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            startingPositionLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5)
        ])
        
        endingPositionLabel.text = viewModel.endingPositionLabelText
        endingPositionLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        endingPositionLabel.textAlignment = .center
        endingPositionLabel.numberOfLines = 0
        endingPositionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(endingPositionLabel)
        NSLayoutConstraint.activate([
            endingPositionLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            endingPositionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            endingPositionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            endingPositionLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5)
        ])
    }
}


//MARK: - Collection View
extension ChessVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.chessPieces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellID, for: indexPath) as! ChessPieceCell
        cell.configureCell(piece: viewModel.chessPieces[indexPath.row],
                           chessRowsCount: viewModel.chessRowsCount,
                           isStartingPiece: indexPath.row == viewModel.startingPosition,
                           isEndingPiece: indexPath.row == viewModel.endingPosition)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / CGFloat(viewModel.chessRowsCount),
                      height: collectionView.frame.width / CGFloat(viewModel.chessRowsCount))
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
        viewModel.tapPieceIn(position: indexPath.row)
        headerLabel.text = viewModel.headerTitle
        startingPositionLabel.text = viewModel.startingPositionLabelText
        endingPositionLabel.text = viewModel.endingPositionLabelText
    }
}
