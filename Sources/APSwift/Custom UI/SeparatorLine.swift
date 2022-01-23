//
//  SeparatorLine.swift
//  
//
//  Created by Анатолий Руденко on 11.01.2022.
//

import UIKit

open class SeparatorLine: BaseView {

    open override func setupComponents() {
        super.setupComponents()
        
        backgroundColor = .black
        height = 1
        roundCorners(0.5)
    }
}

public extension UIView {
    static func separator() -> SeparatorLine {
        .init(frame: .zero)
    }
}
