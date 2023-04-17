//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 09.05.2022.
//

import Foundation

open class Listeners<Listener: Equatable> {
    
    public init() {}
    
    public private(set) var listeners: [Listener] = []
    
    public var current: Listener? {
        self.listeners.last
    }
    
    open func append(_ listener: Listener) {
        self.remove(listener)
        self.listeners += [listener]
    }

    open func remove(_ listener: Listener) {
        self.listeners.removeAll(where: { $0 == listener })
    }
    
    open func clear() {
        self.listeners = []
    }
}
