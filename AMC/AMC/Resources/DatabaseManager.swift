//
//  DatabaseManager.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 1/18/22.
//

import Foundation
import FirebaseDatabase
import CloudKit

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}
   //json
    
    //MARK - Acocunt Manager
    extension DatabaseManager {
        public func userExists(with email: String,
                               completion: @escaping ((Bool) -> Void)) {
            
            var safeEmail = email.replacingOccurrences(of: ".", with: "-")
            safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
            
            database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
                guard snapshot.value as? String != nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
            
        }
        
        //inserts new user to database
        public func insertUser(with user: bankUser){
            database.child(user.safeEmail).setValue([
                "first_name": user.firstName,
                "last_name": user.lastName
            ])
            
        }
    }
   
struct bankUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        return safeEmail
    }
}
