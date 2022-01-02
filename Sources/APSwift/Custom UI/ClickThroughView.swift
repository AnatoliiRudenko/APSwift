//
//  ClickThroughView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 20.12.2021.
//

import UIKit

class ClickThroughView: AppView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}
