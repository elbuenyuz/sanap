//
//  FeedbackVC.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 6/24/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

class FeedbackVC: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet var textViewFeed: StyleTextView!
    
    @IBOutlet var labelError: UILabel!
    
    var userData:Dictionary<String,String> = [:]
    let uidKey = "UID_KEY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
    }
    
    //
    @IBAction func enviarFeedbackBtn(_ sender: Any) {
        
        if textViewFeed.text != ""{
            animateIn()
            labelError.isHidden = true
            
            if let uid = UserDefaults.standard.value(forKey: "UID_KEY") as? String{
                
                print("UID Key = \(uid)")
                userData = ["mensaje":textViewFeed.text]
                DataService.ds.createFeedback(uid: uid, userData: userData)
                
            }
            
            
            
        }else{
            
            labelError.isHidden = false
        }
    }
    
    //create an animation of containerView
    func animateIn(){
        
        addBlurEffect()
        self.view.addSubview(containerView)
        containerView.center = self.view.center
        
        containerView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        containerView.alpha = 0
        
        
        UIView.animate(withDuration: 0.4){
            
            self.containerView.alpha = 1
            self.containerView.transform = CGAffineTransform.identity
        }
        
    }
    
    //dismiss the containerView
    func animateOut () {
        UIView.animate(withDuration: 0.4, animations: {
            self.containerView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.containerView.alpha = 0
            
            self.removeBlurEffect()
            
        }) { (success:Bool) in
            self.containerView.removeFromSuperview()
        }
    }
    //add blur effect to the view
    func addBlurEffect(){
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.opacity = 0.85
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubview(containerView)
        
        
    }
    //remove the blur effect
    func removeBlurEffect(){
        
        for subView in view.subviews{
            if subView is UIVisualEffectView{
                subView.removeFromSuperview()
                
            }
        }
    }
    
    //closeBtn containerView
    @IBAction func closeBtn(_ sender: Any) {
        animateOut()
        dismiss(animated: true, completion: nil)
    }
    
    func completeFeedback(id:String,userData:Dictionary<String,String>){
        DataService.ds.createFeedback(uid: id, userData: userData)
        UserDefaults.standard.set(id, forKey: "UID_KEY")
    }
}
