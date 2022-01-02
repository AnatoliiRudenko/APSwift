//
//  DevelopViewController.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import UIKit

class DevelopViewController: BaseViewController {
    
    // MARK: - Props
    private var titleText: String?
    
    // MARK: - Methods
    convenience init(title: String) {
        self.init(nibName: nil, bundle: nil)
        self.titleText = title
    }
    
    override func setupComponents() {
        super.setupComponents()
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = titleText
    }
    
    // MARK: - UI Properties
    private lazy var label: BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.multiline = true
        label.text = "Данный раздел находится в разработке"
        return label
    }()
}
