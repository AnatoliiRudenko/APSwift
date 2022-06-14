//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 14.06.2022.
//

import Foundation

public enum WeekDay: Int, CaseIterable {
    case monday
    case tueday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var title: String {
        switch self {
        case .monday:
            return "Monday"
        case .tueday:
            return "Tueday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
}
