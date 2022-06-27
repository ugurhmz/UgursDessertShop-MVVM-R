//
//  RegisterResponse.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 27.06.2022.
//

import Foundation


struct RegisterResponse: Codable {
    let username, email, password: String?
    let isAdmin: Bool?
    let userImg, id, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case username, email, password, isAdmin, userImg
        case id = "_id"
        case createdAt, updatedAt
    }
}
