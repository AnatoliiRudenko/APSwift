//
//  UIStackView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 06.12.2021.
//

import UIKit

public extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach({ self.addArrangedSubview($0) })
    }
    
    func removeAllArrangedSubviews() {
        self.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func setInsets(_ insets: NSDirectionalEdgeInsets) {
        directionalLayoutMargins = insets
        isLayoutMarginsRelativeArrangement = true
    }
}
