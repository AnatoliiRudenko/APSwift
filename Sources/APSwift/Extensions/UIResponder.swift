//
//  UIResponder.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 29.12.2021.
//

import UIKit

public extension UIResponder {
    
    public var parentVC: UIViewController? {
        next as? UIViewController ?? next?.parentVC
    }
    
    #warning("fix")
//    public var parentBaseVC: BaseViewController? {
//        next as? BaseViewController ?? next?.parentBaseVC
//    }
}
