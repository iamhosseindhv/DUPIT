//
//  TabOneViewController.swift
//  DUPME
//
//  Created by Hossein on 06/12/2016.
//  Copyright © 2016 Dupify. All rights reserved.
//
//
// FEED/NEWS SECTION

import UIKit
import Firebase

class TabOneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupBackgroundColour()
        
        
        
        

        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogOut), with: nil, afterDelay: 0)
        }
    }
    
    
    //gradient background
    func setupBackgroundColour(){
        let topColour = UIColor(red: (66/255.0), green: (39/255.0), blue: (90/255.0), alpha: 1)
        let bottomColour = UIColor(red: (154/255.0), green: (101/255.0), blue: (146/255.0), alpha: 1)
        let gradientColours : [CGColor] = [topColour.cgColor, bottomColour.cgColor]
        let gradientLocations : [Float] = [0.0, 1.0]
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColours
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    func handleLogOut(){
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
