//
//  SideMenuCell.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 4/26/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func conf(itemName: String,img:UIImage ,cell: SideMenuCell){
        self.itemLabel.text = itemName
        self.imgView.image = img
        
        titleCellConf(cell: cell)
        
    }
    
    func confTitle(itemName:String,Cell:SideMenuCell){
        self.itemLabel.text = itemName
    }
    
    func titleCellConf(cell: UITableViewCell){
        
        guard let cellId = cell.reuseIdentifier else{return}
        
        switch cellId{
        case "titleCell":
            cell.isUserInteractionEnabled = true
            cell.tintColor = UIColor.lightGray
            itemLabel.textColor = UIColor(red:40/255.00, green:211/255.00, blue:195/255.00, alpha:1.0)
            
            
        case "cellMenu":
            cell.isUserInteractionEnabled = true
            cell.tintColor = UIColor.lightGray
            itemLabel.textColor = UIColor.white
            
            if itemLabel.text == "Logout" {
                
                cell.tintColor = UIColor.lightGray
                itemLabel.textColor = UIColor.red
            }
            
            if itemLabel.text == "Feedback"{
                cell.tintColor = UIColor.lightGray
                itemLabel.textColor = UIColor.blue
            }
            
            
        default:
            break
        }
    }


}
