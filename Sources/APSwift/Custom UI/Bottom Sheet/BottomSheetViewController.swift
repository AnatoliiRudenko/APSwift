//
//  BottomSheetContainerViewController.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 27.12.2021.
//

import UIKit

public protocol BottomSheet {
    func unfoldBottomSheet(animated: Bool, completion: Closure?)
    func foldBottomSheet(animated: Bool, completion: Closure?)
    func removeBottomSheet(animated: Bool, completion: Closure?)
}

open class BottomSheetViewController<Content: BaseViewController>: BaseViewController, BottomSheet {
    
    // MARK: - State
    public enum BottomSheetState {
        case initial
        case full
        case removed
    }
    
    // MARK: - Props
    public var animationDuration: TimeInterval = .animation
    public var animationType: UIView.AnimationOptions = .curveEaseOut
    public var currentTopOffset: CGFloat { topConstraint.constant }
    public var foldsOnInitialStage = false
    
    public let contentVC: Content
    public let configuration: BottomSheetConfiguration
    
    public var willChangeState: DataClosure<BottomSheetState>?
    public var didChangeState: DataClosure<BottomSheetState>?
    public var adjustsContentHeightToState = false
    
    private(set) var state: BottomSheetState = .initial {
        didSet {
            didChangeState?(state)
            guard adjustsContentHeightToState else { return }
            adjustContentHeightToState()
        }
    }
    private var topConstraint = NSLayoutConstraint()
    
    // MARK: - Init
    public init(contentVC: Content,
                bottomSheetConfiguration: BottomSheetConfiguration) {
        
        self.contentVC = contentVC
        self.configuration = bottomSheetConfiguration
        
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        
        self.addDismissTap()
        self.setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard isOnFirstLayout else { return }
        configuration.hasInitialStage ? foldBottomSheet() : unfoldBottomSheet()
    }
    
    // MARK: - Display Actions
    public func unfoldBottomSheet(animated: Bool = true, completion: Closure? = nil) {
        willChangeState?(.full)
        self.topConstraint.constant = -configuration.maxHeight
        if animated {
            UIView.animate(withDuration: animationDuration, delay: 0, options: animationType) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.state = .full
                completion?()
            }
        } else {
            self.state = .full
            self.view.layoutIfNeeded()
            completion?()
        }
    }
    
    public func foldBottomSheet(animated: Bool = true, completion: Closure? = nil) {
        guard configuration.hasInitialStage else { return removeBottomSheet(animated: animated, completion: completion) }
        willChangeState?(.initial)
        self.topConstraint.constant = -configuration.initialHeight
        if animated {
            UIView.animate(withDuration: animationDuration, delay: 0, options: animationType) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.state = .initial
                completion?()
            }
        } else {
            self.state = .initial
            self.view.layoutIfNeeded()
            completion?()
        }
    }
    
    public func removeBottomSheet(animated: Bool = true, completion: Closure? = nil) {
        willChangeState?(.removed)
        self.topConstraint.constant = UIScreen.main.bounds.height
        if animated {
            UIView.animate(withDuration: animationDuration, delay: 0, options: animationType) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.state = .removed
                self.dismiss(animated: false, completion: nil)
                completion?()
            }
        } else {
            self.state = .removed
            self.view.layoutIfNeeded()
            self.dismiss(animated: false, completion: nil)
            completion?()
        }
    }
    
    // MARK: - Content stack view
    public let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    // MARK: - UIGestureRecognizer Delegate
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
    
    open override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        switch state {
        case .initial:
            return true
        case .full:
            return false
        case .removed:
            return false
        }
    }
    
    // MARK: - Pan Gesture
    private lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.delegate = self
        pan.addTarget(self, action: #selector(handlePan))
        return pan
    }()
    
    @objc
    private func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: contentVC.view)
        let velocity = sender.velocity(in: contentVC.view)
        
        let yTranslationMagnitude = translation.y.magnitude
        
        switch sender.state {
        case .began, .changed:
            if self.state == .full {
                guard translation.y > 0 else { return }
                topConstraint.constant = -(configuration.maxHeight - yTranslationMagnitude)
                
                self.view.layoutIfNeeded()
            } else {
                let newConstant = -(configuration.initialHeight + yTranslationMagnitude)
                
                guard translation.y < 0 else { return }
                guard newConstant.magnitude < configuration.maxHeight else {
                    self.unfoldBottomSheet()
                    return
                }
                
                topConstraint.constant = newConstant
                
                self.view.layoutIfNeeded()
            }
        case .ended:
            if self.state == .full {
                if velocity.y < 0 {
                    // Bottom Sheet was shown and the user is trying to move it to the top
                    self.unfoldBottomSheet()
                } else if yTranslationMagnitude >= configuration.maxHeight / 3 || velocity.y > 300 {
                    self.foldBottomSheet()
                } else {
                    
                    self.unfoldBottomSheet()
                }
            } else {
                if velocity.y < -300 {
                    self.unfoldBottomSheet()
                } else if velocity.y > 300 {
                    self.foldsOnInitialStage ? self.foldBottomSheet() : self.removeBottomSheet()
                }
            }
        case .failed:
            if self.state == .full {
                self.unfoldBottomSheet()
            } else {
                self.foldBottomSheet()
            }
        default: break
        }
    }
    
    // MARK: - Dismiss Tap
    private func addDismissTap() {
        let tapView = UIView()
        self.view.fitSubviewIn(tapView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapView.addGestureRecognizer(tapGesture)
        tapView.isUserInteractionEnabled = true
    }
    
    @objc
    private func handleTap() {
        removeBottomSheet()
    }
}

// MARK: - Supporting methods
private extension BottomSheetViewController {
    
    // MARK: - UI Setup
    func setupUI() {
        self.addChild(contentVC)
        
        containerStackView.addArrangedSubviews([contentVC.view])
        
        self.view.addSubview(containerStackView)
        containerStackView.addGestureRecognizer(panGesture)
        
        topConstraint = containerStackView.topAnchor
            .constraint(equalTo: self.view.bottomAnchor,
                        constant: UIScreen.main.bounds.height)
        topConstraint.isActive = true
        
        containerStackView.snp.makeConstraints { make in
            make.height.equalTo(configuration.maxHeight)
            make.left.right.equalToSuperview()
        }
        
        contentVC.didMove(toParent: self)
    }
    
    func adjustContentHeightToState() {
        guard state != .removed else { return }
        let height: CGFloat = {
            switch state {
            case .initial:
                return configuration.initialHeight
            case .full:
                return configuration.maxHeight
            case .removed:
                return 0
            }
        }()
        containerStackView.snp.remakeConstraints { make in
            make.height.equalTo(height)
            make.left.right.equalToSuperview()
        }
    }
}
