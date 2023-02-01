//
//  UserRegistrationViewController.swift
//  SurfBuds
//
//  Created by Raymond Lang on 1/31/23.
//

import Foundation
import UIKit
import CoreLocation

class UserRegistrationViewController: UIViewController, CLLocationManagerDelegate  {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let email = emailTextField.text!
        
        let sqliteHelper = SQLiteHelper(dbPath: "path/to/database.sqlite")
        sqliteHelper.open()
        let success = sqliteHelper.insertUserProfile(username: username, password: password, email: email)
        sqliteHelper.close()
        
        if success {
            // Show success message and navigate to home screen, etc.
        } else {
            // Show error message
        }
        
        // Create an instance of the CLLocationManager class
        let locationManager = CLLocationManager()
        
        func viewDidLoad() {
            super.viewDidLoad()
            
            // Implement the CLLocationManagerDelegate method that is called when the location is updated
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                if locations.first != nil {
                    // Do something with the location here
                }
            }
            
            // Implement the CLLocationManagerDelegate method that is called when there is an error updating the location
            func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
