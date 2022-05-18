//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 23.01.2022.
//

import Foundation

public extension Date {
    
    func outputString(date: Date?, format: String, timeZone: TimeZone? = nil, locale: Locale = .current) -> String? {
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        return dateFormatter.string(from: date)
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
