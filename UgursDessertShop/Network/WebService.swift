//
//  WebService.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 26.06.2022.
//

import Foundation
import Alamofire


//enum APIErrors: Error {
//    case custom(message: String)
//}

typealias loginHandler = (LoginResponse?, String?) -> Void
typealias registerHandler = (RegisterResponse? ,String?) -> Void

final class WebService {
    let baseUrl = "http://localhost:3000/ugurapi"
    let headers: HTTPHeaders = [
        .contentType("application/json")
    ]
    
    
    static let shared = WebService()
    
    //MARK: - LOGIN
    func callingLoginAPI(login: LoginModel, completionHandler: @escaping  loginHandler) {
        
        AF.request(baseUrl + "/auth/login", method: .post, parameters: login, encoder: JSONParameterEncoder.default,
                   headers: headers).response { response in
            switch response.result {
            case .success(let data):
        
                if response.response!.statusCode == 200 {
                   do {
                       let res = try JSONDecoder().decode(LoginResponse.self, from: data!)
                    
                       completionHandler(res, nil)
                    } catch {
                        print(error.localizedDescription)
                    }
                                
                } else if response.response!.statusCode == 401 {
                    
                    do {
                        let res = try JSONDecoder().decode(AuthErr.self, from: data!)
                        if let msg = res.msg {
                            completionHandler(nil, msg)
                        }
                     } catch {
                         print(error.localizedDescription)
                     }
                } else if response.response!.statusCode == 404 {
                    completionHandler(nil, "404")
                }
            case .failure(let err):
                completionHandler(nil, err.localizedDescription)
            }

        }
    }
    
    //MARK: - REGISTER
    func callingRegisterAPI(register: RegisterModel, completionHandler: @escaping registerHandler){
        AF.request(baseUrl + "/auth/register", method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):

                if response.response!.statusCode == 201 {
                   do {

                        let res = try JSONDecoder().decode(RegisterResponse.self, from: data!)
                       completionHandler(res,nil)

                    } catch {
                        print(error.localizedDescription)
                        completionHandler(nil,"User not saved!")
                    }

                } else if response.response!.statusCode == 401 {

                    do {
                        let res = try JSONDecoder().decode(AuthErr.self, from: data!)
                        if let msg = res.msg {
                            completionHandler(nil,msg)
                        }
                     } catch {
                         completionHandler(nil,error.localizedDescription)
                     }
                } else if response.response!.statusCode == 404 {
                    completionHandler(nil,"There is a problem with the api")
                } else {
                    do {
                        let res = try JSONDecoder().decode(AuthErr.self, from: data!)
                        if let msg = res.msg {
                            completionHandler(nil,msg)
                        }
                     } catch {
                         completionHandler(nil,error.localizedDescription)
                     }
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(nil,err.localizedDescription)
            }
        }
    }
    
    //  CURRENT USER
    func callingUser(userId: String, userToken: String, completionHandler: @escaping loginHandler) {
    
        
        let myheaders: HTTPHeaders = [
            "token": "Bearer \(userToken)",
            "Accept": "application/json"
        ]

        
        
        AF.request(baseUrl + "/users/\(userId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: myheaders).response {
                   response in

                        switch response.result {
                        case .success(let data):

                            if response.response!.statusCode == 200 {
                               do {
                                   let res = try JSONDecoder().decode(LoginResponse.self, from: data!)

                                   completionHandler(res, nil)
                                } catch {
                                    print(error.localizedDescription)
                                }

                            } else if response.response!.statusCode == 401 {

                                do {
                                    let res = try JSONDecoder().decode(AuthErr.self, from: data!)
                                    if let msg = res.msg {
                                        completionHandler(nil, msg)
                                    }
                                 } catch {
                                     print(error.localizedDescription)
                                 }
                            } else if response.response!.statusCode == 404 {
                                completionHandler(nil, "404")
                            }
                        case .failure(let err):
                            completionHandler(nil, err.localizedDescription)
                        }
        }

        
    }
    
}


// METHOD 2 FOR GET USER WITH TOKEN
//        let  url = URL(string: "\(baseUrl)/users/\(userId)")
//        var request = URLRequest(url: url!)
//        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "token")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print(jsonString)
//                } else {
//                    print("myerr", error)
//                }
//            } else {
//                print("myerr", error)
//            }
//        }.resume()
