//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 06.05.2022.
//

import UIKit

public extension UIImageView {
    
    static var defaultQOS: DispatchQoS.QoSClass = .default
    
    func setImage(urlString: String?, placeholder: UIImage? = nil, qos: DispatchQoS.QoSClass = defaultQOS, completion: DataClosure<UIImage?>? = nil) {
        setImage(url: URL(string: urlString ?? ""), placeholder: placeholder, qos: qos, completion: completion)
    }
    
    func setImage(url: URL?, placeholder: UIImage? = nil, qos: DispatchQoS.QoSClass = defaultQOS, completion: DataClosure<UIImage?>? = nil) {
        self.image = placeholder
        DispatchQueue.global(qos: qos).async {
            ImageManager.load(url: url) { [weak self] image in
                if let image = image {
                    self?.image = image
                }
                completion?(image)
            }
        }
    }
}
