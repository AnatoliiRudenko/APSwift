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
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public convenience init(_ text: String?) {
        self.init(frame: .zero)
        self.text = text
    }
    
    public convenience init(text: String?) {
        self.init(frame: .zero)
        self.text = text
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    open func setupComponents() {
        text = ""
    }
}

// MARK: - Insets
extension BaseLabel {
    
    open override func drawText(in rect: CGRect) {
        var newRect = rect
        switch contentMode {
        case .top:
            newRect.size.height = sizeThatFits(rect.size).height
        case .bottom:
            let height = sizeThatFits(rect.size).height
            newRect.origin.y += rect.size.height - height
            newRect.size.height = height
        default:
            break
        }
        super.drawText(in: newRect.inset(by: insets))
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
