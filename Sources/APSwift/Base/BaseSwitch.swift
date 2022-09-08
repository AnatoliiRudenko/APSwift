//
//  BaseSwitch.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.02.2022.
//

import UIKit

open class BaseSwitch: UISwitch {
    
    // MARK: - Props
    public var didSwitchTo: DataClosure<Bool>?
    
    public var onThumbTintColor: UIColor? {
        didSet {
            setThumbColor()
        }
    }
    public var offThumbTintColor: UIColor? {
        didSet {
            setThumbColor()
        }
    }
    
    // MARK: - Methods
    public func imitateTap() {
        setOn(!isOn, animated: true)
        didSwitch(self)
    }
    
    open func changeUIOnSwitch(_ isOn: Bool) {
        setThumbColor()
    }
    
    // MARK: - Overriden
    open override var isOn: Bool {
        didSet {
            changeUIOnSwitch(isOn)
        }
    }

    open override func setOn(_ on: Bool, animated: Bool) {
        super.setOn(on, animated: animated)
        changeUIOnSwitch(isOn)
    }

    // MARK: - Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    open func setupComponents() {
        addTarget(self, action: #selector(didSwitch), for: .valueChanged)
    }
}

// MARK: - Supporting methods
private extension BaseSwitch {
    
    @objc
    func didSwitch(_ sender: UISwitch) {
        didSwitchTo?(sender.isOn)
        changeUIOnSwitch(sender.isOn)
    }
    
    func setThumbColor() {
        guard let onThumbTintColor = onThumbTintColor,
              let offThumbTintColor = offThumbTintColor
        else { return }
        thumbTintColor = isOn ? onThumbTintColor : offThumbTintColor
    }
}

