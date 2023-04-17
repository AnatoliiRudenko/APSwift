//
//  UIApplication.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 14.12.2021.
//

import UIKit

public extension UIApplication {
    
    var topViewController: UIViewController? {
        if var topController = keyWindowGetter?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
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
