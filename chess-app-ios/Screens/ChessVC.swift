//
//  ChessVC.swift
//  chess-app-ios
//
//  Created by Alex Giatrakis on 6/7/23.
//

import UIKit

class ChessVC: UIViewController {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let headerLabel = UILabel()
    private var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let startingPositionLabel = UILabel()
    private let endingPositionLabel = UILabel()
    private let solutionsLabel = UILabel()
    private var resetButton = UIButton()
    
    private var viewModel = ChessViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewsSetup()
        viewModel.createChess()
    }
    
    
    @objc private func resetAction() {
        viewModel.reset()
        updateUI()
        resetButton.isHidden = true
        collectionView.reloadData()
    }
    
    
    private func updateUI() {
        headerLabel.text = viewModel.headerTitle
        startingPositionLabel.text = viewModel.startingPositionLabelText
        endingPositionLabel.text = viewModel.endingPositionLabelText
        solutionsLabel.text = viewModel.solutionsText
    }
}


//MARK: - Views Setup
extension ChessVC {
    private func viewsSetup() {
        view.backgroundColor = .white
        title = "Chess Game"
        configureScrollView()
        configureStackView()
        configureDescriptionLabel()
        configureCollectionView()
        configureSelectionLabels()
        configureSolutionsLabel()
        configureResetButton()
    }
    
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
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
        headerLabel.allowsDefaultTighteningForTruncation = true
        headerLabel.minimumScaleFactor = 0.85
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(headerLabel)
        headerLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
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
    
    
    private func configureSolutionsLabel() {
        solutionsLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(solutionsLabel)
        NSLayoutConstraint.activate([
            solutionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            solutionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        solutionsLabel.numberOfLines = 0
        solutionsLabel.allowsDefaultTighteningForTruncation = true
        solutionsLabel.minimumScaleFactor = 0.85
        solutionsLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    
    
    private func configureResetButton() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        resetButton.setTitle("RESET", for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        resetButton.backgroundColor = .darkGray
        resetButton.layer.cornerRadius = 12
        resetButton.isHidden = true
        resetButton.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
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
                           isStartingPiece: indexPath.row == viewModel.startingPositionIndex,
                           isEndingPiece: indexPath.row == viewModel.endingPositionIndex)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / CGFloat(viewModel.chessRowsCount),
                      height: collectionView.frame.width / CGFloat(viewModel.chessRowsCount))
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
        viewModel.tapPieceIn(position: indexPath.row)
        updateUI()
        resetButton.isHidden = false
    }
}
