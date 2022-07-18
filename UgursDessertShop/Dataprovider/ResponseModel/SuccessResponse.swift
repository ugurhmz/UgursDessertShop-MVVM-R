//
//  SuccessResponse.swift
//  AuthApp-MVVM
//
//  Created by ugur-pc on 6.07.2022.
//

import Foundation

public struct SuccessResponse: Decodable {
    public let message: String?
    public let error: String?
    public let msg: String?
}
