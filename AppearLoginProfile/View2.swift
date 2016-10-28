//
//  View2.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 22/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SDWebImage



class View2: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var profilePicture: UIBarButtonItem!
    
    @IBOutlet var navigationBarrrrr: UINavigationBar!
    
    @IBOutlet var list: UITableView!
    
    var ThescrollView: UIScrollView!
    
    var stores = [Vendor]()
    var databaseRef: FIRDatabaseReference!
    var storage: FIRStorageReference!
    


    override func viewDidLoad() {
        super.viewDidLoad()
 

           
        // Reference to table view nib file
        let nib = UINib(nibName: "storeProfileCell", bundle: nil)
        list.register(nib, forCellReuseIdentifier: "Cell")
        list.separatorStyle = .none
        list.showsHorizontalScrollIndicator = false
        list.showsVerticalScrollIndicator = false
        
  
        // make the nav bar transparent
        navigationBarrrrr.setBackgroundImage(UIImage(), for: .default)
        navigationBarrrrr.shadowImage = UIImage()
        self.navigationBarrrrr.backgroundColor = .clear
        self.navigationBarrrrr.isTranslucent = true
        
        
        
        list.delegate = self
        list.dataSource = self
        
        
        databaseRef = FIRDatabase.database().reference().child("Vendor")
        
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

    }
 
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.stores.count

}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let cell: StoreProfileList = self.list.cellForRow(at: indexPath) as! StoreProfileList
      
    
       
       self.performSegue(withIdentifier: "show", sender: self)
        
        
      print(cell.vendorName)
        
        
    }
  

    
  

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.list.frame.height / 4

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StoreProfileList
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        // getting web image URL content
        
        DispatchQueue.global(qos: .background).async {
            
            let cover = self.stores[indexPath.row].coverURL
            let imageURL:NSURL? = NSURL(string: cover! )
            if let url = imageURL {
                cell.cover.sd_setImage(with: url as URL!)
                
                // testing speed //
                
                let methodStart = Date()
                
                
                let methodFinish = Date()
                let executionTime = methodFinish.timeIntervalSince(methodStart)
                print("Execution Time: \(executionTime)")
                
                
            }
        }
        
        // Display the vendor name
        cell.vendorName.text = stores[indexPath.row].name
        
        return cell
    }

}
    

