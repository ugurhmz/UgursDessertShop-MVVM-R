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
                    return ProductsCellModel(prdNameLbl: $0.title,
                                             prdPriceLbl: $0.price,
                                             prdImgView: $0.prdImg)
                  }) else { return}
                
                print("movieArr", movieArr)
                self.productArray = movieArr
                self.reloadData?()
                
           case .failure(let error):
              // SnackHelper.showSnack(message:error.localizedDescription)
                print("ERR",error.localizedDescription)
          }
        }
    }
}
