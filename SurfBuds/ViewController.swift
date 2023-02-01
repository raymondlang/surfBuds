//
//  ViewController.swift
//  SurfBuds
//
//  Created by Raymond Lang on 1/31/23.
//

import Foundation
import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        
        // Set the delegate for the location manager
        locationManager?.delegate = self
        
        // Request permission to access the user's location
        locationManager?.requestAlwaysAuthorization()
        
        // Start updating the user's location
        locationManager?.startUpdatingLocation()
        
        view.backgroundColor = .gray
        
    }
    

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

