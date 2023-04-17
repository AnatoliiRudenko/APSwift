//
//  UILabel.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 07.12.2021.
//

import UIKit

public extension UILabel {
    
    func multiline(_ lines: Int = 0) {
        numberOfLines = lines
        lineBreakMode = .byWordWrapping
    }
}

// MARK: - Attributes
public extension UILabel {
    
    var mutableAttributedText: NSMutableAttributedString? {
        var attrText: NSMutableAttributedString?
        if let attributedText = attributedText {
            attrText = NSMutableAttributedString(attributedString: attributedText)
        } else {
            attrText = textToAttributedString(newAttributes: [:], for: self.text)
        }
        return attrText
    }
    
    /// when string value set to nil, function will apply changes to self.text string
    func textToAttributedString(newAttributes: [NSAttributedString.Key: Any], for string: String?) -> NSMutableAttributedString? {
        guard let text = text else { return nil }
        let attrString = text.toAttributedString([.font: font as Any,
                                                  .foregroundColor: (textColor ?? .black) as Any])
        let stringToUse = string ?? text
        if !newAttributes.isEmpty,
           let rangeOfString = text.range(of: stringToUse),
           let nsRange = text.nsRange(from: rangeOfString) {
            attrString?.addAttributes(newAttributes, range: nsRange)
        }
        return attrString
    }
    
    func setAttributedString(newAttributes: [NSAttributedString.Key: Any], for string: String?) {
        attributedText = textToAttributedString(newAttributes: newAttributes, for: string)
    }
    
    /// when string value set to nil, function will apply changes to self.attributedText
    func addAttributes(_ attributes: [NSAttributedString.Key: Any], for string: String?) {
        guard let mutableAttributedText = mutableAttributedText,
              let rangeOfString = mutableAttributedText.string.range(of: string ?? mutableAttributedText.string),
              let nsRange = mutableAttributedText.string.nsRange(from: rangeOfString)
        else { return }
        mutableAttributedText.addAttributes(attributes, range: nsRange)
        self.attributedText = mutableAttributedText
    }
    
    func setLetterSpacedAttributedText(_ value: Double) {
        addAttributes([.kern: value], for: nil)
    }
    
    func setLineSpacedAttributedText(_ value: Double) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = value
        addAttributes([.paragraphStyle: paragraphStyle], for: nil)
    }
}
