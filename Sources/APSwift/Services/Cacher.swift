//
//  File.swift
//  
//
//  Created by Anatolii Rudenko on 26.07.2023.
//

import Foundation

public actor Cacher<T: AnyObject> {
    
    private lazy var cache = NSCache<NSString, T>()
    
    public init() {}
    
    public func object(for path: String?) -> T? {
        guard let path else { return nil }
        let object = cache.object(forKey: NSString(string: path))
        return object
    }
    
    public func set(_ object: T?, for path: String?) {
        guard let object,
              let path
        else { return remove(at: path) }
        cache.setObject(object, forKey: NSString(string: path))
    }
}

// MARK: - Supporting methods
private extension Cacher {
    
    func remove(at path: String?) {
        guard let path else { return }
        cache.removeObject(forKey: NSString(string: path))
    }
}
