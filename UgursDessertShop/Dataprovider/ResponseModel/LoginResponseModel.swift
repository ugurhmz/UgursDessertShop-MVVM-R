//
//  LoginResponseModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 10.07.2022.
//

import Foundation

public struct LoginResponseModel: Codable {
    let id, email, username, name: String?
    let role: String?
    let activationToken: String?
    let isVerified: Bool?
    let createdAt, updatedAt, loginToken: String?
    let msg: String?
    let error: String?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case username
        case name
        case role
        case activationToken
        case isVerified
        case createdAt
        case updatedAt
        case loginToken
        case msg
        case error
    }
}

