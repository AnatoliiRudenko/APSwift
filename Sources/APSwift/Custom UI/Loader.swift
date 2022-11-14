//
//  Loader.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import UIKit

@MainActor
open class Loader: UIView {
    
    // MARK: - Props
    public var size: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 80 : 120
    public var bgColor: UIColor = .white.withAlphaComponent(0.7)
    public var spinnerStyle: UIActivityIndicatorView.Style = .large
    public var spinnerColor: UIColor?
    
    // MARK: - Init
    convenience public init(parentView: UIView) {
        self.init(frame: parentView.bounds, parentView: parentView)
    }
    
    public init(frame: CGRect, parentView: UIView) {
        self.parentView = parentView
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    open func show() {
        guard self.superview == nil else {
            parentView?.bringSubviewToFront(self)
            return
        }
        
        guard let parentView = parentView else { return }
        self.backgroundColor = bgColor
        
        self.spinner = UIActivityIndicatorView(style: spinnerStyle)
        if let spinnerColor = spinnerColor {
            self.spinner.color = spinnerColor
        }
        
        self.addSubview(self.spinner)
        parentView.addSubview(self)
        
        self.spinner.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.size.equalTo(size)
        }
        self.snp.makeConstraints { make in
            make.edges.equalTo(parentView.snp.edges)
        }
        
        self.spinner.startAnimating()
    }

    open func hide() {
        self.spinner.stopAnimating()
        self.removeFromSuperview()
    }
    
    // MARK: - UI Properties
    private lazy var spinner = UIActivityIndicatorView(style: spinnerStyle)
    private weak var parentView: UIView?
}

// MARK: - Static
@available(iOS 13.0, *)
public extension Loader {
    
    static func showRootLoader() {
        UIApplication.shared.keyWindow?.showLoader()
    }
    
    static func hideRootLoader() {
        UIApplication.shared.keyWindow?.hideLoader()
    }
}
