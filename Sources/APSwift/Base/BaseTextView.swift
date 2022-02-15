//
//  BaseTextView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 05.02.2022.
//

import UIKit

open class BaseTextView: UITextView {

    // MARK: - Props
    lazy var mainTextColor: UIColor = textColor ?? .black
    lazy var placeholderColor: UIColor = mainTextColor.withAlphaComponent(0.5)
    var placeholder: String? {
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
    override init(frame: CGRect, textContainer: NSTextContainer?) {
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
}

// MARK: - UITextViewDelegate
extension BaseTextView: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == placeholderColor else { return }
        textView.text = ""
        textView.textColor = mainTextColor
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.isEmpty else { return }
        textView.text = placeholder
        textView.textColor = placeholderColor
    }
}
