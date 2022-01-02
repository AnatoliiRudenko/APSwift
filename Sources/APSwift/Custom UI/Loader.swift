//
//  Loader.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import UIKit

class Loader: UIView {
    
    // MARK: - Props
    var size: CGFloat = 80
    var bgAlpha = 0.7
    var bgColor: UIColor = .white
    var spinnerStyle: UIActivityIndicatorView.Style = .large
    
    private lazy var spinner = UIActivityIndicatorView(style: spinnerStyle)
    private var loadingView: UIView = UIView()
    private weak var parentView: UIView?
    
    // MARK: - Init
    convenience init(parentView: UIView) {
        self.init(frame: parentView.bounds, parentView: parentView)
    }
    
    init(frame: CGRect, parentView: UIView) {
        self.parentView = parentView
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
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
        self.loadingView.frame = parentView.bounds
        self.loadingView.backgroundColor = bgColor
        self.loadingView.alpha = bgAlpha
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        self.spinner = UIActivityIndicatorView(style: .large)
        self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: size, height: size)
        self.spinner.center = CGPoint(x: self.loadingView.bounds.size.width * 0.5, y: self.loadingView.bounds.size.height * 0.5)
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        
        self.loadingView.addSubview(self.spinner)
        parentView.addSubview(self.loadingView)
        
        NSLayoutConstraint.activate([
            self.spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            self.spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            self.loadingView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            self.loadingView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        ])
        
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
}
