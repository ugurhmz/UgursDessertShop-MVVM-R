//
//  ProductRequest.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 9.07.2022.
//

import Foundation

public struct ProductRequest: APIDecodableResponseRequest {
 
    public typealias ResponseType =  [ProductResponseModel]?
    public var method: RequestMethod = .get
    public var path: String = "/product/all"
    public var parameters: RequestParameters = [:]
    
    public init(queryByCategory: String? = "") {
        parameters["category"] = queryByCategory
    }
}
