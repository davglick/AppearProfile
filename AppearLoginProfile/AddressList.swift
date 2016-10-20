//
//  AddressList.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 19/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class AddressList: UITableViewController {

    
    var addressArray = [addAddress]()
    
    var databaseRef: FIRDatabaseReference!
    
    @IBOutlet var addressName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initiate the Firebase database
        
        if let user = FIRAuth.auth()?.currentUser {
            
            let uid = user.uid
            
            //let myTopPostsQuery = (databaseRef.child("Delivery_Address").child(uid)).queryOrdered(byChild: "addressName")
            
            databaseRef = FIRDatabase.database().reference().child("Delivery-Address").child(uid)
            
            
            databaseRef.observe(.value, with: { snapshot in
                
                var newAddress = [addAddress]()
                
                for address in snapshot.children {
                    
                    let newAddresses = addAddress(snapshot: address as! FIRDataSnapshot)
                    newAddress.insert(newAddresses, at:0)
                }
                
                self.addressArray = newAddress
                self.tableView.reloadData()
                
            }) { (Error) in
                
                print(Error.localizedDescription)
                
            }
            
            
        }
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return addressArray.count
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the Cell
        
        
        cell.textLabel?.text = addressArray[indexPath.row].addressName
    
        
        //cell.addressStringLabel.text = addressArray[indexPath.row].addressName
        //cell.selectedAddressTick = addressArray[indexPath.row].DefaultAddress.true
        
        return cell

    }
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
