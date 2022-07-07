//
//  DecodableResponseRequest.swift
//  ChallengeApp
//
//  Created by ugur-pc on 4.05.2022.
//

public protocol DecodableResponseRequest: RequestProtocol {
    associatedtype ResponseType: Decodable
}
