//
//  MatchResultView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI
import UIKit

struct MatchResultView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let matchResultViewController = MatchResultViewController()
        return matchResultViewController
    }
}

#Preview {
    MatchResultView()
}


final class MatchResultViewController: UIViewController {
    
    private lazy var resultsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        return collectionView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConfiguration()
    }
    
    private func setLayout() {
        self.view.addSubview(resultsCollectionView)
        resultsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        resultsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        resultsCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        resultsCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        resultsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func setConfiguration() {
        resultsCollectionView.dataSource = self
        resultsCollectionView.delegate = self
    }
}

extension MatchResultViewController {
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .fractionalHeight(0.8)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .groupPagingCentered
            
            return section
        }
    }
}

extension MatchResultViewController: UICollectionViewDelegate {}

extension MatchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        var color: UIColor
        switch indexPath.item {
        case 0: color = .black
        case 1: color = .gray
        case 2: color = .green
        case 3: color = .coral500
        default: color = .lemon500
        }
        
        cell.backgroundColor = color
        return cell
    }
}
