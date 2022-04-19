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
    private var minInsets: UIEdgeInsets?
    
    open override func setupComponents() {
        super.setupComponents()
        addSubview(content)
        minInsets == nil ? addEqualToConstraints() : addGreaterThanOrEqualToConstraints()
    }

    public init(content: Content, insets: UIEdgeInsets) {
        self.content = content
        self.insets = insets
        super.init(frame: .zero)
    }
    
    public init(content: Content, minInsets: UIEdgeInsets) {
        self.content = content
        self.minInsets = minInsets
        super.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ContainerView {
    
    func addEqualToConstraints() {
        content.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(insets.top)
            make.bottom.equalToSuperview().inset(insets.bottom)
            make.left.equalToSuperview().inset(insets.left)
            make.right.equalToSuperview().inset(insets.right)
        }
    }
    
    func addGreaterThanOrEqualToConstraints() {
        content.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview().inset(minInsets.top)
            make.bottom.greaterThanOrEqualToSuperview().inset(minInsets.bottom)
            make.left.greaterThanOrEqualToSuperview().inset(minInsets.left)
            make.right.greaterThanOrEqualToSuperview().inset(minInsets.right)
            make.center.equalToSuperview()
        }
    }
}
