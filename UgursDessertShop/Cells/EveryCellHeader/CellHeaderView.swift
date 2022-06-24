//
//  CellHeaderView.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 24.06.2022.
//

import UIKit

class CellHeaderView: UICollectionReusableView {
    static var identifier = "HeaderReusableView"
       
       public let titleLabel: UILabel = {
           let label = UILabel()
           label.font = .systemFont(ofSize: 25, weight: .bold)
           label.textColor = .black
           return label
       }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           addSubview(titleLabel)
           setConstraints()
       }

       required init(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)!
           
       }
       
       func setConstraints(){
           titleLabel.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             padding: .init(top: 20, left: 16, bottom: 8, right: 0))
       }
}
