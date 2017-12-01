//
//  StyleView.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 6/27/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

class StyleView: UIView {

   
    override func awakeFromNib() {
        
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor(red:SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).cgColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        
    }
}
