//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 06.05.2022.
//

import UIKit

public extension UIImageView {
    
    func setImage(urlString: String?, placeholder: UIImage? = nil, completion: DataClosure<UIImage?>? = nil) {
        setImage(url: URL(string: urlString ?? ""), placeholder: placeholder, completion: completion)
    }
    
    func setImage(url: URL?, placeholder: UIImage? = nil, completion: DataClosure<UIImage?>? = nil) {
        self.image = placeholder
        ImageManager.load(url: url) { [weak self] image in
            if let image = image {
                self?.image = image
            }
            completion?(image)
        }
    }
}
