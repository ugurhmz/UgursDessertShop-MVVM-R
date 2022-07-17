//
//  CheckOutReusableView.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 28.06.2022.
//
import UIKit

class CheckOutReusableView: UICollectionReusableView {
    static var Identifier = "CheckOutReusableView"
    
    var checkOutBtn: UIButton = {
        let buton = UIButton(type: .system)
         buton.setTitle("Check Out", for: .normal)
         buton.setTitleColor(.white, for: .normal)
         buton.layer.cornerRadius = 45
         buton.layer.masksToBounds = true
         buton.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
         //buton.addTarget(self, action: #selector(clickCheckOutBtn), for: .touchUpInside)
         return buton
     }()
    
    var dontHaveCartItem: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "You do not have any products in your cart"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(checkOutBtn)
        addSubview(dontHaveCartItem)
        checkOutBtn.anchor(top: topAnchor ,
                      leading: leadingAnchor,
                      bottom: bottomAnchor,
                      trailing: trailingAnchor,
                      padding: .init(top: 10, left: 20, bottom: 10, right: 20))
        self.dontHaveCartItem.fillSuperview()
        self.dontHaveCartItem.isHidden = true
        self.checkOutBtn.isHidden = true
        
        self.checkOutBtn.applyGradient(colors: [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.systemGreen.cgColor])
        
    }
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


//MARK: -
extension CheckOutReusableView {
  
    func configure(cartItemCount: Int) {
        if cartItemCount < 1 {
            self.checkOutBtn.isHidden = true
            self.dontHaveCartItem.isHidden = false
        } else {
            self.checkOutBtn.isHidden = false
            self.dontHaveCartItem.isHidden = true
        }
    }
}
