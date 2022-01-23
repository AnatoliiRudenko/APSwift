//
//  BottomSheetConfiguration.swift
//  
//
//  Created by Анатолий Руденко on 11.01.2022.
//

import UIKit

public struct BottomSheetConfiguration {
    let maxHeight: CGFloat
    let initialHeight: CGFloat
    
    var hasInitialStage: Bool { maxHeight > initialHeight }
}
