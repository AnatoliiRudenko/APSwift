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
}
