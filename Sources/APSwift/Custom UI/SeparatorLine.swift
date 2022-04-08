//
//  SeparatorLine.swift
//  
//
//  Created by Анатолий Руденко on 11.01.2022.
//

import UIKit

open class SeparatorLine: BaseView {
    
    private var lineHeight: CGFloat = 1 {
        didSet {
            height = 1
            roundCorners(0.5)
        }
    }
    
    public convenience init(color: UIColor? = nil, height: CGFloat = 1) {
        self.init(frame: .zero)
        self.lineHeight = height
        guard let color = color else { return }
        backgroundColor = color
    }

    open override func setupComponents() {
        super.setupComponents()
        
        backgroundColor = .black
    }
}

public extension UIView {
    static func separator(color: UIColor? = nil, height: CGFloat = 1) -> SeparatorLine {
        .init(color: color)
    }
}
