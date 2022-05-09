//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 09.05.2022.
//

import Foundation

open class Listeners<listener: Listener> {
    
    public init() {}
    
    public private(set) var listeners: [Listener] = []
    
    public var current: Listener? {
        self.listeners.last
    }
    
    open func appendListener(_ listener: Listener) {
        self.removeListener(listener)
        self.listeners += [listener]
    }

    open func removeListener(_ listener: Listener) {
        self.listeners.removeAll(where: { $0 == listener })
    }
}
