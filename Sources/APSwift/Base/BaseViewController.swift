//
//  BaseViewController.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 06.12.2021.
//

import UIKit

open class BaseViewModel {
    public init() {}
}

open class BaseViewController: UIViewController, Coordinatable {
    
    // MARK: - Props
    open var _model: BaseViewModel?
    public var coordinator: Coordinator?
    public var isOnFirstLayout = true
    public var hidesNavBar = false
    
    // MARK: - Content View
    public enum ContentContainerType {
        case regular(insets: UIEdgeInsets = .zero, safeAreaRelatedSides: [Side] = .all)
        case scrollView(insets: UIEdgeInsets = .zero, safeAreaRelatedSides: [Side] = .exceptForBottom, sticksToBottom: Bool = true)
    }
    
    public var contentContainerType: ContentContainerType = .regular(insets: .zero, safeAreaRelatedSides: []) {
        didSet {
            setupContentContainer()
        }
    }
    
    // MARK: - Lifecycle
    public convenience init(
        _model: BaseViewModel?
    ) {
        self.init(nibName: nil, bundle: nil)
        
        self._model = _model
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponents()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard hidesNavBar else { return }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isOnFirstLayout = false
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard hidesNavBar else { return }
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    open func setupComponents() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    // MARK: - Methods
    
    // MARK: - UI Properties
    public lazy var scrollView = UIScrollView()
    public lazy var contentView = UIView()
    public lazy var contentStackView: UIStackView = {
        let stackView: UIStackView = .stackView(.vertical, 16, [])
        contentView.fitSubviewIn(stackView)
        return stackView
    }()
}

// MARK: - UIGestureRecognizerDelegate
extension BaseViewController: UIGestureRecognizerDelegate {
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

// MARK: - Content View set up
private extension BaseViewController {
    
    func setupContentContainer() {
        switch contentContainerType {
        case let .regular(insets, safeAreaRelatedSides):
            addContentView(insets: insets,
                           safeAreaRelatedSides: safeAreaRelatedSides)
        case let .scrollView(insets, safeAreaRelatedSides, sticksToBottom):
            addScrollView(insets: insets,
                          safeAreaRelatedSides: safeAreaRelatedSides,
                          sticksToBottom: sticksToBottom)
        }
    }
    
    func addContentView(insets: UIEdgeInsets, safeAreaRelatedSides: [Side]) {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaRelatedSides.contains(where: { $0 == .top }) ? view.safeAreaLayoutGuide.snp.top : view.snp.top).inset(insets.top)
            make.left.equalTo(safeAreaRelatedSides.contains(where: { $0 == .left }) ? view.safeAreaLayoutGuide.snp.left : view.snp.left).inset(insets.left)
            make.right.equalTo(safeAreaRelatedSides.contains(where: { $0 == .right }) ? view.safeAreaLayoutGuide.snp.right : view.snp.right).inset(insets.right)
            make.bottom.equalTo(safeAreaRelatedSides.contains(where: { $0 == .bottom }) ? view.safeAreaLayoutGuide.snp.bottom : view.snp.bottom).inset(insets.bottom)
        }
    }
    
    func addScrollView(insets: UIEdgeInsets, safeAreaRelatedSides: [Side], sticksToBottom: Bool) {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaRelatedSides.contains(where: { $0 == .top }) ? view.safeAreaLayoutGuide.snp.top : view.snp.top)
            make.left.equalTo(safeAreaRelatedSides.contains(where: { $0 == .left }) ? view.safeAreaLayoutGuide.snp.left : view.snp.left)
            make.right.equalTo(safeAreaRelatedSides.contains(where: { $0 == .right }) ? view.safeAreaLayoutGuide.snp.right : view.snp.right)
            make.bottom.equalTo(safeAreaRelatedSides.contains(where: { $0 == .bottom }) ? view.safeAreaLayoutGuide.snp.bottom : view.snp.bottom)
        }
        if sticksToBottom {
            contentView.snp.makeConstraints { make in
                make.top.equalTo(scrollView.snp.top).inset(insets.top)
                make.left.equalTo(scrollView.snp.left).inset(insets.left)
                make.right.equalTo(scrollView.snp.right).inset(insets.right)
                make.bottom.equalTo(scrollView.snp.bottom).inset(insets.bottom).priority(250)
                make.centerX.equalTo(scrollView.snp.centerX)
                
                var offset = insets.top - insets.bottom
                if offset > 0 {
                    offset *= -1
                }
                make.centerY.equalTo(scrollView.snp.centerY).offset(offset).priority(250)
            }
        } else {
            contentView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(insets.top)
                make.left.equalToSuperview().inset(insets.left)
                make.right.equalToSuperview().inset(insets.right)
                make.bottom.equalToSuperview().inset(insets.bottom)
                make.centerX.equalToSuperview()
            }
        }
        scrollView.contentInsetAdjustmentBehavior = .never
    }
}

