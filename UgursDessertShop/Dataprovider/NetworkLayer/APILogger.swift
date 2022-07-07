//
//  APILogger.swift
//  ChallengeApp
//
//  Created by ugur-pc on 6.05.2022.
//

import Alamofire
import Foundation

final class APILogger: EventMonitor {
    
    static let shared = APILogger()
    
    let queue = DispatchQueue(label: "ugurhmz.logger")
    
    func request(_ request: Request, didCreateURLRequest urlRequest: URLRequest) {
        print("---> Request Created <---")
        print(request.description)
    }
    
    func requestDidFinish(_ request: Request) {
        print("---> Request Finished <---")
        print(request.description)
    }
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("---> Request JSONResponse <---")
        if let data = response.data, let json = String(data: data, encoding: .utf8) {
            print(json)
        }
    }
}
