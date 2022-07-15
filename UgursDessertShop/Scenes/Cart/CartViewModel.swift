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
    var reloadMyData: VoidClosure?
    var userCartId: String?
    var fetchAgainClosure: VoidClosure?
    
    init(router: CartRouter) {
        super.init(router: router)
    }
    
    func cellItemAt(indexPath: IndexPath) -> CartCellProtocol {
        return cellItems[indexPath.row]
    }
    var cellItems: [CartCellProtocol] = []
    
}

//MARK: -
extension CartViewModel {
    func plusButtonTapped(at: IndexPath, userId: String, quanti: Int ) {
        guard let clickItemId = self.cellItems[at.item].prdId else {return }
        guard let itemQuantity = self.cellItems[at.item].stepperCount else { return}
        self.addToCartItem(userId: userId, itemId: clickItemId, quantity: quanti)
 
    }
}




//MARK: -
extension CartViewModel {
    
    func fetchUserCart(userId: String){
        let request = CartRequest(userId: userId)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                print("response", response?.id)
                
                if response?.id == nil {
                    self.currentUserCartItems = []
                    self.reloadMyData?()
                    return
                }
                
                
                
                if let usertCartId = response?.id {
                    if let responseItems = response?.items {
                       let cellItems =  responseItems.map({
                           CartCellModel( prdId: $0.productId?.id ?? "00",
                                        prdImgUrl: $0.productId?.prdImg ?? "-",
                                         prdPrice: $0.productId?.price ?? 0.0,
                                         prdTitle: $0.productId?.title ?? "-",
                                         prdDescription: $0.productId?.itemDescription ?? "-",
                                         stepperCount: $0.quantity ?? 0)
                       })
                       
                        self.currentUserCartItems = responseItems
                        self.userCartId =  usertCartId
                        self.cellItems = cellItems
                        self.reloadMyData?()
                    }
                }
                
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    //MARK: - ADD TO CART ITEM
    func addToCartItem(userId: String, itemId: String, quantity: Int){
        let request = AddToCartRequest(userId: userId, itemId: itemId, quantity: quantity)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let _ = self else { return }

            switch result {
            case .success(let response):
                print(response!)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    // DELETE ONE PRODUCT IN CART
    func deleteCartItem(userId: String, itemId: String) {
        let request = OneProductDeleteInCart(userId: userId, itemId: itemId)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                print(response!)
             

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

