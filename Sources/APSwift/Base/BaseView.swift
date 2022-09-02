//
//  BaseView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 06.12.2021.
//

import UIKit

open class BaseView: UIView {
    
    // MARK: - Props
    open var didTap: (Closure)? {
        didSet {
            self.enableTap()
        }
    }
    
    public var animatesTap = true
    public var tapsThrough = false
    public var isCircled = false
    public lazy var swipe: Swipe = {
        var swipe = Swipe()
        swipe.didSetDirection = { [weak self] direction in
            self?.addSwipe(direction)
        }
        return swipe
    }()
    
    public var isEnabled: Bool = true {
        didSet {
            isUserInteractionEnabled = isEnabled
            alpha = isEnabled ? 1 : 0.5
        }
    }
    
    public lazy var scrollView = UIScrollView()
    public lazy var scrollContentView = BaseView()
    
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
    
    open func setupComponents() {}
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        guard isCircled else { return }
        roundCorners(bounds.width)
    }
    
    // MARK: - Scroll View
    open func addScrollView(stickToBottom: Bool = false) {
        fitSubviewIn(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().priority(stickToBottom ? 999 : 250)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().priority(stickToBottom ? 999 : 250)
        }
    }
    
    // MARK: - Tap Through
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard tapsThrough else { return super.point(inside: point, with: event) }
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
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

// MARK: - Supporting methods
private extension BaseView {
    
    // MARK: - Tap
    private func enableTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc
    private func handleTap() {
        didTap?()
        if animatesTap {
            animateTap()
        }
    }
    
    // MARK: - Swipe
    func addSwipe(_ direction: UISwipeGestureRecognizer.Direction) {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(gesture:)))
        swipe.direction = direction
        addGestureRecognizer(swipe)
    }
    
    @objc
    func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            swipe.onLeft?(gesture)
        case .right:
            swipe.onRight?(gesture)
        case .down:
            swipe.onDown?(gesture)
        case .up:
            swipe.onUp?(gesture)
        default:
            break
        }
    }
}
