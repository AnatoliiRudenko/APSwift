//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 06.05.2022.
//

import UIKit

public extension UIImageView {
    
    func setImage(urlString: String?, placeholder: UIImage? = nil) {
        setImage(url: URL(string: urlString ?? ""), placeholder: placeholder)
    }
    
    func setImage(url: URL?, placeholder: UIImage? = nil) {
        self.image = placeholder
        Task {
            guard let image = await ImageManager.load(url: url) else { return }
            self.image = image
        }
    }
}
