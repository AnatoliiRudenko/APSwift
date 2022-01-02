//
//  Array.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 23.12.2021.
//

import Foundation

public extension Array {
    
    func cutToFirst(_ newCount: Int = 1) -> [Element] {
        guard self.count > newCount else { return self }
        let maxIndex = newCount - 1
        return Array(self[...maxIndex])
    }
}
