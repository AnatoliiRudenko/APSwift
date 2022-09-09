//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 23.01.2022.
//

import Foundation

public extension Date {
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func convertToTimeZone(initialTimeZone: TimeZone, timeZone: TimeZone, wrappingComponents: Bool = false) -> Date? {
        let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initialTimeZone.secondsFromGMT(for: self))
        return byAdding(.second, value: Int(delta), wrappingComponents: wrappingComponents)
    }
    
    func byAdding(_ component: Calendar.Component, value: Int, wrappingComponents: Bool = false) -> Date? {
        Calendar.current.date(byAdding: component, value: value, to: self, wrappingComponents: wrappingComponents)
    }
    
    func string(format: String,
                timeZone: TimeZone? = nil,
                locale: Locale = .current,
                hasDayOrdinalSuffix: Bool = false) -> String? {
        var outputFormat = format
        if hasDayOrdinalSuffix,
           let dayLastIndex = format.lastIndex(of: "d") {
            let nextIndex = format.index(after: dayLastIndex)
            outputFormat.insert(contentsOf: "'\(self.get(.day).ordinalSuffix)'", at: nextIndex)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormat
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        return dateFormatter.string(from: self)
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
