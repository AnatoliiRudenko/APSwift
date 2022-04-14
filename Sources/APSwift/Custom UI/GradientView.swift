//
//  GradientView.swift
//  
//
//  Created by Анатолий Руденко on 26.01.2022.
//

import UIKit

open class GradientView: BaseView {
    
    public var colors = [UIColor]() {
        didSet {
            gradient.colors = colors.map { $0.cgColor }
        }
    }
    public var color: UIColor = .white {
        didSet {
            gradient.colors = [color.cgColor, color.withAlphaComponent(0).cgColor]
        }
    }
    public var startPoint = CGPoint(x: 0, y: 1) {
        didSet {
            gradient.startPoint = startPoint
        }
    }
    public var endPoint = CGPoint(x: 0, y: 0) {
        didSet {
            gradient.endPoint = endPoint
        }
    }
    
    // MARK: - Life cycle
    open override func setupComponents() {
        super.setupComponents()
        
        clipsToBounds = true
        layer.addSublayer(gradient)
        gradient.endPoint = endPoint
        gradient.startPoint = startPoint
    }
    
    open override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        gradient.frame = bounds
    }
    
    // MARK: - UI Properties
    public let gradient = CAGradientLayer()
}
