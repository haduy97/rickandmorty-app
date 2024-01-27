//
//  CollectionReusableView.swift
//  rnm
//
//  Created by Duy Ha on 21/01/2024.
//

import UIKit
import SnapKit

final class FooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "FooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spin = UIActivityIndicatorView(style: .large)
        spin.color = .label.withAlphaComponent(0.6)
        spin.hidesWhenStopped = true
        spin.translatesAutoresizingMaskIntoConstraints = false
        return spin
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("FooterLoadingCollectionReusableView has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(spinner)
        applyConstraints()
    }
    
    private func applyConstraints() {
        spinner.snp.makeConstraints { make in
            make.width.height.equalTo(100.0)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    
    // ---- Public ----
    
    public func startLoading() {
        spinner.startAnimating()
    }
    
    public func stopLoading() {
        spinner.stopAnimating()
    }
}
