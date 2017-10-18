//
//  SettingController.swift
//  DUPME
//
//  Created by Hossein on 22/12/2016.
//  Copyright © 2016 Dupify. All rights reserved.
//
//
//setting view

import UIKit
import LBTAComponents

class SettingController: DatasourceController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        let homeDatasource = HomeDatasource3()
        self.datasource = homeDatasource
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(datasource?.item(indexPath)! as Any)
    }
    

}


class HomeDatasource3: Datasource {
    
    let content = ["Share This App", "DUPME on Social Media", "Edit Account Info", "Language", "Settings", "Share This App", "Report a Bug", "Help Center", "Supports", "Community Guidelines", "Terms of Use", "Privscy Policy", "Licences and Credits", "About", "Log Out"]
    
    override func footerClasses() -> [AnyClass]? {
        return [SettingFooter.self]
    }
    
    override func headerClasses() -> [AnyClass]? {
        return [SettingHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [SettingCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return content[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return content.count
    }
    
}


class SettingHeader: DatasourceCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "WHO TO FOLLOW"
        label.font = UIFont.systemFont(ofSize: 16)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()

    override func setupViews() {
    
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
    
        addSubview(nameLabel)
        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}


class SettingFooter: DatasourceCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Footer"
        label.font = UIFont.systemFont(ofSize: 16)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    override func setupViews() {
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(nameLabel)
        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}


class SettingCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet{
            nameLabel.text = datasourceItem as? String
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Freight-Sans", size: 13)
        return label
    }()
    
    override func setupViews() {
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(nameLabel)
        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}



//handle logout function
//func handleeeLogOut(){
//    do {
//        try FIRAuth.auth()?.signOut()
//    } catch let logoutError {
//        print(logoutError)
//    }
//    let loginController = LoginController()
//    present(loginController, animated: true, completion: nil)
//}
