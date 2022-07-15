//
//  ProductCellModel.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 9.07.2022.
//

import Foundation


final class ProductsCellModel {
    var prdId: String?
    var prdNameLbl: String?
    var prdPriceLbl: Double?
    var prdImgView: String?
    
    public init(
        prdId: String? = nil,
        prdNameLbl: String? = nil,
        prdPriceLbl: Double? = nil,
        prdImgView: String? = nil
    ){
        self.prdId = prdId
        self.prdNameLbl = prdNameLbl
        self.prdPriceLbl = prdPriceLbl
        self.prdImgView = prdImgView
    }
}
