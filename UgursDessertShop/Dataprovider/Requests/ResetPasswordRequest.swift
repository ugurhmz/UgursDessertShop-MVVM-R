//
//  ResetPasswordRequest.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 6.07.2022.
//

import Foundation

public struct ResetPasswordRequest: APIDecodableResponseRequest {
    public typealias ResponseType = SuccessResponse?
    public var method: RequestMethod = .post
    public var path: String = "/reset-password"
    public var parameters: RequestParameters = [:]
    
    public init(email: String) {
        parameters["email"] = email
    }
}
