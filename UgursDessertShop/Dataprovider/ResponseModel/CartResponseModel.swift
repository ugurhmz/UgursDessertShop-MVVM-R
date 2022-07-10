
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cartResponseModel = try? newJSONDecoder().decode(CartResponseModel.self, from: jsonData)

import Foundation

// MARK: - CartResponseModel
public struct CartResponseModel: Codable {
    var id: String?
    var owner: Owner?
    var items: [Item]?
    var createdAt, updatedAt: String?


    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case owner
        case items
        case createdAt
        case updatedAt
   
    }
}

// MARK: - Item
public struct Item: Codable {
    var productId: ItemID?
    var quantity: Int?
    var id: String?

    enum CodingKeys: String, CodingKey {
        case productId = "itemId"
        case quantity
        case id = "_id"
    }
}

//// MARK: - ItemID
public struct ItemID: Codable {
    var id: String?
    var title:String?
    var itemDescription:String?
    var prdImg: String?
    var categories: [Category]?
    var size: String?
    var voting: Int?
    var price: Double?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case itemDescription = "description"
        case prdImg
        case size
        case voting
        case price
        case createdAt
        case updatedAt
        case categories
    }
}

//
// MARK: - Owner
public struct Owner: Codable {
    var id, username, email: String?
    var isAdmin: Bool?
    var userImg, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
        case email, isAdmin, userImg, createdAt
    }
}
