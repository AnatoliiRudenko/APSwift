//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 07.06.2022.
//

import UIKit

open class BaseSegmentedControl: UISegmentedControl {
    
    // MARK: - Init
    public override init(items: [Any]?) {
        super.init(items: items)
        self.setupComponents()
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
