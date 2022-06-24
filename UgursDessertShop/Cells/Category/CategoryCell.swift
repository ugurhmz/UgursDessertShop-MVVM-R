//
//  CategoryCell.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 24.06.2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static var identifier  = "CategoryCell"
    
    private let categoryNameLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
        layer.cornerRadius = 20
         contentView.addSubview(categoryNameLbl)
         setConstraints()
     }
     required init?(coder: NSCoder) {
         fatalError("not imp")
     }
}

extension CategoryCell {
    private func setConstraints(){
       categoryNameLbl.anchor(top:topAnchor,
                                leading: leadingAnchor,
                                bottom: bottomAnchor,
                                trailing: trailingAnchor,
                                padding: .init(top: 5, left: 0, bottom: 10, right: 0))
    }
}
