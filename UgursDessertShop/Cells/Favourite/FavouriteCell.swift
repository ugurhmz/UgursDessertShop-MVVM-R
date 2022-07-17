//
//  FavouriteCell.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 16.07.2022.
//

import UIKit

class FavouriteCell: UITableViewCell {
    
    static var identifier = "FavouriteCell"
    var deleteProductInFavoriteClosure: VoidClosure?
    
    private let prdImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bakery")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let prdPriceLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
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
    
    private let deleteIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "trash")
        iv.tintColor = .red
        return iv
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        return stackView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
        bringSubviewToFront(stackView)
        bringSubviewToFront(deleteIcon)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("not imps")
    }
    
    private func setupViews(){
        addSubview(prdImgView)
        addSubview(stackView)
        addSubview(deleteIcon)
        
        [prdTitleLbl, prdDescriptionLbl, prdPriceLbl].forEach{ stackView.addArrangedSubview($0)}
        let imgSelectTap = UITapGestureRecognizer(target: self, action: #selector(deleteProductInCartBtn))
        imgSelectTap.numberOfTapsRequired = 1 // Kullanıcının el hareketinin tespit edilmesi için gereken dokunma sayısı. (Varsayılan değeri 1'dir.)
        deleteIcon.isUserInteractionEnabled = true
        deleteIcon.addGestureRecognizer(imgSelectTap)
        
    }
    
    @objc func deleteProductInCartBtn(){
        self.deleteProductInFavoriteClosure?()
    }
    
    
}

extension FavouriteCell {
    func fillData(data: FavouriteCellProtocol) {
        if let prdPrice = data.prdPrice {
            self.prdPriceLbl.text = "$ \(prdPrice)"
        }
        if let prdTitle = data.prdTitle {
            self.prdTitleLbl.text = prdTitle
        }
        
        if let prdDesc = data.prdDescription {
            self.prdDescriptionLbl.text = prdDesc
        }
        
        if let prdImgURLString = data.prdImgUrl {
            self.prdImgView.image = UIImage(named: prdImgURLString)
        }
    }
}

extension FavouriteCell {
    private func setConstraints(){
        prdImgView.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom:bottomAnchor,
                          trailing: nil,
                          size: .init(width: 200, height: 0))
        deleteIcon.anchor(top: contentView.topAnchor,
                          leading: nil,
                          bottom: nil,
                          trailing: contentView.trailingAnchor,
                          padding: .init(top: 8, left: 4, bottom: 10, right: 15),
                          size: .init(width:25, height: 25))
        
        stackView.anchor(top: contentView.topAnchor,
                         leading: prdImgView.trailingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor,
                         padding: .init(top: 0, left: 10, bottom: 0, right: 5)
        )
        
        
        
        
    }
}
