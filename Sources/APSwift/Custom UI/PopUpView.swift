//
//  PopUpView.swift
//
//  Created by Анатолий Руденко on 28.12.2021.
//

import UIKit

open class PopUpView<Content: UIView>: BaseView {
    
    public var content: Content
    
    public init(content: Content) {
        self.content = content
        super.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setupComponents() {
        super.setupComponents()
        
        addSubviews([bgTapView, content])
        bgTapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    open func dismiss() {
        setHidden(true) { [weak self] in
            self?.removeFromSuperview()
        }
    }
    
    // MARK: - UI Properties
    private lazy var bgTapView: BaseView = {
        let view = BaseView()
        view.didTap = { [weak self] in
            self?.dismiss()
        }
        return view
    }()
}
