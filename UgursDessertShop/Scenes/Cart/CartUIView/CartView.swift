//
//  CartView.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 28.06.2022.
//

import UIKit

class CartView: UIView {
    private var checkOutBtn: UIButton = {
        let buton = UIButton(type: .system)
         buton.setTitle("Check Out", for: .normal)
        buton.backgroundColor = .red
         buton.setTitleColor(.white, for: .normal)
         buton.layer.cornerRadius = 45
         buton.layer.masksToBounds = true
         buton.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
         buton.addTarget(self, action: #selector(clickCheckOutBtn), for: .touchUpInside)
         return buton
     }()
    
    @objc func clickCheckOutBtn(){
        // CHECKOUT
        print("click")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    private func setupViews(){
       addSubview(checkOutBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }

}
extension CartView {
    func fillData(sumData: Double) {
        let strCast = "\(numberFormat(sumData))"
        let addCartStr = "Check Out | "
        
        let str = NSMutableAttributedString(string: "\(addCartStr)\(strCast) $ ")
        str.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 28), range: NSMakeRange(0, addCartStr.count))
        str.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 22), range: NSMakeRange(addCartStr.count, strCast.count + 3))
        self.checkOutBtn.setAttributedTitle(str, for: .normal)
    }
}

//MARK: -
extension CartView {
    private func setConstraints(){
        checkOutBtn.anchor(top: topAnchor,
                           leading: leadingAnchor,
                           bottom: bottomAnchor,
                           trailing: trailingAnchor)
    }
}
