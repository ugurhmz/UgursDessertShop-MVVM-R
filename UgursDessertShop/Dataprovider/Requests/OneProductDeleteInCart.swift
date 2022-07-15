//
//  CartUpdateRequest.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 15.07.2022.
//

import Foundation

public struct OneProductDeleteInCart: APIDecodableResponseRequest {
    public typealias ResponseType = CartResponseModel?
    public var method: RequestMethod = .delete
    public var path: String = "/carts/delete-product?itemId={productId}"
    public var parameters: RequestParameters = [:]
    
    public init(userId: String, itemId: String) {
       
        parameters["owner"] = userId
        path = "/carts/delete-product?itemId=\(itemId)"
        
    }
}
