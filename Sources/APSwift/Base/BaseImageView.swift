//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 28.07.2022.
//

import UIKit

open class BaseImageView: UIImageView {
    
    public convenience init() {
        self.init(frame: CGRect())
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    open func setupComponents() {
        contentMode = .scaleAspectFit
    }
}
