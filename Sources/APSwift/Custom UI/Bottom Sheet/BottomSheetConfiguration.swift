//
//  BottomSheetConfiguration.swift
//  
//
//  Created by Анатолий Руденко on 11.01.2022.
//

import UIKit

public struct BottomSheetConfiguration {
    let height: CGFloat
    let initialOffset: CGFloat
    
    var hasInitialStage: Bool { height > initialOffset }
}
