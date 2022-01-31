//
//  BaseWebViewController.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 21.12.2021.
//

import UIKit
import WebKit

open class BaseWebViewController: UIViewController {
    
    var webView: WKWebView!
    private var urlString: String?
    private var url: URL?
    
    var titleToSet: String?
    
    // MARK: - Life Cycle
    init(urlString: String?, title: String? = nil) {
        self.urlString = urlString
        self.titleToSet = title
        super.init(nibName: nil, bundle: nil)
    }
    
    init(url: URL, title: String? = nil) {
        self.url = url
        self.titleToSet = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        addWebView()
        load()
        setupComponents()
    }
    
    func setupComponents() {}
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = titleToSet
    }
    
    // MARK: - Web view config
    private func addWebView() {
        let configuration = WKWebViewConfiguration()
        configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.allowsInlineMediaPlayback = true
        configuration.preferences.javaScriptEnabled = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        webView = WKWebView(frame: CGRect(), configuration: configuration)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leftAnchor
                .constraint(equalTo: self.view.leftAnchor),
            webView.topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.rightAnchor
                .constraint(equalTo: self.view.rightAnchor),
            webView.bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Load URL
    func load() {
        guard let url = getURL() else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    private func getURL() -> URL? {
        guard let link = urlString,
              let url = URL(string: link)
        else { return self.url }
        return url
    }
}

extension BaseWebViewController: WKNavigationDelegate {}
