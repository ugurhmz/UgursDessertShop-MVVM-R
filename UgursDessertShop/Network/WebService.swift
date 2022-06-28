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
typealias productHandler = ([ProductResponse]?, String?) -> Void
typealias cartProductHandler = ([CartProductResponse]?, String?) -> Void

typealias oneProductHandler = (ProductResponse?, String?) -> Void

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
    
    // FETCH ALL USER
    func callingAllProducts(completionHandler: @escaping productHandler){
        
        AF.request(baseUrl + "/product/all", method: .get, parameters: nil, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(let data):

                if response.response!.statusCode == 200 {
                   do {
                       let res = try JSONDecoder().decode([ProductResponse].self, from: data!)
                      print("RES", res)
                       completionHandler(res, nil)
                       
                    } catch {
                        completionHandler(nil,"Error showing product!")
                        print(error.localizedDescription)
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
                    completionHandler(nil, "404 Error!")
                }
            case .failure(let err):
                completionHandler(nil,err.localizedDescription)
            }
        }
    }
    
    // FETCH CART ITEMS CURRENT USER
    func callingUserCartItems(userId: String, userToken: String, completionHandler: @escaping cartProductHandler ) {
        
        let myheaders: HTTPHeaders = [
            "token": "Bearer \(userToken)",
            "Accept": "application/json"
        ]

        AF.request(baseUrl + "/carts/user-cart/\(userId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: myheaders).response {
                   response in

                switch response.result {
                case .success(let data):

                    if response.response!.statusCode == 200 {
                       do {
                           let res = try JSONDecoder().decode(CartResponse.self, from: data!)
                           let newArr = res.products?.map({
                               return CartProductResponse(productID: $0.productID, quantity: $0.quantity, id: $0.id)
                           })
                           
                           completionHandler(newArr, nil)
                          
                        } catch {
                            completionHandler(nil, error.localizedDescription)
                        }

                    } else if response.response!.statusCode == 401 {

                        do {
                            let res = try JSONDecoder().decode(AuthErr.self, from: data!)
                            if let msg = res.msg {
                                completionHandler(nil, msg)
                            }
                         } catch {
                             completionHandler(nil, error.localizedDescription)
                         }
                    } else if response.response!.statusCode == 404 {
                        completionHandler(nil, "404")
                    }
                case .failure(let err):
                    completionHandler(nil, err.localizedDescription)
                }
        }
    }
    
    
    func callingOneProduct(prdId: String, completionHandler: @escaping oneProductHandler){
        AF.request(baseUrl + "/product/\(prdId)", method: .get, parameters: nil, encoding: JSONEncoding.default).response {
                   response in

                switch response.result {
                case .success(let data):

                    if response.response!.statusCode == 200 {
                       do {
                           let res = try JSONDecoder().decode(ProductResponse.self, from: data!)
                           completionHandler(res, nil)
                           print("one product",res)
                          
                        } catch {
                            completionHandler(nil, error.localizedDescription)
                        }

                    } else if response.response!.statusCode == 401 {

                        do {
                            let res = try JSONDecoder().decode(AuthErr.self, from: data!)
                            if let msg = res.msg {
                                completionHandler(nil, msg)
                            }
                         } catch {
                             completionHandler(nil, error.localizedDescription)
                         }
                    } else if response.response!.statusCode == 404 {
                        completionHandler(nil," err.localizedDescription")
                    }
                case .failure(let err):
                    completionHandler(nil, err.localizedDescription)
                }
        }
    }
    
}

