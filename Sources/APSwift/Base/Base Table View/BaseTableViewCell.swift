//
//  AppTableViewCell.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 16.12.2021.
//

import UIKit

open class BaseTableViewCell<Data>: UITableViewCell {
    
    open func setData(_ data: Data) {}

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }

    open func setupComponents() {
        selectionStyle = .none
    }
}
