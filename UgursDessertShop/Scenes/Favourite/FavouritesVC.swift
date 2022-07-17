//
//  FavouritesVC.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 24.06.2022.
//

import UIKit
import KeychainSwift

class FavouritesVC: BaseViewController<FavouriteViewModel>{
    private let keychain = KeychainSwift()
    private let tableView: UITableView = {
            let tableView = UITableView()
           tableView.register(FavouriteCell.self,
                              forCellReuseIdentifier: FavouriteCell.identifier)
            return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let userid = self.keychain.get("userid") {
            viewModel.fetchUserFavItems(userId: userid)
         }
        
        self.viewModel.reloadDataClosure = { [weak self] in
            guard let self = self else { return}
            print("data", self.viewModel.userFavItems.count)
            self.tableView.reloadData()
        }
       
    }
    
    private func setupViews(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    

}
extension FavouritesVC {
    private func setConstraints(){
        tableView.fillSuperview()
    }
}

extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.userFavItems.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.identifier,
                                                 for: indexPath) as! FavouriteCell
        
        cell.fillData(data: self.viewModel.userFavItems[indexPath.row])
        cell.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
   
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x,
                                 y: cell.bounds.origin.y,
                                 width: cell.bounds.width,
                                 height: cell.bounds.height).insetBy(dx: 8, dy: verticalPadding/1.2)
        cell.layer.mask = maskLayer
    }

}
