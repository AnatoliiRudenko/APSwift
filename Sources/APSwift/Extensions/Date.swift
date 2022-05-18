//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 23.01.2022.
//

import Foundation

public extension Date {
    
    func outputString(format: String) -> String {
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = format.format
        outputDateFormatter.locale = Locale(identifier: "en_US")
        let dateString = outputDateFormatter.string(from: self)
        return dateString
    }
    
    func daySuffix(day: Int) -> String {
        switch day {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}
