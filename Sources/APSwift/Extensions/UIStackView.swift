//
//  UIStackView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 06.12.2021.
//

import UIKit

public extension UIStackView {
    
    func setInsets(_ insets: NSDirectionalEdgeInsets) {
        directionalLayoutMargins = insets
        isLayoutMarginsRelativeArrangement = true
    }
}

// MARK: - Add/remove
public extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach({ self.addArrangedSubview($0) })
    }
    
    func removeArrangedSubviews(_ views: [UIView]) {
        views.forEach { $0.removeFromSuperview() }
    }
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

// MARK: - Separator
public extension UIStackView {
    
    enum VerticalLocation {
        case top
        case bottom
        case both
    }
    
    func addArrangedSubviewsWithSeparator(_ views: [UIView], separator: UIView = .separator()) {
        guard views.count != 1 else {
            addArrangedSubview(views.first ?? UIView())
            return
        }
        guard views.count != 2 else {
            addArrangedSubview(views.first ?? UIView(), separatorLineLocation: .bottom, separator: separator)
            addArrangedSubview(views.last ?? UIView())
            return
        }
        for (index, subView) in views.enumerated() {
            let isLast = index == views.count - 1
            if isLast {
                addArrangedSubview(subView)
                break
            }
            addArrangedSubview(subView, separatorLineLocation: .bottom, separator: separator)
        }
    }
    
    func addArrangedSubview(_ view: UIView, separatorLineLocation: VerticalLocation, separator: UIView = .separator()) {
        if separatorLineLocation == .top || separatorLineLocation == .both {
            addArrangedSubview(separator)
        }
        addArrangedSubview(view)
        if separatorLineLocation == .bottom || separatorLineLocation == .both {
            addArrangedSubview(separator)
        }
    }
}

