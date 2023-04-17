//
//  NSObject.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 29.12.2021.
//

import Foundation

public extension NSObject {
    func copyObject<T:NSObject>() throws -> T? {
        let data = try NSKeyedArchiver.archivedData(withRootObject:self, requiringSecureCoding:false)
        return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
    }
}
