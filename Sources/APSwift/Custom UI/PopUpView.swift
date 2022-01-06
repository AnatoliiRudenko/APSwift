//
//  PopUpViewController.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 28.12.2021.
//

import UIKit

open class PopUpView: BaseView {
    
    open override func setupComponents() {
        super.setupComponents()
        
        addSubviews([bgTapView, contentView])
        bgTapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    func dismiss() {
        setHidden(true) { [weak self] in
            self?.removeFromSuperview()
        }
    }
    
    // MARK: - UI Properties
    lazy var contentView = BaseView() // to override
    
    private lazy var bgTapView: BaseView = {
        let view = BaseView()
        view.didTap = { [weak self] in
            self?.dismiss()
        }
        return view
    }()
}
