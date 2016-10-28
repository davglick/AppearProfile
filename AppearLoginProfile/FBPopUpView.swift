//
//  FBPopUpView.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 25/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class FBPopUpView: UIViewController, FBSDKLoginButtonDelegate {
    
    var ref: FIRDatabaseReference!
    
    let users = [User]()

    @IBOutlet var FaceBookView: UIView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var FBloginButton: FBSDKLoginButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
       self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        
        self.FaceBookView.layer.cornerRadius = 4
        self.FBloginButton.layer.cornerRadius = 2
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                
                // User is signed in.
                // Remove the sign in pop up page

               self.view.removeFromSuperview()
                
            } else {
                
                // No user is signed in.
                // Show the user the login pop up view
                
                self.FBloginButton.delegate = self
                self.FBloginButton.readPermissions = ["public_profile", "email", "user_friends"]
                self.FBloginButton.isHidden = false
                
        }
    }
    
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private var _fbLoginManager: FBSDKLoginManager?
    
    var fbLoginManager: FBSDKLoginManager {
        get {
            
            if _fbLoginManager == nil {
                _fbLoginManager = FBSDKLoginManager()
                
            }
            
            return _fbLoginManager!
        }
    }

 
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        
        
        activityIndicator.startAnimating()
        
        ref = FIRDatabase.database().reference()
        


        
        print("User Logged In")
        
        
        
        //self.FBloginButton.isHidden = true
        
        if(error != nil) {
            
            // handle error
            self.FBloginButton.isHidden = false
            activityIndicator.stopAnimating()
            
        } else if(result.isCancelled) {
            
            // handle cancel
            self.FBloginButton.isHidden = false
            activityIndicator.stopAnimating()
            
        } else {
            
            self.FaceBookView.isHidden = true
            self.FBloginButton.isHidden = true
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                
            }
            
        }

    
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        
        
        return true
        
         self.view.removeFromSuperview()
    }
    
    func fetchProfile(uid: String) {
        print("fetch profile")
        let parameters = ["fields": "email, first_name, last_name, gender, picture.type(large), verified"]
        
        if let user = FIRAuth.auth()?.currentUser {

        let name: String = user.displayName!
        let email: String = user.email!
        let photoUrl = user.photoURL
        let uid = user.uid
 
            
        self.ref.child("users").child(user.uid).setValue(["username": name, "UserEmail": email, "doing": "doing"])
        }
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) in
            if error != nil {
                print(error)
                
                

                
               // self.ref.child("Users").child(uid).setValue(["userName": name, "UserEmail": email])

                
              //   self.ref = FIRDatabase.database().reference()
                
                // self.ref.child("Users").child(uid).setValue([)
                
                
                print(parameters)
                
                return
            }
            
              

        }
    }
    

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()!.signOut()
        print("User did logout of Facebook")
    
    }
}
    



