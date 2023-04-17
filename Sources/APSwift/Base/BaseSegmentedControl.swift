//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 07.06.2022.
//

import UIKit

open class BaseSegmentedControl: UISegmentedControl {
    
    // MARK: - Props
    public var didSwitchTo: DataClosure<Int>?
    
    // to higlight selected item border
    public var selectedBorderColor: UIColor?
    public var normalBorderColor: UIColor?
    public var cornerRadius: CGFloat?
    
    public var selectedFont: UIFont? {
        didSet {
            addTitleTextAttributes([.font: selectedFont as Any], for: .selected)
        }
    }
    public var normalFont: UIFont? {
        didSet {
            addTitleTextAttributes([.font: normalFont as Any], for: .normal)
        }
    }
    public var selectedTitleColor: UIColor? {
        didSet {
            addTitleTextAttributes([.foregroundColor: selectedTitleColor as Any], for: .selected)
        }
    }
    public var normalTitleColor: UIColor? {
        didSet {
            addTitleTextAttributes([.foregroundColor: normalTitleColor as Any], for: .normal)
        }
    }
    public var normalBGColor: UIColor? {
        didSet {
            setBackgroundImage(normalBGColor?.asImage(size: .init(width: 1, height: height ?? bounds.height)), for: .normal, barMetrics: .default)
        }
    }
    public var selectedBGColor: UIColor? {
        didSet {
            setBackgroundImage(selectedBGColor?.asImage(size: .init(width: 1, height: height ?? bounds.height)), for: .selected, barMetrics: .default)
        }
    }
    public var dividerColor: UIColor? {
        didSet {
            setDividerImage(dividerColor?.asImage(size: .init(width: 1, height: height ?? bounds.height)), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        }
    }
    
    override open var selectedSegmentIndex: Int {
        get { super.selectedSegmentIndex }
        set {
            super.selectedSegmentIndex = newValue
            changeUIOnSwitch(newValue, animated: false)
        }
    }
    
    // MARK: - Init
    public override init(items: [Any]?) {
        super.init(items: items)
        self.setupComponents()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    open func setupComponents() {
        addTarget(self, action: #selector(didSwitch), for: .valueChanged)
    }
    
    // MARK: - Methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        changeUIOnSwitch(selectedSegmentIndex, animated: false)
    }
    
    open func changeUIOnSwitch(_ index: Int, animated: Bool = true) {
        setSelectedSegmentBorder(animated: animated)
    }
    
    func addTitleTextAttributes(_ options: [NSAttributedString.Key: Any], for state: UIControl.State) {
        let oldOptions = titleTextAttributes(for: state) ?? [:]
        let allOptions = options.merging(oldOptions) { first, second in
            first
        }
        setTitleTextAttributes(allOptions, for: state)
    }
    
    // MARK: - Height Constraint
    public var height: CGFloat? {
        didSet {
            guard let value = self.height else {
                self.heightConstraint.isActive = false
                return
            }
            self.heightConstraint.constant = value
            self.heightConstraint.isActive = true
        }
    }
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        self.heightAnchor.constraint(equalToConstant: self.height ?? 0)
    }()
}

// MARK: - Supporting Methods
private extension BaseSegmentedControl {
    
    @objc
    func didSwitch(_ sender: UISegmentedControl) {
        didSwitchTo?(sender.selectedSegmentIndex)
        changeUIOnSwitch(sender.selectedSegmentIndex)
    }
    
    func setSelectedSegmentBorder(animated: Bool = true) {
        guard let selectedBorderColor = selectedBorderColor,
              let normalBorderColor = normalBorderColor,
              let cornerRadius = cornerRadius
        else { return }
        let block = { [weak self] in
            guard let self = self else { return }
            guard self.subviews.count > self.numberOfSegments else { return }
            let views = self.subviews.cutToFirst(Int(Double(self.subviews.count) * 0.5))
            guard !views.isEmpty, (0..<views.count).contains(self.selectedSegmentIndex) else { return }
            self.clipsToBounds = false
            views.forEach {
                $0.addBorder(color: normalBorderColor)
                $0.roundCorners(cornerRadius)
            }
            views[self.selectedSegmentIndex].addBorder(color: selectedBorderColor)
        }
        if animated {
            UIView.animate {
                block()
            }
        } else {
            block()
        }
    }
}
