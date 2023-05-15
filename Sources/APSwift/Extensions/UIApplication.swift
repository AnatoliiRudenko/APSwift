//
//  UIApplication.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 14.12.2021.
//

import UIKit

public extension UIApplication {
    
    func topViewController(base: UIViewController? = nil) -> UIViewController? {
        let base = base ?? keyWindowGetter?.rootViewController
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    var safeAreaInsets: UIEdgeInsets {
        self.windows.first?.safeAreaInsets ?? .zero
    }
    
    var keyWindowGetter: UIWindow? {
        connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
    }
}
