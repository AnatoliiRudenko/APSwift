//
//  PopUpViewController.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 28.12.2021.
//

import UIKit

class PopUpView: BaseView {
    
    override func setupComponents() {
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
    
    func show() {
        isHidden = true
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(self)
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setHidden(false)
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
