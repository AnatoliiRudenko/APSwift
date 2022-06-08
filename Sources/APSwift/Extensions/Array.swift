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
    
    func cutToLast(_ newCount: Int = 1) -> [Element] {
        guard self.count > newCount else { return self }
        return Array(self[newCount...count - 1])
    }
    
    func queryString(values: [String], key: String) -> String {
        values.map { key + "=" + $0 }.joined(separator: "&")
    }
    
    mutating func byRemovingElement(at index: Int) -> Array {
        var currentArray = self
        currentArray.remove(at: index)
        return currentArray
    }
}

// MARK: - Query String
public extension Array where Element: CustomStringConvertible {
    func queryString(key: String) -> String {
        queryString(values: compactMap({ String(describing: $0) }), key: key)
    }
}

public extension Sequence where Element: Hashable {
    var uniqued: [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
