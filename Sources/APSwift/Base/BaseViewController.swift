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
    
    // MARK: - Content View
    public enum ContentContainerType {
        case regular(insets: UIEdgeInsets = .zero, safeAreaRelatedSides: [Side])
        case scrollView(insets: UIEdgeInsets = .zero, safeAreaRelatedSides: [Side])
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
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isOnFirstLayout = false
    }
    
    open func setupComponents() {}
    
    // MARK: - Methods
    open func presentNativeOKCancelAlert(title: String?, message: String?, okAction: Closure?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            okAction?()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    open func presentNativeOKAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    open func presentPermissonNotGrantedNativeAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(settingsUrl)
            else { return }
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    open func presentNativeErrorAlert(_ message: String?) {
        presentNativeOKAlert(title: "Error!", message: message ?? "Something went wrong")
    }
    
    // MARK: - UI Properties
    public lazy var contentView = UIView()
    public lazy var scrollView = UIScrollView()
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
            addContentView(insets: insets, safeAreaRelatedSides: safeAreaRelatedSides)
        case let .scrollView(insets, safeAreaRelatedSides):
            addScrollView(insets: insets, safeAreaRelatedSides: safeAreaRelatedSides)
        }
    }
    
    func addContentView(insets: UIEdgeInsets, safeAreaRelatedSides: [Side]) {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaRelatedSides.contains(where: { $0 == .top }) ? view.safeAreaLayoutGuide.snp.top : view.snp.top)
            make.left.equalTo(safeAreaRelatedSides.contains(where: { $0 == .left }) ? view.safeAreaLayoutGuide.snp.left : view.snp.left)
            make.right.equalTo(safeAreaRelatedSides.contains(where: { $0 == .right }) ? view.safeAreaLayoutGuide.snp.right : view.snp.right)
            make.bottom.equalTo(safeAreaRelatedSides.contains(where: { $0 == .bottom }) ? view.safeAreaLayoutGuide.snp.bottom : view.snp.bottom)
        }
    }
    
    func addScrollView(insets: UIEdgeInsets, safeAreaRelatedSides: [Side]) {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaRelatedSides.contains(where: { $0 == .top }) ? view.safeAreaLayoutGuide.snp.top : view.snp.top)
            make.left.equalTo(safeAreaRelatedSides.contains(where: { $0 == .left }) ? view.safeAreaLayoutGuide.snp.left : view.snp.left)
            make.right.equalTo(safeAreaRelatedSides.contains(where: { $0 == .right }) ? view.safeAreaLayoutGuide.snp.right : view.snp.right)
            make.bottom.equalTo(safeAreaRelatedSides.contains(where: { $0 == .bottom }) ? view.safeAreaLayoutGuide.snp.bottom : view.snp.bottom)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(insets.top)
            make.left.equalToSuperview().inset(insets.left)
            make.right.equalToSuperview().inset(insets.right)
            make.bottom.equalToSuperview().inset(insets.bottom).priority(250)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().priority(250)
        }
        scrollView.contentInsetAdjustmentBehavior = .never
    }
}

