//
//  SeparatorLine.swift
//  
//
//  Created by Анатолий Руденко on 11.01.2022.
//

import UIKit

open class SeparatorLine: BaseView {
    
    public var lineHeight: CGFloat = 1 {
        didSet {
            setHeight()
        }
    }
    
    public convenience init(color: UIColor? = nil, height: CGFloat = 1) {
        self.init(frame: .zero)
        self.lineHeight = height
        self.setHeight()
        guard let color = color else { return }
        backgroundColor = color
    }

    open override func setupComponents() {
        super.setupComponents()
        
        backgroundColor = .black
    }
}

// MARK: - Supporting methods
private extension SeparatorLine {
    func setHeight() {
        height = lineHeight
        roundCorners(lineHeight * 0.5)
    }
}

public extension UIView {
    static func separator(color: UIColor? = nil, height: CGFloat = 1) -> SeparatorLine {
        .init(color: color, height: height)
    }
}
