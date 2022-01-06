//
//  ResizingImageView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 26.12.2021.
//

import UIKit

open class ResizingImageView: UIImageView {
    
    var expectedWidth: CGFloat = UIScreen.main.bounds.width
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .scaleAspectFit
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        contentMode = .scaleAspectFit
    }
    
    open override var intrinsicContentSize: CGSize {
        guard let myImage = self.image else { return CGSize() }
        let myImageWidth = myImage.size.width
        let myImageHeight = myImage.size.height
        let myViewWidth = expectedWidth
        let ratio = myViewWidth / myImageWidth
        let scaledHeight = myImageHeight * ratio
        return CGSize(width: myViewWidth, height: scaledHeight)
    }
}
