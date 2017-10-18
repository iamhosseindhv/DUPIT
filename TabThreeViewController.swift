//
//  TabThreeViewController.swift
//  DUPME
//
//  Created by Hossein on 06/12/2016.
//  Copyright © 2016 Dupify. All rights reserved.
//
//
// ACCOUNT SECTION

import UIKit
import Firebase
import LBTAComponents


class TabThreeViewController: UIViewController {

    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)

        
        
        view.addSubview(profileContainerView)
        view.addSubview(userBalanceView)
        
        
        setupNavBar()
        setupProfileContainerView()
        setupUserBalanceView()
        setupLogOutButton()
    }
    
    let profileContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.backgroundColor = UIColor.lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 38
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    let userNameLable: UILabel = {
        let lable = UILabel()
        lable.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    
    
    let userEmailLable: UILabel = {
        let lable = UILabel()
        lable.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        lable.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let userLocationLable: UILabel = {
        let lable = UILabel()
        lable.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        lable.font = UIFont(name: "HelveticaNeue-Thin", size: 13)
        lable.textColor = UIColor(red: 147/255, green: 62/255, blue: 197/255, alpha: 1)
        lable.text = "Leeds, UK"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let editInfo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "options")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let userBalanceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let userBalanceLable: UILabel = {
        let lable = UILabel()
        lable.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        lable.text = "Balance:"
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    
    func setupProfileContainerView() {
        
        profileContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        profileContainerView.heightAnchor.constraint(equalToConstant: 104).isActive = true
        
    
        profileContainerView.addSubview(profileImageView)
        profileContainerView.addSubview(userNameLable)
        profileContainerView.addSubview(userEmailLable)
        profileContainerView.addSubview(userLocationLable)
        profileContainerView.addSubview(editInfo)

        
        
        profileImageView.topAnchor.constraint(equalTo: profileContainerView.topAnchor, constant: 14).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: profileContainerView.leftAnchor, constant: 14).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 76).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 76).isActive = true
        profileImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView))
        profileImageView.addGestureRecognizer(tap)
        
        
        userNameLable.topAnchor.constraint(equalTo: profileContainerView.topAnchor, constant: 17).isActive = true
        userNameLable.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 14).isActive = true
        userNameLable.widthAnchor.constraint(equalTo: profileContainerView.widthAnchor, multiplier: 3/5).isActive = true
        userNameLable.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        userEmailLable.topAnchor.constraint(equalTo: userNameLable.bottomAnchor, constant: 1).isActive = true
        userEmailLable.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 14).isActive = true
        userEmailLable.widthAnchor.constraint(equalTo: profileContainerView.widthAnchor, multiplier: 3/5).isActive = true
        userEmailLable.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        userLocationLable.topAnchor.constraint(equalTo: userEmailLable.bottomAnchor, constant: 1).isActive = true
        userLocationLable.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 14).isActive = true
        userLocationLable.widthAnchor.constraint(equalTo: profileContainerView.widthAnchor, multiplier: 3/5).isActive = true
        userLocationLable.heightAnchor.constraint(equalToConstant: 20).isActive = true

        editInfo.centerYAnchor.constraint(equalTo: profileContainerView.centerYAnchor).isActive = true
        editInfo.leftAnchor.constraint(equalTo: userNameLable.rightAnchor).isActive = true
        editInfo.widthAnchor.constraint(equalToConstant: 20).isActive = true
        editInfo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        editInfo.isUserInteractionEnabled = true
        let tapme = UITapGestureRecognizer(target: self, action: #selector(handleEditInfo))
        editInfo.addGestureRecognizer(tapme)
        
        
        
        loadUserDetailsFromDatabase()
        loadProfileImageFromDatabase()

    }
    
    func setupUserBalanceView(){
        userBalanceView.topAnchor.constraint(equalTo: profileContainerView.bottomAnchor).isActive = true
        userBalanceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userBalanceView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        userBalanceView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        userBalanceView.addSubview(userBalanceLable)
        
        
        userBalanceLable.topAnchor.constraint(equalTo: userBalanceView.topAnchor, constant: 10).isActive = true
        userBalanceLable.leftAnchor.constraint(equalTo: userBalanceView.leftAnchor, constant: 14).isActive = true
        userBalanceLable.widthAnchor.constraint(equalToConstant: 70).isActive = true
        userBalanceLable.heightAnchor.constraint(equalTo: userBalanceView.heightAnchor, constant: -20).isActive = true
    }
    
    
    //logOut Button
    var logOutButton: UIButton!
    func setupLogOutButton(){
        logOutButton = UIButton(type: .system)
        logOutButton.setTitle( "Sign Out", for: UIControlState.normal)
        logOutButton.bounds = CGRect(x: 0, y: 0, width: 100, height: 50)
        logOutButton.center = CGPoint(x: view.bounds.width / 2 , y: 210)
        logOutButton.backgroundColor = UIColor.red
        logOutButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        logOutButton.addTarget(self, action: #selector(handleLogOut), for: UIControlEvents.touchUpInside)
        view.addSubview(logOutButton)
    }

    //handle logout function
    func handleLogOut(){
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    //handle setting section - present it
    func handleSettingSection(){
        let settingController = SettingController()
        navigationController?.pushViewController(settingController, animated: true)
    }
    
    func setupNavBar(){
        navigationItem.title = "Account"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"setting"), style: .plain, target: self, action: #selector(handleSettingSection))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black

    }
    
    func handleEditInfo(){

    }
    

}
