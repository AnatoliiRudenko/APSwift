//
//  File.swift
//  
//
//  Created by Anatolii Rudenko on 15.09.2023.
//

import UIKit

open class Accessibility {
    
    public let isLogging: Bool
    public let asyncThreadQOS: DispatchQoS.QoSClass?
    
    /// if asyncThreadQOS is present - assignIDs func is going to be run in async thread of QOS given
    /// otherwise the process is going to be run in whatever thread called synchronously
    public init(
        asyncThreadQOS: DispatchQoS.QoSClass? = nil,
        isLogging: Bool = false
    ) {
        self.isLogging = isLogging
        self.asyncThreadQOS = asyncThreadQOS
    }
    
    /// should be called to start the process
    open func assignIDs(for object: Any) {
        if let asyncThreadQOS {
            DispatchQueue.global(qos: asyncThreadQOS).async { [weak self] in
                self?.recursiveAssignAction(for: object)
            }
        } else {
            recursiveAssignAction(for: object)
        }
    }
    
    /// shouldn't be called from outside. Open for overriding
    open func recursiveAssignAction(for object: Any) {
        let mirror = Mirror(reflecting: object)
        let children = Array(mirror.children)
        for child in children {
            let name = getPropertyNameFromChild(child) ?? "N/A"
            if let value = child.value as? UIView {
                if name != "some" {
                    value.isAccessibilityElement = true
                    value.accessibilityIdentifier = name
                    if isLogging {
                        print("added: \(name)")
                    }
                }
                assignIDs(for: child.value)
            } else {
                if isLogging {
                    print("skipped: \(name)")
                }
            }
        }
    }
    
    /// shouldn't be called from outside. Open for overriding
    open func getPropertyNameFromChild(_ child: Mirror.Child) -> String? {
        guard let string = child.label else { return nil }
        if string.contains("_$_") {
            return string.components(separatedBy: "_$_").last
        } else {
            return string
        }
    }
}
