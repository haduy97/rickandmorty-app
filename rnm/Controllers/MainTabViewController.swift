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
        
        delegate = self
        
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
        
        //Set all tabs to ViewControllers
        setViewControllers([tab1, tab2, tab3, tab4], animated: true)
    }
}

extension MainTabViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabTransitionSlide(viewControllers: tabBarController.viewControllers)
    }
}


// Handle trasition slide to when selected the tab
private class TabTransitionSlide: NSObject, UIViewControllerAnimatedTransitioning {

    // Declare variables
    let viewControllers: [UIViewController]?
    let duration: Double = 0.22

    // Init
    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }
    
    // Function AnimatedTransitioning Delegate
    // -- Duration of transition
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(duration)
    }
    
    // -- Animation Slide of transition
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndexOf(forViewController: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndexOf(forViewController: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }

        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart

        DispatchQueue.main.async { [weak self] in
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self?.duration ?? 1.0, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }

    //Function
    func getIndexOf(forViewController vc: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
}
