//
//  VendorPage.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 28/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
import Firebase
import FirebaseDatabase
import FirebaseAuth
import Alamofire

class VendorPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
   
    
    var store: Vendor!
    var databaseRef: FIRDatabaseReference!
    var storage: FIRStorageReference!
    
    @IBOutlet var navigationBar: UINavigationBar!
   
    @IBOutlet var productCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // refence the nib cell
        let nib = UINib(nibName: "ProductViewCell", bundle: nil)
        productCollection.register(nib, forCellWithReuseIdentifier: "ProductCell")
 

            }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: productCollection.frame.size.width/2.00534759, height: productCollection.frame.size.height/2.22333333)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteremItemForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
 

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        //let frame : CGRect = self.view.frame
        //let margin  = (frame.width - 90 * 3) / 6.0
        return UIEdgeInsetsMake(35, 0, 0, 0) // margin between cells
    }

    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      return 25
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
   
       let cell = productCollection.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
       cell.price.text = "$150"
        
       return cell
        
    }
    
    // create the collection view vendor header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = productCollection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! VendorLogo
        
        //header.logo.image = self.store.logo?.image
        
        return header
    }
    
    @IBAction func close(_ sender: AnyObject) {
        
        self.removeFromParentViewController()
        
    }

}

