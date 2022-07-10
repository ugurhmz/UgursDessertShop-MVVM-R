//
//  LoginModel.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 6.07.2022.
//

import Foundation

protocol LoginDataSource: AnyObject {
    var txtEmail: String? { get }
    var txtPassword: String? { get }
    
}


final class LoginModel: LoginDataSource {
    var txtEmail: String?
    var txtPassword: String?
    
    public init(txtEmail: String? = nil,
                txtPassword: String? = nil)
    {
        self.txtEmail = txtEmail
        self.txtPassword = txtPassword
    }
    
    
}
