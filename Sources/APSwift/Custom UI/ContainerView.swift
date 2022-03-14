//
//  ContainerView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 17.12.2021.
//

import UIKit

open class ContainerView<Content: UIView>: BaseView {

    private(set) var content: Content
    private var insets: UIEdgeInsets = .zero
    
    open override func setupComponents() {
        super.setupComponents()
        addSubview(content)
        content.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(insets.top)
            make.bottom.equalToSuperview().inset(insets.bottom)
            make.left.equalToSuperview().inset(insets.left)
            make.right.equalToSuperview().inset(insets.right)
        }
    }

    open init(content: Content, insets: UIEdgeInsets = .zero) {
        self.content = content
        self.insets = insets
        super.init(frame: .zero)
    }
    
    open required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
