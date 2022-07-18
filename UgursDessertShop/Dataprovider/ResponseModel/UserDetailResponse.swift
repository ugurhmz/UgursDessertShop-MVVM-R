//
//  UserDetailResponse.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 16.07.2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userDetailResponseModel = try? newJSONDecoder().decode(UserDetailResponseModel.self, from: jsonData)

import Foundation

// MARK: - UserDetailResponseModel
public struct UserDetailResponseModel: Codable {
    var id, username, email,password: String?
    var isAdmin: Bool?
    var userImg, createdAt, updatedAt: String?
    var name: String?
    var isVerified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, email, password, isAdmin, userImg, createdAt, updatedAt
        case name
        case isVerified
    }
}
