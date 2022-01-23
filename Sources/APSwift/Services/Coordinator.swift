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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    // MARK: - Methods
    func goTo(vc: Coordinatable) {
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showPopUp(_ popUpView: UIView) {
        popUpView.isHidden = true
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(popUpView)
        popUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        popUpView.setHidden(false)
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func popSeveralScreens(_ amount: Int, animated: Bool = true) {
        let viewControllers: [UIViewController] = self.navigationController.viewControllers as [UIViewController]
        navigationController.popToViewController(viewControllers[viewControllers.count - (1 + amount)], animated: animated)
    }
    
    func developmentScreen(title: String) {
        goTo(vc: DevelopViewController(title: title))
    }
}
