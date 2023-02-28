//
//  BaseTextView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 05.02.2022.
//

import UIKit

open class BaseTextView: UITextView {

    // MARK: - Props
    public var didChangeText: DataClosure<String>?
    public var maxLength: Int?
    public var centersTextVertically = false
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
            let newValue = newValue ?? ""
            super.text = shouldCallTextSetter ?
            (newValue.isEmpty == false ? newValue : placeholder) :
            newValue
            shouldCallTextSetter = true
            setTextColor()
        }
    }
    private var shouldCallTextSetter = true
    
    // MARK: - Init
    public convenience init(placeholder: String?) {
        self.init(frame: .zero, textContainer: nil)
        defer { self.placeholder = placeholder }
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }

    open func setupComponents() {
        textContainer.lineFragmentPadding = 0
        delegate = self
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
        shouldCallTextSetter = false
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
    
    open func textViewDidChange(_ textView: UITextView) {
        didChangeText?(textView.text)
        
        guard centersTextVertically else { return }
        centerVertically()
    }
}

// MARK: - Supporting methods
private extension BaseTextView {
    
    func setTextColor() {
        self.textColor = text.isEmpty ? placeholderColor : mainTextColor
    }
}
