//
//  TabBarVC.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 7.07.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = createHomeViewController()
        let cartViewController = createCartViewController()
        let favouriteViewController = createFavouriteViewController()
        
        viewControllers = [
            homeViewController,
            favouriteViewController,
            cartViewController
        ]
    }
    
    private func createHomeViewController() -> UINavigationController {
        let homeRouter = HomeRouter()
        let homeViewModel = HomeViewModel(router: homeRouter)
        let homeViewController = HomeVC(viewModel: homeViewModel)
        let navController = MainNavigationController(rootViewController: homeViewController)
        navController.tabBarItem.image = UIImage(systemName: "house")
        homeRouter.viewController = homeViewController
        return navController
    }
    
    private func createCartViewController() -> UINavigationController {
        let cartRouter = CartRouter()
        let cartViewModel = CartViewModel(router: cartRouter)
        let cartViewController = CartVC(viewModel: cartViewModel)
        let navController = MainNavigationController(rootViewController: cartViewController)
        navController.tabBarItem.image = UIImage(systemName: "cart")
        cartRouter.viewController = cartViewController
        return navController
    }
    
    
    
    private func createFavouriteViewController() -> UINavigationController {
        let favRouter = FavouriteRouter()
        let favViewModel = FavouriteViewModel(router: favRouter)
        let favViewController = FavouritesVC(viewModel: favViewModel)
        let navController = MainNavigationController(rootViewController: favViewController)
        navController.tabBarItem.image = UIImage(systemName: "heart")
        favRouter.viewController = favViewController
        return navController
    }
    
}
