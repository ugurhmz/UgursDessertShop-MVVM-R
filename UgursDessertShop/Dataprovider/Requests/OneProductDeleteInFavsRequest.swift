//
//  OneProductDeleteInFavsRequest.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 17.07.2022.
//

import Foundation

public struct OneProductDeleteInFavsRequest: APIDecodableResponseRequest {
    public typealias ResponseType = FavouriteResponseModel?
    public var method: RequestMethod = .delete
    public var path: String = "/favourites/delete-favproduct?itemId={productId}"
    public var parameters: RequestParameters = [:]
    
    public init(userId: String, itemId: String) {
       
        parameters["owner"] = userId
        path = "/favourites/delete-favproduct?itemId=\(itemId)"
        
    }
}
