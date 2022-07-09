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
    
    init(router: CartRouter) {
          super.init(router: router)
    }
    
    
}

extension CartViewModel {
    
    func fetchUserCart(email: String, userId: String){
        guard keychain.get(Keychain.token) != nil else {
            let request = CartRequest(email: email, userId: userId)
            dataProvider.request(for: request) { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return 
        }
        
    }
}
