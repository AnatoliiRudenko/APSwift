//
//  BaseCollectionViewCell.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 17.12.2021.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    
    open func setData(_ data: Data) {}
    
    public var letsShadowThrough = false {
        didSet {
            clipsToBounds = !letsShadowThrough
            contentView.clipsToBounds = !letsShadowThrough
            if letsShadowThrough {
                backgroundColor = .clear
                contentView.backgroundColor = .clear
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    open func setupComponents() {}
}
