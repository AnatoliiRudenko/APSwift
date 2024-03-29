//
//  UIScrollView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 28.01.2022.
//

import UIKit

public extension UIScrollView {
    
    func setSafeAreaBottomInset(extraValue: CGFloat = 0) {
        contentInset.bottom = UIApplication.shared.safeAreaInsets.bottom + extraValue
    }
    
    func scrollToView(_ view: UIView?,
                      position: UITableView.ScrollPosition = .top,
                      extraY: CGFloat = 0,
                      animated: Bool = true) {
        
        guard let view = view,
              let origin = view.superview,
              !(position == .none && bounds.intersects(view.frame))
        else { return }
        
        let childStartPoint = origin.convert(view.frame.origin, to: self)
        
        let scrollPointY: CGFloat = {
            switch position {
            case .bottom:
                let childEndY = childStartPoint.y + view.frame.height
                return CGFloat.maximum(childEndY - frame.size.height, 0)
            case .middle:
                let childCenterY = childStartPoint.y + view.frame.height * 0.5
                let scrollViewCenterY = frame.size.height * 0.5
                return CGFloat.maximum(childCenterY - scrollViewCenterY, 0)
            default:
                // Scroll to top
                return childStartPoint.y
            }
        }()
        
        scrollRectToVisible(CGRect(x: 0,
                                   y: scrollPointY + extraY,
                                   width: 0.01,
                                   height: frame.height),
                            animated: animated)
    }
    
    func scrollToTop(animated: Bool = true) {
        setContentOffset(.init(x: contentOffset.x, y: -contentInset.top), animated: animated)
    }
    
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if bottomOffset.y > 0 {
            setContentOffset(bottomOffset, animated: animated)
        }
    }
    
    var isScrolledToBottom: Bool {
        let bottomEdge = contentOffset.y + bounds.size.height
        return bottomEdge > contentSize.height
    }
}
