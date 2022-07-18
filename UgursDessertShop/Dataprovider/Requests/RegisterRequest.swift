//
//  RegisterRequest.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 6.07.2022.
//

public struct RegisterRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = SuccessResponse

    public var path: String = "/register"
    public var method: RequestMethod = .post
    public var parameters: RequestParameters = [:]
    
    public init( email: String,username: String, name: String, password: String) {
        parameters["username"] = username
        parameters["email"] = email
        parameters["password"] = password
        parameters["name"] = name
    }
    
}
