//
//  AddToFavRequest.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 17.07.2022.
//

import Foundation

public struct AddToFavRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = FavouriteResponseModel?
    public var method: RequestMethod = .post
    public var path: String = "/favourites"
    public var parameters: RequestParameters = [:]
    
    public init(userId: String, itemId: String) {
        parameters["owner"] = userId
        parameters["itemId"] = itemId
    }
}
