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
typealias cartProductHandler = (CartResponse?, String?) -> Void

typealias oneProductHandler = (ProductResponse?, String?) -> Void

final class WebService {
    let baseUrl = "http://localhost:3000/ugurapi"
    var reloadAddToCartClosure: VoidClosure?
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

        AF.request(baseUrl + "/carts/user-id/\(userId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: myheaders).response {
                   response in

                switch response.result {
                case .success(let data):

                    if response.response!.statusCode == 200 {
                       do {
                           let res = try JSONDecoder().decode(CartResponse.self, from: data!)
                          // guard let cartId = res.id else {return }
                           
                           completionHandler(res, nil)
                           //completionHandler(res.items, nil)
                           
                           
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
    
    func callingAddToCart(currentUserId: String,
                          userToken: String,
                          prdQuantity: Int,
                          clickingProduct: ProductResponse) {
        
        guard let clickPrdId = clickingProduct.id else {return }
        
        let myheaders: HTTPHeaders = [
            "token": "Bearer \(userToken)",
            "Accept": "application/json"
        ]
        
        let params: [String: Any] = [
            "owner" : currentUserId,
            "itemId": clickPrdId,
            "quantity": prdQuantity
        ]
        
        AF.request(baseUrl + "/carts",
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default, headers: myheaders).response {
                   response in
            
            switch response.result {
            case .success(let data):

                if response.response!.statusCode == 200 {
                   do {
                       let res = try JSONDecoder().decode(CartResponse.self, from: data!)
                     
                       print("one product",res)
                      
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
                    print("error.localizedDescription")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    
    
    func callingAddToCartTwo(currentUserId: String,
                          userToken: String,
                          prdQuantity: Int,
                          clickingProduct: CartProductResponse ,
                             completionHandler: @escaping StringClosure
    ) {
        
        guard let clickThisPrd = clickingProduct.itemId?.id else { return }
        
        let myheaders: HTTPHeaders = [
            "token": "Bearer \(userToken)",
            "Accept": "application/json"
        ]

        let params: [String: Any] = [
            "owner" : currentUserId,
            "itemId": clickThisPrd,
            "quantity": prdQuantity
        ]

        AF.request("http://localhost:3000/ugurapi/carts",
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default, headers: myheaders).response {
                   response in

            switch response.result {
            case .success(let data):

                if response.response!.statusCode == 200 {
                   do {
                       completionHandler("s")
                       
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
                    print("error.localizedDescription")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }

        }
    }
    
    
    // DELETE ITEM IN CART
    func callingDeleteItemInCart(currentUserId: String,
                                 userToken: String,
                                 itemId: String )
    {
        let urlString = baseUrl + "/carts/delete-product?itemId=\(itemId)"
        let parameters = [  "owner": currentUserId ]
        guard let url = URL(string: urlString) else {return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "token")
        
        request.httpBody  = try? JSONSerialization.data(withJSONObject: parameters,
                                                   options: [])
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
    
            NotificationCenter.default.post(name: NSNotification.Name("refresh"), object: nil)
            
        }.resume()
        
    }
    
    func callingDeleteAllCart(userToken: String,
                              cartId: String) {
        
        let myheaders: HTTPHeaders = [
            "token": "Bearer \(userToken)",
            "Accept": "application/json"
        ]

        let params: [String: Any] = [
            "cartId": cartId
        ]
        
        AF.request("http://localhost:3000/ugurapi/carts/delete-all/cartId/\(cartId)",
                   method: .delete,
                   parameters: params,
                   encoding: JSONEncoding.default, headers: myheaders).response {
                   response in
            
            switch response.result {
            case .success(let data):

                if response.response!.statusCode == 200 {
                    NotificationCenter.default.post(name: NSNotification.Name("refresh"), object: nil)

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
                    print("error.localizedDescription")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }

        }
    }
    
}

