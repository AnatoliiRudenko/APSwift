//
//  AppTableView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 10.12.2021.
//

import UIKit

protocol TableViewContentDelegate: AnyObject {
    func tableView(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)
}

protocol TableViewSelectionDelegate: AnyObject {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, data: Any)
}

open class BaseTableView<Cell: UITableViewCell, Data>: UITableView, TableViewDelegates {
    
    // MARK: - Props
    weak var contentDelegate: TableViewContentDelegate?
    weak var selectionDelegate: TableViewSelectionDelegate?
    
    internal(set) open var data = [Data]()
    
    var onPaging: Closure?
    var onScrollingBeyondTop: Closure?
    
    var plugView: BaseView?
    
    var contentHeight: CGFloat {
        layoutIfNeeded()
        return contentSize.height
    }
    
    var isLastCellVisible: Bool {
        guard let indexes = self.indexPathsForVisibleRows else { return false }
        return indexes.contains { $0.row == data.count - 1 }
    }
    
    // MARK: - Methods
    func setData(_ data: [Data], completion: Closure? = nil) {
        self.data = data
        DispatchQueue.main.async { [weak self] in
            self?.reloadData {
                completion?()
            }
            self?.showPlugView(data.isEmpty)
        }
    }
    
    func showPlugView(_ show: Bool) {
        guard let plugView = plugView else { return }
        if plugView.superview == nil && show {
            addSubview(plugView)
            plugView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.center.equalToSuperview()
            }
        }
        plugView.setHidden(!show)
    }
    
    // MARK: - Init
    convenience init() {
        self.init(frame: .zero, style: .grouped)
    }
    
    convenience init(style: UITableView.Style) {
        self.init(frame: .zero, style: style)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        registerCell(Cell.self)
        subscribe(self)
        separatorStyle = .none
        contentInsetAdjustmentBehavior = .never
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 2
        tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.01))
        tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.01))
    }
    
    // MARK: - Delegates
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(cell: Cell.self, indexPath: indexPath) else { return UITableViewCell() }
        contentDelegate?.tableView(self, cell: cell, indexPath: indexPath)
        if indexPath.row == data.count - 1 {
           onPaging?()
        }
        return cell
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionDelegate?.tableView(self, didSelectRowAt: indexPath, data: data[indexPath.row])
    }
    
    // MARK: - UIScrollView Delegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isLastCellVisible {
            onPaging?()
        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if targetContentOffset.pointee.y <= 0 && scrollView.contentOffset.y <= 0 {
            onScrollingBeyondTop?()
        }
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
