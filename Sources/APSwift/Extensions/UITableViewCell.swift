//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 17.06.2022.
//

import UIKit

public extension UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
