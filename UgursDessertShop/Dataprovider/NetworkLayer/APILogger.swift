//
//  APILogger.swift
//  ChallengeApp
//
//  Created by ugur-pc on 7.07.2022.
//

import Alamofire
import Foundation

final class APILogger: EventMonitor {
    
    static let shared = APILogger()
    
    let queue = DispatchQueue(label: "ugurhmz.logger")
    
    func request(_ request: Request, didCreateURLRequest urlRequest: URLRequest) {
        print("🌎---> Request Created <---🌎")
        print(request.description)
    }
    
    func requestDidFinish(_ request: Request) {
        print("🌎---> Request Finish <---🌎")
        print(request.description)
    }
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("🌎---> Request JSONResponse <---🌎")
        if let data = response.data, let json = String(data: data, encoding: .utf8) {
            print(json)
        }
    }
}
