//
//  UIButton.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 07.12.2021.
//

import Foundation
import UIKit

extension UIButton {
    
    func setImage(_ image: UIImage?) {
        setImage(image, for: .normal)
    }
    
    func setTitle(_ title: String?, animated: Bool = false) {
        guard !animated else {
            setTitle(title, for: .normal)
            return
        }
        UIView.setAnimationsEnabled(false)
        setTitle(title, for: .normal)
        UIView.setAnimationsEnabled(true)
    }
    
    func underline() {
        guard let text = self.title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: tintColor as Any, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: tintColor as Any, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
