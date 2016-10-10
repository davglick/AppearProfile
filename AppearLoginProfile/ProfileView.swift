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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
