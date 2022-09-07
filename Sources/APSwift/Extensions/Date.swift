//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 23.01.2022.
//

import Foundation

public extension Date {
    
    func convertToTimeZone(initialTimeZone: TimeZone, timeZone: TimeZone) -> Date? {
        let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initialTimeZone.secondsFromGMT(for: self))
        return byAdding(.second, value: Int(delta))
    }
    
    func byAdding(_ component: Calendar.Component, value: Int) -> Date? {
        Calendar.current.date(byAdding: component, value: value, to: self)
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
