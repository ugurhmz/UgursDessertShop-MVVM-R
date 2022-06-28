//
//  AppDao.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 27.06.2022.
//

import Foundation

class UserDao {
    
    func save(userId: String, userToken: String) {
        var userArr: [String] = []
        userArr.append(userId)
        userArr.append(userToken)
        UserDefaults.standard.set(userArr, forKey: "userId")
    }
    func fetchUser() -> [String] {
        guard let idUser = UserDefaults.standard.stringArray(forKey: "userId") else { return [] }
        
        return idUser
    }
}
