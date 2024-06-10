//
//  BaseCollectionView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 17.12.2021.
//

import UIKit

public protocol CollectionViewContentDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath)
}

public protocol CollectionViewSelectionDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, data: Any)
}

open class BaseCollectionView<Cell: UICollectionViewCell, Data>: UICollectionView, CollectionViewDelegates, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Props
    public weak var contentDelegate: CollectionViewContentDelegate?
    public weak var selectionDelegate: CollectionViewSelectionDelegate?
    public var userWillScrollToIndex: DataClosure<Int>?
    public var automaticallyAdjustsHeight = false
    public var alignsSingleItemLeft = false
    
    internal(set) open var data = [Data]()
    
    open func setData(_ data: [Data], completion: Closure? = nil) {
        self.data = data
        DispatchQueue.main.async { [weak self] in
            self?.reloadData {
                completion?()
                guard self?.automaticallyAdjustsHeight ?? false else { return }
                self?.height = self?.contentHeight
            }
        }
    }
    
    public var contentHeight: CGFloat {
        layoutIfNeeded()
        return contentSize.height
    }
    
    public var flowLayout: UICollectionViewFlowLayout? {
        collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    // cellHeight only gets considered when cellsInRow has a value
    public var cellHeight: CGFloat?
    public var cellsInRow: Int?
    public var cellSize: CGSize {
        guard let cellsInRow = cellsInRow else {
            return UICollectionViewFlowLayout.automaticSize
        }
        guard let flowLayout = flowLayout else { return .zero }
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(cellsInRow - 1))
        let size = (bounds.width - totalSpace) / CGFloat(cellsInRow)
        return CGSize(width: size, height: cellHeight ?? size)
    }
    
    // MARK: - Init
    convenience public init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.init(frame: .zero, collectionViewLayout: layout)
    }

    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    open func setupComponents() {
        registerCell(Cell.self)
        subscribe(self)
    }
    
    // MARK: - Delegates
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeue(cell: Cell.self, indexPath: indexPath) else { return UICollectionViewCell() }
        contentDelegate?.collectionView(collectionView, cell: cell, indexPath: indexPath)
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionDelegate?.collectionView(collectionView, didSelectItemAt: indexPath, data: data[indexPath.row])
    }
    
    // MARK: - Scroll View Delegate
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {}
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if let userWillScrollToIndex {
            let itemWidth = frame.width
            let contentOffset = targetContentOffset.pointee.x
            let targetItem = lround(Double(contentOffset/itemWidth))
            let targetIndex = targetItem % data.count
            userWillScrollToIndex(targetIndex)
        }   
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {}
    
    // MARK: - UICollectionViewDelegateFlowLayout
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if alignsSingleItemLeft, collectionView.numberOfItems(inSection: section) == 1 {
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: collectionView.frame.width - cellSize.width)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Height Constraint
    public var height: CGFloat? {
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
