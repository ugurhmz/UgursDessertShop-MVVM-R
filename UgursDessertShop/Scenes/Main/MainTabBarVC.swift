//
//  TabBarVC.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 24.06.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = createHomeViewController()
      //  let favoritesViewController = createFavoritesViewController()
        
        viewControllers = [
            homeViewController,
            //favoritesViewController
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
    
//    private func createFavoritesViewController() -> UINavigationController {
//        let favoritesRouter = FavoritesRouter()
//        let favoritesViewModel = FavoritesViewModel(router: favoritesRouter)
//        let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)
//        let navController = MainNavigationController(rootViewController: favoritesViewController)
//        navController.tabBarItem.image = .icHeart
//        favoritesRouter.viewController = favoritesViewController
//        return navController
//    }
    

}
