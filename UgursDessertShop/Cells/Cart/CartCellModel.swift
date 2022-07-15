//
//  CartCellModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 10.07.2022.
//

import Foundation

public protocol CartCellDataSource: AnyObject {
    var prdId: String? { get }
     var prdImgUrl: String? { get }
     var prdPrice: Double? { get }
     var prdTitle: String? { get }
     var prdDescription: String? { get }
     var stepperCount: Int? { get }
}

public protocol CartCellEventSource: AnyObject {
    var plusButtonTapped: VoidClosure? { get set }
}

public protocol CartCellProtocol: CartCellDataSource, CartCellEventSource {}

public final class CartCellModel: CartCellProtocol {
    public var prdId: String?
    public var prdImgUrl: String?
    public var prdPrice: Double?
    public var prdTitle: String?
    public var prdDescription: String?
    public var stepperCount: Int?
    public var plusButtonTapped: VoidClosure?
    
    public init( prdId: String,
                prdImgUrl: String,
                prdPrice: Double,
                prdTitle: String,
                prdDescription: String,
                stepperCount: Int)
    {
        self.prdId = prdId
        self.prdImgUrl = prdImgUrl
        self.prdPrice = prdPrice
        self.prdTitle = prdTitle
        self.prdDescription = prdDescription
        self.stepperCount = stepperCount
    }
}
