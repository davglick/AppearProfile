//
//  ViewController.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 3/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FirebaseAuth
import FirebaseStorage


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var facebookLoginView: UIView!
    @IBOutlet var faceBookLogin: FBSDKLoginButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  self.faceBookLogin.isHidden = true
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                
                // User is signed in.
                // Take to Profile Page
            
                let mainStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                let ProfileViewController: UIViewController = mainStoryBoard.instantiateViewController(withIdentifier: "UserProfile")
                
                self.present(ProfileViewController, animated: true, completion:  nil)
                
            } else {
                
                // No user is signed in.
                // Show the user the login pop up view
                
                self.faceBookLogin.delegate = self
                self.faceBookLogin.readPermissions = ["public_profile", "email", "user_friends"]
                self.view!.addSubview(self.faceBookLogin)
                self.faceBookLogin.isHidden = false
                
            }
        }
        
        
        faceBookLogin.delegate = self
        self.faceBookLogin.readPermissions = ["public_profile", "email", "user_friends"]
        self.view!.addSubview(self.faceBookLogin)
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        
        print("User Logged In")
    
        self.faceBookLogin.isHidden = true
        
        if(error != nil) {
            
            // handle error
            self.faceBookLogin.isHidden = false
            activityIndicator.stopAnimating()
            
        } else if(result.isCancelled) {
            
            // handle cancel
            self.faceBookLogin.isHidden = false
            activityIndicator.stopAnimating()
        
        } else {
   
       let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
       
        }
            
        }
            

        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        
        return true
    }
    
    func fetchProfile(uid: String) {
        print("fetch profile")
        let parameters = ["fields": "email, first_name, last_name, gender, picture.type(large), verified"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) in
            if error != nil {
                print(error)

                return
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()!.signOut()
        print("User did logout of Facebook")
    }
}

