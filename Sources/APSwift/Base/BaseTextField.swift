//
//  BaseTextField.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import UIKit

open class BaseTextField: UITextField {
    
    // MARK: - Props
    // MARK: - Insets Props
    public var insets: UIEdgeInsets = .zero
    
    // MARK: - Max Length props
    public var maxLength: Int? {
        didSet {
            addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        }
    }
    public var isFilled: Bool {
        guard let maxLength = maxLength else { return true }
        return (text ?? "").count == maxLength
    }
    public var onReachingMaxLength: Closure?
    
    // MARK: - Methods
    @objc
    func editingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if let maxLength = maxLength,
           text.count >= maxLength {
            onReachingMaxLength?()
            textField.text = String(text.prefix(maxLength))
        }
    }

    // MARK: - Init
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    open func setupComponents() {}
    
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

// MARK: - Inset
extension BaseTextField {
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }
}
