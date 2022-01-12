//
//  BottomSheetContainerViewController.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 27.12.2021.
//

import UIKit

open class BottomSheetViewController<Content: BaseViewController>: BaseViewController {
    
    // MARK: - Props
    var animationDuration: TimeInterval = 0.2
    var animationType: UIView.AnimationOptions = .curveEaseOut
    var currentTopOffset: CGFloat { topConstraint.constant }
    
    // MARK: - Initialization
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
    public func unfoldBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = -configuration.height
        willChangeState?(.full)
        if animated {
            UIView.animate(withDuration: animationDuration, delay: 0, options: animationType) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.state = .full
            }
        } else {
            self.view.layoutIfNeeded()
            self.state = .full
        }
    }
    
    public func foldBottomSheet(animated: Bool = true) {
        guard configuration.hasInitialStage else { return removeBottomSheet() }
        self.topConstraint.constant = -configuration.initialOffset
        willChangeState?(.initial)
        if animated {
            UIView.animate(withDuration: animationDuration, delay: 0, options: animationType) {
                            self.view.layoutIfNeeded()
            } completion: { _ in
                self.state = .initial
            }
        } else {
            self.view.layoutIfNeeded()
            self.state = .initial
        }
    }
    
    public func removeBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = UIScreen.main.bounds.height
        if animated {
            UIView.animate(withDuration: animationDuration, delay: 0, options: animationType) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.dismiss(animated: false, completion: nil)
            }
        } else {
            self.view.layoutIfNeeded()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    // MARK: - Pan Action
    @objc
    func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: contentVC.view)
        let velocity = sender.velocity(in: contentVC.view)
        
        let yTranslationMagnitude = translation.y.magnitude
        
        switch sender.state {
        case .began, .changed:
            if self.state == .full {
                guard translation.y > 0 else { return }
                topConstraint.constant = -(configuration.height - yTranslationMagnitude)
                
                self.view.layoutIfNeeded()
            } else {
                let newConstant = -(configuration.initialOffset + yTranslationMagnitude)
                
                guard translation.y < 0 else { return }
                guard newConstant.magnitude < configuration.height else {
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
                } else if yTranslationMagnitude >= configuration.height / 3 || velocity.y > 300 {
                    self.foldBottomSheet()
                } else {

                    self.unfoldBottomSheet()
                }
            } else {
                if yTranslationMagnitude >= configuration.height / 3 || velocity.y < -300 {
                    
                    self.unfoldBottomSheet()
                    
                } else {
                    self.foldBottomSheet()
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
    
    // MARK: - Configuration
    
    private let configuration: BottomSheetConfiguration
    
    // MARK: - State
    public enum BottomSheetState {
        case initial
        case full
    }
    
    var willChangeState: DataClosure<BottomSheetState>?
    var didChangeState: DataClosure<BottomSheetState>?
    
    private(set) var state: BottomSheetState = .initial {
        didSet {
            didChangeState?(state)
        }
    }
    
    // MARK: - Children
    let contentVC: Content
    
    // MARK: - Contents stack view
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    // MARK: - Top Constraint
    private var topConstraint = NSLayoutConstraint()
    
    // MARK: - Pan Gesture
    lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.delegate = self
        pan.addTarget(self, action: #selector(handlePan))
        return pan
    }()
    
    // MARK: - UIGestureRecognizer Delegate
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
    
    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        switch state {
        case .initial:
            return true
        case .full:
            return false
        }
    }
    
    // MARK: - Supporting Methods
    private func addDismissTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc
    private func handleTap() {
        removeBottomSheet()
    }
}

extension BottomSheetViewController {
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addChild(contentVC)
        
        containerStackView.addArrangedSubviews([contentVC.view])
        
        self.view.addSubview(containerStackView)
        containerStackView.addGestureRecognizer(panGesture)
        
        topConstraint = containerStackView.topAnchor
            .constraint(equalTo: self.view.bottomAnchor,
                        constant: UIScreen.main.bounds.height)
        topConstraint.isActive = true
        
        containerStackView.snp.makeConstraints { make in
            make.height.equalTo(configuration.height)
            make.left.right.equalToSuperview()
        }
        
        contentVC.didMove(toParent: self)
    }
}
