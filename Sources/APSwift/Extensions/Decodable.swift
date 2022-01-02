//
//  Decodable.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 09.12.2021.
//

import Foundation

public extension Decodable {
    
    var hasValues: Bool {
        Mirror(reflecting: self).children.reduce(false) { acc, val in
            let subMirror = Mirror(reflecting: val.value)
            return acc || (subMirror.displayStyle == .optional ? subMirror.children.count > 0 : true)
        }
    }
}
