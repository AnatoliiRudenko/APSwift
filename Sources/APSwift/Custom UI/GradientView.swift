//
//  GradientView.swift
//  
//
//  Created by Анатолий Руденко on 26.01.2022.
//

import UIKit

class GradientView: BaseView {
    
    var color = UIColor.white {
        didSet {
            gradient.colors = [color.withAlphaComponent(0).cgColor, color.cgColor]
        }
    }
    var endPoint = CGPoint(x: 0, y: 0) {
        didSet {
            gradient.endPoint = endPoint
        }
    }
    var startPoint = CGPoint(x: 0, y: 1) {
        didSet {
            gradient.startPoint = startPoint
        }
    }
    
    // MARK: - Life cycle
    override func setupComponents() {
        super.setupComponents()
        
        clipsToBounds = true
        
        gradient.colors = [color.withAlphaComponent(0).cgColor, color.cgColor]
        layer.addSublayer(gradient)
        
        gradient.endPoint = endPoint
        gradient.startPoint = startPoint
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        gradient.frame = bounds
    }
    
    // MARK: - UI Properties
    private let gradient = CAGradientLayer()
}
