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
    
    func textToAttributedString(newAttributes: [NSAttributedString.Key: Any], for string: String?) -> NSMutableAttributedString? {
        guard let text = text,
              let string = string, !string.isEmpty,
              let rangeOfString = text.range(of: string),
              let nsRange = text.nsRange(from: rangeOfString)
        else { return nil }
        let attrString = text.addAttributes([.font: font as Any,
                                             .foregroundColor: (textColor ?? .black) as Any],
                                            to: text)
        attrString?.addAttributes(newAttributes, range: nsRange)
        return attrString
    }
    
    func setAttributedString(newAttributes: [NSAttributedString.Key: Any], for string: String?) {
        attributedText = textToAttributedString(newAttributes: newAttributes, for: string)
    }
    
    func addAttributes(_ attributes: [NSAttributedString.Key: Any]) {
        guard let attributedText = attributedText,
              let rangeOfString = attributedText.string.range(of: attributedText.string),
              let nsRange = attributedText.string.nsRange(from: rangeOfString)
        else { return }
        let currentAttrString = NSMutableAttributedString(attributedString: attributedText)
        currentAttrString.addAttributes(attributes, range: nsRange)
        self.attributedText = currentAttrString
    }
}
