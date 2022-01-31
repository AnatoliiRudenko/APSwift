//
//  TagsCollectionView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 20.12.2021.
//

import UIKit

open class TagsCollectionView<Cell: UICollectionViewCell, Data>: BaseCollectionView<Cell, Data> {
    
    var didCalculateTagsHeight: DataClosure<CGFloat>?
    
    override func setData(_ data: [Data], completion: Closure? = nil) {
        isHidden = data.isEmpty
        self.data = data
        UIView.animate(withDuration: 0.0, animations: { [weak self] in
            guard let self = self else { return }
            self.reloadData()
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            let height = self.contentSize.height
            var rows = ceil(height / (self.rowHeight + self.lineSpacing))
            if rows == 0 {
                rows = 1
            }
            let newHeightValue = (rows * self.rowHeight) + (rows - 1) * self.lineSpacing
            self.didCalculateTagsHeight?(newHeightValue)
            completion?()
        })
    }
    
    func setSizes(rowHeight: CGFloat, lineSpacing: CGFloat, itemSpacing: CGFloat) {
        self.rowHeight = rowHeight
        self.lineSpacing = lineSpacing
        self.itemSpacing = itemSpacing
    }
    
    var rowHeight: CGFloat = 22
    var lineSpacing: CGFloat = 8
    var itemSpacing: CGFloat = 4
    
    override func setupComponents() {
        super.setupComponents()
        
        isScrollEnabled = false
        backgroundColor = .clear
        
        let layout = TagsCollectionLayout(itemSpacing: itemSpacing)
        layout.estimatedItemSize = CGSize(width: 108, height: rowHeight)
        collectionViewLayout = layout
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpacing
    }
}
