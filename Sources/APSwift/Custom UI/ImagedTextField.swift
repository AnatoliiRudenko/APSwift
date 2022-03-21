//
//  ImagedTextField.swift
//  
//
//  Created by Анатолий Руденко on 14.01.2022.
//

import UIKit

open class ImagedTextField: BaseTextField {
    
    public enum ImageSide {
        case left
        case right
    }

    // MARK: - Props
    public var imageSide: ImageSide = .right
    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    public var imageWidth: CGFloat = 24
    public var textToImageSpacing: CGFloat = 8
    
    // MARK: - Init
    convenience init(imageSide: ImageSide, image: UIImage?) {
        self.init(frame: .zero)
        self.imageSide = imageSide
        self.setImageView()
    }
    
    // MARK: - UI Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Insets
    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: insets.left, y: 0, width: imageWidth, height: bounds.height)
    }
    
    open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: bounds.width - insets.right - imageWidth, y: 0, width: imageWidth, height: bounds.height)
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        switch imageSide {
        case .left:
            return bounds.inset(by: .init(top: insets.top, left: insets.left + imageWidth + textToImageSpacing, bottom: insets.bottom, right: insets.right))
        case .right:
            return bounds.inset(by: .init(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right + imageWidth + textToImageSpacing))
        }
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }
}

// MARK: - Supporting methods
private extension ImagedTextField {
    
    func setImageView() {
        switch imageSide {
        case .left:
            leftViewMode = .always
            leftView = imageView
            rightViewMode = .never
            rightView = nil
        case .right:
            rightViewMode = .always
            rightView = imageView
            leftViewMode = .never
            leftView = nil
        }
    }
}
