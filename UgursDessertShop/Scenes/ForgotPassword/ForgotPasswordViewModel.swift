//
//  ForgotPasswordViewModel.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 6.07.2022.
//

import Foundation

final class ForgotPasswordViewModel: BaseViewModel<ForgotPasswordRouter> {
    
    func showLoginScreen() {
        router.close()
    }
}

extension ForgotPasswordViewModel {
    func passwordReset(email: String) {
        showLoading?()
        let request = ResetPasswordRequest(email: email)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(let response):
                if let myres = response?.msg {
                    SnackHelper.showSnack(message: myres )
                    return
                }
                
                if let myres = response?.message {
                    SnackHelper.showSnack(message: myres )
                    return
                }
                
                if let oter = response?.error {
                    SnackHelper.showSnack(message: oter )
                    return
                }
                print("sucess")
            case .failure(let error):
                SnackHelper.showSnack(message: error.localizedDescription )
            }
        }
    }
}
