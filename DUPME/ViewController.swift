//
//  ViewController.swift
//  DUPME
//
//  Created by Hossein on 06/12/2016.
//  Copyright © 2016 Dupify. All rights reserved.
//
//
// TabBarController

import UIKit
import Firebase

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating homeview (left view)
        let tabOneViewController = TabOneViewController()
        let leftTabBar = UINavigationController(rootViewController: tabOneViewController)
        let leftTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "left") , selectedImage: UIImage(named: "leftSelected"))
        leftTabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        leftTabBar.tabBarItem = leftTabBarItem
        
        //adding three views (left-add-account) to tab bar
        viewControllers = [leftTabBar , createViewController(relatedViewController: TabTwoViewController(), imageName: "add") , createViewController(relatedViewController: TabThreeViewController(), imageName: "account")]
        tabBar.isTranslucent = false
        UITabBar.appearance().tintColor = UIColor(red: 147/255, green: 62/255, blue: 197/255, alpha: 1)
        
        //modifying height and color of top border of TabBar
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.7)
        topBorder.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true

    }
    
    
    //function for creating tabbar items and viewControllers
    private func createViewController(relatedViewController: UIViewController, imageName: String ) -> UINavigationController {
        let navController = UINavigationController(rootViewController: relatedViewController)
        let tabBarItem = UITabBarItem(title: nil, image: UIImage(named: imageName) , selectedImage: nil)
        tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        navController.tabBarItem = tabBarItem
        return navController
    }
    
    
}




//code for hiding keyboard when touching arround
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
