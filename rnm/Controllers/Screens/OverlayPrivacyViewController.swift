//
//  OverlayPrivacyViewController.swift
//  rnm
//
//  Created by Duy Ha on 28/01/2024.
//

import UIKit

class OverlayPrivacyViewController: UIViewController {
    
    let logoImageView: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "rickandmorty"))
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.text = "Rick n Morty"
        label.font = .systemFont(ofSize: Constants.textTitle, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Config overlayViewController
        configSetupVC()
     

        // Do any additional setup after loading the view.
        applyConstraints()
    }
    
    // Private Function
    private func configSetupVC() {
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, titleLabel)
    
    }
    
    private func applyConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(90.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(15.0)
            make.centerX.equalTo(logoImageView)
        }
    }

}
