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
    
    func getStore() {
        
        let string: String? = "https://\(self.store.APIToken!)@\(self.store.storeDomain!).myshopify.com/admin/products.json?fields=id,sku,images,title,vendor,variants,product_type,body_html,options"
        let url: NSURL? = NSURL(string: string!)!
        //let request = NSURLRequest(URL: url)
        let session = URLSession.shared
        
     //   session.dataTaskWithURL(url as! URL, completionHandler: { ( data: NSData?, response: URLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse ,
                realResponse.statusCode == 200
                else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            do {
                
                let shop = JSON(data: data!)
                var x = [Product]()
                for test in shop["products"] {
                    let product = Product(store: test.1)
                    x.append(product)
                }
                self.products = x
                dispatch_async(dispatch_get_main_queue()) {
                    self.collectionView.reloadData()
                }
                //let key: AnyObject = Array(shop.dictionaryValue.keys)[0]
                // let value = shop[key as! String]
                //print(value[0]["images"][1]["src"])
            }
        }).resume()
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
