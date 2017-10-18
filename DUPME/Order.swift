//
//  Order.swift
//  DUPME
//
//  Created by Hossein on 28/03/2017.
//  Copyright © 2017 Dupify. All rights reserved.
//

import Firebase

enum OrderDetail: String {
    case key
    case imageCount
    case status
    case thumbnailURL
}

struct Order {
    let key: String
    let imageCount: Int
    let status: String
    let thumbnailURL: String

    init(child: FIRDataSnapshot) {
        let value = child.value as? NSDictionary
        let key = value?[OrderDetail.key.rawValue] as! String
        let imageCount = value?[OrderDetail.imageCount.rawValue] as! Int
        let status = value?[OrderDetail.status.rawValue] as! String
        let thumbnailURL = value?[OrderDetail.thumbnailURL.rawValue] as! String
        
        self.key = key
        self.imageCount = imageCount
        self.status = status
        self.thumbnailURL = thumbnailURL
    }
}


struct Model {
    let modelURL: URL
    let textureURL: URL
    
    init(modelURL: URL, textureURL: URL) {
        self.modelURL = modelURL
        self.textureURL = textureURL
    }
    
}



