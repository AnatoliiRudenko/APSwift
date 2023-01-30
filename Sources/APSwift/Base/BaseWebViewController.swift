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
    private var titleToSet: String?
    
    // MARK: - Life Cycle
    public init(urlString: String?, title: String? = nil) {
        self.urlString = urlString
        self.titleToSet = title
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(url: URL, title: String? = nil) {
        self.url = url
        self.titleToSet = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = createConfiguration()
        setUpWebView(configuration: configuration)
        load()
        setupComponents()
    }
    
    open func setupComponents() {}
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = titleToSet
    }
    
    // MARK: - Web view config
    open func createConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.allowsInlineMediaPlayback = true
        configuration.preferences.javaScriptEnabled = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        return configuration
    }
    
    open func setUpWebView(configuration: WKWebViewConfiguration) {
        webView = WKWebView(frame: CGRect(), configuration: configuration)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leftAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            webView.topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.rightAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            webView.bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Load URL
    open func load() {
        guard let url = getURL() else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}

// MARK: - Supporting methods
private extension BaseWebViewController {
    
    func getURL() -> URL? {
        guard let link = urlString,
              let encodedLink = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedLink)
        else { return self.url }
        return url
    }
}

extension BaseWebViewController: WKNavigationDelegate {}
