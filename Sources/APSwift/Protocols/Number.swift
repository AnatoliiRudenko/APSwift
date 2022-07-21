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
    
    func roundedStringTruncatingZeros(decimalPlaces: Int = 1) -> String {
        roundTo(places: decimalPlaces).stringTruncatingTrailingZeros(decimalPlaces: decimalPlaces)
    }
    
    func stringTruncatingTrailingZeros(decimalPlaces: Int = 1) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = decimalPlaces
        formatter.minimumFractionDigits = 0
        formatter.minimumIntegerDigits = 1
        return formatter.string(from: NSNumber(floatLiteral: self.asDouble)) ?? "0"
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
