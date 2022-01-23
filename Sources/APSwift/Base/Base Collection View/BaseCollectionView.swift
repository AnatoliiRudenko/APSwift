//
//  BaseCollectionView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 17.12.2021.
//

import UIKit

protocol CollectionViewContentDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath)
}

protocol CollectionViewSelectionDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, data: Any)
}

open class BaseCollectionView<Cell: UICollectionViewCell, Data>: UICollectionView, CollectionViewDelegates, UICollectionViewDelegateFlowLayout {
    
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
    
    var cellHeight: CGFloat?
    var cellsInRow: Int?
    var cellSize: CGSize {
        guard let cellsInRow = cellsInRow else {
            return UICollectionViewFlowLayout.automaticSize
        }
        guard let flowLayout = flowLayout else { return .zero }
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(cellsInRow - 1))
        let size = Int((bounds.width - totalSpace) / CGFloat(cellsInRow))
        return CGSize(width: size, height: cellHeight ?? size)
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
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    func setupComponents() {}
    
    // MARK: - Delegates
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeue(cell: Cell.self, indexPath: indexPath) else { return UICollectionViewCell() }
        contentDelegate?.collectionView(collectionView, cell: cell, indexPath: indexPath)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionDelegate?.collectionView(collectionView, didSelectItemAt: indexPath, data: data[indexPath.row])
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {}
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {}
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize
    }
    
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
