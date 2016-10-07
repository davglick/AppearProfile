
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
    
    //@IBOutlet var profilePicture: UIView!
    
    @IBOutlet var profileName: UILabel!
    
    @IBOutlet var profileView: UIView!
    
    @IBOutlet var addressView: UIView!
    
    @IBOutlet var paymentView: UIView!
    
    @IBOutlet var profilePicture: UIImageView!
    
    @IBOutlet var addAddress: UIButton!
    
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
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Customize the Profile View
            
            self.profileView.layer.cornerRadius = 4
            self.profileView.layer.borderWidth = 1
            self.profileView.layer.borderColor = UIColor(red:190/255.0, green:191/255.0, blue:191/255.0, alpha: 0.5).cgColor
            
            // Customize Address View
            
            self.addressView.layer.cornerRadius = 4
            self.addressView.layer.borderWidth = 1
            self.addressView.layer.borderColor = UIColor(red:190/255.0, green:191/255.0, blue:191/255.0, alpha: 0.5).cgColor
            
            
            // Customize Payment View
            
            self.paymentView.layer.cornerRadius = 4
            self.paymentView.layer.borderWidth = 1
            self.paymentView.layer.borderColor = UIColor(red:190/255.0, green:191/255.0, blue:191/255.0, alpha: 0.5).cgColor
            
            
            // Address Gallery Button Rounded
            
            self.addAddress.layer.cornerRadius = 3
            
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
                
                self.profileName.text = user.displayName
                
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
        
                /*
        // Firebase storage 
        
        
        // Referance to storage 
        
        let storage = FIRStorage.storage()
        
        // Refeance to our storage service
        let storageRef = storage.reference(forURL: "gs://appearprofile.appspot.com")
        
        var profilePic = FBSDKGraphRequest(graphPath: "me", parameters: ["height": 300, "width": 300, "redircet": false], httpMethod: "GET")
        
        profilePic?.start(completionHandler: {(connection, result, error) -> Void in
            // Handle the result
            
            if(error == nil)
            {
                
                let dictionary = result as? NSDictionary
                let data = dictionary?.object(forKey: "data")
                
                let urlPic = ((data as AnyObject).object(forKey: "url"))! as! String
                
                if let imageData = NSData(contentsOf: NSURL(string: urlPic)! as URL)
                    
                {
                    
                    let profilePicRef = storageRef.child(user.uid+"/profile_pic.jpg")
                   
                    let uploadTask = profilePicRef.putData(imageData, metadata: nil){
                        
                    metadata,error in
                        
                    if(error == nil)
                        
                    {
                        let downloadUrl = metadata!.downloadURL
                    }
                    
                    else {
                        
                        print("error in downloading image")
                    }
                }
                    
                    //self.uiimvProfilePic
            }
                
        }
        
        })
        
        */
                            
    })
            
        } else {
                    
        // No user is signed in.
                    
        }
        
           //     })
                
                
            //    }
   // }
    
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


}
