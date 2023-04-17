//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 26.08.2022.
//

import Foundation

public extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
