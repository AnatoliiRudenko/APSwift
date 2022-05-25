//
//  UILabel.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 07.12.2021.
//

import UIKit

public extension UILabel {
    
    func setLetterSpacing(_ value: Double) {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
    
    func multiline(_ lines: Int = 0) {
        numberOfLines = lines
        lineBreakMode = .byWordWrapping
    }
}
