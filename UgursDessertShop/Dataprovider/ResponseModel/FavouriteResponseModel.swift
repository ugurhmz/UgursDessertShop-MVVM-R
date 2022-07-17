//
//  FavouriteResponseModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 16.07.2022.
//
import Foundation

// MARK: - FavouriteResponseModel
public struct FavouriteResponseModel: Codable {
    var id: String?
    var owner: Owner?
    var items: [Item]?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case owner, items, createdAt, updatedAt
       
    }
}

