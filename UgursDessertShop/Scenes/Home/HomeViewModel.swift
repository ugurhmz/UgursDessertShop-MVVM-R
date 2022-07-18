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
    var userDetail: UserDetailResponseModel?
    var userDetailClosure: VoidClosure?
    var userFavItems: [ProductsCellModel] = []
    var favDataClosure: VoidClosure?
    
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
                guard let productArr = response?.map({
                    return ProductsCellModel(prdId: $0.id,
                                             prdNameLbl: $0.title,
                                             prdPriceLbl: $0.price,
                                             prdImgView: $0.prdImg)
                  }) else { return}
                
                self.productArray = productArr
                self.reloadData?()
                
           case .failure(let error):
                
              SnackHelper.showSnack(message:"There are no products in the category!")
                
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
               
                var firstObj =  CategoryResponseModel(id: "-",
                                                    name: "All",
                                                    categoryImg: "",
                                                    createdAt: "",
                                                    updatedAt: "")
                
                self.categoryArray = categoryArr
                self.categoryArray?.insert(firstObj, at: 0)
               
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCurrentUserDetail(userId: String){
        let request = UserDetailRequest(userId: userId)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
               print("userdetail", response!)
                guard let userDetail = response else { return }
                self.userDetail = userDetail
                self.userDetailClosure?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    //MARK: - ADD TO FAV ITEM
    func addToFavItem(userId: String,
                      itemId: String)
    {
        let request = AddToFavRequest(userId: userId, itemId: itemId)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let _ = self else { return }

            switch result {
            case .success(let response):
                print("prdEklendi",response!)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    //MARK: -  USER  FAV ITEMS
    func fetchUserFavItems(userId: String){
        let request = FavouriteRequest(userId: userId)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }

                switch result {
                case .success(let response):
                    
                    if response?.id == nil {
                        self.userFavItems = []
                        self.favDataClosure?()
                        return
                    }
                    
                    if let userFavId = response?.id {
                        
                        if let responseItems = response?.items {
                            let cellFavItems = responseItems.map({
                                return ProductsCellModel(prdId: $0.productId?.id,
                                                         prdNameLbl: $0.productId?.title,
                                                         prdPriceLbl: $0.productId?.price,
                                                         prdImgView: $0.productId?.prdImg)
                            })
                            
                            
                            self.userFavItems = cellFavItems
                            self.favDataClosure?()
                           
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
