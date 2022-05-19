//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 19.05.2022.
//

import Foundation

public enum Side {
    case top
    case bottom
    case left
    case right
}

public extension Array where Element == Side {
    
    static var exceptForBottom: [Side] { [.top, .left, .right] }
}
