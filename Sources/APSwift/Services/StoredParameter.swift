//
//  StoredParameter.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 13.12.2021.
//

import Foundation
import KeychainSwift

public struct StoredParameter<T> {
    
    // MARK: - Static
    public enum Store {
        case UserDefaults
        case Keychain
    }
    
    // MARK: - Props
    
    public var value: T? {
        get {
            get()
        }
        set {
            guard let newValue = newValue else {
                remove()
                return
            }

            set(newValue)
        }
    }
    
    /// Prefix for keychain key. Default: `"\(Bundle.main.bundleIdentifier ?? "")_keychain_"`.
    ///
    public let keychainKeyPrefix: String
    
    /// Parameter stored name.
    ///
    public let name: String
    
    /// Parameter stored key. Default: `"stored_parameter_\(name)"`.
    ///
    public let key: String
    
    /// Store type.
    ///
    public let store: Store
    
    // MARK: - Init
    public init(_ name: String, store: Store) {
        self.keychainKeyPrefix = "\(Bundle.main.bundleIdentifier ?? "")_keychain_"
        self.name = name
        self.key = "stored_parameter_\(name)"
        self.store = store
    }
    
    // MARK: - Public methods
    
    public func set(_ value: T) {
        switch self.store {
        case .UserDefaults:
            UserDefaults.standard.set(value, forKey: self.key)
        case .Keychain:
            self.setInKeychain(value)
        }
    }
    
    public func get() -> T? {
        switch self.store {
        case .UserDefaults:
            return UserDefaults.standard.object(forKey: self.key) as? T
        case .Keychain:
            return self.getInKeychain()
        }
        
    }
    
    public func remove() {
        switch self.store {
        case .UserDefaults:
            UserDefaults.standard.removeObject(forKey: self.key)
        case .Keychain:
            KeychainSwift(keyPrefix: self.keychainKeyPrefix).delete(self.key)
        }
        
    }
}

// MARK: - Supporting Methods
private extension StoredParameter {
    
     func setInKeychain(_ value: T) {
        let keychain = KeychainSwift(keyPrefix: self.keychainKeyPrefix)
        
        switch value {
        case let string as String:
            keychain.set(string, forKey: self.key)
        case let int as Int:
            keychain.set(int.description, forKey: self.key)
        case let double as Double:
            keychain.set(double.description, forKey: self.key)
        case let float as Float:
            keychain.set(float.description, forKey: self.key)
        case let bool as Bool:
            keychain.set(bool, forKey: self.key)
        case let data as Data:
            keychain.set(data, forKey: self.key)
        default:
            break
        }
    }
    
    func getInKeychain() -> T? {
        let keychain = KeychainSwift(keyPrefix: self.keychainKeyPrefix)
        let value: Any?
        
        switch T.self {
        case is String.Type:
            value = keychain.get(self.key)
        case is Int.Type:
            value = Int(keychain.get(self.key) ?? "")
        case is Double.Type:
            value = Double(keychain.get(self.key) ?? "")
        case is Float.Type:
            value = Float(keychain.get(self.key) ?? "")
        case is Bool.Type:
            value = keychain.getBool(self.key)
        case is Data.Type:
            value = keychain.getData(self.key)
        default:
            value = nil
        }
        
        return value as? T
    }
}
