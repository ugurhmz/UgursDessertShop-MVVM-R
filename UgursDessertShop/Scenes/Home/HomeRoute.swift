//
//  HomeRoute.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 7.07.2022.
//

import UIKit

protocol HomeRoute {
    func placeOnWindowHome()
}

extension HomeRoute where Self: RouterProtocol {
    
    func placeOnWindowHome() {
        let router = HomeRouter()
        let viewModel = HomeViewModel(router: router, dataProvider: APIDataProvider())
        let viewController = HomeVC(viewModel: viewModel)
        let navigationController = MainNavigationController(rootViewController: viewController)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navigationController, transition: transition)
    }
}
