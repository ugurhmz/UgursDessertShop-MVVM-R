//
//  APIRequestInterceptor.swift
//  ChallengeApp
//
//  Created by ugur-pc on 6.05.2022.
//

import Alamofire
import Foundation
import KeychainSwift

public class APIRequestInterceptor: RequestInterceptor {
    
    public static let shared = APIRequestInterceptor()
    
    public func adapt(_ urlRequest: URLRequest,
                      for session: Session,
                      completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var urlRequest = urlRequest
        let accessToken = KeychainSwift().get(Keychain.token)
        //let accessToken: String? = "MY_TOKEN"
        
        if let accessToken = accessToken {
            urlRequest.headers.add(name: "token", value: "Bearer \(accessToken)")
        }
        completion(.success(urlRequest))
    }
}
