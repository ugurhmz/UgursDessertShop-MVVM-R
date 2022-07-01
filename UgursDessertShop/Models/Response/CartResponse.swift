//
//  CartResponse.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 28.06.2022.
//
import Foundation

// MARK: - Welcome
struct CartResponse: Codable {
    let id: String?
    let owner: UserCart?
    let items: [CartProductResponse]?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case owner = "owner"
        case items, createdAt, updatedAt
    }
}

// MARK: - Product
struct CartProductResponse: Codable {
    let itemId: Prd?
    let quantity: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case itemId, quantity
        case id = "_id"
    }
}

// MARK: - Prd
struct Prd: Codable {
    let id, title, prdDescription, prdImg: String?
    let categories: [CartPrdCategory]?
    let size: String?
    let voting: Int?
    let price: Double?
    let createdAt, updatedAt: String?
 

    enum CodingKeys: String, CodingKey {
        case id  = "_id"
        case title
        case prdDescription = "description"
        case prdImg, categories, size, voting, price, createdAt, updatedAt
       
    }
}

// MARK: - Category
struct CartPrdCategory: Codable {
    let id, name, categoryImg, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, categoryImg, createdAt
    }
}

// MARK: - UserID
struct UserCart: Codable {
    let id, username, email: String?
    let isAdmin: Bool?
    let userImg, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, email, isAdmin, userImg, createdAt
    }
}

