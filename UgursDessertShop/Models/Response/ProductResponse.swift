//
//  ProductResponse.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 28.06.2022.
//

import Foundation

struct ProductResponse: Codable {
    let id, title, description, prdImg: String?
    let categories: [String]?
    let size: String?
    let voting: Int?
    let price: Double?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description
        case prdImg, categories, size, voting, price, createdAt, updatedAt
    }
}

