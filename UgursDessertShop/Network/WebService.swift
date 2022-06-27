//
//  WebService.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 26.06.2022.
//

import Foundation
import Alamofire

typealias Handler = (Swift.Result<Any?, Error>) -> Void

final class WebService {
    let baseUrl = "http://localhost:3000/ugurapi"
    let headers: HTTPHeaders = [
        .contentType("application/json")
    ]
    static let shared = WebService()
    
    
    func callingLoginAPI(login: LoginModel) {
        AF.request(baseUrl + "/auth/login", method: .post, parameters: login, encoder: JSONParameterEncoder.default,
                   headers: headers).response { response in
            switch response.result {
            case .success(let data):
        
                if response.response!.statusCode == 200 {
                   do {
                        
                        let res = try JSONDecoder().decode(LoginResponse.self, from: data!)
                       print(res)
                       
                    } catch {
                        print(error.localizedDescription)
                    }
                                
                } else if response.response!.statusCode == 401 {
                    
                    do {
                        let res = try JSONDecoder().decode(AuthErr.self, from: data!)
                        if let msg = res.msg {
                            print(msg)
                        }
                     } catch {
                         print(error.localizedDescription)
                     }
                } else if response.response!.statusCode == 404 {
                    print("There is a problem with the api")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }

        }
    }
    
    func callingRegisterAPI(register: RegisterModel){
        AF.request(baseUrl + "/auth/register", method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
        
                if response.response!.statusCode == 201 {
                   do {
                        
                        let res = try JSONDecoder().decode(RegisterResponse.self, from: data!)
                       print(res)
                       
                    } catch {
                        print(error.localizedDescription)
                    }
                                
                } else if response.response!.statusCode == 401 {
                    
                    do {
                        let res = try JSONDecoder().decode(AuthErr.self, from: data!)
                        if let msg = res.msg {
                            print(msg)
                        }
                     } catch {
                         print(error.localizedDescription)
                     }
                } else if response.response!.statusCode == 404 {
                    print("There is a problem with the api")
                } else {
                    do {
                        let res = try JSONDecoder().decode(AuthErr.self, from: data!)
                        if let msg = res.msg {
                            print(msg)
                        }
                     } catch {
                         print(error.localizedDescription)
                     }
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    
}
