//
//  CharactersListViewModel.swift
//  rnm
//
//  Created by Duy Ha on 14/01/2024.
//

import Foundation
import UIKit

//----Protocol----

protocol CharactersListViewModelDelegate: AnyObject {
    func didLoadIntialCharacters()
    func didSelectCharacter(_  character: CharacterModel)
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
}

//----ViewModel----

final class CharactersListViewModel: NSObject {
    //Private
    private var characters = [CharacterModel]() {
        didSet {
            characters.forEach {
                let vm = CharacterItemCellViewModel(
                    name: $0.name,
                    status: $0.status,
                    imgUrl: URL(string: $0.image)
                )
                if !cellViewModels.contains(vm) {
                    cellViewModels.append(vm)
                }
            }
        }
    }
    
    private var apiInfo: GetListCharactersResponse.Info?
    private var cellViewModels = [CharacterItemCellViewModel]()
    private var isLoadingProgress: Bool = false
    
    private func onTappedItem(from list: [CharacterModel]?, at indexPath: IndexPath) {
        guard let list = list else { return }
        
        let character = list[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
    //Public
    public weak var delegate: CharactersListViewModelDelegate?
    
    // ---Get data first time
    public func fetchData() {
        APIService.shared.execute(.getListCharacters, responseType: GetListCharactersResponse.self) { [weak self] rs in
            switch rs {
            case .success(let res):
                self?.characters = res.results
                self?.apiInfo = res.info
                
                DispatchQueue.main.async {
                    self?.delegate?.didLoadIntialCharacters()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
                DispatchQueue.main.async {
                    self?.delegate?.didLoadIntialCharacters()
                }
            }
        }
    }
    
    // ---Get data Paginite
    public func fetchAdditionalCharacters (_ url: URL) {
        guard !isLoadingProgress else { return }
        
        isLoadingProgress = true
        guard let request = Request(url: url) else {
            isLoadingProgress = false
            return
        }

        APIService.shared.execute(request, responseType: GetListCharactersResponse.self) { [weak self] rs in
            guard let strongSelf = self else { return }
            switch rs {
            case .success(let res):
                let newResults = res.results
                strongSelf.apiInfo = res.info
                
                let startIndex = strongSelf.characters.count
                let endIndex = startIndex + newResults.count
                let indexPaths = Array(startIndex..<endIndex).compactMap { IndexPath(row: $0, section: 0) }
                
                strongSelf.characters.append(contentsOf: newResults)
            
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPaths)
                    strongSelf.isLoadingProgress = false
                }
            case .failure(let error):
                print(error)
                strongSelf.isLoadingProgress = false
            }
        }
        
    }
    
    public var isShowLoadMoreIndicator: Bool { return apiInfo?.next != nil }
}

// ----CollectionView----

extension CharactersListViewModel: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath)
        as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
                
        let itemViewModel = cellViewModels[indexPath.row]
        cell.configure(with: itemViewModel)
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("No Footer Available")
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FooterLoadingCollectionReusableView.identifier,
                for: indexPath
            ) as? FooterLoadingCollectionReusableView else {
                fatalError("Faild to load FooterLoadingCollectionReusableView")
        }
        
        footer.startLoading()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard isShowLoadMoreIndicator else {
            return CGSize(width: collectionView.bounds.width, height: 10.0)
        }
        
        return CGSize(width: collectionView.bounds.width, height: 125.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        onTappedItem(from: characters, at: indexPath)
    }
    
    //Haptic long-touch 3D
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            let infoAction = UIAction(title: "Info", state: .off) { _ in
                collectionView.deselectItem(at: indexPath, animated: true)
                self?.onTappedItem(from: self?.characters, at: indexPath)
            }
            
            return UIMenu(options: .displayInline, children: [infoAction])
        }
        
        return config
    }
}

// ----CollectionView - ScrollView----

extension CharactersListViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isShowLoadMoreIndicator, !isLoadingProgress, !cellViewModels.isEmpty,
            let nextUrlString = apiInfo?.next,
            let url = URL(string: nextUrlString) else {
                return
        }
        
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.bounds.height
        
        // Check if OffsetY is reached the end of the scrollview
        guard contentHeight != 0 && scrollViewHeight != 0,
            contentOffsetY >= (contentHeight - scrollViewHeight )
        else { return }
            
        fetchAdditionalCharacters(url)
    }
}
