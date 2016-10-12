//
//  FacebookLoginPopUp.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 7/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit

class FacebookLoginPopUp: UIViewController {

    
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var textLabel: UILabel!
    
    @IBOutlet var FaceBookLoginView: UIView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.textLabel.text = (String: "Login or Register an account \n with Facebook")
        textLabel.font = UIFont(name: "Syncopate", size: 13.0)
        textLabel.font = UIFont.systemFont(ofSize: 13)
        textLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.FaceBookLoginView.layer.cornerRadius = 4
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
