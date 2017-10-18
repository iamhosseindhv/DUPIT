//
//  View1.swift
//  SlidePage
//
//  Created by ibrahim on 10/17/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import UIKit

class View1: UIView {

    var contentView : UIView?
    @IBOutlet weak var slideImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView!.frame = bounds
        
        // Make the view stretch with containing view
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        
        // initiate view
        let mountainImg = UIImage(named: "mountain")
        let contextImg = UIImage(cgImage: (mountainImg?.cgImage)!)
        let rect = CGRect(x: 0, y: 0, width: (self.contentView?.frame.width)!,height: (self.contentView?.frame.height)!)
        let imgRef = (contextImg.cgImage)!.cropping(to: rect)
        
        slideImage.image = UIImage(cgImage: imgRef!, scale: (mountainImg?.scale)!, orientation: (mountainImg?.imageOrientation)!)
        
        self.layoutIfNeeded()
        
        addSubview(contentView!)
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
