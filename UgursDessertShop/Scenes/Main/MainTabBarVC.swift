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
        
        viewControllers = [
            homeViewController,
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
    
    
    
}
