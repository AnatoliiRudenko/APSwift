//
//  UIApplication.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 14.12.2021.
//

import UIKit

public extension UIApplication {
    
    class var topViewController: UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
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
    
    var keyWindow: UIWindow? {
        windows.first(where: { $0.isKeyWindow })
    }
}
