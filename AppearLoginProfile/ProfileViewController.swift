
//
//  ProfileViewController.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 4/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import FirebaseStorage


class ProfileViewController: UIViewController {
    
    
   // @IBOutlet var closePopUp: UIButton!
   
   
    
    @IBOutlet var profileCellView: UIView!
    
    @IBOutlet var profileView: UIView!
    
    @IBOutlet var addressView: UIView!
    
    @IBOutlet var paymentView: UIView!
    
    @IBOutlet var profilePicture: UIImageView!
    
    @IBOutlet var profileViewTrigger: UIButton!
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
 
            
            // Customize the Profile View
            
            self.profileCellView.layer.cornerRadius = 4
            self.profileCellView.layer.borderWidth = 1
            self.profileCellView.layer.borderColor = UIColor(red:190/255.0, green:191/255.0, blue:191/255.0, alpha: 0.5).cgColor
            
            // Customize Address View
            
            self.addressView.layer.cornerRadius = 4
            self.addressView.layer.borderWidth = 1
            self.addressView.layer.borderColor = UIColor(red:190/255.0, green:191/255.0, blue:191/255.0, alpha: 0.5).cgColor
            
            
            // Customize Payment View
            
            self.paymentView.layer.cornerRadius = 4
            self.paymentView.layer.borderWidth = 1
            self.paymentView.layer.borderColor = UIColor(red:190/255.0, green:191/255.0, blue:191/255.0, alpha: 0.5).cgColor

            
            // make the profile picture round
            
            self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width/2
            self.profilePicture.layer.borderColor = UIColor(red: 160/255, green: 160/255, blue: 159/255, alpha: 1).cgColor
            self.profilePicture.layer.borderWidth = 0.5
            self.profilePicture.clipsToBounds = true
            
            if let user = FIRAuth.auth()?.currentUser {
                
                // User is signed in.
                
                let name = user.displayName
                let email = user.email
                let photoUrl = user.photoURL
                let uid = user.uid
                
                
              //  self.profileName.text = user.displayName
                
                let data = NSData(contentsOf: photoUrl!)
                self.profilePicture.image = UIImage(data: data! as Data)
                
                
                // Firebase storage
                
                
                // Referance to storage
                
                let storage = FIRStorage.storage()
                
                
                // Refeance to our storage service
                let storageRef = storage.reference(forURL: "gs://appearprofile.appspot.com")
                
                
                var profilePic = FBSDKGraphRequest(graphPath: "me/picture", parameters: ["height": 300, "width": 300,"redirect": false], httpMethod: "GET")
                profilePic?.start(completionHandler: {(connection, result, error) -> Void in

                    // Handle the result
                    
                    if(error == nil)
                        
                    {
                        let dictionary = result as? NSDictionary
                        let data = dictionary?.object(forKey: ("data"))
                        
                        let urlPic = (data as AnyObject?)?.object(forKey:"url")! as! String
      

                        if let imageData = NSData(contentsOf: NSURL(string:urlPic)! as URL)
                            
                        {
                            let profilePicRef = storageRef.child(user.uid+"/profile_pic.jpg")
                            
                            let uploadTask = profilePicRef.put(imageData as Data, metadata: nil) {
                                
                                metadata, error in
                                
                                if(error == nil)
                                {
                                    
                                    let downloadUrl = metadata!.downloadURL
                                }
                                
                                else
                                
                                {
                            }
                                print("error in downoalding image")
                            
                            
                        }
                        
                    }
                }
        
    
                            
    })
            
        } else {
                    
        // No user is signed in.
                    
        }
        
    }
    

    @IBAction func showPopUpView(_ sender: AnyObject) {
        
        let popUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileViewPopUp") as! ViewProfilePopUp
        self.addChildViewController(popUpVc)
        popUpVc.view.frame = self.view.frame
        self.view.addSubview(popUpVc.view)
        popUpVc.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}








