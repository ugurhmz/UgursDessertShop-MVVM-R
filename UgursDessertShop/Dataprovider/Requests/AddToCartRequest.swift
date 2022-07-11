//
//  AddToCartRequest.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 10.07.2022.
//

import Foundation

public struct AddToCartRequest: APIDecodableResponseRequest {
    public typealias ResponseType = CartResponseModel?
    public var method: RequestMethod = .post
    public var path: String = "/carts"
    public var parameters: RequestParameters = [:]
    
    public init(userId: String, itemId: String, quantity: Int) {
        parameters["owner"] = userId
        parameters["itemId"] = itemId
        parameters["quantity"] = quantity
    }
}
