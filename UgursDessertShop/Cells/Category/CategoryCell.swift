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
        label.text = "Cheesecake Cheesecake"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
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
        layer.cornerRadius = 16
        contentView.addSubview(categoryNameLbl)
        let lblText = "Cheesecake"
        self.categoryNameLbl.text = lblText
        if lblText.count > 10 {
            self.categoryNameLbl.font = .systemFont(ofSize: 15)
        } else if lblText.count < 10 {
            self.categoryNameLbl.font = .systemFont(ofSize: 20)
        }
            
        
    }
    
    override func layoutSubviews() {
        customlayer()
    }
    
     func customlayer(){
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        self.layer.backgroundColor = UIColor.white.cgColor

        contentView.layer.masksToBounds = true
        layer.cornerRadius = 10
    }
}

extension CategoryCell {
    private func setConstraints(){
       categoryNameLbl.anchor(top:topAnchor,
                                leading: leadingAnchor,
                                bottom: bottomAnchor,
                                trailing: trailingAnchor,
                                padding: .init(top: 2, left: 0, bottom: 2, right: 0))
    }
}

extension CategoryCell {
    func configure(select: Bool) {
        
        if select {
           
            contentView.backgroundColor = AddToCartBtnBg
            self.categoryNameLbl.textColor = .white
            contentView.layer.cornerRadius = 10
        } else {
         
            contentView.backgroundColor = .white
            self.categoryNameLbl.textColor = .black
            contentView.layer.cornerRadius = 10
           
        }
    }
}
