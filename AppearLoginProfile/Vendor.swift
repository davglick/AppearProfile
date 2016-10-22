//
//  Vendor.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 21/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Vendor: NSObject {
    
    var coverURL: String!
    var coverPhoto: UIImageView?
    var name: String!
    var key: String!
    var ref: FIRDatabaseReference?

    


init(coverURL: String, coverPhoto: String, name: String, key: String = "") {
    
    self.coverURL = coverURL
    self.coverPhoto = UIImageView()
    self.name = name
    self.key = key
    self.ref = FIRDatabase.database().reference()

    
}


init(snapshot: FIRDataSnapshot) {
    
    
    coverURL = (snapshot.value as? NSDictionary)?["background"] as? String
    coverPhoto = UIImageView()
    name = (snapshot.value as? NSDictionary)? ["name"] as? String
    
    self.key = snapshot.key
    self.ref = snapshot.ref
    
}
    
    func toAnyObject() -> [String: AnyObject] {
        
        return ["coverURL": coverURL as AnyObject , "coverPhoto": coverPhoto as AnyObject, "name": name as AnyObject]
    }


}
