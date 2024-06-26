//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 19.04.2022.
//

import UIKit

public extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool,
                            completion: Closure? = nil) {
        pushViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion?() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
    
    func popViewController(animated: Bool,
                           completion: Closure? = nil) {
        popViewController(animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion?() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
}

// MARK: - Sizes
public extension UINavigationController {
    
    var navBarHeight: CGFloat {
        navigationBar.frame.size.height
    }
}

// MARK: - Hairline
public extension UINavigationController {
    
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    
    func popSeveralScreens(_ amount: Int, animated: Bool = true) {
        let viewControllers: [UIViewController] = viewControllers as [UIViewController]
        popToViewController(viewControllers[viewControllers.count - (1 + amount)], animated: animated)
    }
}

private extension UINavigationController {
    
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
}
