//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 23.01.2022.
//

import Foundation

public extension Date {
    
    func outputString(format: String,
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
