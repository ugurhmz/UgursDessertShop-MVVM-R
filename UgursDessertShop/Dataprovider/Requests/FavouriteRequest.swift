//
//  FavouriteRequest.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 17.07.2022.
//

import Foundation

public struct FavouriteRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = FavouriteResponseModel?
    public var method: RequestMethod = .get
    public var path: String = "/favourites/user-id/{userId}"
    public var parameters: RequestParameters = [:]
    
    public init(userId: String) {
        path = "/favourites/user-id/\(userId)"
        
    }
}
