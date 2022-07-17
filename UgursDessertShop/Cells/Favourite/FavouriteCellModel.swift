//
//  FavouriteCellmodel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 17.07.2022.
//

import Foundation

public protocol FavouriteCellDataSource: AnyObject {
    var prdId: String? { get }
    var prdImgUrl: String? { get }
    var prdPrice: Double? { get }
    var prdTitle: String? { get }
    var prdDescription: String? { get }
}

public protocol FavouriteEventSource: AnyObject { }

public protocol FavouriteCellProtocol: FavouriteCellDataSource, FavouriteEventSource { }


public final class FavouriteCellModel: FavouriteCellProtocol {
    public var prdId: String?
    public var prdImgUrl: String?
    public var prdPrice: Double?
    public var prdTitle: String?
    public var prdDescription: String?
    
    public init( prdId: String,
                  prdImgUrl: String,
                  prdPrice: Double,
                  prdTitle: String,
                  prdDescription: String)
      {
          self.prdId = prdId
          self.prdImgUrl = prdImgUrl
          self.prdPrice = prdPrice
          self.prdTitle = prdTitle
          self.prdDescription = prdDescription
      }
}
