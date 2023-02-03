//
//  Encodable.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 10.12.2021.
//

import Foundation

public extension Encodable {
    
    var dictionary: [String: Any] {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] } ?? [:]
    }
    
    var jsonCompatibleData: Any? {
        guard let array = self as? Array<Encodable> else {
            return dictionary
        }
        let value = array.map { $0.dictionary }
        return value
    }
}

public extension Encodable {
    
    var hasValues: Bool {
        Mirror(reflecting: self).children.reduce(false) { acc, val in
            let subMirror = Mirror(reflecting: val.value)
            return acc || (subMirror.displayStyle == .optional ? subMirror.children.count > 0 : true)
        }
    }
}

private extension Encodable {
    
    var jsonArrayData: Any? {
        guard let array = self as? Array<Encodable> else { return nil }
        let value = array.map { $0.dictionary }
        return value
    }
}
