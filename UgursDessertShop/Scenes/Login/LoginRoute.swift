//
//  LoginRoute.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 5.07.2022.
//

import UIKit

protocol LoginRoute {
    func placeOnLogin()
}

extension LoginRoute where Self: RouterProtocol {
    
    func placeOnLogin() {
           let router = LoginRouter()
           let viewModel = LoginViewModel(router: router)
           let viewController = LoginVC(viewModel: viewModel)
           let navigationController = MainNavigationController(rootViewController: viewController)
           
           let transition = PlaceOnWindowTransition()
           router.viewController = viewController
           router.openTransition = transition
           
           open(navigationController, transition: transition)
       }
}

