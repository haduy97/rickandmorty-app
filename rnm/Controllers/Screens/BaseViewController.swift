//
//  BasicViewController.swift
//  rnm
//
//  Created by Duy Ha on 04/01/2024.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    let overlayViewController: UIViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .systemBackground
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }()
    
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        // Config overlayViewController
        overlayViewController.view.addSubviews(logoImageView, titleLabel)
        applyConstraints()
        
        // Subcribe notification to catch event in active state
        NotificationCenter.default.addObserver(self, selector: #selector(hideOverlayViewController), name: UIApplication.didBecomeActiveNotification, object: nil)

        // Subcribe notification to catch event in background state
        NotificationCenter.default.addObserver(self, selector: #selector(showOverlayViewController), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func showOverlayViewController() {
        present(overlayViewController, animated: true)
    }
    
    @objc func hideOverlayViewController() {
        dismiss(animated: true)
    }
    
    
    // ---- Private ----
    private func applyConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(90.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20.0)
            make.centerX.equalTo(logoImageView)
        }
    }
}
