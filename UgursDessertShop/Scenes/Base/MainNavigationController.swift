//
//  MainNavigationController.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 5.07.2022.
//


import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureContents()
    }

    private func configureContents() {

        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            navigationBar.backgroundColor = .white
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
            
        }
        navigationBar.backItem?.backBarButtonItem?.setTitlePositionAdjustment(.init(horizontal: 0, vertical: -13), for: .default)
    }
  
    #if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
    #endif
    
}
