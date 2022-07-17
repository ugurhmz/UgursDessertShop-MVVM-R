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
    
    init(router: FavouriteRouter){
        super.init(router: router)
    }
    
}

extension FavouriteViewModel {
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
}
