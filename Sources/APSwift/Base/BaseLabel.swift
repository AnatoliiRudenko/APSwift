//
//  BaseLabel.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 13.12.2021.
//

import UIKit

open class BaseLabel: UILabel {
    
    public var hidesIfEmpty = false
    
    open override var text: String? {
        get { super.text }
        set {
            super.text = newValue
            if hidesIfEmpty {
                self.isHidden = newValue?.isEmpty == true || newValue == nil
            }
        }
    }
    
    public var multiline: Bool = false {
        didSet {
            numberOfLines = multiline ? 0 : 1
            lineBreakMode = .byWordWrapping
        }
    }
    
    open func multiline(_ lines: Int) {
        numberOfLines = lines
        lineBreakMode = .byWordWrapping
    }
    
    public var insets: UIEdgeInsets = .zero
    
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
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupComponents() {
        text = ""
    }
}

// MARK: - Insets
extension BaseLabel {
    
    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + insets.left + insets.right,
                      height: size.height + insets.top + insets.bottom)
    }
    
    open override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (insets.left + insets.right)
        }
    }
}
