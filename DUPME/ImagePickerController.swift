//
//  ImagePickerController.swift
//  DUPME
//
//  Created by Hossein on 27/03/2017.
//  Copyright © 2017 Dupify. All rights reserved.
//

import Firebase
import ImagePicker

extension TabTwoViewController: ImagePickerDelegate {

    
    
    // MARK: - ImagePickerDelegate
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        //        guard images.count > 0 else { return }
        //
        //        let lightboxImages = images.map {
        //            return LightboxImage(image: $0)
        //        }
        //
        //        let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
        //        imagePicker.present(lightbox, animated: false, completion: nil)
    }
    
    
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        let subOrderName = databaseRef.childByAutoId().key
        let imageCount = images.count
        //upload taken photos
        uploadPhotos(images: images, subOrderName: subOrderName)
        //upload data of order to database
        uploadOrderData(imagesCount: imageCount, subOrderName: subOrderName)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    private func uploadPhotos(images: [UIImage], subOrderName: String){
        
        var i = 1
        var success = 0
        let imageCount = images.count
        let userID = FIRAuth.auth()!.currentUser!.uid
        progressView.setProgress(0.0, animated: false)
        
        for image in images {
            
            let orderRef = storageRef.child("orders/\(userID)/\(subOrderName)").child("\(userID)_\(subOrderName)_\(i).jpg")
            i += 1
            
            let myImage = UIImageJPEGRepresentation(image, 0.8)
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let uploadTask = orderRef.put(myImage!, metadata: metadata, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                } else {
                    success += 1
                    print("success!!")
                    let progresss = Float(success) / Float(imageCount)
                    self.progressView.setProgress(progresss, animated: true)

                    if (success == imageCount){
                        //all photos updated, so update status
                        let orderRef = self.databaseRef.child("users/\(userID)/orders/\(subOrderName)/status")
                        orderRef.setValue("Creating 3D Model")
                    }
                }
            })
            uploadTask.observe(.failure, handler: { (snapshot) in
//                print(snapshot)
            })
        }
        //reset imageNameCounter
        i = 1
        
    }
    
    
    
    private func uploadOrderData(imagesCount: Int, subOrderName: String){
        let userID = FIRAuth.auth()!.currentUser!.uid
        let orderRef = databaseRef.child("users/\(userID)/orders/\(subOrderName)")
        let values = ["key":subOrderName, "imageCount":imagesCount, "status":"Uploading photos", "thumbnailURL":"https://firebasestorage.googleapis.com/v0/b/dupme-2692d.appspot.com/o/KmVeMWDlmvfe6TnJkvmQsqqt4O33%2FED901CFB-5E64-4F6B-B714-7DA361B98870%2FKmVeMWDlmvfe6TnJkvmQsqqt4O33_ED901CFB-5E64-4F6B-B714-7DA361B98870_14.jpg?alt=media&token=0724f707-c5f4-44ca-98c7-19b65315c099"] as [String : Any]
        orderRef.setValue(values)
    }
    
    
    //fetch orders from database
    func fetchOrders(){
        let userID = FIRAuth.auth()!.currentUser!.uid
        let ref = databaseRef.child("users/\(userID)/orders")
        ref.observe(.value, with: { (snapshot) in
            self.fullListOfOrders = []
            for child in snapshot.children.allObjects as! [FIRDataSnapshot]{

                let order = Order(child: child)
                let first = self.fullListOfOrders.startIndex
                self.fullListOfOrders.insert(order, at: first)

                let homeDatasource = HomeDatasource()
                homeDatasource.orders = self.fullListOfOrders
                self.datasource = homeDatasource
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    
    


}
