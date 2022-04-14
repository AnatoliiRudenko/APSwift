//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 31.03.2022.
//

import Foundation

public protocol Number {
    var asDouble: Double { get }
}

public extension Number {
    
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self.asDouble * divisor).rounded() / divisor
    }
}

// MARK: - Conformance
extension Double : Number {
    public var asDouble: Double { self }
}
extension Float : Number {
    public var asDouble: Double { Double(self) }
}
extension Int : Number {
    public var asDouble: Double { Double(self) }
}
