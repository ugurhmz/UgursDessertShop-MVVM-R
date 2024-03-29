//
//  ProductsCell.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 24.06.2022.
//

import UIKit

class ProductsCell: UICollectionViewCell {
    static var identifier  = "ProductsCell"
    var addCartClosure: VoidClosure?
    var addToFavClosure: VoidClosure?
   
    
    public var prdimgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "d1")
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        iv.backgroundColor = ProductBgColor
        return iv
    }()
    
    private let prdPriceLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "$ 9.99 / kg"
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private let prdNameLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.text = "Macarons"
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    
    private var addToCartBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        btn.tintColor = AddToCartBtnBg
        // btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(clickAddToCartBtn), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func clickAddToCartBtn() {
        self.addCartClosure?()
    }
    
    var addToFavouriteBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        btn.tintColor = AddToCartBtnBg
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(clickFavouriteBtn), for: .touchUpInside)
        return btn
    }()
    
    @objc func clickFavouriteBtn(){
        self.addToFavClosure?()
    }
    
    private lazy var prdstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [prdPriceLbl, prdNameLbl])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        bringSubviewToFront(addToCartBtn)
        bringSubviewToFront(addToFavouriteBtn)
    }
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    
    private func setupViews(){
        addSubview(prdimgView)
        addSubview(prdstackView)
        prdstackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 4, right: 3)
        prdstackView.isLayoutMarginsRelativeArrangement = true
        prdstackView.setCustomSpacing(-30, after: prdPriceLbl)
        addSubview(addToCartBtn)
        addSubview(addToFavouriteBtn)
        layer.cornerRadius = 12
    }
}
extension ProductsCell {
    func configure(productModel: ProductsCellModel, favItems: [ProductsCellModel]) {
        
        
        self.prdNameLbl.text = productModel.prdNameLbl
        if let price =  productModel.prdPriceLbl{
            self.prdPriceLbl.text = "$ \(price) / gr"
        }
        
        if let img = productModel.prdImgView {
            self.prdimgView.image = UIImage(named: "\(img)")
        }
        
        
        if favItems.count == 0 {
            print(favItems.count)
            addToFavouriteBtn.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
        if  favItems.contains(productModel) {
            addToFavouriteBtn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            addToFavouriteBtn.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    
    
}


extension ProductsCell {
    private func setConstraints(){
        prdimgView.anchor(top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          bottom: nil,
                          trailing: contentView.trailingAnchor,
                          size: .init(width: 0, height: self.frame.height / 1.7 ))
        
        prdstackView.anchor(top: prdimgView.bottomAnchor,
                            leading: leadingAnchor,
                            bottom: bottomAnchor,
                            trailing: addToCartBtn.leadingAnchor,
                            padding: .init(top: 0, left: 0, bottom: 0, right: 5)
        )
        
        addToCartBtn.anchor(top: nil,
                            leading: nil,
                            bottom: contentView.bottomAnchor,
                            trailing: contentView.trailingAnchor,
                            padding: .init(top: 0, left:0, bottom: 8, right: 8 ),
                            size: .init(width: 46, height: 46))
        
        addToFavouriteBtn.anchor(top: prdimgView.topAnchor,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: prdimgView.trailingAnchor,
                                 padding: .init(top: 10, left:0, bottom: 0, right: 10 ),
                                 size: .init(width: 28, height: 28))
    }
}
