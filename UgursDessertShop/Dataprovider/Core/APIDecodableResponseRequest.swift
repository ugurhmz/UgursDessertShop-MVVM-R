//
//  APIDecodableResponseRequest.swift
//  ChallengeApp
//
//  Created by ugur-pc on 4.05.2022.
//

public protocol APIDecodableResponseRequest: DecodableResponseRequest {}

// MARK: - RequestEncoding
public extension APIDecodableResponseRequest {
    var encoding: RequestEncoding {
        switch method {
        case .get:
            return .url
        default:
            return .json
        }
    }
}


//MARK: - url
public extension APIDecodableResponseRequest {
    var url: String {
        return "http://localhost:3500/ugurapi/user" + path
    }
}


//MARK: - RequestParameters
public extension APIDecodableResponseRequest {
    var parameters: RequestParameters {
        return [:]
    }
}


//MARK: - RequestHeaders
public extension APIDecodableResponseRequest {
    var headers: RequestHeaders {
        return [:]
    }
}
