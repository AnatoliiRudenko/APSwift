//
//  Data.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import Foundation

public extension Data {
    
    func decodedObject<T: Decodable>(stategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = stategy
        return try decoder.decode(T.self, from: self)
    }
    
    func decodedArray<T: Decodable>(stategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) throws -> [T] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = stategy
        return try decoder.decode([T].self, from: self)
    }
}
