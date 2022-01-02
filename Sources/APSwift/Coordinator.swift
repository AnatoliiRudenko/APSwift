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
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func developmentScreen(title: String) {
        goTo(vc: DevelopViewController(title: title))
    }
}
