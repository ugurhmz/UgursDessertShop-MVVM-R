//
//  CategoryResponseModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 16.07.2022.
//

import Foundation


public struct CategoryResponseModel: Codable {
    var id, name, categoryImg, createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, categoryImg, createdAt, updatedAt
    }
}


