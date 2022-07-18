//
//  RegisterRoute.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 6.07.2022.
//

protocol RegisterRoute {
    func pushRegister()
    
}

extension RegisterRoute where Self: RouterProtocol {
    
    func pushRegister() {
        let router = RegisterRouter()
        let viewModel = RegisterViewModel(router: router)
        let viewController = RegisterVC(viewModel: viewModel)
        let transition = PushTransition()
        
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
