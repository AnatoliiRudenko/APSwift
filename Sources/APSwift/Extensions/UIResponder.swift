//
//  UIResponder.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 29.12.2021.
//

import UIKit

public extension UIResponder {
    
    var parentVC: UIViewController? {
        next as? UIViewController ?? next?.parentVC
    }
    
    var parentBaseVC: BaseViewController? {
        next as? BaseViewController ?? next?.parentBaseVC
    }
}
