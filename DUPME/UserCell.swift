//
//  UserCell.swift
//  DUPME
//
//  Created by Hossein on 29/03/2017.
//  Copyright © 2017 Dupify. All rights reserved.
//

import LBTAComponents

protocol UserCellDelegate: class {
    
    func downloadClicked(_ cell: UserCell)
    
}

class UserCell: DatasourceCell {
    
    var delegate: UserCellDelegate? = nil
    
    override var datasourceItem: Any? {
        didSet {
            guard let order = datasourceItem as? Order else { return }
            statusLabel.text = "Status: \(order.status)"
            imageCountLabel.text = "No. of images: \(order.imageCount)"
            thumbnailImageView.loadImage(urlString: order.thumbnailURL)
            
            switch order.status {
            case "3D Model Created":
                viewButton.isHidden = true
                downloadButton.isHidden = false
            default:
                viewButton.isHidden = false
                downloadButton.isHidden = true
            }
            
            
        }
    }
    
    let thumbnailImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.backgroundColor = .white
//        imageView.image = UIImage(named: "default_profile_img")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .orange
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let imageCountLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        //like ... button in soundcloud and youtube. something slides up from the bottom of the view. LBTA has a tutorial fro youtube version of this
        button.setTitle("...", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let viewButton: UIButton = {
        let button = UIButton(type: .system)
//        button.setTitle( "hi", for: UIControlState.normal)
//        button.backgroundColor = .red
        button.setImage(#imageLiteral(resourceName: "view"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        button.isHidden = false
        return button
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "download"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(downloadClicked), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    
    let progressView: UIProgressView = {
        let pview = UIProgressView(progressViewStyle: .default)
        pview.trackTintColor = .purple
        pview.progressTintColor = .red
//        pview.progressTintColor = UIColor(r: 147, g: 62, b: 197)
        return pview
    }()
    

    
    
    override func setupViews() {
        super.setupViews()
        
        let tabTwoViewController = TabTwoViewController()
        delegate = tabTwoViewController
        
        backgroundColor = UIColor(r: 242, g: 242, b: 242)
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(thumbnailImageView)
        addSubview(imageCountLabel)
        addSubview(statusLabel)
        addSubview(moreButton)
        addSubview(downloadButton)
        addSubview(viewButton)
        addSubview(progressView)

        thumbnailImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 75, heightConstant: 75)
        
        statusLabel.anchor(thumbnailImageView.topAnchor, left: thumbnailImageView.rightAnchor, bottom: nil, right: viewButton.leftAnchor, topConstant: 5, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 25)
        
        imageCountLabel.anchor(statusLabel.bottomAnchor, left: statusLabel.leftAnchor, bottom: nil, right: viewButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 25)
        
        moreButton.anchor(downloadButton.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: -4, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 25)
        
        
        viewButton.anchor(nil, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 20, heightConstant: 25)
        viewButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        downloadButton.anchor(nil, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 20, heightConstant: 25)
        downloadButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        downloadButton.addTarget(self, action: #selector(downloadClicked), for: .touchUpInside)
        
        progressView.anchor(nil, left: thumbnailImageView.rightAnchor, bottom: thumbnailImageView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 5, rightConstant: 0, widthConstant: self.bounds.width/2 , heightConstant: 3)
        
    }
    
    
    
    func downloadClicked(){
        guard let delegate = delegate else {
            print("delegate is nil")
            return
        }
        delegate.downloadClicked(self)
    }
    
    
    
}
