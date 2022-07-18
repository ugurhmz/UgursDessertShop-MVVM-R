//
//  LoginViewModel.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 6.07.2022.
//

import Foundation
import SwiftEntryKit
import KeychainSwift

final class LoginViewModel: BaseViewModel<LoginRouter> {
    
    let keychain = KeychainSwift()
    var currentUser: LoginResponseModel?
    var reloadDataClosure: VoidClosure?
    
    
    func pushHome() {
        router.placeOnWindowMainTabBar()
    }
    
    func showRegisterOnWindow() {
        router.pushRegister()
    }
    
    func pushForgotPassword(){
        router.pushPasswordResetVC()
    }
    
}

extension LoginViewModel {
    
    func sendLoginRequest(email: String, password: String ){
        showActivityIndicatorView?()
        let request = LoginRequest(email: email, password: password)
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
                
            case .success(let response):
                
                if let myres = response?.msg {
                    SnackHelper.showSnack(message: myres )
                    return
                }
                
                if let oter = response?.error {
                    SnackHelper.showSnack(message: oter )
                    return
                }
                if let loginToken = response?.loginToken {
                    
                    if let userid = response?.id {
                        self.keychain.set(userid, forKey: "userid")
                    }
                    self.keychain.set(loginToken, forKey: Keychain.token)
                    self.currentUser = response
                    self.reloadDataClosure?()
                    self.pushHome()
                }
                
                
            case .failure(let error):
                SnackHelper.showSnack(message: error.localizedDescription )
            }
        }
    }
}
