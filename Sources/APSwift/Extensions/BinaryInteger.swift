//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 31.03.2022.
//

import Foundation

public extension BinaryInteger {
    
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (Double(self) * divisor).rounded() / divisor
    }
}
