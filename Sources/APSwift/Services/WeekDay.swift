//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 14.06.2022.
//

import Foundation

public enum WeekDay: Int, CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    public static let allCasesUSFormat: [WeekDay] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    
    public var title: String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
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
    
    public var shortTitle: String {
        String(title.prefix(3))
    }
}
