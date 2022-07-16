//
//  CategoryRequest.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 16.07.2022.
//

import Foundation

public struct CategoryRequest: APIDecodableResponseRequest {
 
    public typealias ResponseType =  [CategoryResponseModel]?
    public var method: RequestMethod = .get
    public var path: String = "/category/get-all"
    public var parameters: RequestParameters = [:]
    
    public init() {
       
    }
}
