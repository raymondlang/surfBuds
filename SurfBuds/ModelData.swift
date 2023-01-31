//
//  ModelData.swift
//  SurfBuds
//
//  Created by Raymond Lang on 1/23/23.
//

import Foundation
import UIKit
import SQLite3

class User {
    var name: String
    var age: Int
    var location: String
    var surfExperience: String
    var profileImage: UIImage
    
    init(name: String, age: Int, location: String, surfExperience: String, profileImage: UIImage) {
        self.name = name
        self.age = age
        self.location = location
        self.surfExperience = surfExperience
        self.profileImage = profileImage
    }
}

class SQLiteHelper {
    // The path to the database file
    private let dbPath: String
    
    // The connection to the database
    private var db: OpaquePointer?
    
    // Initializes the SQLiteHelper with the path to the database file
    init(dbPath: String) {
        self.dbPath = dbPath
    }
    
    
    // Open a connection to the database
    func open() -> Bool {
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            return true
        } else {
            print("Error opening database: \(String(cString: sqlite3_errmsg(db)))")
            return false
        }
    }
    
    // Close the connection to the database
    func close() {
        sqlite3_close(db)
    }
    
    // Execute a SELECT statement and return the results as an array of dictionaries
    func select(_ query: String) -> [[String: Any]] {
        var statement: OpaquePointer?
        var result = [[String: Any]]()
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let columnCount = sqlite3_column_count(statement)
                var row = [String: Any]()
                
                for i in 0..<columnCount {
                    let columnName = String(cString: sqlite3_column_name(statement, i))
                    let columnType = sqlite3_column_type(statement, i)
                    
                    switch columnType {
                    case SQLITE_INTEGER:
                        row[columnName] = Int(sqlite3_column_int(statement, i))
                    case SQLITE_FLOAT:
                        row[columnName] = Double(sqlite3_column_double(statement, i))
                    case SQLITE_TEXT:
                        if let text = sqlite3_column_text(statement, i) {
                            row[columnName] = String(cString: text)
                        }
                    case SQLITE_NULL:
                        row[columnName] = NSNull()
                    default:
                        print("Unknown column type")
                    }
                }
                result.append(row)
            }
        } else {
            print("Error preparing query: \(String(cString: sqlite3_errmsg(db)))")
        }
        sqlite3_finalize(statement)
        return result
    }
    
    // Connect to Registration Page
    func insertUserProfile(username: String, password: String, email: String) -> Bool {
        let query = "INSERT INTO users (username, password, email) VALUES ('\(username)', '\(password)', '\(email)');"
        return execute(query)
        }
    
    // Execute an INSERT, UPDATE, or DELETE statement
    func execute(_ query: String) -> Bool {
        if sqlite3_exec(db, query, nil, nil, nil) == SQLITE_OK {
            return true
        } else {
            print("Error executing query: \(String(cString: sqlite3_errmsg(db)))")
            return false
        }
    }
}

class UserRegistrationViewController: UIViewController {
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
    }
}
