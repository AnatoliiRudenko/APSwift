//
//  AppCheckBoxView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 24.12.2021.
//

import UIKit
import SnapKit

open class CheckBoxView: BaseView {

    // MARK: - Props
    var isChecked: Bool {
        get {
            self.checkbox.isChecked
        }
        set {
            self.checkbox.isChecked = newValue
        }
    }
    
    var didTapToState: DataClosure<Bool>? {
        get {
            self.checkbox.didTapToState
        }
        set {
            self.checkbox.didTapToState = newValue
        }
    }
    
    var title: String? {
        get {
            self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    // MARK: - Init
    open override func setupComponents() {
        super.setupComponents()
        
        animateTap = false
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView.addArrangedSubviews([titleLabelContainerView, checkboxContainerView])
        titleLabelContainerView.addSubview(titleLabel)
        checkboxContainerView.addSubview(checkbox)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        
        checkbox.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        didTap = { [weak self] in
            self?.isChecked.toggle()
        }
    }
    
    // MARK: - UI Properties
    lazy var titleLabel = BaseLabel()
    
    lazy var checkbox = CheckBox()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var titleLabelContainerView: BaseView = {
        let view = BaseView()
        return view
    }()
    
    private lazy var checkboxContainerView: BaseView = {
        let view = BaseView()
        return view
    }()
}
