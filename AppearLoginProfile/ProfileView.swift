//
//  ProfileView.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 10/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit




class ProfileView: UIViewController {
    
    
    @IBOutlet var profileName: UILabel!
    
    var effect:UIVisualEffect!
    
    var databaseRef: FIRDatabaseReference!


    override func viewWillAppear(_ animated: Bool) {
       

        if FIRAuth.auth()?.currentUser == nil {
 
            
            let FBPop = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FBPopUp") as! FBPopUpView
            self.addChildViewController(FBPop)
            FBPop.view.frame = self.view.frame
            self.view.addSubview(FBPop.view)
            FBPop.didMove(toParentViewController: self)
            

        } else {
            
            
            /*
            if let user = FIRAuth.auth()?.currentUser {
                // databaseRef.observe(.value, with: { snapshot in
                
                
                // User is signed in.
                
                let name = user.displayName
                let email = user.email
                let photoUrl = user.photoURL
                let uid = user.uid
                
                
                
                //  Display Profile Name, Photo and Email
                
                let data = NSData(contentsOf: photoUrl!)
                self.profileName.text = user.displayName
               // })
                
            }
            
            
        }
        
    }
 */
    

          if let user = FIRAuth.auth()?.currentUser {
            // User is signed in.
     
          let name = user.displayName
 
           self.profileName.text = user.displayName
            }
                
    }
            
}

    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func profileViewButton(_ sender: AnyObject) {
        
    }

}
