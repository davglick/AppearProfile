//
//  AddressMapView.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 13/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import Firebase
import FirebaseAuth
import FirebaseDatabase


class AddressMapView: UIViewController,CLLocationManagerDelegate  {
    
    let locationManager = CLLocationManager()
    
    var googleMapView: GMSMapView!

    @IBOutlet var mapView: GMSMapView!
    
    @IBOutlet var addButton: UIButton!
   
    
    
    // Present the Autocomplete view controller when the button is pressed.
    @IBAction func autocompleteClicked(_ sender: AnyObject) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        self.present(autocompleteController, animated: true, completion: nil)
    }
    
}

extension AddressMapView: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        
        let name: String = place.name
        let address: String = place.formattedAddress!
        
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress)
        print("Place attributions: ", place.attributions)
        self.dismiss(animated: true, completion: nil)
        mapView.clear()
        // Print a google marker in the selected location
        
        let position = place.coordinate
        let marker = GMSMarker(position: position)
        marker.title = place.formattedAddress
        marker.map = mapView
        
        mapView.animate(toLocation: place.coordinate)
        mapView.animate(toZoom: 12)
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        //print("Error: ", error.description)
        
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    

    //  This is the extention code for getting the users location

    @objc(locationManager:didChangeAuthorizationStatus:) func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            
            
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            locationManager.stopUpdatingLocation()
        }
        
    }
        


    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Navigation Controller Design
        
      
        
        
     
        
        self.addButton.layer.cornerRadius = self.addButton.frame.size.width/2
        self.addButton.layer.borderColor = UIColor(red: 160/255, green: 160/255, blue: 159/255, alpha: 1).cgColor
        self.addButton.layer.borderWidth = 0.05
        self.addButton.clipsToBounds = true
        
            addButton.layer.shadowColor = UIColor.black.cgColor
            addButton.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            addButton.layer.masksToBounds = false
            addButton.layer.shadowRadius = 0.5
            addButton.layer.shadowOpacity = 0.5
        
        
     
        self.view.addSubview(addButton)
    
        
    }
    
    
    
    @IBAction func dismissSecondVC(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        
          }
    
    
    
      }





    
