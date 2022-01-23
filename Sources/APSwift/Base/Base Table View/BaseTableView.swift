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
    
    private(set) var data = [Data]()
    
    var didReload: Closure?
    
    func setData(_ data: [Data]) {
        self.data = data
        DispatchQueue.main.async { [weak self] in
            self?.reloadData {
                self?.didReload?()
            }
        }
    }
    
    var contentHeight: CGFloat {
        layoutIfNeeded()
        return contentSize.height
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
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(cell: Cell.self, indexPath: indexPath) else { return UITableViewCell() }
        contentDelegate?.tableView(self, cell: cell, indexPath: indexPath)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionDelegate?.tableView(self, didSelectRowAt: indexPath, data: data[indexPath.row])
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
