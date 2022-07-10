//
//  LoginResponseModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 10.07.2022.
//

import Foundation

// MARK: - LoginResponseModel
public struct LoginResponseModel: Codable {
    var id, username, email: String?
    var isAdmin: Bool?
    var userImg, createdAt, updatedAt: String?
    var accessToken, loginMsg: String?
    var error, msg: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, email, isAdmin, userImg, createdAt, updatedAt
        case accessToken, loginMsg, msg, error
    }
}
