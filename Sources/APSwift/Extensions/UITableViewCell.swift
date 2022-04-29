//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 29.04.2022.
//

import UIKit

extension UITableViewCell {
    
    func hideSeparator() {
        separatorInset = .init(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
    }
}
