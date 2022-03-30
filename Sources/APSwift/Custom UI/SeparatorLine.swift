//
//  SeparatorLine.swift
//  
//
//  Created by Анатолий Руденко on 11.01.2022.
//

import UIKit

open class SeparatorLine: BaseView {
    
    public convenience init(color: UIColor? = nil) {
        self.init(frame: .zero)
        guard let color = color else { return }
        backgroundColor = color
    }

    open override func setupComponents() {
        super.setupComponents()
        
        backgroundColor = .black
        height = 1
        roundCorners(0.5)
    }
}

public extension UIView {
    static func separator(color: UIColor? = nil) -> SeparatorLine {
        .init(color: color)
    }
}
