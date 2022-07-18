//
//  RegisterViewModel.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 6.07.2022.
//

import Foundation

final class RegisterViewModel: BaseViewModel<RegisterRouter> {
    func showLoginScreen() {
        router.close()
    }
}

extension RegisterViewModel {
    
    func sendRegisterRequest(username: String, email: String, password: String, name: String) {
        showLoading?()
        dataProvider.request(for: RegisterRequest(email: email, username: username, name: name, password: password) ) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(let response):
                
                 if let respError = response.error {
                     SnackHelper.showSnack(message: respError )
                     return
                 }
                
                if let respMessage = response.message {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        SnackHelper.showSnack(message: respMessage )
                    }
                }
                
                
            case .failure(let error):
                SnackHelper.showSnack(message: error.localizedDescription )
            }
        }
    }
}
