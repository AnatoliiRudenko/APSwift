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
}
