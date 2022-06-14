//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 14.06.2022.
//

import UIKit

public func execute(_ closure: Closure?, animated: Bool) {
    if animated {
        UIView.animate {
            closure?()
        }
    } else {
        closure?()
    }
}
