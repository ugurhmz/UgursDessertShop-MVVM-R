//
//  ForgotPasswordRoute.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 6.07.2022.
//

import Foundation

protocol ForgotPasswordRoute {
    func pushPasswordResetVC()
}

extension ForgotPasswordRoute where Self: RouterProtocol {
    
    func pushPasswordResetVC() {
        let router = ForgotPasswordRouter()
        let viewModel = ForgotPasswordViewModel(router: router)
        let viewController = ForgotPasswordVC(viewModel: viewModel)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
