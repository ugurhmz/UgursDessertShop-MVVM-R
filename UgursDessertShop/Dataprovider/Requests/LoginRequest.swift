//
//  LoginRequest.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 10.07.2022.
//

import Foundation

public struct LoginRequest: APIDecodableResponseRequest {
    public typealias ResponseType = LoginResponseModel?
    public var method: RequestMethod = .post
    public var path: String = "/user/login"
    public var parameters: RequestParameters = [:]
    
    public init(email: String, password: String) {
        parameters["email"] = email
        parameters["password"] = password
    }
}
