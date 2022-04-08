//
//  BottomSheetConfiguration.swift
//  
//
//  Created by Анатолий Руденко on 11.01.2022.
//

import UIKit

public struct BottomSheetConfiguration {
    
    public let maxHeight: CGFloat
    public let initialHeight: CGFloat
    
    public init(maxHeight: CGFloat, initialHeight: CGFloat) {
        self.maxHeight = maxHeight
        self.initialHeight = initialHeight
    }
    
    var hasInitialStage: Bool { maxHeight > initialHeight }
}
