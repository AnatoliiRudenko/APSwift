//
//  BaseTextView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 05.02.2022.
//

import UIKit

open class BaseTextView: UITextView {

    // MARK: - Props
    public var maxLength: Int?
    public lazy var mainTextColor: UIColor = textColor ?? .black
    public lazy var placeholderColor: UIColor = mainTextColor.withAlphaComponent(0.5)
    public var placeholder: String? {
        didSet {
            self.text = placeholder
            self.textColor = placeholderColor
        }
    }
    open override var text: String! {
        get {
            super.text == placeholder ? "" : super.text
        }
        set {
            super.text = newValue
        }
    }
    
    // MARK: - Init
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }

    open func setupComponents() {
        delegate = self
        backgroundColor = .clear
    }
    
    // MARK: - Height Constraint
    public var height: CGFloat? {
        didSet {
            guard let value = self.height else {
                self.heightConstraint.isActive = false
                return
            }
            self.heightConstraint.constant = value
            self.heightConstraint.isActive = true
        }
    }
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        self.heightAnchor.constraint(equalToConstant: self.height ?? 0)
    }()
}

// MARK: - UITextViewDelegate
extension BaseTextView: UITextViewDelegate {
    
    open func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == placeholderColor else { return }
        textView.text = ""
        textView.textColor = mainTextColor
    }
    
    open func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.isEmpty else { return }
        textView.text = placeholder
        textView.textColor = placeholderColor
    }
    
    open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let maxLength = maxLength else { return true }
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= maxLength
    }
}
