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
           label.font = .systemFont(ofSize: 32, weight: .bold)
           label.textColor = .black
           return label
       }()
    
    public let viewAllLbl: UILabel = {
        let label = UILabel()
        label.text = "View All"
        label.font = .systemFont(ofSize:20, weight: .medium)
        label.textColor = .systemGreen
        return label
    }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           addSubview(titleLabel)
           addSubview(viewAllLbl)
           setConstraints()
       }

       required init(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)!
           
       }
       
       func setConstraints(){
           titleLabel.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: viewAllLbl.leadingAnchor,
                             padding: .init(top: 20, left: 16, bottom: 8, right: 0))
           
           viewAllLbl.anchor(top: topAnchor,
                             leading: titleLabel.trailingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             padding: .init(top: 20, left: 0, bottom: 8, right: 20))
       }
}
