//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 06.05.2022.
//

import UIKit

public extension UIImageView {
    
    func setImage(urlString: String?, placeholder: UIImage? = nil, completion: DataClosure<UIImage?>? = nil) {
        self.image = placeholder
        ImageManager.load(urlString: urlString) { [weak self] image in
            self?.image = image
            completion?(image)
        }
    }
}
