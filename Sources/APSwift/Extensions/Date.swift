//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 23.01.2022.
//

import Foundation

public extension Date {
    
    enum Format {
        case ddmmyy(separator: String)
        
        var format: String {
            switch self {
            case .ddmmyy(let separator):
                return "dd\(separator)MM\(separator)yy"
            }
        }
    }
    
    func outputString(outputFormat: Date.Format) -> String {
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = outputFormat.format
        outputDateFormatter.locale = Locale(identifier: "ru_RU")
        let dateString = outputDateFormatter.string(from: self)
        return dateString
    }
}
