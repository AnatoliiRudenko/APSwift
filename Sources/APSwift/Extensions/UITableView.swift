//
//  UITableView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 10.12.2021.
//

import UIKit

public typealias TableViewDelegates = UITableViewDelegate & UITableViewDataSource

public extension UITableView {
    
    func isCellVisible(section: Int, row: Int) -> Bool {
        guard let indexes = self.indexPathsForVisibleRows else { return false }
        return indexes.contains { $0.section == section && $0.row == row }
    }
    
    func subscribe(_ object: TableViewDelegates) {
        delegate = object
        dataSource = object
    }
    
    func registerCell<T: UITableViewCell>(_ cell: T.Type) {
        register(cell, forCellReuseIdentifier: String.className(cell))
    }
    
    func registerNibCell<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: UITableViewCell>(cell: T.Type, indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: String.className(cell), for: indexPath) as? T
    }
    
    func reloadData(completion: @escaping Closure) {
        UIView.animate(withDuration: 0, animations: reloadData) { _ in completion() }
    }
    
    func removeExtraInsets() {
        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0
        }
    }
    
    func hideSeparator(_ hide: Bool, for cell: UITableViewCell) {
        cell.separatorInset = hide ? .init(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0) : separatorInset
    }
}

// MARK: - Scroll
public extension UITableView {
    
    func scrollTableToBottom(animated: Bool = true) {
        let sections = numberOfSections
        let rows = numberOfRows(inSection: sections - 1)
        guard rows > 0, sections > 0 else { return }
        scrollToRow(at: IndexPath(row: rows - 1, section: sections - 1),
                    at: .bottom,
                    animated: animated)
    }
}

// MARK: - Loader
public extension UITableView {

    func showTableLoader(_ show: Bool) {
        guard let superview else { return }
        let id = "Loader container view above table view"
        if show {
            let containerView = UIView()
            containerView.accessibilityIdentifier = id
            superview.addSubview(containerView)
            containerView.snp.makeConstraints { make in
                make.edges.equalTo(self.snp.edges)
            }
            Loader(parentView: containerView).show(true)
        } else {
            let containerView = superview.subviews.first(where: { $0.accessibilityIdentifier == id })
            containerView?.subviews.compactMap({ $0 as? Loader }).forEach { $0.show(false) }
            containerView?.removeFromSuperview()
        }
    }
}
