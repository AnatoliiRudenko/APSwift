//
//  Loader.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import UIKit

open class Loader: UIView {
    
    // MARK: - Props
    var size: CGFloat = 80
    var bgColor: UIColor = .white.withAlphaComponent(0.7)
    var spinnerStyle: UIActivityIndicatorView.Style = .large
    var spinnerColor: UIColor?
    
    // MARK: - Init
    convenience init(parentView: UIView) {
        self.init(frame: parentView.bounds, parentView: parentView)
    }
    
    init(frame: CGRect, parentView: UIView) {
        self.parentView = parentView
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func show() {
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
            make.size.equalTo(80)
        }
        self.loadingView.snp.makeConstraints { make in
            make.edges.equalTo(parentView.snp.edges)
        }
        
        self.spinner.startAnimating()
    }

    func hide() {
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
