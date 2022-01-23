//
//  DirectionalInsets.swift
//  
//
//  Created by Анатолий Руденко on 13.01.2022.
//

import UIKit

public struct DirectionalInsets {
    let vertical: CGFloat
    let horizontal: CGFloat
    
    var asUIEdgeInsets: UIEdgeInsets {
        .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

// MARK: - Static
public extension DirectionalInsets {
    
    static let zero: DirectionalInsets = .init(vertical: 0, horizontal: 0)
}
