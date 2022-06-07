//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 07.06.2022.
//

import UIKit

public extension UIColor {
    
    func asImage(size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
