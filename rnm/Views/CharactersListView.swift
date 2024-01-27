//
//  CharactersListView.swift
//  rnm
//
//  Created by Duy Ha on 14/01/2024.
//

import UIKit
import SnapKit

//Protocol
protocol CharactersListViewDelegate: AnyObject {
    func charactersListView(_ charactersListView: CharactersListView, didSelectCharacter character: CharacterModel)
}

///View handles showing list of characters, loader, etc...
final class CharactersListView: UIView {
    
    private let viewModel = CharactersListViewModel()
    private let loadingView = LoadingView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
  
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isHidden = true
        collection.alpha = 0
        collection.backgroundColor = .systemBackground
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        collection.register(FooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                            withReuseIdentifier: FooterLoadingCollectionReusableView.identifier)
        
        return collection
    }()
    
    public weak var delegate: CharactersListViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        

        addSubviews(collectionView, loadingView)
        applyConstraints()
        
        viewModel.fetchData()
        viewModel.delegate = self
        setUpcollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpcollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    private func applyConstraints() {
        loadingView.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(0.25)
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

// Extension delegate
extension CharactersListView: CharactersListViewModelDelegate {
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func didSelectCharacter(_ character: CharacterModel) {
        delegate?.charactersListView(self, didSelectCharacter: character)
    }
    
    func didLoadIntialCharacters() {
        loadingView.removeFromSuperview()
        
        collectionView.reloadData()
        collectionView.isHidden = false
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.collectionView.alpha = 1
        }
    }
    
}
