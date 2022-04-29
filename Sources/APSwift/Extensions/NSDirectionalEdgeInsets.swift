//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 25.04.2022.
//

import UIKit

public extension NSDirectionalEdgeInsets {
    
    static func allAround(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: value, leading: value, bottom: value, trailing: value)
    }
    
    static func directional(vertical: CGFloat, horizontal: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    static func horizontal(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: 0, leading: value, bottom: 0, trailing: value)
    }
    
    static func vertical(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: value, leading: 0, bottom: value, trailing: 0)
    }
    
    static func top(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: value, leading: 0, bottom: 0, trailing: 0)
    }
    
    static func bottom(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: 0, leading: 0, bottom: value, trailing: 0)
    }
    
    static func leading(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: 0, leading: value, bottom: 0, trailing: 0)
    }
    
    static func trailing(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        .init(top: 0, leading: 0, bottom: 0, trailing: value)
    }
}
