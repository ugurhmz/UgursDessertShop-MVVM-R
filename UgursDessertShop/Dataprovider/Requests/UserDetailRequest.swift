//
//  UserDetailRequest.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 16.07.2022.
//

import Foundation

public struct UserDetailRequest: APIDecodableResponseRequest {
    public typealias ResponseType = UserDetailResponseModel?
    public var method: RequestMethod = .get
    public var path: String = "/user/{userId}"
    public var parameters: RequestParameters = [:]
    
    public init(userId: String) {
        path = "/user/\(userId)"
    }
}
