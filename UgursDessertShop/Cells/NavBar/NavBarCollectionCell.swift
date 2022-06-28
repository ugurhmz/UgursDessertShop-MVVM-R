//
//  SearchSectionCell.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 24.06.2022.
//

import UIKit

class NavBarCollectionCell: UICollectionViewCell {
    static var identifier = "NavBarCollectionCell"
 
    public var navbarImgView: UIImageView = {
         let iv = UIImageView()
         iv.contentMode = .scaleToFill
         iv.image = UIImage(named: "bakery")
         iv.clipsToBounds = true
         //iv.layer.cornerRadius = 12
         return iv
     }()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         setupViews()
         setConstraints()
     }
     required init?(coder: NSCoder) {
         fatalError("not imp")
     }
    
    private func setupViews(){
       addSubview(navbarImgView)
    }
    
 
}

extension NavBarCollectionCell {
    private func setConstraints(){
        navbarImgView.fillSuperview()
    }
}
