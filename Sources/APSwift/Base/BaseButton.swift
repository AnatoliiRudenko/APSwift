//
//  BaseButton.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import UIKit

open class BaseButton: UIButton {
    
    var didTap: (Closure)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        self.addTarget(self, action: #selector(self.handleTap), for: .touchUpInside)
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
}

// MARK: - Supporting Methods
extension BaseButton {
    
    @objc
    func handleTap() {
        didTap?()
        animatesTap()
    }
}
