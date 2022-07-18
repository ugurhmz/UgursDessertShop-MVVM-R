//
//  ViewController.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 24.06.2022.
//

import UIKit
import KeychainSwift

class HomeVC: BaseViewController<HomeViewModel> {
    private let keychain = KeychainSwift()
    var favData: [FavouriteCellProtocol] = []
    var filterClosure: StringClosure?
    var selectedIndex = Int ()
    var userID: String?
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let generalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: HomeVC.createCompositionalLayout())
        cv.backgroundColor = HomeBgColor
        
        //header
               cv.register(CellHeaderView.self, forSupplementaryViewOfKind: "header",
                           withReuseIdentifier:   CellHeaderView.identifier)
        cv.register(NavBarCollectionCell.self, forCellWithReuseIdentifier: NavBarCollectionCell.identifier)
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        cv.register(ProductsCell.self, forCellWithReuseIdentifier: ProductsCell.identifier)
        return cv
    }()

   static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
       let mylayout = UICollectionViewCompositionalLayout {  (index, environment) -> NSCollectionLayoutSection? in
           return  HomeVC.createSectionFor(index: index, environment: environment)
        }
        return mylayout
    }
    
    static func createSectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch index {
            
        case 0:
            return createNavBarSection()
        case 1:
            return createCategoriesSection()
        case 2:
            return createProductsSection()
        default:
            return  createProductsSection()
        }
    }
    
    static func createNavBarSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
       
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
       let section = NSCollectionLayoutSection(group: group)
       section.orthogonalScrollingBehavior = .continuous
      /*  // suplementary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(55))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "header",
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header] */
       return section
    }
    
    static func createCategoriesSection() -> NSCollectionLayoutSection {
        
        let inset: CGFloat = 1
      
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: .fractionalHeight(0.67))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                     leading: 16,
                                                     bottom: inset,
                                                     trailing: 4)
     
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .fractionalHeight(0.10))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem:  item, count: 2)
     
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(80))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "header",
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    static func createProductsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(300)))
       item.contentInsets.bottom = 16
       item.contentInsets.trailing = 16
       
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
       
       let section = NSCollectionLayoutSection(group: group)
       section.contentInsets = .init(top: 2, leading: 16, bottom: 0, trailing: 0)
       return section
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        generalCollectionView.allowsMultipleSelection = false
        searchBarConfigure()
        
        viewModel.fetchAllProducts(categoryQuery: "")
        viewModel.fetchAllCategory()
        
        guard let userId =  self.keychain.get("userid") else {return }
        userID = userId
        viewModel.fetchCurrentUserDetail(userId: userId)
        
    
        self.viewModel.userDetailClosure = { [weak self] in
            guard let self = self else { return}
            
            self.userProfileIconSettings(self.viewModel.userDetail?.userImg ?? "")
            self.navigationItem.title = "Hi, \(self.viewModel.userDetail?.username ?? "-")"
        }
        
        
        self.filterClosure = { [weak self] categoryName in
            guard let self = self else {return }
            self.viewModel.fetchAllProducts(categoryQuery: categoryName)
        }
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let userId =  self.keychain.get("userid") else {return }
        
        self.viewModel.fetchUserFavItems(userId: userId)
        self.viewModel.favDataClosure = { [weak self] in
            guard let self = self else { return}
            self.generalCollectionView.reloadData()
        }
        
       
    }
    
    private func userProfileIconSettings(_ img: String) {
        let img = UIImage(named: "\(img)")
        let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
        
        // NEW CODE HERE: Setting the constraints
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.layer.borderWidth = 1
        imageView.image = img
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        let barButton = UIBarButtonItem(customView: imageView)
        self.navigationItem.rightBarButtonItems = [barButton]
    }
    
    private func setupViews(){
        view.addSubview(generalCollectionView)
        generalCollectionView.dataSource = self
        generalCollectionView.delegate = self
        generalCollectionView.collectionViewLayout = HomeVC.createCompositionalLayout()
        
        self.viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.generalCollectionView.reloadData()
        }
    }
    
    private func  searchBarConfigure() {
        customSearchBarStyle()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = self.searchController
        searchController.searchBar.tintColor  = .black
        //searchController.searchBar.delegate = self
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        searchController.searchBar.barTintColor = .black
       
    }
    
    private func customSearchBarStyle(){
        
         if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            //navBarAppearance.configureWithOpaqueBackground()
             navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font: UIFont(name: "Charter-Black", size: 30)!]
           
             navigationController?.navigationBar.barStyle = .black
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

            navigationController?.navigationBar.prefersLargeTitles = true
          
            }
    }
}

extension HomeVC {
    private func setConstraints(){
        generalCollectionView.fillSuperview()
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Sections.SearchSection.rawValue:
            return 1
        case Sections.CategoriesSection.rawValue:
            guard let categoryCount = viewModel.categoryArray?.count else {
                return 0
            }
            return categoryCount
        case Sections.ProductsSection.rawValue:
            guard let prdArr = viewModel.productArray else {
                return 0
            }
            return prdArr.count
        default:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            
        case  Sections.SearchSection.rawValue:
            let searchCell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: NavBarCollectionCell.identifier, for: indexPath) as! NavBarCollectionCell
            return searchCell
            
        case Sections.CategoriesSection.rawValue:
            
            let categoryCell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            
            guard let categoryDatas = viewModel.categoryArray else { return UICollectionViewCell() }
            
            categoryCell.fillData(data: categoryDatas[indexPath.row])
            // select category
           if selectedIndex == indexPath.row {
               categoryCell.configure(select: true)
               print(categoryDatas[selectedIndex])
           }
           else {
               categoryCell.configure(select: false)
           }
            
            
            return categoryCell
        case Sections.ProductsSection.rawValue:
            let productsCell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.identifier, for: indexPath) as! ProductsCell
            productsCell.backgroundColor = .white
            
            
            if let  prdModel = viewModel.productArray?[indexPath.item] {
                productsCell.configure(productModel: prdModel, favItems: self.viewModel.userFavItems)
            }
            
            
            
            productsCell.addCartClosure = { [weak self] in
                guard let self = self else { return}
                if let  prdModelId = self.viewModel.productArray?[indexPath.item].prdId {
        
                    self.viewModel.addToCartItem(userId: self.userID ?? "",
                                                     itemId: prdModelId,
                                                     quantity: 1)
                }
            }
            
            productsCell.addToFavClosure = { [weak self] in
                guard let self = self else { return}
             
                if let  prdModelId = self.viewModel.productArray?[indexPath.item].prdId {
        
                    self.viewModel.addToFavItem(userId: self.userID ?? "",
                                                     itemId: prdModelId)
                }
                self.generalCollectionView.reloadData()
            }
            
            
            return productsCell
        default:
           return UICollectionViewCell()
        }
    }
    
    // viewForSupplementaryElementOfKind
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: CellHeaderView.identifier, for: indexPath) as! CellHeaderView
        
        switch indexPath.section {
        case Sections.SearchSection.rawValue:
            view.titleLabel.text = ""
            case Sections.CategoriesSection.rawValue:
                view.titleLabel.text = "Categories"
            case Sections.ProductsSection.rawValue:
                view.titleLabel.text = ""
            default:
                return UICollectionReusableView()
        }
        return view
    }
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedIndex = indexPath.row
            if selectedIndex == 0 {
                viewModel.fetchAllProducts(categoryQuery: "")
                return
            }
            guard let categoryDatas = viewModel.categoryArray else { return  }
            
            if let categoryName = categoryDatas[selectedIndex].name {
                self.filterClosure?(categoryName)
            }
           
        }
    }
}
