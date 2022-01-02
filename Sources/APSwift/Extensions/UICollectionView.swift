//
//  UICollectionView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 17.12.2021.
//

import UIKit

typealias CollectionViewDelegates = UICollectionViewDelegate & UICollectionViewDataSource

extension UICollectionView {
    
    func subscribe(_ object: CollectionViewDelegates) {
        delegate = object
        dataSource = object
    }
    
    func registerCell<T: UICollectionViewCell>(_ cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: String.className(cell))
    }
    
    func dequeue<T: UICollectionViewCell>(cell: T.Type, indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: String.className(cell), for: indexPath) as? T
    }
    
    func reloadData(completion: @escaping Closure) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() }) { _ in completion() }
    }
}
