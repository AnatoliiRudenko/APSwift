//
//  Coordinator.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 06.12.2021.
//

import UIKit

protocol Coordinatable: UIViewController {
    var coordinator: Coordinator? { get set }
}

open class Coordinator: NSObject {
    
    var navigationController: UINavigationController
    var popUpView: BaseView?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    // MARK: - Methods
    func goTo(vc: Coordinatable, animated: Bool = true) {
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func popSeveralScreens(_ amount: Int, animated: Bool = true) {
        let viewControllers: [UIViewController] = self.navigationController.viewControllers as [UIViewController]
        navigationController.popToViewController(viewControllers[viewControllers.count - (1 + amount)], animated: animated)
    }
    
    func openBaseWebView(urlString: String, title: String? = nil, animated: Bool = true) {
        let vc = BaseWebViewController(urlString: urlString, title: title)
        navigationController.pushViewController(vc, animated: animated)
    }
    
    func developmentScreen(title: String) {
        goTo(vc: DevelopViewController(title: title))
    }
}

// MARK: - Pop up
extension Coordinator {
    
    func showPopUp(_ popUpView: BaseView, animated: Bool = true) {
        popUpView.isHidden = true
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(popUpView)
        popUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        popUpView.setHidden(false, animated: animated)
        self.popUpView = popUpView
    }
    
    func removePopUp(animated: Bool = true) {
        self.popUpView?.setHidden(true, animated: animated) {
            self.popUpView?.removeFromSuperview()
            self.popUpView = nil
        }
    }
}
