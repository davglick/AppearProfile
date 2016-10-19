//
//  AddressGalleryView.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 12/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class AddressGalleryView: UIViewController, UIViewControllerTransitioningDelegate {
    
    var gravity: UIGravityBehavior!
    var animator: UIDynamicAnimator!
    
    let addressMapView = AddressMapView()
    
    let transition = CircularTransition()
    
    let addressMap = AddressMapView()

    
    @IBOutlet var addressGallery: UITableView!
    
    @IBOutlet var addressGalleryView: UIView!

    @IBOutlet var addressGalleryHeader: UIButton!
    
    @IBOutlet var addAddress: UIButton!
    
    

    var addresses = [""]
    
    var databaseRef: FIRDatabaseReference!
    
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Initiate the Firebase database 
        
        //databaseRef = FIRDatabase.database().reference().child("Delivery_Address")
        
        //databaseRef.observe(.value, with: { (snapshot) in
            
         //   var newAddress = [self.addresses]
            
           // for item in snapshot.children {
                
                //var newAddresses = selectedAddress(snapshot: item as! FIRDataSnapshot)
                //newAddress.insert(newAddress as! [String], at: 0)
                
           // }
            
           // self.addresses = newAddress as! [String]
           // self.addressGallery.reloadData()
            
          //  }) { (Error) in
                
            //    print(Error.localizedDescription)
      //  }
        
        
        
        
        // profile View Design
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.addressGalleryView.layer.cornerRadius = 4
        
        // address gallery grey header design
        
      self.addressGalleryHeader.layer.cornerRadius = 3
        
        
        // add address button design
        
        self.addAddress.layer.cornerRadius = self.addAddress.frame.size.width/2
        self.addAddress.layer.borderColor = UIColor(red: 160/255, green: 160/255, blue: 159/255, alpha: 1).cgColor
        self.addAddress.layer.borderWidth = 0.05
        self.addAddress.clipsToBounds = true
        
    // Create an observer to see chages in address table view 
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
    func animateOut () {
        
        UIView.animate(withDuration: 0.5, animations: {
            //self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0
            
            self.animator = UIDynamicAnimator(referenceView: self.addressGalleryView)
            self.gravity = UIGravityBehavior(items: [self.addressGalleryView])
            self.animator.addBehavior(self.gravity)
            
        }) { (success: Bool) in
            self.addressGalleryView.removeFromSuperview()
            
        }
        
        }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let mapViewVC = segue.destination as! AddressMapView
        mapViewVC.transitioningDelegate = self
        mapViewVC.modalPresentationStyle = .custom
        
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .present
        transition.startingPoint = addAddress.center
        transition.circleColor = addAddress.backgroundColor!
        
        return transition
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .dismiss
        transition.startingPoint = addAddress.center
        transition.circleColor = addAddress.backgroundColor!
        
        return transition
        
    }

    
    @IBAction func closeAddressPopUp(_ sender: AnyObject) {
        
        animateOut()
        
    }


}

