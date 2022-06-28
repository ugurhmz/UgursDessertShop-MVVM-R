//
//  HomeViewModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 28.06.2022.
//

import Foundation

final class HomeViewModel {
    
    var appDao: UserDao
    
    var webService: WebService
    var errClosure: StringClosure?
    var prdClosure: VoidClosure?
    var productArray: [ProductResponse] = []
    
    init() {
        webService = WebService()
        appDao =  UserDao()
    }
    
    // FETCH PRODUCTS
    func fetchProducts(){
        webService.callingAllProducts { [weak self] (result, err) in
            guard let self = self else {return }
            
            guard err == nil else {
                if let myerr = err{
                    self.errClosure?(myerr)
                }
                return
            }
            if let myarr = result {
                self.productArray = myarr
                self.prdClosure?()
            }
            
        }
    }
    
  
}
