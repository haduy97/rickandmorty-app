//
//  ViewController.swift
//  rnm
//
//  Created by Duy Ha on 04/01/2024.
//

import UIKit

final class MainTabViewController: UITabBarController {
    
    private var tabBarModels: [TabBarModel] {
        let models: [TabBarModel] = [.characters, .location, .episode, .setting].map {
            TabBarModel(type: $0)
        }
        return models
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        delegate = self
        setUpTabs()
    }
    
    private func setUpTabs() {
        tabBar.tintColor = .label
        
        let tabViewControllers: [UIViewController] = tabBarModels.map {
            let vc = $0.rootViewController
            vc.tabBarItem.image = $0.icon
            vc.tabBarItem.title = $0.title
            vc.navigationController?.navigationItem.largeTitleDisplayMode = .always
            vc.navigationController?.navigationBar.prefersLargeTitles = true
            
            return vc
        }
            
        //Set all tabs to ViewControllers
        setViewControllers(tabViewControllers, animated: true)
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
    let duration: Double = 0.3

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
            let fromVC = transitionContext.viewController(forKey: .from),
            let fromView = fromVC.view,
            let fromIndex = getIndexOf(forViewController: fromVC),
            let toVC = transitionContext.viewController(forKey: .to),
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
            UIView.animate(withDuration: self?.duration ?? 0.5, animations: {
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
