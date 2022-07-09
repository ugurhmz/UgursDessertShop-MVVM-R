//
//  BaseResponse.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 9.07.2022.
//


public struct BaseResponse<T: Decodable>: Decodable {
    public let data: T

}
