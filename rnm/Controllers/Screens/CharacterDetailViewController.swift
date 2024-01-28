//
//  CharacterDetailViewController.swift
//  rnm
//
//  Created by Duy Ha on 18/01/2024.
//

import UIKit
import SnapKit

// Controller show detail info of character
final class CharacterDetailViewController: UIViewController {
    private var viewModel: CharacterDetailViewModel
    private let detailView = CharacterDetailView()
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // --Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //-- Private Function
    private func setupView() {
        // Config view
        title = viewModel.title
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        
        // Apply constraints
        applyConstraints()
    }
    
    private func applyConstraints() {
        detailView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }

}
