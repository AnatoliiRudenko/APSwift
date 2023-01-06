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
    open var isChecked: Bool {
        get {
            self.checkbox.isChecked
        }
        set {
            self.checkbox.isChecked = newValue
        }
    }
    
    open var didTapToState: DataClosure<Bool>? {
        get {
            self.checkbox.didTapToState
        }
        set {
            self.checkbox.didTapToState = newValue
        }
    }
    
    open var title: String? {
        get {
            self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    private let checkBoxLocatedToTheRightSide: Bool
    
    // MARK: - Init
    public init(checkBoxLocatedToTheRightSide: Bool) {
        self.checkBoxLocatedToTheRightSide = checkBoxLocatedToTheRightSide
        super.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override func setupComponents() {
        super.setupComponents()
        
        animatesTap = false
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let arrangedSubviews = checkBoxLocatedToTheRightSide ? [titleLabelContainerView, checkboxContainerView] : [checkboxContainerView, titleLabelContainerView]
        stackView.addArrangedSubviews(arrangedSubviews)
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
            self?.checkbox.didTap?()
        }
    }
    
    // MARK: - UI Properties
    public lazy var titleLabel = BaseLabel()
    
    public lazy var checkbox = CheckBox()
    
    public let stackView: UIStackView = {
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
