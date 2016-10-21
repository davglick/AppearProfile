//
//  StoreListViewController.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 20/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class StoreListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var list: UITableView!
    
    @IBOutlet var profileIcon: UIBarButtonItem!
    
    @IBOutlet var shoppingBagIcon: UIBarButtonItem!
    
    
    var stores = [Vendor]()
    var databaseRef: FIRDatabaseReference!
    var storage: FIRStorageReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list.delegate = self
        list.dataSource = self
        
        
        databaseRef = FIRDatabase.database().reference().child("Vendor")
        
        /*
        
        self.databaseRef.child("Vendor").observe(.value, with: { snapshot in
            var newItems = [Vendor]()
            for item in snapshot.children {
                let vendor = Vendor(snapshot: item as! FIRDataSnapshot)
                newItems.append(vendor)
            }
            
            self.stores = newItems
            //DispatchQueue.main.asynchronously() {
            self.list.reloadData()

        }) { (Error) in
            
            
            print(Error.localizedDescription)
            
        }
 */

 
    
        
        databaseRef.observe(.value, with: { (snapshot) in
            
            
            var newItems = [Vendor]()
            
            for item in snapshot.children {
                
                let newVendors = Vendor(snapshot: item as! FIRDataSnapshot)
                newItems.insert(newVendors, at: 0)
            }
            
            self.stores = newItems
            self.list.reloadData()
         
            }) { (Error) in
                
                
                print(Error.localizedDescription)
                
        }
        
        
        
        // make the nav bar transparent 
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true
            navigationController?.view.backgroundColor = .clear
            
            // Reference to table view nib file
            
            let nib = UINib(nibName: "storeProfileCell", bundle: nil)
            list.register(nib, forCellReuseIdentifier: "Cell")
            list.separatorStyle = .none
            list.showsHorizontalScrollIndicator = false
            list.showsVerticalScrollIndicator = false
            

 
    
        }
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return self.stores.count
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.list.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StoreProfileList
        
        
         cell.vendorName.text = stores[indexPath.row].name
        
        return cell
    }

 }


