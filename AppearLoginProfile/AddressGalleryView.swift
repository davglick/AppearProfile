//
//  AddressGalleryView.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 12/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit

class AddressGalleryView: UIViewController {
    
    var gravity: UIGravityBehavior!
    var animator: UIDynamicAnimator!
    
    
    @IBOutlet var addressGallerView: UIView!

    @IBOutlet var addressGalleryHeader: UIButton!
    
    @IBOutlet var addAddress: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // profile View Design
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.addressGallerView.layer.cornerRadius = 4
        
        // address gallery grey header design
        
      self.addressGalleryHeader.layer.cornerRadius = 3
        
        
        // add address button design
        
        self.addAddress.layer.cornerRadius = self.addAddress.frame.size.width/2
        self.addAddress.layer.borderColor = UIColor(red: 160/255, green: 160/255, blue: 159/255, alpha: 1).cgColor
        self.addAddress.layer.borderWidth = 0.05
        self.addAddress.clipsToBounds = true
        


       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
    func animateOut () {
        
        UIView.animate(withDuration: 0.5, animations: {
            //self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0
            
            self.animator = UIDynamicAnimator(referenceView: self.addressGallerView)
            self.gravity = UIGravityBehavior(items: [self.addressGallerView])
            self.animator.addBehavior(self.gravity)
            
        }) { (success: Bool) in
            self.addressGallerView.removeFromSuperview()
            
        }
    }

    
    @IBAction func closeAddressPopUp(_ sender: AnyObject) {
        
        animateOut()
        
    }


}
