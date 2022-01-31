//
//  ResizingImageView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 26.12.2021.
//

import UIKit

open class ResizingImageView: UIImageView {
    
    var expectedWidth: CGFloat = UIScreen.main.bounds.width {
        didSet {
            self.fitsSuperviewWidth = false
            self.width = expectedWidth
        }
    }
    var fitsSuperviewWidth = true
    
    private var width: CGFloat = 0
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        contentMode = .scaleAspectFit
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if fitsSuperviewWidth {
            width = superview?.bounds.width ?? 0
            invalidateIntrinsicContentSize()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        guard let myImage = self.image else { return CGSize() }
        let myImageWidth = myImage.size.width
        let myImageHeight = myImage.size.height
        let myViewWidth = width
        let ratio = myViewWidth / myImageWidth
        let scaledHeight = myImageHeight * ratio
        return CGSize(width: myViewWidth, height: scaledHeight)
    }
}
