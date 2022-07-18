//
//  LogoutRequest.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 6.07.2022.
//

import Foundation

public struct LogoutRequest: APIDecodableResponseRequest {
    public typealias ResponseType = LoginResponseModel?
    public var method: RequestMethod = .post
    public var path: String = "/logout"
    
    public init() {}
}
