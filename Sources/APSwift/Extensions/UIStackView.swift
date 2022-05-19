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
    
    // MARK: - Single Subview
    enum SingleSubviewSeparatorLocation {
        case top
        case bottom
        case both
    }
    
    func addArrangedSubview(_ view: UIView, separatorLocation: SingleSubviewSeparatorLocation, separator: UIView = .separator()) {
        if separatorLocation == .top || separatorLocation == .both {
            addArrangedSubview(separator)
        }
        addArrangedSubview(view)
        if separatorLocation == .bottom || separatorLocation == .both {
            addArrangedSubview(separator)
        }
    }
    
    // MARK: - Mutiple Subviews
    enum SubviewsOutterSeparatorLocation {
        case none
        case top
        case bottom
        case both
    }
    
    func addArrangedSubviews(_ views: [UIView], separatorLocation: SubviewsOutterSeparatorLocation, separator: UIView = .separator()) {
        var getSeparator: UIView { (try? separator.copyObject()) ?? .separator() }
        if separatorLocation == .top || separatorLocation == .both {
            addArrangedSubview(getSeparator)
        }
        addArrangedSubviewsWithSeparatorBetween(views, separator: getSeparator)
        if separatorLocation == .bottom || separatorLocation == .both {
            addArrangedSubview(getSeparator)
        }
    }
    
    private func addArrangedSubviewsWithSeparatorBetween(_ views: [UIView], separator: UIView = .separator()) {
        guard views.count != 1 else {
            addArrangedSubview(views.first ?? UIView())
            return
        }
        guard views.count != 2 else {
            addArrangedSubview(views.first ?? UIView(), separatorLocation: .bottom, separator: separator)
            addArrangedSubview(views.last ?? UIView())
            return
        }
        for (index, subView) in views.enumerated() {
            let isLast = index == views.count - 1
            if isLast {
                addArrangedSubview(subView)
                break
            }
            addArrangedSubview(subView, separatorLocation: .bottom, separator: separator)
        }
    }
}

