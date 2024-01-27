//
//  BasicViewController.swift
//  rnm
//
//  Created by Duy Ha on 04/01/2024.
//

import UIKit

class BaseViewController: UIViewController {
    let overlayViewController: UIViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .systemBackground.withAlphaComponent(0.98)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
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
}
