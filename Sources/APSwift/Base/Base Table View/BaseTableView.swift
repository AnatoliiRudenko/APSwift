//
//  BaseTableView.swift
//
//  Created by Анатолий Руденко on 10.12.2021.
//

import UIKit

public protocol TableViewContentDelegate: AnyObject {
    func tableView(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)
}

public protocol TableViewSelectionDelegate: AnyObject {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, data: Any)
}

open class BaseTableView<Cell: UITableViewCell, Data>: UITableView, TableViewDelegates {
    
    // MARK: - Props
    public weak var contentDelegate: TableViewContentDelegate?
    public weak var selectionDelegate: TableViewSelectionDelegate?
    
    internal(set) open var data = [Data]()
    
    public var onPaging: Closure?
    public var onRefreshing: Closure?
    
    public var plugView: UIView?
    public var hidesLastSeparator = true
    public var isHeightEqualToContentHeight = false
    public var mainHeader: (view: UIView, height: CGFloat?)?
    
    public var contentHeight: CGFloat {
        layoutIfNeeded()
        return contentSize.height
    }
    
    public var isLastCellVisible: Bool {
        guard let indexes = self.indexPathsForVisibleRows else { return false }
        return indexes.contains { $0.row == data.count - 1 }
    }
    
    // MARK: - Methods
    open func setData(_ data: [Data], completion: Closure? = nil) {
        self.data = data
        DispatchQueue.main.async { [weak self] in
            self?.reloadData {
                completion?()
                guard let self = self, self.isHeightEqualToContentHeight else { return }
                self.height = self.contentHeight
            }
            self?.showPlugView(data.isEmpty)
        }
    }
    
    open func showPlugView(_ show: Bool) {
        guard let plugView = plugView else { return }
        if plugView.superview == nil && show {
            addSubview(plugView)
            plugView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.center.equalToSuperview()
            }
            plugView.layer.zPosition = -10 // we want it behind header/footer
        }
        plugView.setHidden(!show)
    }
    
    // MARK: - Init
    convenience public init() {
        self.init(frame: .zero, style: .grouped)
    }
    
    convenience public init(style: UITableView.Style) {
        self.init(frame: .zero, style: style)
    }
    
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    open func setupComponents() {
        registerCell(Cell.self)
        subscribe(self)
        separatorStyle = .none
        contentInsetAdjustmentBehavior = .never
        separatorInset = .zero
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 2
        sectionHeaderHeight = 0
        sectionFooterHeight = 0
        tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.01))
        tableFooterView = UIView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.01))
        removeExtraInsets()
    }
    
    open func hideSeparatorIfNeeded(for cell: UITableViewCell, at indexPath: IndexPath) {
        let shouldHideSeparator = hidesLastSeparator && indexPath.row == data.count - 1
        super.hideSeparator(shouldHideSeparator, for: cell)
    }
    
    // MARK: - Delegates
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(cell: Cell.self, indexPath: indexPath) else { return UITableViewCell() }
        contentDelegate?.tableView(self, cell: cell, indexPath: indexPath)
        hideSeparatorIfNeeded(for: cell, at: indexPath)
        return cell
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionDelegate?.tableView(self, didSelectRowAt: indexPath, data: data[indexPath.row])
    }
    
    // MARK: - Header
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        mainHeader?.view
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        mainHeader?.height ?? sectionHeaderHeight
    }
    
    // MARK: - UIScrollView Delegate
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isLastCellVisible {
            onPaging?()
        }
    }
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if targetContentOffset.pointee.y <= 0 && scrollView.contentOffset.y <= 0 {
            onRefreshing?()
        }
    }
    
    // MARK: - Height Constraint
    public var height: CGFloat? {
        didSet {
            guard let value = self.height else {
                self.heightConstraint.isActive = false
                return
            }
            if let heightConstraintPriority {
                self.heightConstraint.priority = .init(rawValue: heightConstraintPriority)
            }
            self.heightConstraint.constant = value
            self.heightConstraint.isActive = true
        }
    }
    
    public var heightConstraintPriority: Float?
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        self.heightAnchor.constraint(equalToConstant: self.height ?? 0)
    }()
}
