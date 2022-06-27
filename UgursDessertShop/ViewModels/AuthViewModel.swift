//
//  AuthViewModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 27.06.2022.
//

import Foundation

final class AuthViewModel {
    var webService: WebService
    var errClosure: StringClosure?
    var dataClosure: VoidClosure?
    var currentUser: LoginResponse?
    
    init() {
        webService = WebService()
    }
    
    func fetchLogin(email: String, password: String) {
        let loginModel = LoginModel(email: email, password: password)
        webService.callingLoginAPI(login: loginModel) { [weak self] (result,err)  in
            guard let self = self else { return }
            
            guard err == nil else {
                if let myerr = err{
                    self.errClosure?(myerr)
                }
                return
            }
            
            self.currentUser = result
            self.dataClosure?()
        }
    }
}
