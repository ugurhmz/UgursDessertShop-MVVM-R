//
//  LoginResponse.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 26.06.2022.
//

import Foundation

struct LoginResponse: Codable {
    let id, username, email: String?
    let isAdmin: Bool?
    let userImg, createdAt, updatedAt: String?
    let accessToken, loginMsg: String?
   
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, email, isAdmin, userImg, createdAt, updatedAt
        case accessToken, loginMsg
    }
   
}
