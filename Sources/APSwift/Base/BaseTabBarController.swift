//
//  BaseTabBarController.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 14.12.2021.
//

import UIKit

class BaseTabBarController<Tab: UITabBarItem>: UITabBarController {
    
    // MARK: - Props
    open var items = [Tab]()
    
    // MARK: - Methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponents()
    }
    
    open var selectedItem: Tab? {
        get {
            self.items.first(where: { $0.tag == self.selectedIndex })
        }
        set {
            guard let tag = newValue?.tag, self.items.contains(where: { $0.tag == tag }) else { return }
            
            self.selectedIndex = tag
        }
    }
    
    open func setupComponents() {}
}
