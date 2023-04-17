//
//  File.swift
//  
//
//  Created by Anatolii Rudenko on 07.02.2023.
//

import Foundation

public struct ConcurrentTask<T> {
    
    let action: AsyncDataClosure<Any>
    let callback: DataClosure<T?>?
    
    /// - Parameters:
    ///    - action: async call to make. For example: { await asyncFunc() } or asyncFunc
    ///    - callback: handle call results here
    public init(action: @escaping AsyncDataClosure<Any>, callback: DataClosure<T?>? = nil) {
        self.action = action
        self.callback = callback
    }
}
