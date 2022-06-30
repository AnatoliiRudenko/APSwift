//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 06.05.2022.
//

import UIKit

public extension UIImageView {
    
    func setImage(urlString: String?, placeholder: UIImage? = nil, qos: DispatchQoS.QoSClass = ImageManager.defaultQOS, completion: DataClosure<UIImage?>? = nil) {
        setImage(url: URL(string: urlString ?? ""), placeholder: placeholder, qos: qos, completion: completion)
    }
    
    func setImage(url: URL?, placeholder: UIImage? = nil, qos: DispatchQoS.QoSClass = ImageManager.defaultQOS, completion: DataClosure<UIImage?>? = nil) {
        self.image = placeholder
        ImageManager.load(url: url, qos: qos) { [weak self] image in
            if let image = image {
                self?.image = image
            }
            completion?(image)
        }
    }
}
