//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 07.09.2022.
//

import UIKit

open class BaseStackView: UIStackView {
    
    public var onDidLayout: Closure?
    private(set) public var didLayout = false
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        didLayout = true
        onDidLayout?()
    }
}
