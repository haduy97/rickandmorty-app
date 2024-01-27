//
//  LoadingView.swift
//  rnm
//
//  Created by Duy Ha on 15/01/2024.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    private let rickandmortyLogo: UIImage? = {
        var image = UIImage(named: "rickandmorty")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        return image
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: rickandmortyLogo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(logoImageView)
        addLoaderConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addLoaderConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse]) { [weak self] in
            self?.logoImageView.alpha = 0.1
        }
    }

}
