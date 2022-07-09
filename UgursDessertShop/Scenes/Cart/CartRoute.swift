//
//  CartRoute.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 9.07.2022.
//

import Foundation

protocol CartRoute {
    func placeOnCart()
}

extension CartRoute where Self: RouterProtocol {
    
    func placeOnCart() {
        let router = CartRouter()
        let viewModel = CartViewModel(router: router)
        let viewController = CartVC(viewModel: viewModel)
        let navigationController = MainNavigationController(rootViewController: viewController)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navigationController, transition: transition)
    }
}
