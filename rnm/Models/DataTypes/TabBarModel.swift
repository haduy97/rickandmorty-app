//
//  TabBarModel.swift
//  rnm
//
//  Created by Duy Ha on 29/01/2024.
//

import Foundation
import UIKit

struct TabBarModel {
    //Main model
    let rootViewController: UIViewController
    let icon: UIImage
    let title: String
    
    init(type: TabType) {
        self.rootViewController = type.viewController
        self.icon = type.icon
        self.title = type.title
    }
    
    //Internal Enum
    public enum TabType {
        case characters, location, episode, setting
        
        var viewController: UIViewController {
            switch self {
            case .characters:
                return UINavigationController(rootViewController: CharactersViewController())
            case .location:
                return UINavigationController(rootViewController: LocationViewController())
            case .episode:
                return UINavigationController(rootViewController: EpisodeViewController())
            case .setting:
                return UINavigationController(rootViewController: SettingViewController())
            }
        }
        
        var icon: UIImage! {
            switch self {
            case .characters:
                return UIImage(systemName: "person")
            case .location:
                return UIImage(systemName: "location.viewfinder")
            case .episode:
                return UIImage(systemName: "livephoto.play")
            case .setting:
                return UIImage(systemName: "gearshape")
            }
        }
        
        var title: String {
            switch self {
            case .characters:
                return "Character"
            case .location:
                return "Location"
            case .episode:
                return "Episode"
            case .setting:
                return "Setting"
            }
        }
    }
}

