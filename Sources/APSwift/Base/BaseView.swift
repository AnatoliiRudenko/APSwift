//
//  BaseView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 06.12.2021.
//

import UIKit

open class BaseView: UIView {
    
    var didTap: (Closure)? {
        didSet {
            self.enableTap()
        }
    }
    
    var animatesTap = true
    var tapsThrough = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
        updateComponents()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupComponents() {}
    open func updateComponents() {}
    
    // MARK: - Tap
    private func enableTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc
    private func handleTap() {
        didTap?()
        if animatesTap {
            animatesTap()
        }
    }
    
    // MARK: - Height Constraint
    var height: CGFloat? {
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
    
    // MARK: - Tap Through
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard tapsThrough else { return super.point(inside: point, with: event) }
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}
