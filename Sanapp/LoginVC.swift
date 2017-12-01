//
//  LoginVC.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 5/2/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn

class LoginVC: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate{
    
    @IBOutlet weak var faceView: UIImageView!
    @IBOutlet weak var googleView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //googleDelegates init
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()!.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if let _ = UserDefaults.standard.value(forKey: "UID_KEY"){
            print("JESS: ID found in keychain")
            performSegue(withIdentifier: "toMainMenu", sender: nil)
            
        }
    }
    
    //facebook button pressed function
    @IBAction func fbBtnTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.8, animations: {
            self.faceView.frame.size.width += 2
            self.faceView.frame.size.height += 2
        }){ _ in
            UIView.animate(withDuration: 0.8, delay: 0.25, animations: {
                self.faceView.frame.size.height -= 2
                self.faceView.frame.size.width -= 2
                
            })
        }
        
        let loginManager = FBSDKLoginManager()
        //login with permissions
        loginManager.logIn(withReadPermissions: ["public_profile"], from: self) { (result,error) in
            //error handler
            if error != nil{
                print("Error: faceError\(error.debugDescription)")
            }else if result?.isCancelled == true{
                print("INFO: auth with facebook was cancelled")
            }else{
                print("INFO: auth existosa")
                
                //create facebooks credentials
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                //call credenltialAuth function
                self.credentialAuth(credential)
            }
            
        }

    }
    
    @IBAction func googleBtnPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.8, animations: {
            self.googleView.frame.size.width += 2
            self.googleView.frame.size.height += 2
        }){ _ in
            UIView.animate(withDuration: 0.8, delay: 0.25, animations: {
                self.googleView.frame.size.height -= 2
                self.googleView.frame.size.width -= 2
                
            })
        }
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("Failed to log into Google: ", err)
            return
        }
        
        print("Successfully logged into Google", user)
        
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        //create google credentials
        let credentials = FIRGoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        //call credenltialAuth function
        self.credentialAuth(credentials)
    }

    //credentialAuth, credential firebase authorization.
    func credentialAuth(_ credential:FIRAuthCredential){
        
        //signInCredential
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil{
                print("ERROR: unable to auth with Firebase\(error.debugDescription)")
            }else{
                print("INFO: succesfully auth with firebase")
                
                //user handler
                if let user = user{
                    //we save data
                    if user.email != nil{
                        let userData = ["provider":credential.provider,"email":user.email]
                        self.completeSignIn(id: user.uid, userData:userData as! Dictionary<String,  String>)
                    }else{
                        let userData = ["provider":credential.provider,"email":""]
                        self.completeSignIn(id: user.uid, userData:userData )
                    }
                }
            }
        })
    }
    
    //completeSignIn, we saved the information and we create the firebase user
    func completeSignIn(id:String,userData:Dictionary<String,String>){
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        UserDefaults.standard.set(id, forKey: "UID_KEY")
        print("INFO: data saved to local memory")
        performSegue(withIdentifier: "toMainMenu", sender: nil)
        
    }
    
}
