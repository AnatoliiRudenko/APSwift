//
//  UILabel.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 07.12.2021.
//

import UIKit

extension UILabel {
    
    func setLetterSpacing(_ value: Double) {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
