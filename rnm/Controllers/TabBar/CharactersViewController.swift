//
//  RMCharacterViewController.swift
//  rnm
//
//  Created by Duy Ha on 04/01/2024.
//

import UIKit
import SnapKit

final class CharactersViewController: UIViewController {
    private let charactersListView = CharactersListView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        
        setupCharactersListView()
        applyConstraints()
    }
    
    private func applyConstraints() {
        charactersListView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupCharactersListView() {
        view.addSubview(charactersListView)
        charactersListView.delegate = self
    }
}

extension CharactersViewController: CharactersListViewDelegate {
    func charactersListView(_ charactersListView: CharactersListView, didSelectCharacter character: CharacterModel) {
        let viewModel = CharacterDetailViewModel(character)
        let vc = CharacterDetailViewController(viewModel: viewModel)
        
        vc.navigationItem.largeTitleDisplayMode = .never
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
