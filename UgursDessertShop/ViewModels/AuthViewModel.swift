//
//  AuthViewModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 27.06.2022.
//


import Foundation

typealias stringHandler = (String?) -> Void



final class AuthViewModel{
    
    var appDao: UserDao
    
    var webService: WebService
    var errClosure: StringClosure?
    var dataClosure: VoidClosure?
    var currentUser: LoginResponse?
    var userInfos: LoginResponse?
    var userCartItemsArr: [CartProductResponse]?
    var cartIDStr: String?
    
    init() {
        webService = WebService()
        appDao =  UserDao()
    }
    
    
    // LOGIN
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
            if let result = result {
                self.appDao.save(userId: result.id ?? "0", userToken: result.accessToken ?? "")
            }
            self.currentUser = result
            self.dataClosure?()
        }
    }
    
    func currentUserId() -> [String] {
        let currentUserId = appDao.fetchUser()
        return currentUserId
    }
    
    // REGISTER
    func fetchRegister(username: String, email: String, password: String) {
        let registerModel = RegisterModel(username: username, email: email, password: password)
        webService.callingRegisterAPI(register: registerModel) { [weak self] (result,err)  in
            guard let self = self else { return }
            
            guard err == nil else {
                if let myerr = err{
                    self.errClosure?(myerr)
                }
                return
            }
            
            self.dataClosure?()
        }
    }
    
    // GET USER
    func fetchCurrentUser(userId: String, token: String) {
        webService.callingUser(userId: userId, userToken: token) { [weak self] (result,err)  in
            guard let self = self else { return }
           
            guard err == nil else {
                if let myerr = err{
                    self.errClosure?(myerr)
                }
                return
            }
            self.userInfos = result
            self.dataClosure?()
        }
    }
    
    // USER CART
    func fetchUsertCartItems(userId: String, token: String){

        webService.callingUserCartItems(userId: userId, userToken: token) { [weak self] (result,err)  in
            guard let self = self else { return }
           
            guard err == nil else {
                if let myerr = err{
                    self.errClosure?(myerr)
                }
                return
            }
            print("CARTID", result?.id)
            guard let cartID = result?.id else {return}
            guard let items = result?.items else {return }
            self.cartIDStr = cartID
            self.userCartItemsArr = items
            self.dataClosure?()
        }
    }
}
