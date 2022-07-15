//
//  CartUpdateRequest.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 15.07.2022.
//

import Foundation

public struct CartUpdateRequest: APIDecodableResponseRequest {
    public typealias ResponseType = CartResponseModel?
    public var method: RequestMethod = .put
    public var path: String = "/carts/update/cartId/{cartId}"
    public var parameters: RequestParameters = [:]
    
    public init(userId: String, itemId: String, quantity: Int, cartId: String) {
       
        parameters["owner"] = userId
        parameters["itemId"] = itemId
        parameters["quantity"] = quantity
        path = "/carts/update/cartId/\(cartId)"
        
    }
}
