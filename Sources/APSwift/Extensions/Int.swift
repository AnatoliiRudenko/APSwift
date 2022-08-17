//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 17.08.2022.
//

import Foundation

extension Int {
    
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
}
