//
//  CharacterCollectionViewCell.swift
//  rnm
//
//  Created by Duy Ha on 16/01/2024.
//

import UIKit

// Single cell for character
final class CharacterCollectionViewCell: UICollectionViewCell {
    static let identifier = "CharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .systemFont(ofSize: Constants.textLarge, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: Constants.textMedium, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    // Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        
        applyAttributes()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    private func applyAttributes() {
        contentView.backgroundColor = .systemGray2
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8.0
    }
    
    private func applyConstraints() {
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).offset(-3.0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(30.0)
            make.left.equalToSuperview().offset(7.0)
            make.right.equalToSuperview().offset(-7.0)
            make.bottom.equalTo(statusLabel.snp.top)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.height.equalTo(nameLabel)
            make.width.equalTo(nameLabel)
            make.centerX.equalTo(nameLabel)
            make.bottom.equalToSuperview()
        }
    }
    
    // Reuse & Config
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel: CharacterItemCellViewModel) {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.statusText
        viewModel.getImg { [weak self] rs in
            switch rs {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }

}
