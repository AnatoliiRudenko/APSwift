//
//  Loader.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import UIKit

@available(iOS 13.0, *)
open class Loader: UIView {
    
    // MARK: - Props
    public var size: CGFloat = 80
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
        guard loadingView.superview == nil else { return }
        guard Thread.isMainThread else {
            return DispatchQueue.main.async {
                self.show()
            }
        }
        
        guard let parentView = parentView else { return }
        self.loadingView = UIView()
        self.loadingView.backgroundColor = bgColor
        
        self.spinner = UIActivityIndicatorView(style: spinnerStyle)
        if let spinnerColor = spinnerColor {
            self.spinner.color = spinnerColor
        }
        
        self.loadingView.addSubview(self.spinner)
        parentView.addSubview(self.loadingView)
        
        self.spinner.snp.makeConstraints { make in
            make.center.equalTo(self.loadingView.snp.center)
            make.size.equalTo(size)
        }
        self.loadingView.snp.makeConstraints { make in
            make.edges.equalTo(parentView.snp.edges)
        }
        
        self.spinner.startAnimating()
        parentView.bringSubviewToFront(self)
    }

    open func hide() {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async {
                self.hide()
            }
        }
        self.spinner.stopAnimating()
        self.loadingView.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    // MARK: - UI Properties
    private lazy var spinner = UIActivityIndicatorView(style: spinnerStyle)
    private var loadingView: UIView = UIView()
    private weak var parentView: UIView?
}
