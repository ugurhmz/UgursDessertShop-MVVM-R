//
//  FavouriteViewModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 16.07.2022.
//

import Foundation

final class FavouriteViewModel: BaseViewModel<FavouriteRouter> {
    var reloadDataClosure: VoidClosure?
    var userFavItems: [FavouriteCellProtocol] = [] 
    var deleteClosure: VoidClosure?
    
    init(router: FavouriteRouter){
        super.init(router: router)
    }
    
}

extension FavouriteViewModel {
    
    //MARK: -  USER  FAV ITEMS
    func fetchUserFavItems(userId: String){
        let request = FavouriteRequest(userId: userId)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }

                switch result {
                case .success(let response):
                    if let userFavId = response?.id {
                        
                        if let responseItems = response?.items {
                            let cellFavItems = responseItems.map({
                                FavouriteCellModel( prdId: $0.productId?.id ?? "00",
                                                    prdImgUrl: $0.productId?.prdImg ?? "-",
                                                     prdPrice: $0.productId?.price ?? 0.0,
                                                     prdTitle: $0.productId?.title ?? "-",
                                                     prdDescription: $0.productId?.itemDescription ?? "-")
                            })
                            
                            
                            self.userFavItems = cellFavItems
                            self.reloadDataClosure?()
                           
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    
    //MARK: - DELETE ONE ITEM IN FAVS
    func deleteFavItem(userId: String, itemId: String) {
           let request = OneProductDeleteInFavsRequest(userId: userId, itemId: itemId)
    
           dataProvider.request(for: request) { [weak self] (result) in
               guard let _ = self else { return }
               DispatchQueue.main.async {
                   NotificationCenter.default.post(name: NSNotification.Name("refresh"), object: nil)
               }
               switch result {
                 
               case .success( _):
                  
                   print("abc")

               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
}
