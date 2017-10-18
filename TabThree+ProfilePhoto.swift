//
//  TabThreeHandler.swift
//  DUPME
//
//  Created by Hossein on 15/01/2017.
//  Copyright © 2017 Dupify. All rights reserved.
//

import UIKit
import Firebase
import LBTAComponents

extension TabThreeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
            uploadProfileImageToDatabase()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    private func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    func handleSelectProfileImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        let alert = UIAlertController(title: "Profile Photo", message: nil, preferredStyle: .actionSheet)
        
        
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: {
            action in
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        })
        
        
        let chooseFromGalleyAction = UIAlertAction(title: "Choose from Gallery", style: .default, handler: {
            action in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        })
        
        
        let removePhotoAction = UIAlertAction(title: "Remove Current Photo", style: .default, handler: {
            action in
            alert.view.tintColor = .red
            self.profileImageView.image = nil
            self.removeProfileImageFromDatabase()
        })
        removePhotoAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(takePhotoAction)
        alert.addAction(chooseFromGalleyAction)
        if profileImageView.image != nil {
            alert.addAction(removePhotoAction)
        }
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func loadProfileImageFromDatabase(){
        let userID = FIRAuth.auth()!.currentUser!.uid
        let ref = databaseRef.child("users/\(userID)")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            guard let imageURl = value?["profileImageURL"] else { return }
            self.profileImageView.loadImage(urlString: imageURl as! String)
        })
    }
    
    
    func loadUserDetailsFromDatabase(){
        let userID = FIRAuth.auth()!.currentUser!.uid
        let ref = databaseRef.child("users/\(userID)")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let userName = value?["name"] as? String
            let email = value?["email"] as? String
            self.userNameLable.text = userName
            self.userEmailLable.text = email
        })
    }
    
    
    private func removeProfileImageFromDatabase(){
        let userID = FIRAuth.auth()!.currentUser!.uid
        let ref = storageRef.child("Profile Images").child("\(userID).jpg")
        ref.delete { (error) in
            if error != nil {
                print(error!)
                return
            }
            let ref = self.databaseRef.child("users/\(userID)/profileImageURL")
            ref.removeValue()
        }
    }
    
    private func uploadProfileImageToDatabase(){
        
        let userID = FIRAuth.auth()!.currentUser!.uid
        let ref = storageRef.child("Profile Images").child("\(userID).jpg")
        
        let myImage = UIImageJPEGRepresentation(self.profileImageView.image!, 0.8)
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        ref.put(myImage!, metadata: metadata, completion: { (metadata, error) in
            if error != nil {
                print(error!)
            }
            if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                let ref = self.databaseRef.child("users/\(userID)/profileImageURL")
                ref.setValue(profileImageURL)
            }
        })
        
    }
    
    
    
    
}



