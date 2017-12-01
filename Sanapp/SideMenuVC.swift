//
//  SideMenuVC.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 4/26/17.
//  Copyright © 2017 Devius. All rights reserved.
//
import UIKit
import Foundation

class SideMenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableArray = [String]()
    var imgArray = [UIImage]()
    var dataArray = [ModelElement]()
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableArray = ["Que es Sanapp?","Estres","Cansancio","Depresion","Ansiedad","Miedos","Debilidad","Feedback","Logout"]
        
        imgArray = [#imageLiteral(resourceName: "Sanapp-Icon-1"),#imageLiteral(resourceName: "Sanapp-Icon-2"),#imageLiteral(resourceName: "Sanapp-Icon-3"),#imageLiteral(resourceName: "depre"),#imageLiteral(resourceName: "Sanapp-Icon-5"),#imageLiteral(resourceName: "Sanapp-Icon-6"),#imageLiteral(resourceName: "deb"),#imageLiteral(resourceName: "feBck"),#imageLiteral(resourceName: "logout")]
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableArray[indexPath.row] == "Que es Sanapp?"{
            
            let cell =  tableView.dequeueReusableCell(withIdentifier:"titleCell", for: indexPath) as! SideMenuCell
            
            
            cell.conf(itemName: tableArray[indexPath.row], img: imgArray[indexPath.row],cell: cell)
            
            
            print("title aqui aparece")
            return cell
            
        }else{
            let cell =  tableView.dequeueReusableCell(withIdentifier:"cellMenu", for: indexPath) as! SideMenuCell
            
            
            cell.conf(itemName: tableArray[indexPath.row], img: imgArray[indexPath.row],cell: cell)
            print("menu aqui aparece")
            return cell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    let toFeedbackId = "toFeedback"
    //tengo que enviar el objeto 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let cell = tableView.cellForRow(at: indexPath)
            cell?.isSelected = false
            
        
        switch tableArray[indexPath.row] {
        case "Que es Sanapp?":
            var element = ModelElement(name: sanTitle, desc: sanDesc,path:#imageLiteral(resourceName: "b1"))
            performSegue(withIdentifier: "toMainMenu", sender: element)
        case "Estres":
            performSegue(withIdentifier: "toMainMenu", sender: ESTRES)
        case "Cansancio":
            performSegue(withIdentifier: "toMainMenu", sender: CANSANCIO)
        case "Depresion":
            performSegue(withIdentifier: "toMainMenu", sender: DEPRESION)
        case "Ansiedad":
            performSegue(withIdentifier: "toMainMenu", sender: ANSIEDAD)
        case "Miedos":
            performSegue(withIdentifier: "toMainMenu", sender: MIEDOS)
        case "Debilidad":
           performSegue(withIdentifier: "toMainMenu", sender: DEBILIDAD)
        case "Logout":
            UserDefaults.standard.removeObject(forKey: "UID_KEY")
            dismiss(animated: true, completion: nil)
        case "Feedback":
            performSegue(withIdentifier: toFeedbackId, sender: nil) 
        default:
            //toogleView
            break
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toogle()
        if segue.identifier == "toMainMenu" {
            
            let secondNav = segue.destination as! UINavigationController
            let secondVC = secondNav.topViewController as! MainViewVC
            print("entramos si senor")
            secondVC.element = sender as! ModelElement // now you can access public variables and functions from the second viewController
            
        }
    }
    
    func toogle(){
        self.revealViewController().revealToggle(animated: true)
    }
}
