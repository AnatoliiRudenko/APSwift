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
}
