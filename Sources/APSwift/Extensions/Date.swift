//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 23.01.2022.
//

import Foundation

public extension Date {
    
    func outputString(date: Date?,
                      format: String,
                      timeZone: TimeZone? = nil,
                      locale: Locale = .current,
                      hasDaySuffix: Bool = false) -> String? {
        guard let date = date else { return nil }
        var outputFormat = format
        if hasDaySuffix,
           let dayLastIndex = format.lastIndex(of: "d") {
            let nextIndex = format.index(after: dayLastIndex)
            outputFormat.insert(contentsOf: "'\(daySuffix(day: date.get(.day)))'", at: nextIndex)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormat
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

public extension Date {
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
