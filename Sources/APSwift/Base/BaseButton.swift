//
//  BaseButton.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import UIKit

open class BaseButton: UIButton {
    
    public var didTap: (Closure)?
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
        self.addTarget(self, action: #selector(self.handleTap), for: .touchUpInside)
        contentHorizontalAlignment = .left
        semanticContentAttribute = .forceRightToLeft
        contentMode = .scaleToFill
    }
    
    // MARK: - UI Properties
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(contentEdgeInsets.left + imageEdgeInsets.left)
            make.centerY.equalToSuperview()
        }
        return imageView
    }()
    
    // MARK: - Resize to fit title label
    open override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: titleLabel?.frame.size.width ?? 0, height: .greatestFiniteMagnitude)) ?? .zero
        let imagesWidth: CGFloat = (leftImage?.size.width ?? 0) + (rightImage?.size.width ?? 0)
        let width: CGFloat = labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right + contentEdgeInsets.left + contentEdgeInsets.right + imagesWidth
        let height: CGFloat = labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom + contentEdgeInsets.top + contentEdgeInsets.bottom
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
    
    @objc
    func handleTap() {
        didTap?()
        animatesTap()
    }
    
    func setImage(_ image: UIImage?, left: Bool) {
        let inset: CGFloat = textToImageOffset + (left ? imageEdgeInsets.left : imageEdgeInsets.right)
        if left {
            leftImageView.image = image
        } else {
            imageView?.snp.remakeConstraints { make in
                make.right.equalToSuperview().inset(imageEdgeInsets.right)
                make.centerY.equalToSuperview()
            }
            setImage(image)
        }
        contentEdgeInsets = .init(top: contentEdgeInsets.top,
                                  left: left ? inset : contentEdgeInsets.left,
                                  bottom: contentEdgeInsets.bottom,
                                  right: left ? contentEdgeInsets.right : inset)
    }
}
