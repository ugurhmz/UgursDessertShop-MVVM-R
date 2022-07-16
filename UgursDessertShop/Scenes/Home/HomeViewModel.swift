//
//  HomeViewModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 7.07.2022.
//

import Foundation

protocol HomeViewProtocol {
    
}


final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    
    var reloadData: VoidClosure?
    var productArray: [ProductsCellModel]?
    var categoryArray: [CategoryResponseModel]?
    
    init(router: HomeRouter) {
          super.init(router: router)
    }
    
    
}

extension HomeViewModel {
    
    func fetchAllProducts(categoryQuery: String){
        let request = ProductRequest(queryByCategory: categoryQuery)
        dataProvider.request(for: request) { [weak self]  result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
              
                guard let movieArr = response?.map({
                    return ProductsCellModel(prdId: $0.id,
                                             prdNameLbl: $0.title,
                                             prdPriceLbl: $0.price,
                                             prdImgView: $0.prdImg)
                  }) else { return}
                
                self.productArray = movieArr
                self.reloadData?()
                
           case .failure(let error):
              SnackHelper.showSnack(message:error.localizedDescription)
                
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
    
    
    
    //MARK: -  CATEGORY GET ALL
    func fetchAllCategory(){
        let request = CategoryRequest()
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                guard let categoryArr = response else {return }
                self.categoryArray = categoryArr
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
