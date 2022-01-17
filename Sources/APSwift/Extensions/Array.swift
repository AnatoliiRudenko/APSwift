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
    
    func queryString(values: [String], key: String) -> String {
        values.map { key + "=" + $0 }.joined(separator: "&")
    }
}

// MARK: - Query String
public extension Array where Element == String {
    func queryString(key: String) -> String {
        queryString(values: compactMap({ String($0) }), key: key)
    }
}
public extension Array where Element == Int {
    func queryString(key: String) -> String {
        queryString(values: compactMap({ String($0) }), key: key)
    }
}
public extension Array where Element == Double {
    func queryString(key: String) -> String {
        queryString(values: compactMap({ String($0) }), key: key)
    }
}
public extension Array where Element == Float {
    func queryString(key: String) -> String {
        queryString(values: compactMap({ String($0) }), key: key)
    }
}
