//
//  ViewController.swift
//  rnm
//
//  Created by Duy Ha on 04/01/2024.
//

import UIKit

final class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setUpTabs()
    }
    
    private func setUpTabs() {
        //Tab Variables
        let tab1 = UINavigationController(rootViewController: CharactersViewController())
        let tab2 = UINavigationController(rootViewController: LocationViewController())
        let tab3 = UINavigationController(rootViewController: EpisodeViewController())
        let tab4 = UINavigationController(rootViewController: SettingViewController())
        
        //Set Icon for Tab
        tab1.tabBarItem.image = .init(systemName: "person")
        tab2.tabBarItem.image = .init(systemName: "location.viewfinder")
        tab3.tabBarItem.image = .init(systemName: "livephoto.play")
        tab4.tabBarItem.image = .init(systemName: "gearshape")
        
        //Set Title for Tab
        tab1.tabBarItem.title = "Character"
        tab2.tabBarItem.title = "Location"
        tab3.tabBarItem.title = "Episode"
        tab4.tabBarItem.title = "Setting"
        
        tabBar.tintColor = .label
        
        // Perform animated transition on the view
        UIView.transition(with: tabBar, duration: 0.3, options: .transitionCrossDissolve) { [weak self] in
            self?.setViewControllers([tab1, tab2, tab3, tab4], animated: true)
        }
    }
}
