//
//  CollectionProgressView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 17.12.2021.
//

import UIKit

open class CollectionProgressView: BaseView {
    
    // MARK: - Props
    var activeColor: UIColor
    var inactiveColor: UIColor
    
    var circleDiameter: CGFloat = 8 {
        didSet {
            drawProgress(currentPhase: index)
        }
    }
    
    var maxIndex: Int = 0 {
        didSet {
            drawProgress(currentPhase: index)
            setHidden(false)
        }
    }
    
    var index: Int = 0 {
        didSet {
            guard index <= maxIndex, index >= 0 else { return }
            drawProgress(currentPhase: index)
        }
    }
    
    // MARK: - Init
    init(activeColor: UIColor, inactiveColor: UIColor, maxIndex: Int = 0) {
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.maxIndex = maxIndex
        super.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setupComponents() {
        super.setupComponents()
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        drawProgress(currentPhase: 0)
    }
    
    // MARK: - UI Properties
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }()
}

// MARK: - Supporting Methods
extension CollectionProgressView {
    
    private func drawProgress(currentPhase: Int) {
        var circles = [UIView]()
        for _ in 0..<maxIndex {
            circles.append(inactiveCircle)
        }
        circles.insert(activeCircle, at: currentPhase)
        stackView.removeAllArrangedSubviews()
        stackView.addArrangedSubviews(circles)
    }
    
    private var inactiveCircle: UIView {
        let view = self.drawCircle(diameter: circleDiameter)
        view.backgroundColor = inactiveColor
        return view
    }
    
    private var activeCircle: UIView {
        let view = self.drawCircle(diameter: circleDiameter)
        view.backgroundColor = activeColor
        return view
    }
    
    private func drawCircle(diameter: CGFloat) -> UIView {
        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        circleView.clipsToBounds = true
        circleView.layer.cornerRadius = diameter * 0.5
        circleView.heightAnchor.constraint(equalToConstant: diameter).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: diameter).isActive = true
        return circleView
    }
}
