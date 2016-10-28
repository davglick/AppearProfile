//
//  profileSegue.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 22/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit

class profileSegue: UIStoryboardSegue {
    
    override func perform() {
        
            
        let sourceVC = self.source
        let destinationVC = self.destination
        
        sourceVC.view.addSubview(destinationVC.view)
        
        destinationVC.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            
        destinationVC.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            }) { (finnished) in
                
                
                destinationVC.view.removeFromSuperview()
                
                
                let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                    
                    sourceVC.present(destinationVC, animated: false, completion: nil)
                    
                })
               
        }
        
        
            
        }
    }


