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
        textLabel.font = UIFont.systemFont(ofSize: 14)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.FaceBookLoginView.layer.cornerRadius = 4
       
        
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
