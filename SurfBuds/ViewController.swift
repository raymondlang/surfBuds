//
//  ViewController.swift
//  SurfBuds
//
//  Created by Raymond Lang on 1/31/23.
//

import Foundation
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        
        // Set the delegate for the location manager
        locationManager?.delegate = self
        
        // Request permission to access the user's location
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        
    }
    
    // Start updating the user's location
    locationManager.startUpdatingLocation()
}
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }


class UserRegistrationViewController: UIViewController, CLLocationManagerDelegate {
    
    // Create an instance of the CLLocationManager class
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Implement the CLLocationManagerDelegate method that is called when the location is updated
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                // Do something with the location here
            }
        }
        
        // Implement the CLLocationManagerDelegate method that is called when there is an error updating the location
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error: \(error.localizedDescription)")
        }
    }
}

