//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 27.01.2022.
//

import Foundation

extension Mirror {
    
    static func getValues<T>(of type: T.Type, from object: Any, block: DataClosure<T>?) {
        let reflection = Mirror(reflecting: object)
        for child in reflection.children {
            if let value = child.value as? T {
                block?(value)
            }
        }
    }
}
