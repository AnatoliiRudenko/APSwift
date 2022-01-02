//
//  Dictionary.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 13.12.2021.
//

import Foundation

extension Dictionary {
    
    var queryString: String {
        var output: String = "?"
        for (key, value) in self {
            if let array = value as? [Any] {
                for element in array {
                    output += "\(key)=\(element)&"
                }
                continue
            }
            output += "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}

extension Dictionary where Value: Comparable {
    var sortedByValue: [(Key, Value)] { return Array(self).sorted { $0.1 < $1.1 } }
}

extension Dictionary where Key: Comparable {
    var sortedByKey: [(Key, Value)] { return Array(self).sorted { $0.0 < $1.0 } }
    
    var valuesSortedByKey: [Value] { sortedByKey.map { $0.1 } }
}
