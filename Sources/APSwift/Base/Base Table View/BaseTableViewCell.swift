//
//  AppTableViewCell.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 16.12.2021.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupComponents() {
        selectionStyle = .none
    }
}
