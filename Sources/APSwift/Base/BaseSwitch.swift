//
//  BaseSwitch.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.02.2022.
//

import UIKit

class BaseSwitch: UISwitch {
    
    // MARK: - Props
    var didSwitchTo: DataClosure<Bool>?
    
    var onThumbTintColor: UIColor? {
        didSet {
            setThumbColor()
        }
    }
    var offThumbTintColor: UIColor? {
        didSet {
            setThumbColor()
        }
    }
    
    // MARK: - Methods
    func imitateTap() {
        setOn(!isOn, animated: true)
        didSwitch(self)
    }
    
    // MARK: - Overriden
    open override var isOn: Bool {
        didSet {
            setThumbColor()
        }
    }

    open override func setOn(_ on: Bool, animated: Bool) {
        super.setOn(on, animated: animated)
        setThumbColor()
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    func setupComponents() {
        addTarget(self, action: #selector(didSwitch), for: .valueChanged)
    }
}

// MARK: - Supporting methods
private extension BaseSwitch {
    
    @objc
    func didSwitch(_ sender: UISwitch) {
        didSwitchTo?(sender.isOn)
        setThumbColor()
    }
    
    func setThumbColor() {
        guard let onThumbTintColor = onThumbTintColor,
              let offThumbTintColor = offThumbTintColor
        else { return }
        thumbTintColor = isOn ? onThumbTintColor : offThumbTintColor
    }
}

