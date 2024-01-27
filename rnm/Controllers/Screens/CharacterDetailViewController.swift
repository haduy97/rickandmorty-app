//
//  CharacterDetailViewController.swift
//  rnm
//
//  Created by Duy Ha on 18/01/2024.
//

import UIKit
import SnapKit

// Controller show detail info of character
class CharacterDetailViewController: UIViewController {
    private var viewModel: CharacterDetailViewModel
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = viewModel.title
        view.backgroundColor = .systemBackground
    }

}
