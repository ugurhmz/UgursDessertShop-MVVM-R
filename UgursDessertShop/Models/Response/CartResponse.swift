//
//  CartResponse.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 28.06.2022.
//

import Foundation


// MARK: - Welcome
struct CartResponse: Codable {
    let id, userID: String?
    let products: [CartProductResponse]?
    let createdAt, updatedAt: String?


    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case products, createdAt, updatedAt
    }
}

// MARK: - Product
struct CartProductResponse: Codable {
    let productID: String?
    let quantity: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case quantity
        case id = "_id"
    }
}
