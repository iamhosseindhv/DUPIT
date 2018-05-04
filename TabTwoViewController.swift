//
//  TabTwoViewController.swift
//  DUPME
//
//  Created by Hossein on 06/12/2016.
//  Copyright © 2016 Dupify. All rights reserved.
//
//
// TAKE PICTURE SECTION

import UIKit
import ImagePicker
import Firebase
import LBTAComponents


class TabTwoViewController: DatasourceController , UINavigationBarDelegate, UserCellDelegate {
    
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    var fullListOfOrders = [Order]()
    var downloadedModels = [IndexPath: Model]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    
        fetchOrders()
        setupProfressView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(downloadedModels)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        print(downloadedModels)
//        let model = downloadedModels[indexPath]
//        print(model)
        
//        var orderCell = datasource?.item(indexPath) as! Order
//        let texturePath = orderCell.textureURL
//        //if there exists a file for texture url, then definitely there is file for module url.
//        print(orderCell)
//        
//        if localFileExists(atPath: texturePath!) {
//            let modelurl = URL(string: orderCell.modelURL!)
//            let textureurl = URL(string: texturePath!)
//            showModel(modelURL: modelurl!, textureURL: textureurl!)
//        }
        collectionView.deselectItem(at: indexPath, animated: true)
        
//        code for how to remove item
//        let userID = FIRAuth.auth()!.currentUser!.uid
//        let ref = databaseRef.child("users/\(userID)/orders/\(key)")
//        ref.removeValue()
    }
    
    
    func setupNavBar(){
        navigationItem.title = "New Model"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "upload"), style: .plain, target: self, action: #selector(handleUpload))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    var progressView: UIProgressView!
    func setupProfressView(){
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.center = CGPoint(x: view.bounds.width / 2 , y: 1)
        progressView.bounds = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        progressView.backgroundColor = .red
        progressView.progressTintColor = UIColor(r: 147, g: 62, b: 197)
        progressView.trackTintColor = UIColor(r: 217, g: 217, b: 217)
        view.addSubview(progressView)
    }

    
    func handleUpload(){
        let imagePicker = ImagePickerController()
        imagePicker.delegate = self
//        imagePicker.imageLimit = 20
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func localFileExists(atPath path: String) -> Bool {
        var isDir : ObjCBool = false
        return FileManager.default.fileExists(atPath: path, isDirectory: &isDir)        
    }
    
    func localPath(forURL address: String) -> URL {
        let ref = FIRStorage.storage().reference(forURL: address)
        let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let localPath = fileManager?.appendingPathComponent(ref.name) else {
            fatalError("cannot create local path for given URL address")
        }
        return localPath
    }
    
    
    func showModel(modelURL: URL, textureURL: URL){
        let modelViewController = ModelViewerController()
        modelViewController.modelURL = modelURL
        modelViewController.textureURL = textureURL
        navigationController?.pushViewController(modelViewController, animated: true)
    }
    
    func downloadModel(forCell cell: UserCell, modelURL: String, textureURL: String, completion: @escaping ((Model) ->())) {
        
        // Download .obj file
        let modelRef = FIRStorage.storage().reference(forURL: modelURL)
        let modelPath = localPath(forURL: modelURL)
        modelRef.write(toFile: modelPath) { (modelurl, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            // Download texture
            let textureRef = FIRStorage.storage().reference(forURL: textureURL)
            let texturePath = self.localPath(forURL: textureURL)
            textureRef.write(toFile: texturePath) { (textureurl, err) in
                if err != nil {
                    print(error.debugDescription)
                    return
                }
                let model = Model(modelURL: modelPath, textureURL: texturePath)
                completion(model)
            }
            
        }
        //attach observers for failure and download progress
        
    }
    
    
    
    // Mark - UserCell Delegate
    
    func downloadClicked(_ cell: UserCell) {
        let mycollectionView = cell.superview as! UICollectionView
        let indexPath = mycollectionView.indexPath(for: cell)
        let orderCell = cell.controller?.datasource?.item(indexPath!) as! Order
        let key = orderCell.key
        
        let userID = FIRAuth.auth()!.currentUser!.uid
        let ref = FIRDatabase.database().reference().child("users/\(userID)/orders/\(key)")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            let modelURL = value["modelURL"] as! String
            let textureURL = value["textureURL"] as! String
            

            
            self.downloadModel(forCell: cell, modelURL: modelURL, textureURL: textureURL, completion: { (model) in
                
                self.downloadedModels[indexPath!] = model
                print(self.downloadedModels)
                
//                print(orderCell)
//                orderCell.modelURL = urls[0].path
//                orderCell.textureURL = urls[1].path
//                orderCell.imageCount = 100
                
            })
            
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



