//
//  File.swift
//  
//
//  Created by Anatolii Rudenko on 28.02.2023.
//

import UIKit

public extension UITextView {
    
    func centerVertically() {
        let rect = layoutManager.usedRect(for: textContainer)
        let topInset = (bounds.size.height - rect.height) / 2.0
        textContainerInset.top = max(0, topInset)
    }
}
