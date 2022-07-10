//
//  CartRequest.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 9.07.2022.
//

import Foundation

public struct CartRequest: APIDecodableResponseRequest {
    public typealias ResponseType = CartResponseModel?
    public var method: RequestMethod = .get
    public var path: String = "/carts/user-id/{userId}"
    public var parameters: RequestParameters = [:]
    
    public init(userId: String) {
        path = "/carts/user-id/\(userId)"
        
    }
}
