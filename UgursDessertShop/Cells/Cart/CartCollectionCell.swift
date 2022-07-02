//
//  CartCollectionCell.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 28.06.2022.
//

import UIKit

class CartCollectionCell: UICollectionViewCell {
    
    static var identifier = "CartCollectionCell"
    var addToCartClosure: VoidClosure?
    var subtractToCartClosure: VoidClosure?
    var collectionRealoadClosure: VoidClosure?
    var webService = WebService()
    var homeViewModel = HomeViewModel()
    var newReloadClosure: VoidClosure?
    var intClosure: IntClosure?
    var deleteItemInCartClosure: VoidClosure?
    
    private let prdImgView: UIImageView = {
         let iv = UIImageView()
         iv.image = UIImage(named: "v3")
         iv.contentMode = .scaleToFill
         iv.clipsToBounds = true
         iv.layer.cornerRadius = 15
        iv.backgroundColor =  ProductBgColor
         return iv
    }()
    
    private let prdPriceLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "1020.50 TL"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let prdTitleLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Lorem Ipsum"
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2

        return label
    }()

    private let prdDescriptionLbl: UILabel = {
        let label = UILabel()
        label.text = "lorem ipsum dolar sit lorem ipsum dolar sitlorem ipsum dolar sitlorem ipsum dolar sitlorem ipsum dolar sit"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.1709887727, green: 0.1870856636, blue: 0.2076978542, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()

    private let plusBtn: UIButton = {
         let buton = UIButton()
         buton.setTitle("+", for: .normal)
         buton.backgroundColor = #colorLiteral(red: 0.8086332071, green: 0.3559194398, blue: 0.1270762815, alpha: 1)
         buton.setTitleColor(.white, for: .normal)
         buton.layer.cornerRadius = 18
         buton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
         
         buton.addTarget(self, action: #selector(clickPlusBtn), for: .touchUpInside)
         return buton
     }()

    private var minusBtn: UIButton = {
        let buton = UIButton(type: .system)
         buton.setTitle("-", for: .normal)
         buton.backgroundColor = #colorLiteral(red: 0.8086332071, green: 0.3559194398, blue: 0.1270762815, alpha: 1)
         buton.setTitleColor(.white, for: .normal)
         buton.layer.cornerRadius = 18
         buton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
         buton.addTarget(self, action: #selector(clickMinusBtn), for: .touchUpInside)
         return buton
     }()
    
    private let stepperCountLbl: UILabel = {
          let label = UILabel()
          label.font = .systemFont(ofSize: 18, weight: .bold)
          label.text = "1"
          label.textColor = .black
          label.textAlignment = .center

          return label
   }()
    private let deleteIcon: UIImageView = {
           let iv = UIImageView()
        iv.image = UIImage(systemName: "trash")
           iv.tintColor = .red
           return iv
    }()

    private var  topstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private var  prdstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        setStyle()
    }
    
    private func setStyle(){
        self.plusBtn.backgroundColor = #colorLiteral(red: 0.2499767244, green: 0.009076544084, blue: 0.8062750697, alpha: 1)
        self.minusBtn.backgroundColor = #colorLiteral(red: 0.2499767244, green: 0.009076544084, blue: 0.8062750697, alpha: 1)
        bringSubviewToFront(prdstackView)
        bringSubviewToFront(deleteIcon)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}

//MARK: - @objc funcs
extension CartCollectionCell {
    
    @objc func clickMinusBtn(){
        if let subtractToCartaction = subtractToCartClosure {
            subtractToCartaction()
        }
    }
    @objc func clickPlusBtn(){
        if let addCartAction = addToCartClosure {
             addCartAction()
        }
        
    }
}

extension CartCollectionCell {
    func fillData(cartItemModel: CartProductResponse) {
        
        guard let quantity = cartItemModel.quantity  else  { return }
        
        if String(quantity).count > 4 {
            self.stepperCountLbl.font = .systemFont(ofSize: 15)
        }
        self.stepperCountLbl.text = "\(quantity)"
        
        
        if let cartProduct = cartItemModel.itemId {
            self.prdTitleLbl.text = cartProduct.title
           
            if let  prdPrice = cartProduct.price {
                let totalPrice = Double(quantity) * prdPrice
                self.prdPriceLbl.text = "$ \(numberFormat(totalPrice))"
            }
            
            if let  prdDescription = cartProduct.prdDescription {
                self.prdDescriptionLbl.text = prdDescription
            }
            
            if let prdImg = cartProduct.prdImg {
                self.prdImgView.image = UIImage(named: "\(prdImg)")
            }
                
        }
    }
    
    //MARK: - ADD TO CART
    func checkPrdAndCartItemTwo(
        userID: String,
        userTOKEN: String,
        clickedPrd: CartProductResponse,
        allCartItems: [CartProductResponse]) {
        var count = 0
        var toplamMiktar = 0
            
         
            guard let clickItemId  = clickedPrd.itemId?.id else { return }
          
            
        allCartItems.forEach({
      
            guard let  cartItemId = $0.itemId?.id else { return }
         
            if clickItemId == cartItemId {
                    count += 1
                toplamMiktar -= 1
                    return
                 }
        })
       
       if count == 1 {

           self.homeViewModel.addToCartFromService(currentUserId: userID,
                                                   userToken: userTOKEN,
                                                   prdQuantity: toplamMiktar,
                                                      clickingProduct: clickedPrd)
           
       } else {
           self.homeViewModel.addToCartFromService(currentUserId: userID,
                                                   userToken: userTOKEN,
                                                   prdQuantity: 1,
                                                      clickingProduct: clickedPrd)
           self.intClosure?(toplamMiktar)
       }
        
    }
    
    
    //MARK: - ADD TO CART
    func checkPrdAndCartItem(
        userID: String,
        userTOKEN: String,
        clickedPrd: CartProductResponse,
        allCartItems: [CartProductResponse]) {
        var count = 0
        var toplamMiktar = 0
            
         
            guard let clickItemId  = clickedPrd.itemId?.id else { return }
            print("clickItemId",clickItemId)
            
        allCartItems.forEach({
      
            guard let  cartItemId = $0.itemId?.id else { return }
         
            if clickItemId == cartItemId {
                    count += 1
                toplamMiktar += 1
                    return
                 }
        })
       
       if count == 1 {

           self.homeViewModel.addToCartFromService(currentUserId: userID,
                                                   userToken: userTOKEN,
                                                   prdQuantity: toplamMiktar,
                                                      clickingProduct: clickedPrd)
           
       } else {
           self.homeViewModel.addToCartFromService(currentUserId: userID,
                                                   userToken: userTOKEN,
                                                   prdQuantity: 1,
                                                      clickingProduct: clickedPrd)
           self.intClosure?(toplamMiktar)
       }
        
    }
}

//MARK: -
extension CartCollectionCell {
    
    private func setupViews(){
        addSubview(prdImgView)
        addSubview(deleteIcon)
        addSubview(prdstackView)
        addSubview(topstackView)
        addSubview(prdPriceLbl)
       
        [minusBtn, stepperCountLbl, plusBtn].forEach{ prdstackView.addArrangedSubview($0)}
        [prdTitleLbl, prdDescriptionLbl].forEach{ topstackView.addArrangedSubview($0)}
        
        
        let deleteIconTap = UITapGestureRecognizer(target: self, action: #selector(clickDeleteIcon))
        deleteIcon.isUserInteractionEnabled = true
        deleteIcon.addGestureRecognizer(deleteIconTap)
     
    }
    
    @objc func clickDeleteIcon(){
        if let deleteItemInCartAction = deleteItemInCartClosure {
            deleteItemInCartAction()
        }
       
    }
    
    private func setConstraints(){
        prdImgView.anchor(top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: nil,
                          size: .init(width: 120, height: 0))
        
        deleteIcon.anchor(top: contentView.topAnchor,
                          leading: nil,
                          bottom: nil,
                          trailing: contentView.trailingAnchor,
                          padding: .init(top: 2, left: 4, bottom: 10, right: 2),
                          size: .init(width:25, height: 25))
        
        
        topstackView.anchor(top: deleteIcon.topAnchor,
                            leading: prdImgView.trailingAnchor,
                            bottom: nil,
                            trailing: deleteIcon.leadingAnchor,
                            padding: .init(top: 2, left: 8, bottom: 0, right: 3),
                            size: .init(width: 0, height: 90))
        
        prdstackView.anchor(top: topstackView.bottomAnchor,
                            leading: prdImgView.trailingAnchor,
                           bottom: bottomAnchor,
                           trailing: nil,
                           padding: .init(top: 2, left: 8, bottom: 2, right: 5),
                           size: .init(width: 140, height: 0))
        
        prdPriceLbl.anchor(top: topstackView.bottomAnchor,
                          leading: prdstackView.trailingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 2, left: 5, bottom: 5, right: 1))
    }
}
