//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 28.07.2022.
//

import UIKit

open class BaseSlider: UISlider {
    
    // MARK: - Props
    public var reactsToTap = true
    
    // MARK: - Init
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    open func setupComponents() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tap)
    }
}

private extension BaseSlider {
    
    @objc
    func handleTap(_ sender: UITapGestureRecognizer) {
        guard reactsToTap else { return }
        let location = sender.location(in: self)
        let percent = minimumValue + Float(location.x / bounds.width) * maximumValue
        setValue(percent, animated: true)
        sendActions(for: .valueChanged)
    }
}
