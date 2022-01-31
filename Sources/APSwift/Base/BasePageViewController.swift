//
//  BasePageViewControllerView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 18.01.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import UIKit

class BasePageViewController: UIPageViewController {
    
    // MARK: - Props
    var pages = [UIViewController]() {
        didSet {
            setContent()
        }
    }
    
    var willTransitionToIndex: DataClosure<Int>?
    var didTransitionToIndex: DataClosure<Int>?
    
    var showsControls = true
    
    var currentIndex: Int {
        pages.firstIndex(of: presentedViewController ?? UIViewController()) ?? 0
    }
    
    var initialIndex = 0 {
        didSet {
            guard (0...pages.count - 1).contains(initialIndex) else { return initialIndex = 0 }
            setContent()
        }
    }
    
    var scrollView: UIScrollView {
        view.subviews.compactMap { $0 as? UIScrollView }.first ?? UIScrollView()
    }
    
    // MARK: - Init
    convenience init(pages: [UIViewController], initialIndex: Int = 0) {
        self.init(pages: pages, transitionStyle: .scroll, navigationOrientation: .horizontal, initialIndex: initialIndex)
    }
    
    init(pages: [UIViewController],
         transitionStyle style: UIPageViewController.TransitionStyle,
         navigationOrientation: UIPageViewController.NavigationOrientation,
         options: [UIPageViewController.OptionsKey: Any]? = nil,
         initialIndex: Int = 0) {
        self.pages = pages
        self.initialIndex = initialIndex
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponents()
    }
    
    // MARK: - Methods
    func setupComponents() {
        dataSource = self
        delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        setContent()
    }
    
    func scrollTo(index: Int) {
        guard (0...pages.count - 1).contains(index) else { return }
        scrollTo(vc: pages[index])
    }
    
    func scrollTo(vc: UIViewController) {
        guard pages.contains(vc) else { return }
        let destinationIndex = pages.firstIndex(of: vc) ?? 0
        let direction: UIPageViewController.NavigationDirection = destinationIndex > currentIndex ? .forward : .reverse
        setViewControllers([vc], direction: direction, animated: true, completion: nil)
    }
}

extension BasePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else { return pages[initialIndex] }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1
        guard nextIndex < pages.count else { return pages[initialIndex] }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        willTransitionToIndex?(pages.firstIndex(of: pendingViewControllers.first ?? UIViewController()) ?? 0)
        // иногда крашит
//        self.setViewControllers(self.viewControllers, direction: .forward, animated: false, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        didTransitionToIndex?(pages.firstIndex(of: pageViewController.viewControllers?.first ?? UIViewController()) ?? 0)
    }
}

extension BasePageViewController: UIPageViewControllerDelegate {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        showsControls ? pages.count : 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = pageViewController.viewControllers?.first,
              let firstVCIndex = pages.firstIndex(of: firstVC)
        else { return 0 }
        return firstVCIndex
    }
}

// MARK: - Supporting Methods
private extension BasePageViewController {
    
    func setContent() {
        setViewControllers([pages[initialIndex]], direction: .forward, animated: false, completion: nil)
    }
}
