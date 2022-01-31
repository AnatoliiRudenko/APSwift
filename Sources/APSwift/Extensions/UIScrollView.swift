//
//  UIScrollView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 28.01.2022.
//

import UIKit

extension UIScrollView {
    
    func scrollToTop(animated: Bool = true) {
        setContentOffset(.init(x: contentOffset.x, y: -contentInset.top), animated: animated)
    }
}
