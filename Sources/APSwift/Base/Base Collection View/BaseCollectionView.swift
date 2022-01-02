//
//  BaseCollectionView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 17.12.2021.
//

import UIKit

protocol CollectionViewContentDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath, data: Any)
}

protocol CollectionViewSelectionDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, data: Any)
}

class BaseCollectionView<Cell: UICollectionViewCell, Data>: UICollectionView, CollectionViewDelegates {
    
    // MARK: - Props
    weak var contentDelegate: CollectionViewContentDelegate?
    weak var selectionDelegate: CollectionViewSelectionDelegate?
    
    var data = [Data]()
    
    func setData(_ data: [Data], completion: Closure? = nil) {
        self.data = data
        DispatchQueue.main.async { [weak self] in
            self?.reloadData {
                completion?()
            }
        }
    }
    
    var contentHeight: CGFloat {
        layoutIfNeeded()
        return contentSize.height
    }
    
    var flowLayout: UICollectionViewFlowLayout? {
        collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    // MARK: - Init
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.init(frame: .zero, collectionViewLayout: layout)
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    func setupComponents() {}
    
    // MARK: - Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeue(cell: Cell.self, indexPath: indexPath) else { return UICollectionViewCell() }
        contentDelegate?.collectionView(collectionView, cell: cell, indexPath: indexPath, data: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionDelegate?.collectionView(collectionView, didSelectItemAt: indexPath, data: data[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {}
    
    // MARK: - Height Constraint
    var height: CGFloat? {
        didSet {
            guard let value = self.height else {
                self.heightConstraint.isActive = false
                return
            }
            self.heightConstraint.constant = value
            self.heightConstraint.isActive = true
        }
    }
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        self.heightAnchor.constraint(equalToConstant: self.height ?? 0)
    }()
}
