//
//  DevelopViewController.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import UIKit

open class DevelopViewController: BaseViewController {
    
    // MARK: - Props
    open var text: String { "This screen is being developed" }
    
    private var titleText: String?
    
    // MARK: - Methods
    convenience public init(title: String) {
        self.init(nibName: nil, bundle: nil)
        self.titleText = title
    }
    
    open override func setupComponents() {
        super.setupComponents()
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = titleText
    }
    
    // MARK: - UI Properties
    lazy var label: BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.multiline = true
        label.text = self.text
        return label
    }()
}
