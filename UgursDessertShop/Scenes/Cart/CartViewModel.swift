//
//  CartViewModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 9.07.2022.
//

import Foundation
import KeychainSwift


final class CartViewModel: BaseViewModel<CartRouter> {
    private let keychain = KeychainSwift()
    var currentUserCartItems: [Item]?
    var reloadDataClosure: VoidClosure?
    
    init(router: CartRouter) {
        super.init(router: router)
    }
    
    
}

extension CartViewModel {
    
    func fetchUserCart(userId: String){
        let request = CartRequest(userId: userId)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                if let _ = response?.id {
                    if let responseItems = response?.items {
                        self.currentUserCartItems = responseItems
                        self.reloadDataClosure?()
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
