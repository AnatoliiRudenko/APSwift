//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 16.06.2022.
//

import UIKit

open class CircleDiagramView: BaseView {
    
    // MARK: - Props
    public let progressLayer = CAShapeLayer()
    
    public var diameter: CGFloat = 160
    public var maxValue: CGFloat = 100
    public var minValue: CGFloat = 0
    public var value: CGFloat {
        currentValue
    }
    private var currentValue: CGFloat = 0
    
    // MARK: - Methods
    override open func setupComponents() {
        super.setupComponents()
     
        setProgressUI()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.draw(value: value, animated: false)
    }
    
    open func setValue(_ value: CGFloat, animated: Bool = true) {
        self.currentValue = value
        self.draw(value: value, animated: animated)
    }
    
    open func setRelativeValue(_ relativeValue: CGFloat, animated: Bool = true) {
        var relativeValueToUse = relativeValue
        if relativeValue < 0 {
            relativeValueToUse = 0
        }
        if relativeValue > 1 {
            relativeValueToUse = 1
        }
        setValue(relativeValueToUse * maxValue, animated: animated)
    }
}

// MARK: - Supporting Methods
private extension CircleDiagramView {
    
    func draw(value: CGFloat, animated: Bool) {
        roundCorners(diameter * 0.5)
        let startRadians: CGFloat = -.pi / 2 + minValue.asRadians
        let valueRadians = value / maxValue * 2 * .pi
        let targetRadians = valueRadians + startRadians
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: diameter * 0.5, y: diameter * 0.5),
                                        radius: diameter * 0.5,
                                        startAngle: startRadians,
                                        endAngle: targetRadians,
                                        clockwise: true)
        progressLayer.path = circularPath.cgPath
        
        let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        progressAnimation.toValue = 1
        progressAnimation.fillMode = .forwards
        progressAnimation.isRemovedOnCompletion = false
        progressLayer.add(progressAnimation, forKey: "progressAnimation")
        
        guard !animated else { return }
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.strokeEnd = 1
        CATransaction.commit()
    }
    
    func setProgressUI() {
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.blue.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 4
        progressLayer.strokeEnd = 0
        guard progressLayer.superlayer == nil else { return }
        layer.addSublayer(progressLayer)
    }
}
