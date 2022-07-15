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
    var strClosure: StringClosure?
    var prdPrice: Double?
    
    var pickerNumbers = [1,2,3,4,5,6,7,8,9,10]
    var pickerView = UIPickerView()
    
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
    
    private var prdtextField: UITextField = {
        let field = UITextField()
        return field
    }()

    weak var viewModel: CartCellProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        setStyle()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        prdtextField.inputView = pickerView
    }
    
    private func setStyle(){
        bringSubviewToFront(prdstackView)
        bringSubviewToFront(deleteIcon)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


extension CartCollectionCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerNumbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerNumbers[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stepperCountLbl.text =  "\(pickerNumbers[row])"
        strClosure?("\(pickerNumbers[row])")
        let quantity = pickerNumbers[row]
        print("selfprice",self.prdPrice )
        if let price = self.prdPrice {
            self.prdPriceLbl.text = "$ \(price * Double(quantity) )"
        }
        prdtextField.resignFirstResponder()
    }
    
}

extension CartCollectionCell {
    
    public func setData(viewModel: CartCellProtocol) {
        self.viewModel = viewModel
        self.prdTitleLbl.text = viewModel.prdTitle
        self.prdDescriptionLbl.text = viewModel.prdDescription
        guard let quantity = viewModel.stepperCount  else  { return }

        guard let price = viewModel.prdPrice else { return }
       
        self.prdPrice = price
        self.prdPriceLbl.text = "$ \(price * Double(quantity) )"
        
        if String(quantity).count > 4 {
            self.stepperCountLbl.font = .systemFont(ofSize: 15)
        }
        self.stepperCountLbl.text = "\(quantity)"
        
        if let prdImg = viewModel.prdImgUrl {
            self.prdImgView.image = UIImage(named: "\(prdImg)")
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
       
        [ stepperCountLbl, prdtextField ].forEach{ prdstackView.addArrangedSubview($0)}
        [prdTitleLbl, prdDescriptionLbl].forEach{ topstackView.addArrangedSubview($0)}
        
        
        let deleteIconTap = UITapGestureRecognizer(target: self, action: #selector(clickDeleteIcon))
        deleteIcon.isUserInteractionEnabled = true
        deleteIcon.addGestureRecognizer(deleteIconTap)
     
    }
    
    @objc func clickDeleteIcon(){
       
       
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
