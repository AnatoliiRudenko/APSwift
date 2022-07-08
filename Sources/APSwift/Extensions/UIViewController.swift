//
//  UIViewController.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 04.02.2022.
//

import UIKit

public extension UIViewController {
    
    var navBarHeight: CGFloat {
        navigationController?.navigationBar.frame.height ?? 0
    }
    
    func hideKeyboardOnTap(completion: ((UITapGestureRecognizer) -> Void)? = nil) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        completion?(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
