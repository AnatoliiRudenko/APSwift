//
//  UIApplication.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 14.12.2021.
//

import UIKit

public extension UIApplication {
    
    class var topViewController: UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        if var topController = keyWindow?.rootViewController {
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
}
