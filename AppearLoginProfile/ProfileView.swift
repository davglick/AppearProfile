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

class ProfileView: UIViewController {
    
    
    @IBOutlet var profileName: UILabel!
    
    var effect:UIVisualEffect!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let user = FIRAuth.auth()?.currentUser {
            // User is signed in.
            let name = user.displayName
           
            
            self.profileName.text = user.displayName
        }
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func profileViewButton(_ sender: AnyObject) {
        
    }

}
