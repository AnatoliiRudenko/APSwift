//
//  File.swift
//  
//
//  Created by Anatolii Rudenko on 28.02.2023.
//

import UIKit

public extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) * 0.5
        let positiveTopOffset = max(1, topOffset)
        textContainerInset.top = positiveTopOffset
    }
}
