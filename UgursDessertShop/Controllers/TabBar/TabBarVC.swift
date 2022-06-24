//
//  TabBarVC.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 24.06.2022.
//

import UIKit

class TabBarVC: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeTab = HomeVC()
        homeTab.tabBarItem.image = UIImage(systemName: "house")
        let nav1 = UINavigationController(rootViewController: homeTab)


        let favouritesTab = FavouritesVC()
        favouritesTab.tabBarItem.image = UIImage(systemName: "heart.fill")
        let nav2 = UINavigationController(rootViewController: favouritesTab)
     
       let cartTab = CartVC()
       cartTab.tabBarItem.image = UIImage(systemName: "cart.fill")
       let nav3 = UINavigationController(rootViewController: cartTab)
       tabBar.tintColor = FavColor
       
             
             
       viewControllers = [nav1, nav2, nav3]
       tabBar.layer.cornerRadius = 35
       tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       tabBar.backgroundColor = TabBarBG
       tabBar.layer.masksToBounds = true
  
        
    }
    

}
