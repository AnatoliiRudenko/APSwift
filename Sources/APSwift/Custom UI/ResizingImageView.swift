//
//  ResizingImageView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 26.12.2021.
//

import UIKit

open class ResizingImageView: BaseImageView {
    
    public var didCalculateSize: DataClosure<CGSize>?
    
    public var expectedWidth: CGFloat = UIScreen.main.bounds.width {
        didSet {
            self.fitsSuperviewWidth = false
            self.width = expectedWidth
        }
    }
    
    public var fitsSuperviewWidth = true
    public var setsSizeConstraints = false
    
    private var width: CGFloat = 0
    
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
        let size = CGSize(width: myViewWidth, height: scaledHeight)
        if setsSizeConstraints {
            snp.makeConstraints { make in
                make.size.equalTo(size)
            }
        }
        if let didCalculateSize {
            didCalculateSize(size)
        }
        return size
    }
}
