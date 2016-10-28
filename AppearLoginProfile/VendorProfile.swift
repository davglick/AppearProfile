//
//  StoreViewController.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 26/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
import Firebase
import FirebaseDatabase
import FirebaseAuth

class VendorProfile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var store: Vendor!
    var products = [Product]()
    let ref = FIRDatabase.database().reference()

    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var productCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set up collection View
        let nib = UINib(nibName: "ProductViewCell", bundle: nil)
        productCollection.register(nib, forCellWithReuseIdentifier: "ProductCell")
        navigationBar.topItem?.title = store.name

       
    }
    
    func getStore() {
        
        let string: String? = "https://\(self.store.APIToken!)@\(self.store.storeDomain!).myshopify.com/admin/products.json?fields=id,sku,images,title,vendor,variants,product_type,body_html,options"
        let url: NSURL? = NSURL(string: string!)!
        //let request = NSURLRequest(URL: url)
        let session = URLSession.shared
        
        
      session.dataTask(with: url as! URL, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
 
            
           
            // Make sure we get an OK response
            guard let realResponse = response as? HTTPURLResponse ,
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
                DispatchQueue.main.async {

                    self.productCollection.reloadData()
                }
                //let key: AnyObject = Array(shop.dictionaryValue.keys)[0]
                // let value = shop[key as! String]
                //print(value[0]["images"][1]["src"])
            }
        }).resume()
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2.00534759, height: collectionView.frame.size.height/2.22333333)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //let frame : CGRect = self.view.frame
        //let margin  = (frame.width - 90 * 3) / 6.0
        return UIEdgeInsetsMake(35, 0, 0, 0) // margin between cells
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // let cell: CustomCVCCollectionViewCell = self.collectionView.cellForItemAtIndexPath(indexPath) as! CustomCVCCollectionViewCell
        let storyboard = UIStoryboard(name: "StoreList", bundle: nil)
        _ = storyboard.instantiateViewController(withIdentifier: "Product") //as! ProductViewController
      //  vc.product = self.products[indexPath.row]
      //  vc.imageDisplay = self.store.imageDisplay
     //   vc.product.vendorID = self.store.key!
     //   vc.delegate = self
     //   self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath as IndexPath) as! ProductCell
        let url = NSURL(string: self.products[indexPath.row].image[0]!)
        cell.backgroundColor = UIColor.white
        cell.image.sd_setImage(with: url as URL!, placeholderImage: nil, options: .refreshCached)
        cell.title.text = self.products[indexPath.row].title!
        cell.vendor.text = self.products[indexPath.row].vendor!
        cell.price.text = "$\(self.products[indexPath.row].price!)"
        return cell
    }




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
  

