//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 20.07.2022.
//

import Foundation

public extension NSMutableAttributedString {
    
    func addAttributes(_ attributes: [NSAttributedString.Key: Any], for string: String?) {
        guard let string = string, !string.isEmpty,
              let rangeOfString = self.string.range(of: string),
              let nsRange = self.string.nsRange(from: rangeOfString)
        else { return }
        self.addAttributes(attributes, range: nsRange)
    }
}
