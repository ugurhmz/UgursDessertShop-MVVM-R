//
//  CartVC.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 24.06.2022.
//

import UIKit
import KeychainSwift

class CartVC: BaseViewController<CartViewModel> {
    private let keychain = KeychainSwift()
    private let checkOutRedButtonView = CartView()
    let deleteAllBtn = UIButton(type: .system)
    var userCartItemCount: Int?
    
    // General CollectionView
    private var generalCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
          cv.showsHorizontalScrollIndicator = false
          cv.backgroundColor = .white
          cv.register(CartCollectionCell.self,
                          forCellWithReuseIdentifier: CartCollectionCell.identifier)
          cv.register(CheckOutReusableView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CheckOutReusableView.Identifier)
          return cv
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
     
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("refresh"), object: nil, queue: nil) { [weak self] _ in
                  guard let self = self else { return}
                    if let userid = self.keychain.get("userid") {
                        self.viewModel.fetchUserCart(userId: userid)
                       
                    }
                  self.generalCollectionView.reloadData()
         }
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkOutRedButtonView.isHidden = true
    
        self.showActivityIndicator()
          if let userid = self.keychain.get("userid") {
              viewModel.fetchUserCart(userId: userid)
              
          }

          self.viewModel.reloadMyData = { [weak self] in
              guard let self = self else { return}
              
              
              guard let userCartItemscount = self.viewModel.currentUserCartItems?.count else {
                  return
              }
              self.userCartItemCount = userCartItemscount
              if   self.userCartItemCount ?? 0 < 4 {
                   self.checkOutRedButtonView.isHidden = true
              }

              if self.userCartItemCount == 0 {
                  self.deleteAllBtn.isHidden = true
              } else {
                  self.deleteAllBtn.isHidden = false
              }

              self.generalCollectionView.reloadData()
              
          }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
               self.hideActivityIndicator()
        }
    }
    
    
    private func setupViews(){
        view.addSubview(generalCollectionView)
        view.addSubview(checkOutRedButtonView)
        checkOutRedButtonView.layer.cornerRadius = 40
        settingsNavigateBar()
    }
    
    private func settingsNavigateBar(){
               if #available(iOS 13.0, *) {
                 let navBarAppearance = UINavigationBarAppearance()
                  navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "Charter-Black", size: 26)!]
                
                   navigationController?.navigationBar.barStyle = .black
                 navigationController?.navigationBar.standardAppearance = navBarAppearance
                 navigationController?.navigationBar.compactAppearance = navBarAppearance
                 navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
                 navigationController?.navigationBar.prefersLargeTitles = false
                 }
 
               deleteAllBtn.setImage(UIImage(systemName: "trash.circle.fill"), for: .normal)
               deleteAllBtn.setTitle("Delete All", for: .normal)
               deleteAllBtn.tintColor = CartDeleteAllTintColor
               deleteAllBtn.titleLabel?.font = UIFont(name: "Charter-Black", size: 18)
               navigationItem.rightBarButtonItems = [
                   UIBarButtonItem(customView: deleteAllBtn)
               ]
               navigationController?.navigationBar.tintColor = .label
        
        deleteAllBtn.addTarget(self, action: #selector(clickDeleteAllCartItems), for: .touchUpInside)
           
    }
    
    @objc func clickDeleteAllCartItems(){
       
    }
    
}
extension CartVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        self.checkOutRedButtonView.isHidden = false
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        if distanceFromBottom < height {
            self.checkOutRedButtonView.isHidden = true
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let items = self.viewModel.currentUserCartItems else {
            return 0
        }
        
        
        return items.count
    }
   
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionCell.identifier, for: indexPath) as! CartCollectionCell
        
        let cellViewModel = viewModel.cellItemAt(indexPath: indexPath)
        cell.setData(viewModel: cellViewModel)
        guard let userId = self.keychain.get("userid") else { return UICollectionViewCell()}
        cell.setData(viewModel: cellViewModel)
        cell.strClosure = { [weak self] quanti in
            guard let self = self else { return }
            self.viewModel.plusButtonTapped(at: indexPath, userId: userId, quanti: Int(quanti) ?? 0)
            
        }
        
        cell.deleteProductInCartClosure = { [weak self]  in
            guard let self = self else { return }
            self.viewModel.deleteCartItem(userId: userId, itemId: self.viewModel.cellItems[indexPath.item].prdId ?? "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionFooter {
            let footerCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier:CheckOutReusableView.Identifier , for: indexPath) as! CheckOutReusableView
       
                if self.userCartItemCount == 0 {
                    footerCell.dontHaveCartItem.isHidden = false
                    footerCell.checkOutBtn.isHidden = true
                } else if self.userCartItemCount ?? 0 > 0 && self.userCartItemCount ?? 0  <= 4 {
                    footerCell.checkOutBtn.isHidden = false
                    footerCell.dontHaveCartItem.isHidden = true
                } else if self.userCartItemCount ?? 0  > 4 {
                    footerCell.dontHaveCartItem.isHidden = true
                }
          
            
            return footerCell
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return  CGSize(width: generalCollectionView.frame.width,
                       height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}

//MARK: - DelegateFlowLayout
extension CartVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: generalCollectionView.frame.width - 35,height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
}
//MARK: -
extension CartVC {
    private func setConstraints(){
     
        generalCollectionView.fillSuperview()
        checkOutRedButtonView.anchor(top: nil,
                            leading: view.leadingAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 0, left: 20, bottom: 0, right: 20),
                            size: .init(width: 0, height: 80)
        )
    }
}


