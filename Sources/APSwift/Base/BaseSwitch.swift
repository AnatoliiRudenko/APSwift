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
    
    open func changeUIOnSwitch() { }
    
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
        setThumbColor()
        changeUIOnSwitch()
    }
    
    func setThumbColor() {
        guard let onThumbTintColor = onThumbTintColor,
              let offThumbTintColor = offThumbTintColor
        else { return }
        thumbTintColor = isOn ? onThumbTintColor : offThumbTintColor
    }
}

