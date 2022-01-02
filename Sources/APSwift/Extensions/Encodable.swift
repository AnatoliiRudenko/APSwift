//
//  Encodable.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 10.12.2021.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any?] {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] } ?? [:]
    }
    
    var dictionaryWithoutEmptyFields: [String: Any?] {
        var dict = dictionary
        filterFromEmptyFields(dictionary: &dict)
        return dictionary
    }
    
    func filterFromEmptyFields(dictionary: inout [String: Any?]) {
        let keysToRemove = dictionary.keys.filter {
            guard let value = dictionary[$0] else { return false }
            if let stringValue = value as? String,
               stringValue.isEmpty {
                return true
            }
            return value == nil
        }
        for key in keysToRemove {
            dictionary.removeValue(forKey: key)
        }
    }
}
