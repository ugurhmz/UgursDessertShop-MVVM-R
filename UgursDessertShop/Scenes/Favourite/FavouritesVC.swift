//
//  FavouritesVC.swift
//  UgursDessertShop
//
//  Created by ugur-pc on 24.06.2022.
//

import UIKit

class FavouritesVC: BaseViewController<FavouriteViewModel>{
    
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
    
    private func setupViews(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

}
extension FavouritesVC {
    private func setConstraints(){
        tableView.fillSuperview()
    }
}

extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.identifier,
                                                 for: indexPath) as! FavouriteCell
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
