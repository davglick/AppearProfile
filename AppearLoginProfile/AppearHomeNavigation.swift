//
//  AppearHomeNavigation.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 24/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit

class AppearHomeNavigation: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileView = view1()
        let storeView = View2()
            
        //Initialize using Unique ID for the View
        let V1 = (self.storyboard?.instantiateViewController(withIdentifier: "V1"))! as UIViewController
        
        
        //Add initialized view to main view and its scroll view and also set bounds
        self.addChildViewController(V1)
        self.scrollView.addSubview(V1.view)
        V1.didMove(toParentViewController: self)
        V1.view.frame = scrollView.bounds
        
        
        
        //Create frame for the view and define its urigin point with respect to View 1 
        
        
       
        
        
        // create view 2
        let V2 = (self.storyboard?.instantiateViewController(withIdentifier: "V2"))! as UIViewController
        //Add initialized view to main view and its scroll view also set bounds
        
        self.addChildViewController(V2)
        
        //4view1.ThescrollView = self.scrollView
        self.scrollView.addSubview(V2.view)
        V2.didMove(toParentViewController: self)
        V2.view.frame = scrollView.bounds
        storeView.ThescrollView = self.scrollView

        
        var V2Frame: CGRect = V2.view.frame
        V2Frame.origin.x = self.view.frame.width
        V2.view.frame = V2Frame
        
        
        
        // create view 3 
        let V3 = (self.storyboard?.instantiateViewController(withIdentifier: "V3"))! as UIViewController
        self.addChildViewController(V3)
        self.scrollView.addSubview(V3.view)
        V3.didMove(toParentViewController: self)
        V3.view.frame = scrollView.bounds
        
        
        var V3Frame: CGRect = V3
            .view.frame
        V3Frame.origin.x = 2 * self.view.frame.width
        V3.view.frame = V3Frame
        
        self.scrollView.contentOffset = CGPoint(x: self.view.frame.width * 1, y: self.view.frame.height)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.height)

       

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}


















