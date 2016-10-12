//
//  ViewProfilePopUp.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 10/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import Canvas
import FBSDKLoginKit
import FBSDKCoreKit

class ViewProfilePopUp: UIViewController {
  
    
    @IBOutlet var profileName: UILabel!
 
    @IBOutlet var profileView: UIView!
    
    @IBOutlet var profileEmail: UILabel!
    
    @IBOutlet var logout: UIButton!
    
    @IBOutlet var profilePicture: UIImageView!
    
    
     @IBAction func didTapLogout(_ sender: AnyObject) {
     
     // Signs the user out of the firebase App
     try! FIRAuth.auth()!.signOut()
     
     // Sign use out of Facebook App
     
     FBSDKAccessToken.setCurrent(nil)
     
     
     // Go back to the login screen
     
     let mainStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
     let ViewController: UIViewController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginScreen")
     
     self.present(ViewController, animated: true, completion:  nil)
     
     
     }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }

    var gravity: UIGravityBehavior!
    var animator: UIDynamicAnimator!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // make the profile picture round
        
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width/2
        self.profilePicture.layer.borderColor = UIColor(red: 160/255, green: 160/255, blue: 159/255, alpha: 1).cgColor
        self.profilePicture.layer.borderWidth = 0.5
        self.profilePicture.clipsToBounds = true
        
        
        // profile View Design
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.profileView.layer.cornerRadius = 4
        
        // logout button design 
        
        self.logout.layer.cornerRadius = 3
        
        
        if let user = FIRAuth.auth()?.currentUser {
            
            // User is signed in.
            
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid
            
            
            //  Display Profile Name, Photo and Email
            
            let data = NSData(contentsOf: photoUrl!)
            self.profilePicture.image = UIImage(data: data! as Data)
            self.profileName.text = user.displayName
            self.profileEmail.text = user.email
        
            
            }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func animateOut () {
        
        UIView.animate(withDuration: 0.5, animations: {
            //self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0

            self.animator = UIDynamicAnimator(referenceView: self.profileView)
            self.gravity = UIGravityBehavior(items: [self.profileView])
            self.animator.addBehavior(self.gravity)
            
        }) { (success: Bool) in
            self.profileView.removeFromSuperview()
            
        }
    }

 
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25) { 
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        };
    }
    
    
    @IBAction func closePopUp(_ sender: AnyObject) {
        
        animateOut()
    }
 
    
}


