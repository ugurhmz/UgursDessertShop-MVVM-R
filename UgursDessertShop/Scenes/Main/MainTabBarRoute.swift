//
//  MainTabBarRoute.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 7.07.2022.
//

import UIKit

protocol MainTabBarRoute {
    func placeOnWindowMainTabBar()
}

extension MainTabBarRoute where Self: RouterProtocol {
    
    func placeOnWindowMainTabBar() {
        let mainTabBarController = MainTabBarVC()
        let transition = PlaceOnWindowTransition()
        
        open(mainTabBarController, transition: transition)
    }
}
