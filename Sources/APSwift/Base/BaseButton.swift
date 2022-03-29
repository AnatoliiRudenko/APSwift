//
//  BaseButton.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import UIKit

open class BaseButton: UIButton {
    
    public var didTap: (Closure)?
    
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
    
    open func setupComponents() {
        self.addTarget(self, action: #selector(self.handleTap), for: .touchUpInside)
    }
    
    // MARK: - Resize to fit title label
    open override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: titleLabel?.frame.size.width ?? 0, height: .greatestFiniteMagnitude)) ?? .zero
        let width: CGFloat = labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right + contentEdgeInsets.left + contentEdgeInsets.right + imageEdgeInsets.left + imageEdgeInsets.right + (image?.size.width ?? 0)
        let height: CGFloat = labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom + contentEdgeInsets.top + contentEdgeInsets.bottom
        return CGSize(width: width, height: height)
    }
    
    open var image: UIImage? {
        image(for: .normal)
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

// MARK: - Supporting Methods
extension BaseButton {
    
    @objc
    func handleTap() {
        didTap?()
        animatesTap()
    }
}
