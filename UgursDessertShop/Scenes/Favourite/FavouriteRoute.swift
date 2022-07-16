//
//  FavouriteRoute.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 16.07.2022.
//

import Foundation

protocol FavouriteRoute {
    func placeOnFavourite()
}

extension FavouriteRoute where Self: RouterProtocol {
    
    func placeOnFavourite() {
        let router = FavouriteRouter()
        let viewModel = FavouriteViewModel(router: router)
        let viewController = FavouritesVC(viewModel: viewModel)
        let navigationController = MainNavigationController(rootViewController: viewController)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navigationController, transition: transition)
    }
}
