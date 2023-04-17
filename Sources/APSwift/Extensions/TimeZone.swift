//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 07.09.2022.
//

import Foundation

public extension TimeZone {
    
    var hoursFromGMT: Int? {
        Int((secondsFromGMT().asDouble/3600).rounded())
    }
}
