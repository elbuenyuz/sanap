//
//  ViewController.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 4/21/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds




class MainViewVC: UIViewController, GADInterstitialDelegate{
    
    //viewContainerPopUp
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var nameElementos: UILabel!
    @IBOutlet weak var backgroundImgView: UIImageView!
    
    //MainView
    @IBOutlet var containerView: UIView!
    @IBOutlet var backgroundBtns: UIImageView!
    @IBOutlet weak var banner: GADBannerView!
    @IBOutlet weak var Menu: UIBarButtonItem!
    
    
    var interstitialAd: GADInterstitial?
    var audioPlayer :AVAudioPlayer?
    var element = ModelElement()
    var arrayElements = [ModelElement]()
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //styleContainerView
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 3.0
        
        var elemento = element
        interstitialAd = createAndLoadInterstitial()
        if elemento.name == "por asignar"{
            
        }else{
            animateIn()
        }
        //sideMenu
        if self.revealViewController() != nil {
            Menu.target = self.revealViewController()
            Menu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func chargeAudio(tag:String,img:UIImage){
        
        backgroundBtns.image = img
        
        let sound = Bundle.main.url(forResource: tag, withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound!)
            guard let player = audioPlayer else { return }
            player.stop()
            player.prepareToPlay()
            player.play()
            print("playplayplay")
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    //admob
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitialAd = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitialAd.delegate = self
        interstitialAd.load(GADRequest())
        return interstitialAd
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitialAd = createAndLoadInterstitial()
    }
    @IBAction func tapAction(_ sender: UIButton) {
        
        if (interstitialAd?.isReady)! {
            interstitialAd?.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        
        let btnTag = sender.tag
        
        switch btnTag {
        case 1:
            
            chargeAudio(tag: "agua",img: #imageLiteral(resourceName: "buttonestres"))
        case 2:
            chargeAudio(tag: "gong", img: #imageLiteral(resourceName: "cansancio"))
        case 3:
            chargeAudio(tag: "ansiedad", img: #imageLiteral(resourceName: "buttonansiedad_"))
        case 4:
            chargeAudio(tag: "campanas", img: #imageLiteral(resourceName: "depresion"))
        case 5:
            chargeAudio(tag: "furin", img: #imageLiteral(resourceName: "buttondebilidad"))
        case 6:
            chargeAudio(tag: "pajaros", img: #imageLiteral(resourceName: "buttonmiedos"))
        default:
            return
        }
    
    }
    @IBAction func btnPressed(_ sender: Any) {
        animateOut()
        self.removeBlurEffect()
    }
    
    
    
    func chargeData(title: String, desc:String,img:UIImage){
        
        self.labelDesc.text = desc
        self.nameElementos.text = title
        self.backgroundImgView.image = img
    }
    
    func addBlurEffect(){
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.opacity = 0.85
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubview(containerView)
        
        
    }
    
    func removeBlurEffect(){
        
        for subView in view.subviews{
            if subView is UIVisualEffectView{
                subView.removeFromSuperview()
                
            }
        }
    }
    func animateIn(){
        
        self.addBlurEffect()
        
        chargeData(title: element.name, desc: element.description, img: element.imageUrl)
        
        self.view.addSubview(containerView)
        containerView.center = self.view.center
        
        containerView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        containerView.alpha = 0
        
        
        
        UIView.animate(withDuration: 0.4){
            self.containerView.alpha = 1
            self.containerView.transform = CGAffineTransform.identity
        }
        
    }
    func animateOut () {
        UIView.animate(withDuration: 0.4, animations: {
            self.containerView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.containerView.alpha = 0
            
            
            
        }) { (success:Bool) in
            self.containerView.removeFromSuperview()
        }
        self.removeBlurEffect()
    }
}

