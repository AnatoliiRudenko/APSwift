//
//  BaseButton.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import UIKit

open class BaseButton: UIButton {
    
    open var didTap: (Closure)?
    public var animatesTap = true
    // don't use with center content horizontal alignment
    public var leftImage: UIImage? {
        didSet {
            setImage(leftImage, left: true)
        }
    }
    public var rightImage: UIImage? {
        didSet {
            setImage(rightImage, left: false)
        }
    }
    public var textToImageOffset: CGFloat = 16
    
    open override var isEnabled: Bool {
        get { super.isEnabled }
        set {
            super.isEnabled = newValue
            self.alpha = newValue ? 1 : 0.5
        }
    }
    
    // MARK: - Init
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public convenience init(title: String?) {
        self.init(frame: .zero)
        self.setTitle(title)
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
        self.addTarget(self, action: #selector(self.handleTap), for: .touchUpInside)
    }
    
    @objc
    func handleTap() {
        didTap?()
        if animatesTap {
            animateTap()
        }
    }
    
    // MARK: - UI Properties
    public lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        return imageView
    }()
    
    // MARK: - Resize to fit title label
    open override var intrinsicContentSize: CGSize {
        guard leftImage != nil || rightImage != nil else { return super.intrinsicContentSize }
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: titleLabel?.frame.size.width ?? 0, height: .greatestFiniteMagnitude)) ?? .zero
        let width: CGFloat = labelSize.width + contentEdgeInsets.left + contentEdgeInsets.right
        let height: CGFloat = labelSize.height + contentEdgeInsets.top + contentEdgeInsets.bottom
        return CGSize(width: width, height: height)
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
private extension BaseButton {
    
    func setImage(_ image: UIImage?, left: Bool) {
        adjustToSettingImage()
        let inset: CGFloat = textToImageOffset + (left ? contentEdgeInsets.left : contentEdgeInsets.right) + (image?.size.width ?? 0)
        if left {
            leftImageView.image = image
            leftImageView.snp.remakeConstraints { make in
                make.left.equalToSuperview().inset(contentEdgeInsets.left + imageEdgeInsets.left)
                make.centerY.equalToSuperview()
            }
        } else {
            imageView?.snp.remakeConstraints { make in
                make.right.equalToSuperview().inset(contentEdgeInsets.right + imageEdgeInsets.right)
                make.centerY.equalToSuperview()
            }
            setImage(image)
        }
        contentEdgeInsets = .init(top: contentEdgeInsets.top,
                                  left: left ? inset : contentEdgeInsets.left,
                                  bottom: contentEdgeInsets.bottom,
                                  right: left ? contentEdgeInsets.right : inset)
        if !left {
            titleEdgeInsets = .init(top: titleEdgeInsets.top,
                                    left: titleEdgeInsets.left,
                                    bottom: titleEdgeInsets.bottom,
                                    right: -(image?.size.width ?? 0)) // потому для правой картинки используется нативный imageView, он автоматически учитвается при подсчете размера для лэйбла
        }
    }
    
    func adjustToSettingImage() {
        contentHorizontalAlignment = .left
        semanticContentAttribute = .forceRightToLeft
        contentMode = .scaleToFill
    }
}
