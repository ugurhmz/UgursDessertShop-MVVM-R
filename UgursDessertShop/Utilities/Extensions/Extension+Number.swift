//
//  Extension+Number.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 1.07.2022.
//

import Foundation


extension NSObject {
    
    func numberFormat(_ mynumber: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: mynumber)) else { return "0.0" }
        return formattedNumber
    }
}
