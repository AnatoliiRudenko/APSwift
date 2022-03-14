//
//  UIEdgeInsets.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 04.02.2022.
//

import UIKit

extension UIEdgeInsets {
    
    static func allAround(_ value: CGFloat) -> UIEdgeInsets {
        .init(top: value, left: value, bottom: value, right: value)
    }
    
    static func directional(vertical: CGFloat, horizontal: CGFloat) -> UIEdgeInsets {
        .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    static func horizontal(_ value: CGFloat) -> UIEdgeInsets {
        .init(top: 0, left: value, bottom: 0, right: value)
    }
    
    static func vertical(_ value: CGFloat) -> UIEdgeInsets {
        .init(top: value, left: 0, bottom: value, right: 0)
    }
    
    static func top(_ value: CGFloat) -> UIEdgeInsets {
        .init(top: value, left: 0, bottom: 0, right: 0)
    }
    
    static func bottom(_ value: CGFloat) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: value, right: 0)
    }
    
    static func left(_ value: CGFloat) -> UIEdgeInsets {
        .init(top: 0, left: value, bottom: 0, right: 0)
    }
    
    static func right(_ value: CGFloat) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: value)
    }
}
