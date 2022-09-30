//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 17.08.2022.
//

import Foundation

public extension Int {
    
    var ordinalSuffix: String {
        guard self != 11, self != 12 else { return "th" }
        let string = String(self)
        let lastNumber = string.digits.last
        switch lastNumber {
        case 1:
            return "st"
        case 2:
            return "nd"
        case 3:
            return "rd"
        default:
            return "th"
        }
    }
    
    /// if self == 2
    /// and digits == 4
    /// return would be "0002"
    func toString(digits: Int) -> String {
        let string = String(self)
        let count = string.count
        // if length matches digits - return string
        guard count != digits else { return string }
        // if length > digits - return last n(digits) characters
        guard count < digits else { return String(string.suffix(digits)) }
        // add some "0" to meet digits condition
        let delta = digits - count
        let zeros = String(repeating: "0", count: delta)
        return zeros + string
    }
}
