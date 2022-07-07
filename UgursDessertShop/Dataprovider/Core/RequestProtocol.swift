//
//  RequestProtocol.swift
//  ChallengeApp
//
//  Created by ugur-pc on 4.05.2022.
//


public protocol RequestProtocol {
    var path: String { get }
    var method: RequestMethod { get }
    var parameters: RequestParameters { get }
    var headers: RequestHeaders { get }
    var encoding: RequestEncoding { get }
    var url: String { get }
}
