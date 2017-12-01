//
//  DataService.swift
//  adoptMe
//
//  Created by Daniel Ramirez on 1/24/17.
//  Copyright © 2017 simpleCoding. All rights reserved.
//

import Foundation
import Firebase
import FBSDKCoreKit
import FirebaseDatabase

let DB_BASE = FIRDatabase.database().reference()

class DataService{
    
    //servicio de informacion
    static let ds = DataService()
    
    fileprivate var _REF_BASE = DB_BASE
    fileprivate var _REF_USERS = DB_BASE.child("users")
    fileprivate  var _REF_FEEDBACK = DB_BASE.child("users").child("feedback")
    
    var REF_BASE:FIRDatabaseReference{
        return _REF_BASE
    }
    
    var REF_USERS:FIRDatabaseReference{
        return _REF_USERS
    }
    
    var REF_FEEDBACK:FIRDatabaseReference{
        return _REF_FEEDBACK
    }
    
    func createFirebaseDBUser(uid: String,userData:Dictionary<String,String>){
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    func createFeedback(uid: String,userData:Dictionary<String,String>){
            REF_USERS.child(uid).child("feedback").childByAutoId().updateChildValues(userData)
    //        REF_USERS.child(uid).child("feedback").updateChildValues(userData)
    }

}
